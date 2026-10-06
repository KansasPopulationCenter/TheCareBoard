# Dashboard data and metadata

This folder contains 19 aggregate/metadata CSVs and three XLSX metadata workbooks. All original 22 files were preserved byte for byte during organization.

Project-created aggregate data and metadata are licensed under [CC BY 4.0](../LICENSES/CC-BY-4.0.txt). Credit The Care Board, Kansas Population Center, University of Kansas; retain supplied notices and identify changes when sharing adaptations. See [citation and licensing](../docs/LICENSE_AND_CITATION.md) for the full scope and suggested citation.

- [Data dictionary](../docs/DATA_DICTIONARY.md): roles, exact columns, rows, observed dates, and cautions.
- [Snapshot inventory](../docs/APP_DATA_INVENTORY.csv): sizes, SHA-256 checksums, rows, and reporting labels.
- [Reference periods](../docs/REFERENCE_PERIODS.md): indicator coverage, pooled windows, and source-note limits for Version 2.0.0.
- [Release record](../docs/releases/2.0.0/README.md): planned October 12, 2026 publication and accompanying file checksums.
- [Schema](../docs/app_data_schema.json): expected columns for structural checks.
- [Methodology](../docs/METHODOLOGY.md): available code and missing sections.

Preserve filenames/fields used by dashboard consumers. `metrics_priviledge.csv` retains its existing spelling; `geo` and `geo_level` are literal field names; `metric_tables.xlsx` is read during upload.

`national` is the national aggregate; values such as `state20` identify states using the two-digit FIPS suffix (20 is Kansas). Geographic coverage varies. Counts can be weighted estimates, and time fields can be aggregate rather than per-person. Missing cells are not automatically zero.

Catalog date ranges describe labels appearing anywhere in a table, not complete coverage for each indicator. The reference-period record compiles available code and source notes for undated tables and identifies what remains unverified. These are supplied outputs, not estimates recalculated during organization.
