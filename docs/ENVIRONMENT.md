# Software environment

On October 6, 2026, the owner selected **R 4.4.0**. Installed package versions were captured from the existing R 4.4 user library, without upgrading packages. R/reticulate discovered an existing Python installation, and the R/Python connection was tested with that interpreter. This records the environment available during preparation; it does not establish the environment that originally generated `app_data`.

| Component | Recorded version or file |
| --- | --- |
| R | 4.4.0 |
| R environment manager | renv 1.0.7 |
| R packages | [renv.lock](../renv.lock); selected dependencies in [config/r-packages.txt](../config/r-packages.txt) |
| Quarto | 1.8.27 |
| Python | 3.11.14 |
| Python modules used by the monitor | pandas 1.5.3; NumPy 1.26.4; matplotlib 3.8.0 |
| Python package pins | [requirements.txt](../requirements.txt), including required transitive packages |
| Verification evidence | [environment record](releases/2.0.0/environment.json) |

## Restore R packages

Use R 4.4.0 and open an R/RStudio session with the repository root as the working directory. The tracked `.Rprofile` activates the project environment. Restore the recorded versions in the R console:

```r
renv::restore()
```

If starting R with startup profiles disabled, first run `source("renv/activate.R")`. Restoration installs project packages and can download archived versions; allow it to complete before running checks. See the official [renv restore documentation](https://rstudio.github.io/renv/reference/restore.html). PDF rendering additionally requires a TeX installation; only HTML rendering was tested here.

The captured selection covers current analyses, documentation, IPUMS/Census helpers, and optional warehouse access. Database packages do not authorize or configure warehouse writes. The legacy care-ratio document has additional dependencies (`lctools`, `doParallel`, and `foreach`) outside this selection. The optional `getPass` package was absent; the existing key helper provides its own input fallback.

Some installed Windows packages were built under later R 4.4 patch releases. All 24 selected packages loaded successfully under R 4.4.0, but package loading does not exercise every function. A restore into a fresh project library and a full statistical build remain unverified.

## Restore Python packages

Use Python 3.11.14. From the repository root, the following PowerShell commands create an ignored project environment and install the pins:

```powershell
python --version
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
$env:RETICULATE_PYTHON = (Resolve-Path '.\.venv\Scripts\python.exe').Path
```

Set `RETICULATE_PYTHON` before starting R/Quarto from that shell. In an already open R session, select it before any Python module is loaded:

```r
Sys.setenv(RETICULATE_PYTHON = normalizePath(".venv/Scripts/python.exe"))
```

Use `.venv/bin/python` on macOS/Linux. See the official [Python virtual environment instructions](https://docs.python.org/3.11/library/venv.html), [pip requirements documentation](https://pip.pypa.io/en/stable/user_guide/#requirements-files), and [reticulate interpreter selection](https://rstudio.github.io/reticulate/reference/use_python.html).

The existing monitor can install missing Python modules, and the R loaders can install missing packages. Restore the pins and select the interpreter before running the pipeline. The requirements record installed versions; fresh installation and cross-platform execution have not been tested. Machine-specific Python paths, local libraries, and environments are excluded from GitHub. Conda's solver plugin emitted messages during discovery; direct Python imports and the R/Python smoke check succeeded. Conda environment management was not validated.

## Verification during preparation

Under R 4.4.0 on Windows, the existing provider-window and eldercare regression checks passed. A synthetic DataFrame passed between R and Python, and matplotlib rendered a plot in memory. Quarto 1.8.27 rendered the master to HTML with all analysis/download/database flags false. Aggregate structure and original payload hashes also passed. The checks did not regenerate the statistical tables.

After restoring packages, run from the repository root:

```powershell
Rscript tests/provider_window.R
Rscript tests/atus_eldercare.R
python scripts/check_repository.py --verify-snapshot
quarto render TheCareBoard_Master.qmd --to html -P execute_pipeline:false -P run_ipums_download:false -P run_database_upload:false
```

Use an Rscript from R 4.4.0. These commands allow the project `.Rprofile` to load the restored library. Private verification used the installed user library explicitly; it did not prove a clean restore. A full build additionally needs the [external source inputs](SOURCE_INPUTS.md) and the source-period/scientific review in [the upload guide](GITHUB_UPLOAD_GUIDE.md).

## Maintain the capture

After deliberate dependency changes and verification, refresh the R lock from the selected package list:

```r
renv::snapshot(packages = readLines("config/r-packages.txt"))
```

Update Python pins only from the chosen pipeline interpreter. Preserve the capture date, test results, and limits in the release environment record, then refresh the release file checksums.
