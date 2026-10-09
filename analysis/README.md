# Analysis documents

All 14 documents referenced by [TheCareBoard_Master.qmd](../TheCareBoard_Master.qmd) are present: 12 preprocessing/analysis/monitor steps plus optional IPUMS download and warehouse upload. Eight missing documents were recovered from the owner's working folder. Shared helpers are under `R/`; computations use the repository root.

The master defaults to documentation mode. Rendering an individual analytic QMD can execute it and rewrite outputs. IPUMS submission and warehouse upload are explicit maintainer operations. Recovered scripts do not establish a successful full statistical rebuild; source payloads and a verified environment are still required.

The parental labor monitor is a separate monthly communication product with Python figures; its replication tables are outside `app_data/`. Its social PNG is ignored by Git. See [restoration record](../docs/PIPELINE_RESTORATION.md), [Reproducibility](../docs/REPRODUCIBILITY.md), and [reference periods](../docs/REFERENCE_PERIODS.md).

`legacy/care_ratio.qmd` remains outside the active pipeline. CaRES is the current replacement for that panel. Existing filename spellings are preserved for compatibility.
