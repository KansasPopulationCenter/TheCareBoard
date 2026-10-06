# The Care Board

**Data and methods for understanding the U.S. care economy.**

The Care Board measures paid and unpaid care across households, labor markets, and places. This repository contains the aggregate tables used by [thecareboard.org](https://thecareboard.org/), dashboard metadata, and the available R/Quarto methodology and analysis code. The project is based at the Kansas Population Center, Institute for Policy & Social Research, University of Kansas.

[Explore the dashboard](https://thecareboard.org/) · [Browse the data](app_data/) · [Read the methodology](docs/METHODOLOGY.md) · [Understand the tables](docs/DATA_DICTIONARY.md) · [Pipeline restoration](docs/PIPELINE_RESTORATION.md)

## Repository status

This snapshot contains **22 aggregate data and metadata files**, **14 current pipeline documents**, and one legacy analysis. All eight previously missing scripts, their supporting helpers, three crosswalks, request sample lists, and the GDP input have been restored. Installed R/Python dependencies are captured; external source payloads, a clean dependency restore, and a verified full build remain necessary for complete replication. The supplied tables can be used directly; full regeneration requires the additions listed in [Reproducibility](docs/REPRODUCIBILITY.md).

**Version 2.0.0 is scheduled for public release on October 12, 2026** in the [existing repository](https://github.com/KansasPopulationCenter/TheCareBoard). The folder was organized on October 5, 2026; the supplied estimates were not recalculated. See the [release record](docs/releases/2.0.0/README.md) for status and file checksums, and [reference periods](docs/REFERENCE_PERIODS.md) for indicator coverage and source windows. This repository contains the data pipeline; website frontend source is maintained separately.

The owner selected a sync of the current snapshot on October 6, 2026, with methodological review and corrections deferred. Known discrepancies remain documented. Existing historical material under `Previous Versions/` and `zzz_lib/` is retained at its original repository paths. See [Snapshot sync scope](docs/SNAPSHOT_SYNC.md).

## Available data

| Topic | Files in `app_data/` |
| --- | --- |
| Care needs and provision | `market.csv`, `market_datum.csv` |
| Paid care activities | `activity_formal.csv`, `activity_formal_datum.csv` |
| Unpaid care activities | `activity_informal.csv`, `activity_informal_datum.csv` |
| Care providers | `provider.csv`, `provider_datum.csv`, `care_provider_population.csv`, `care_provider_datum.csv` |
| Broader economic impacts | `metrics_formal.csv`, `metrics_informal.csv` |
| Household measures | `metrics_maternal_power.csv`, `metrics_priviledge.csv`, `metrics_sandwich_generation.csv` |
| Geographic care resources | `metrics_state_care_gini.csv` |
| Dashboard metadata | `provider_category.csv`, `provider_category.xlsx`, `provider_group.xlsx`, `metric_tables.xlsx`, `metric_labels.csv`, `source.csv` |

Download individual CSVs from `app_data/` or clone/download the repository. Public tables need no database connection. Read the [table catalog](docs/DATA_DICTIONARY.md) for schemas, reference periods, populations, and units before comparing indicators. Missing values are not automatically zero. January 1 date labels identify reporting periods rather than establishing literal January observations; tables without dates need their source/release notes.

The spelling of `metrics_priviledge.csv` and `bargainin_power.qmd` is retained for compatibility with existing consumers.

## Project layout

```text
TheCareBoard_Master.qmd      Master methodology and ordered pipeline
_quarto.yml                 Render scope and computation/output directories
analysis/                   Available analyses and warehouse-upload logic
  legacy/                   Superseded care-ratio analysis
R/                          Shared R helpers
app_data/                   Dashboard aggregate tables and metadata
config/                     Credential-free database example
data/                       Input-access manifest; source payloads excluded
docs/                       Methodology, data catalog, and publishing guides
scripts/                    Structural repository checks
renv.lock, requirements.txt Captured R and Python dependencies
renv/                       R environment activation; local libraries ignored
generated/                  Local rendered documents; ignored by Git
local_only/                 Credentials, notes, drafts, media, backups; ignored
```

## Preview the methodology

See [Software environment](docs/ENVIRONMENT.md) for R 4.4.0, the captured R/Python dependencies, and setup. Restore the R packages before using Quarto. Run from the repository root:

```powershell
quarto render TheCareBoard_Master.qmd --to html -P execute_pipeline:false -P run_ipums_download:false -P run_database_upload:false
```

Output goes to `generated/`. The master defaults to documentation mode and labels missing sections. This preview does not regenerate or validate statistical estimates. Individual analytic QMDs can execute when rendered directly; see [Reproducibility](docs/REPRODUCIBILITY.md) before using them. PDF output additionally needs TeX.

Run structural checks with Python 3.9 or newer and no third-party Python packages:

```powershell
python scripts/check_repository.py
python scripts/check_repository.py --pipeline
```

The second command also checks pipeline inputs. All scripts and helpers are present; it reports source payloads absent from CB even when they are available in the owner's external storage. Make authorized inputs available at the expected paths before a full build. [Source input records](docs/SOURCE_INPUTS.md) distinguish confirmed input metadata from pending external fingerprints. Neither command runs analyses, submits extracts, or connects to the warehouse.

## Citation and contributions

Copyright (c) 2026 Kansas Population Center, University of Kansas. Project code is available under the [MIT License](LICENSE); project-created aggregate data, metadata, and written methodology are available under [CC BY 4.0](LICENSES/CC-BY-4.0.txt). Both allow commercial reuse subject to their notice/attribution requirements. Code within QMD documents uses MIT; their narrative text uses CC BY 4.0. See [citation and licensing](docs/LICENSE_AND_CITATION.md) for scope and credit, and [CITATION.cff](CITATION.cff) for citation metadata. Source-data terms remain separate.

Read [CONTRIBUTING.md](CONTRIBUTING.md) before changing measures or metadata. Project questions: [careboard@ku.edu](mailto:careboard@ku.edu). Maintainers preparing a public upload should use the [GitHub upload guide](docs/GITHUB_UPLOAD_GUIDE.md) and [file-by-file manifest](docs/FILE_MANIFEST.csv).
