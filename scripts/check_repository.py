"""Check public aggregate files and optional pipeline inputs without running R.

Run from any directory. Python 3.9+ and its standard library are sufficient.
"""
from pathlib import Path
import argparse
import csv
import hashlib
import json
import re
import sys
import zipfile
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
CURRENT_PIPELINE = (
    "data_processing.qmd", "market.qmd", "market_datum.qmd",
    "activity_formal.qmd", "activity_informal.qmd", "care_provider.qmd",
    "provider.qmd", "broad_impacts.qmd", "gini.qmd",
    "sandwich_generation.qmd", "bargainin_power.qmd", "parental_labor_monitor.qmd",
)
REQUIRED_PUBLIC = (
    "README.md", "CONTRIBUTING.md", "CITATION.cff", ".gitignore",
    ".gitattributes", "_quarto.yml", "TheCareBoard_Master.qmd",
    "R/load_defaults.R", "config/db_connect.example.R",
    "analysis/_database_upload.qmd", "docs/METHODOLOGY.md",
    "docs/REPRODUCIBILITY.md", "docs/DATA_DICTIONARY.md",
    "docs/APP_DATA_INVENTORY.csv", "data/input_manifest.csv",
    "docs/crosswalk_schema.json",
)
MISSING_MARKERS = {"", "NA", "NULL", "NaN"}


def check_tables(errors, verify_snapshot):
    schema_path = ROOT / "docs/app_data_schema.json"
    if not schema_path.is_file():
        errors.append("Missing docs/app_data_schema.json")
        return 0
    try:
        schema = json.loads(schema_path.read_text(encoding="utf-8"))["files"]
    except (OSError, ValueError, KeyError) as exc:
        errors.append(f"Invalid schema: {exc}")
        return 0
    observed = {p.name for p in (ROOT / "app_data").glob("*") if p.is_file() and p.suffix != ".md"}
    for name in sorted(observed - set(schema)):
        errors.append(f"Undocumented app_data file: {name}")
    total_rows = 0
    for name, spec in sorted(schema.items()):
        p = ROOT / "app_data" / name
        if not p.is_file():
            errors.append(f"Missing app_data/{name}")
            continue
        if p.stat().st_size >= 100 * 1024 * 1024:
            errors.append(f"app_data/{name} is at or above 100 MiB")
        try:
            if verify_snapshot and hashlib.sha256(p.read_bytes()).hexdigest() != spec["sha256"]:
                errors.append(f"Snapshot checksum differs: app_data/{name}")
            if spec["kind"] == "xlsx":
                with zipfile.ZipFile(p) as workbook:
                    if workbook.testzip():
                        errors.append(f"Corrupt workbook member: {name}")
                    tree = ET.fromstring(workbook.read("xl/workbook.xml"))
                    sheets = [s.attrib["name"] for s in tree.findall(".//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}sheet")]
                    if sheets != spec["sheets"]:
                        errors.append(f"Workbook sheets differ: {name}")
                continue
            with p.open(encoding="utf-8-sig", newline="") as stream:
                reader = csv.reader(stream)
                header = next(reader, [])
                if header != spec["columns"]:
                    errors.append(f"Columns differ: app_data/{name}")
                    continue
                if len(header) != len(set(header)):
                    errors.append(f"Duplicate header: {name}")
                geo_index = next((i for i, field in enumerate(header) if field in ("geo", "geo_level")), None)
                date_index = header.index("date") if "date" in header else None
                seen_ids = set()
                id_index = header.index("id") if name in ("metric_labels.csv", "provider_category.csv", "source.csv") else None
                count = 0
                for line, row in enumerate(reader, 2):
                    count += 1
                    if len(row) != len(header):
                        errors.append(f"Malformed CSV row: {name}:{line}")
                        continue
                    if geo_index is not None and row[geo_index] not in MISSING_MARKERS:
                        if not re.fullmatch(r"national|state\d{2}", row[geo_index]):
                            errors.append(f"Invalid geography identifier: {name}:{line}")
                    if date_index is not None and row[date_index] not in MISSING_MARKERS:
                        if not re.fullmatch(r"\d{4}-\d{2}-\d{2}", row[date_index]):
                            errors.append(f"Invalid date label: {name}:{line}")
                    if id_index is not None:
                        key = row[id_index]
                        if key in MISSING_MARKERS or key in seen_ids:
                            errors.append(f"Missing/duplicate metadata ID: {name}:{line}")
                        seen_ids.add(key)
                if not count:
                    errors.append(f"Empty table: {name}")
                if verify_snapshot and count != spec["observed_rows"]:
                    errors.append(f"Snapshot row count differs: {name}")
                total_rows += count
        except (OSError, UnicodeError, csv.Error, KeyError, zipfile.BadZipFile, ET.ParseError) as exc:
            errors.append(f"Cannot read {name}: {exc}")
    return total_rows


def check_crosswalks(errors, verify_snapshot):
    schema_path = ROOT / "docs/crosswalk_schema.json"
    if not schema_path.is_file():
        return
    try:
        schemas = json.loads(schema_path.read_text(encoding="utf-8"))["files"]
        tables = {}
        for name, spec in schemas.items():
            path = ROOT / spec["path"]
            if not path.is_file():
                errors.append(f"Missing public crosswalk: {spec['path']}")
                continue
            if verify_snapshot and hashlib.sha256(path.read_bytes()).hexdigest() != spec["sha256"]:
                errors.append(f"Snapshot checksum differs: {spec['path']}")
            with path.open(encoding=spec["encoding"], newline="") as stream:
                reader = csv.DictReader(stream)
                if reader.fieldnames != spec["columns"]:
                    errors.append(f"Crosswalk columns differ: {name}")
                    continue
                rows = list(reader)
            if not rows or any(None in row or any(value is None for value in row.values()) for row in rows):
                errors.append(f"Empty/malformed crosswalk: {name}")
                continue
            if verify_snapshot and len(rows) != spec["observed_rows"]:
                errors.append(f"Snapshot row count differs: {name}")
            tables[name] = rows
        for name, key in (("FormalOccs_Crossover.csv", "code"), ("ATUSActivityCrossover.csv", "Code")):
            if name not in tables:
                continue
            codes = [row[key] for row in tables[name] if row[key] not in MISSING_MARKERS]
            if any(not re.fullmatch(r"\d+", code) for code in codes) or len(codes) != len(set(codes)):
                errors.append(f"Invalid/duplicate crosswalk code: {name}")
            uncoded = [row for row in tables[name] if row[key] in MISSING_MARKERS]
            if name == "ATUSActivityCrossover.csv":
                if {row["Activity"] for row in uncoded} != {"Secondary Childcare", "Secondary Eldercare"} or len(uncoded) != 2:
                    errors.append("Unexpected uncoded ATUS crosswalk rows; expected the two secondary-care annotations.")
            elif uncoded:
                errors.append(f"Missing crosswalk code: {name}")
        atus_codes = {row["Code"] for row in tables.get("ATUSActivityCrossover.csv", [])}
        for number, row in enumerate(tables.get("Informal_Formal_Crosswalk.csv", []), 2):
            if atus_codes and row["Code_Informal"] not in atus_codes:
                errors.append(f"Replacement crosswalk activity missing from ATUS lookup: row {number}")
            bounds = re.fullmatch(r"(\d+)(?:-(\d+))?", row["Code_Formal"])
            if not bounds or int(bounds[1]) > int(bounds[2] or bounds[1]):
                errors.append(f"Invalid replacement occupation range: row {number}")
    except (OSError, UnicodeError, csv.Error, ValueError, KeyError, TypeError) as exc:
        errors.append(f"Cannot validate crosswalks: {exc}")


def check_pipeline(errors):
    for name in CURRENT_PIPELINE:
        if not (ROOT / "analysis" / name).is_file():
            errors.append(f"Missing pipeline script: analysis/{name}")
        else:
            text = (ROOT / "analysis" / name).read_text(encoding="utf-8-sig")
            helpers = re.findall(r"^\s*source\(\s*[\"']([^\"']+)[\"']", text, re.MULTILINE)
            for helper in sorted(set(helpers)):
                if not (ROOT / helper).is_file():
                    errors.append(f"Missing helper used by {name}: {helper}")
    # The raw download script is optional for a cleaned-input refresh.
    if not (ROOT / "analysis/IPUMS_API.qmd").is_file():
        print("NOTE: analysis/IPUMS_API.qmd is absent (optional raw-download step).")
    else:
        text = (ROOT / "analysis/IPUMS_API.qmd").read_text(encoding="utf-8-sig")
        for helper in sorted(set(re.findall(r"^\s*source\(\s*[\"']([^\"']+)[\"']", text, re.MULTILINE))):
            if not (ROOT / helper).is_file():
                print(f"NOTE: optional raw-download helper is absent: {helper}")
    for name in ("ASECdata.csv", "ATUSdata.csv", "CPSdata.csv", "Informal_Formal_Crosswalk.csv", "GdpByState.csv"):
        if not (ROOT / "data/CSV" / name).is_file():
            errors.append(f"Missing current-analysis input: data/CSV/{name}")
    for name in ("FormalOccs_Crossover.csv", "ATUSActivityCrossover.csv", "workforce_area_characteristics.csv"):
        if not (ROOT / "data/CSV" / name).is_file():
            errors.append(f"Missing upstream input: data/CSV/{name}")
    population_candidates = ("nhgis_populationbytract.csv", "nighis_populationbytract.csv",
                             "Tractlevel_totalpop_acs_2009_2023.csv", "tractlevel_totalpop_acs_2009_2023.csv",
                             "Tractlevel_Employment.csv")
    if not any((ROOT / "data/CSV" / name).is_file() for name in population_candidates):
        errors.append("Missing ACS tract population denominator (one of gini.qmd's accepted filenames).")
    for stem in ("cps_00453", "cps_00452", "atus_00035", "atus_00036", "atus_00029"):
        definition = ROOT / "data/IPUMS Pulls" / (stem + ".xml")
        if not definition.is_file():
            errors.append(f"Missing raw extract definition: data/IPUMS Pulls/{stem}.xml (matching payload also required).")
        elif not any((definition.parent / (stem + suffix)).is_file() for suffix in (".dat.gz", ".dat")):
            errors.append(f"Missing raw extract payload: data/IPUMS Pulls/{stem}.dat.gz or .dat")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--pipeline", action="store_true", help="Also check the intended pipeline's scripts and core inputs; does not execute them.")
    parser.add_argument("--verify-snapshot", action="store_true", help="Compare aggregate bytes and row counts with the documented snapshot.")
    args = parser.parse_args()
    errors = []
    for rel in REQUIRED_PUBLIC:
        if not (ROOT / rel).is_file():
            errors.append(f"Missing repository file: {rel}")
    total_rows = check_tables(errors, args.verify_snapshot)
    check_crosswalks(errors, args.verify_snapshot)
    if args.pipeline:
        check_pipeline(errors)
    if errors:
        for error in errors:
            print("ERROR:", error)
        print(f"FAILED: {len(errors)} issue(s). No analysis or database operation was run.")
        return 1
    print(f"PASS: aggregate schemas, CSV structure, metadata IDs, workbooks, and required repository files; {total_rows:,} CSV data rows.")
    if args.verify_snapshot:
        print("PASS: every aggregate file matches the documented SHA-256 snapshot.")
    print("PASS: three public crosswalk schemas, code keys, and replacement activity/range mappings.")
    print("Statistical calculations and release consistency are outside these structural checks.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
