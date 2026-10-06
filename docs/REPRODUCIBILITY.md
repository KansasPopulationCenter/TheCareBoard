# Reproducibility and setup

The supplied aggregate tables can be used directly. **All eight missing pipeline scripts and their required helpers are now restored from the owner's working folder.** The three crosswalks, optional request sample lists, and GDP input are present. A full rebuild still requires source payloads and a verified execution environment.

## Restored code

`analysis/` contains all 14 steps referenced by the master. The recovered documents are `IPUMS_API.qmd`, `data_processing.qmd`, `market.qmd`, `market_datum.qmd`, `provider.qmd`, `gini.qmd`, `sandwich_generation.qmd`, and `parental_labor_monitor.qmd`.

`R/` contains the existing `load_defaults.R` plus recovered `load_libraries.R`, `data_prep_functions.R`, `atus_eldercare.R`, and `refresh_atus_eldercare.R`. Source references now resolve from the repository root. The preprocessing helper's CPS/ASEC metadata paths were aligned with the recovered preprocessing document (`cps_00453`/`cps_00452`); its original older references are preserved in local backups. No statistical expressions or supplied estimates were changed.

See [restoration record](PIPELINE_RESTORATION.md), [crosswalks](CROSSWALKS.md), and [eldercare documentation](ATUS_ELDERCARE.md). The existing provider-window and eldercare checks are under `tests/`.

## Inputs still required

[Input manifest](../data/input_manifest.csv) identifies current paths and observed file status. Raw preprocessing needs XML/payload pairs for CPS `cps_00453`, ASEC `cps_00452`, ATUS activities `atus_00035`, and the eldercare roster `atus_00036`. Market need/provision also needs `atus_00029`. The cleaned outputs consumed by analyses are `CPSdata.csv`, `ASECdata.csv`, and `ATUSdata.csv` under `data/CSV/`.

Gini/LQ/CaRES additionally needs `workforce_area_characteristics.csv` and a compatible ACS tract population file. `gini.qmd` accepts the two NHGIS filename spellings and listed long-file alternatives; it validates their columns when run. The owner confirmed that the external working-folder inputs produced the supplied exports. [Source inputs](SOURCE_INPUTS.md) documents observed sizes, DDI version dates, requested samples, acquisition instructions, and current fingerprint status. Large source records have not been copied into CB. Historical publisher releases/assembly parameters remain explicitly unrecorded where evidence is absent; pending external SHA-256 reads remain item 4.

Source records stay outside the public Git allowlist. See [IPUMS CPS terms](https://cps.ipums.org/cps/terms.shtml) before redistributing extracts. Recreating a request with new account-specific extract numbers requires updating the corresponding code metadata paths together.

## Environment

Documentation preview needs R, Quarto, `knitr`, and `rmarkdown`. The analysis helper loads `pacman`, `tidyverse`, `data.table`, `haven`, `janitor`, `ggplot2`, `scales`, `DescTools`, `Hmisc`, `slider`, `readxl`, `rlang`, `skimr`, `DT`, and `writexl`. The recovered loader also requires `ipumsr`; the parental monitor uses `reticulate`, pandas, NumPy, and matplotlib. It can install missing Python modules during execution. Helper sourcing can install missing R packages.

Warehouse operations need `DBI` and `RPostgres`. Legacy care-ratio dependencies remain separate. Rendering PDFs requires TeX; monitor fonts/graphics should be checked in the intended environment. On October 6, 2026, installed dependencies were captured under the owner-selected R 4.4.0 in `renv.lock`, with Python 3.11.14 package pins in `requirements.txt` and Quarto 1.8.27 recorded. All 24 selected R packages loaded, and the existing checks, R/Python smoke check, and documentation HTML render passed. See [Software environment](ENVIRONMENT.md) for setup and evidence. Clean restoration and the full statistical build remain unverified; this capture does not prove the original generation environment.

## Checks and execution

Run checks from the repository root:

```powershell
python scripts/check_repository.py --verify-snapshot
python scripts/check_repository.py --pipeline
Rscript tests/provider_window.R
Rscript tests/atus_eldercare.R
quarto render TheCareBoard_Master.qmd --to html -P execute_pipeline:false -P run_ipums_download:false -P run_database_upload:false
```

The structural snapshot check covers dashboard payloads and public crosswalks. The pipeline check is still expected to report missing source inputs; it no longer reports missing scripts/helpers. The provider check needs base R; the eldercare check needs `data.table`. Restore the project environment before running these commands; normal Rscript startup loads the tracked `.Rprofile`. Documentation mode evaluates no child analyses and labels any future missing sections. An HTML render passed on October 6, 2026; it does not validate the statistical estimates.

After source inputs and dependencies are verified, a deliberate full preprocessing/analysis build uses:

```powershell
quarto render TheCareBoard_Master.qmd --to html -P execute_pipeline:true -P run_ipums_download:false -P run_database_upload:false
```

This executes preprocessing and updates aggregate/replication outputs; it needs the raw extracts even when cleaned CSVs already exist. Run in a working copy and compare with the preserved release snapshot before replacing results. Downloads and warehouse uploads remain opt-in. No full build, extract request, or database write was performed during restoration.

## Database connection

[config/db_connect.example.R](../config/db_connect.example.R) documents the `CAREBOARD_DB_*` environment variables. Local connections remain under ignored `local_only/credentials/`. Public data access and documentation previews need no credentials. The upload document performs deletion/reloads and view refreshes when intentionally executed.
