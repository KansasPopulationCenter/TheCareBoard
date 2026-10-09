# The Care Board

**Data and methods for understanding the U.S. care economy.**

The Care Board measures paid and unpaid care across households, labor markets, and places. This repository contains the aggregate tables used by [thecareboard.org](https://thecareboard.org/), dashboard metadata, and the available R/Quarto methodology and analysis code. The project is based at the Kansas Population Center, Institute for Policy & Social Research, University of Kansas.

[Explore the dashboard](https://thecareboard.org/) · [Browse the data](app_data/) · [Read the methodology](docs/METHODOLOGY.md) · [Understand the tables](docs/DATA_DICTIONARY.md) · [Pipeline restoration](docs/PIPELINE_RESTORATION.md)

## Repository status

This snapshot contains **22 aggregate data and metadata files**, **14 current pipeline documents**, and one legacy analysis. All eight previously missing scripts, their supporting helpers, three crosswalks, request sample lists, and the GDP input have been restored. Installed R/Python dependencies are captured; external source payloads, a clean dependency restore, and a verified full build remain necessary for complete replication. The supplied tables can be used directly; full regeneration requires the additions listed in [Reproducibility](docs/REPRODUCIBILITY.md).

**Version 2.0.0 was published on GitHub on October 9, 2026, ahead of the official launch on October 12, 2026.** The [published release](https://github.com/KansasPopulationCenter/TheCareBoard/releases/tag/v2.0.0) identifies the fixed snapshot in this repository. The folder was organized on October 5, 2026; the supplied estimates were not recalculated. See the [release record](docs/releases/2.0.0/README.md) for status and file checksums, and [reference periods](docs/REFERENCE_PERIODS.md) for indicator coverage and source windows. This repository contains the data pipeline; website frontend source is maintained separately.

The owner selected a sync of the current snapshot on October 6, 2026, with methodological review and corrections deferred. Known discrepancies remain documented. Existing historical material under `Previous Versions/` and `zzz_lib/` is retained at its original repository paths. See [Snapshot sync scope](docs/SNAPSHOT_SYNC.md).

## Available data

[Browse the version 2.0.0 data library](https://bit.ly/CareBoard2DataLibrary) · [View the version 2.0.0 release](https://bit.ly/CareBoard2Release)

The named links below open or download files from the published **Version 2.0.0** snapshot, identified by the `v2.0.0` tag.

### Statistical data

| Topic | Contents | Download |
| --- | --- | --- |
| Population by age | Population counts by age | [Population by age CSV](https://bit.ly/CareBoard2PopulationByAgeCSV) |
| Care needs and provision | Care need and provision by age and care focus | [Care needs and provision CSV](https://bit.ly/CareBoard2CareNeedsProvisionCSV) |
| Paid care activity definitions | Care focus and wages for paid care activities | [Paid care activities CSV](https://bit.ly/CareBoard2PaidCareActivitiesCSV) |
| Paid care activity time and population | Time and population for paid care activities | [Paid care activity time and population CSV](https://bit.ly/CareBoard2PaidCareActivityTimePopulationCSV) |
| Unpaid care activity definitions | Care focus and wages for unpaid care activities | [Unpaid care activities CSV](https://bit.ly/CareBoard2UnpaidCareActivitiesCSV) |
| Unpaid care activity time and population | Care attention, time, and population for unpaid activities | [Unpaid care activity time and population CSV](https://bit.ly/CareBoard2UnpaidCareActivityTimePopulationCSV) |
| Provider demographics | Demographic groups and provider population | [Provider demographics CSV](https://bit.ly/CareBoard2ProviderDemographicsCSV) |
| Provider care time and population | Provider time and population by care type, focus, and attention | [Provider care time and population CSV](https://bit.ly/CareBoard2ProviderCareTimePopulationCSV) |
| Care-provider group populations | Population denominators for care-provider groups | [Care-provider population CSV](https://bit.ly/CareBoard2CareProviderPopulationCSV) |
| Care-provider flows and time | Care-provider time and population by demographic group | [Care-provider flows and time CSV](https://bit.ly/CareBoard2CareProviderFlowsCSV) |
| Paid care economic and labor metrics | Paid care workforce, time, value, and parental labor indicators | [Paid care metrics CSV](https://bit.ly/CareBoard2PaidCareMetricsCSV) |
| Unpaid care economic and labor metrics | Unpaid care workforce, time, value, and parental care/labor indicators | [Unpaid care metrics CSV](https://bit.ly/CareBoard2UnpaidCareMetricsCSV) |
| Maternal income shares | Mothers' within-couple wage and salary income shares | [Maternal income shares CSV](https://bit.ly/CareBoard2MaternalIncomeShareCSV) |
| Care privilege | Care-privileged adult population and proportion | [Care privilege CSV](https://bit.ly/CareBoard2CarePrivilegeCSV) |
| Sandwich caregiving | Sandwich caregiving population and time | [Sandwich generation CSV](https://bit.ly/CareBoard2SandwichGenerationCSV) |
| Geographic care resources | Care-job Gini, location quotient, and CaRES | [Care-job Gini and CaRES CSV](https://bit.ly/CareBoard2StateCareGiniCaRESCSV) |

### Dashboard metadata

| Metadata | Contents | Download |
| --- | --- | --- |
| Provider categories | Category definitions and display order | [Provider categories CSV](https://bit.ly/CareBoard2ProviderCategoriesCSV) · [Provider categories Excel](https://bit.ly/CareBoard2ProviderCategoriesXLSX) |
| Provider groups | Provider demographic group metadata | [Provider groups Excel](https://bit.ly/CareBoard2ProviderGroupsXLSX) |
| Metric definitions | Metric and metric-group metadata | [Metric metadata Excel](https://bit.ly/CareBoard2MetricMetadataXLSX) |
| Metric labels | Dashboard labels and display types | [Metric labels CSV](https://bit.ly/CareBoard2MetricLabelsCSV) |
| Data sources | Dashboard source and explanatory notes | [Data sources CSV](https://bit.ly/CareBoard2DataSourcesCSV) |

Public tables need no database connection. Read the [table catalog](docs/DATA_DICTIONARY.md) for schemas, reference periods, populations, and units before comparing indicators. Missing values are not automatically zero. January 1 date labels identify reporting periods rather than establishing literal January observations; tables without dates need their source/release notes.

The spelling of `metrics_priviledge.csv` and `bargainin_power.qmd` is retained for compatibility with existing consumers.

### Data crosswalks

| Topic | Contents | Download |
| --- | --- | --- |
| Care activities to care focus | ATUS activity codes and care classifications | [Activity-to-care crosswalk CSV](https://bit.ly/CareBoard2ActivityCareCrosswalkCSV) |
| Occupations to care focus | Occupation codes and care classifications | [Occupation-to-care crosswalk CSV](https://bit.ly/CareBoard2OccupationCareCrosswalkCSV) |
| Occupations to care activities | Links between occupation codes and ATUS activities | [Occupation-to-activity crosswalk CSV](https://bit.ly/CareBoard2OccupationActivityCrosswalkCSV) |

## Documentation and code

### Methodology and documentation

| Topic | Contents | Open or download |
| --- | --- | --- |
| Methodology | Written methodology overview | [Read the methodology](https://bit.ly/CareBoard2Methods) |
| Data dictionary | Table schemas, populations, and units | [Read the data dictionary](https://bit.ly/CareBoard2DataDictionary) |
| Reference periods | Reporting labels and source windows | [Read the reference periods](https://bit.ly/CareBoard2ReferencePeriods) |
| Crosswalk guide | Crosswalk structure and interpretation | [Read the crosswalk guide](https://bit.ly/CareBoard2CrosswalkGuide) |
| Reproduction guide | Inputs, execution safeguards, and replication limits | [Read the reproduction guide](https://bit.ly/CareBoard2ReproductionGuide) |
| Master methodology source | Master methodology and ordered pipeline | [Master methodology QMD](https://bit.ly/CareBoard2MasterMethodologyQMD) |

### Pipeline code

These links provide Quarto source documents. For environment setup and execution safeguards, see [Reproducibility](docs/REPRODUCIBILITY.md).

| Topic | Contents | Source |
| --- | --- | --- |
| IPUMS downloads | IPUMS extraction and download requests | [IPUMS download code QMD](https://bit.ly/CareBoard2IPUMSDownloadQMD) |
| Microdata processing | Prepare the analysis input data | [Microdata processing code QMD](https://bit.ly/CareBoard2MicrodataProcessingQMD) |
| Population by age | Compile population-by-age statistics | [Population by age code QMD](https://bit.ly/CareBoard2PopulationByAgeQMD) |
| Care needs and provision | Compile care need and provision statistics | [Care needs and provision code QMD](https://bit.ly/CareBoard2CareNeedsProvisionQMD) |
| Paid care activities | Compile paid care activity statistics | [Paid care activities code QMD](https://bit.ly/CareBoard2PaidCareActivitiesQMD) |
| Unpaid care activities | Compile unpaid care activity statistics | [Unpaid care activities code QMD](https://bit.ly/CareBoard2UnpaidCareActivitiesQMD) |
| Provider demographics | Compile provider demographics and care statistics | [Provider demographics code QMD](https://bit.ly/CareBoard2ProviderDemographicsQMD) |
| Care-provider groups | Compile care-provider group populations and time | [Care-provider groups code QMD](https://bit.ly/CareBoard2CareProviderFlowsQMD) |
| Broader economic impacts | Compile workforce, time, value, and parental labor metrics | [Broader impacts code QMD](https://bit.ly/CareBoard2BroadImpactsQMD) |
| Maternal income shares and care privilege | Compile maternal income share and care-privilege indicators | [Maternal income share and care privilege code QMD](https://bit.ly/CareBoard2MaternalIncomeShareQMD) |
| Sandwich caregiving | Compile sandwich-generation statistics | [Sandwich generation code QMD](https://bit.ly/CareBoard2SandwichGenerationQMD) |
| Care-job Gini and CaRES | Compile geographic care-job inequality and CaRES | [Care-job Gini and CaRES code QMD](https://bit.ly/CareBoard2StateCareGiniCaRESQMD) |
| Parental labor monitor | Compile parental labor monitor statistics | [Parental labor monitor code QMD](https://bit.ly/CareBoard2ParentalLaborMonitorQMD) |
| Warehouse upload | Load prepared data and metadata into the warehouse | [Warehouse upload code QMD](https://bit.ly/CareBoard2WarehouseUploadQMD) |

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
