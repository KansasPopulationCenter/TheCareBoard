# Repository preparation record

Preparation date: October 5, 2026. This records organization and structural checks, not a statistical release.

This record preserves the initial preparation and subsequent restoration stages. For the current complete source inventory and validation limits, see [Pipeline restoration](PIPELINE_RESTORATION.md).

## Changes

- Separated analysis documents, shared helpers, public documentation, aggregate data, source-access records, and local-only material.
- Kept all original aggregate files unchanged and retained originals of modified source/documents in ignored local backups.
- Updated helper/connection/reference paths for the new layout. Statistical expressions in the individual analytic QMDs were not changed.
- Made the master default to documentation mode. It labels missing sections and stops selected execution before child analyses when scripts are absent.
- Added an introduction, contribution/citation files, data dictionary/schema, inventories, upload guide, connection example, and structural checker.

## Initial verification before source restoration

All 22 original aggregate files match their original SHA-256 values. Structural checks cover the 19 CSV schemas, row shapes, geography/date formats, selected metadata IDs, and three workbook ZIP structures/sheet names. The supplied CSV tables contain 95,913 data rows.

All 125 R chunks and both shared/example R files parsed successfully under the available R 4.4.0 and R 4.3.2 installations without evaluating their analyses. No pipeline regeneration, IPUMS extract request, warehouse connection/write, GitHub push, or website deployment occurred.

The master safeguard was checked directly: documentation mode selects no child execution, eight missing sections are identified, and execution mode stops before the analytic loader when selected scripts are absent. Quarto project inspection and YAML parsing succeeded. Public Markdown links, Git ignore decisions (including credential/input probes), and a targeted scan for literal credentials and private user paths were checked. These scans are structural checks, not a guarantee that every scientific or editorial issue has been identified.

A rendered master preview remains unverified in this environment: the available R library paths lack `knitr` and `rmarkdown`. Install/use the project's working documentation environment before rendering. Full statistical replication additionally needs the eight missing pipeline documents and source inputs listed in [Reproducibility](REPRODUCIBILITY.md).

The upload guide is a publication recommendation. Scientific review and unresolved source provenance remain the project owner's decisions. The approved licensing and release metadata are recorded below.

## Licensing completed October 5, 2026

The owner confirmed ownership of the project materials, permission to allow reuse including commercial use, and no existing licensing requirements. The approved copyright-holder name is Kansas Population Center, University of Kansas. MIT applies to code; CC BY 4.0 applies to project-created aggregate data, metadata, and written methodology. The public scope distinguishes code and prose within QMD documents and preserves separate third-party source terms. License texts, README/citation metadata, and the upload manifest were updated without altering aggregate data.

## Version 2.0.0 metadata prepared October 5, 2026

The owner selected an update to `https://github.com/KansasPopulationCenter/TheCareBoard`, confirmed the existing author order (Misty Heggeness, Joseph Bommarito, Lucie Prewitt), and approved Version 2.0.0 with planned public availability on October 12, 2026. Citation metadata and sync guidance now reflect those decisions. No release tag or commit was invented, and no GitHub publication occurred.

The [reference-period report](REFERENCE_PERIODS.md) compiles observed nonmissing date coverage for all 34 dated numeric fields, source notes for undated tables, and window rules in the available code. The [release record](releases/2.0.0/README.md) retains accompanying file checksums. At this preparation stage, source payloads and eight pipeline documents were absent; the later restoration recovered the code, while original source vintages and generation-run provenance remain unverified. The report identifies the unknown parental CPS ending month and the Circle of Care source-note/unpaid-wage-code discrepancy without changing supplied data or statistical expressions.

## Pipeline restoration completed October 5, 2026

All eight missing QMDs, four additional helpers, two existing checks, eldercare documentation, three crosswalks, two request lists, and the GDP input are restored. The earlier missing-script and 125-chunk checks above describe the initial preparation state. The current state and additional validation are recorded in [Pipeline restoration](PIPELINE_RESTORATION.md). Source/helper paths and CPS/ASEC metadata references were aligned; formulas and all 22 supplied dashboard payloads were preserved. Internal working reviews, added PDFs, and original recovered-file backups remain excluded from Git. Source access and a verified full environment/run remain outstanding.

### Verification after full pipeline restoration

On October 5, 2026, all 199 embedded R chunks, eight standalone helper/example/test R files, and two embedded Python chunks parsed successfully without evaluating the statistical pipeline. The master safeguard passed with all 14 required files present and rejected a simulated missing script before loading dependencies. Existing provider-window regression checks passed. All 703 supplied CaRES values agree with the recovered scaling formula within `1e-12`; the underlying source-data Gini/LQ were not rebuilt. Crosswalk schemas, numbered keys, replacement mappings, aggregate schemas, and the 22 original payload hashes passed structural checks.

The existing eldercare check was attempted in R 4.4.0 but could not execute because `data.table` is unavailable in this environment. Full dependency verification, source-input access, rendering, and statistical regeneration remain future work. No database writes or GitHub publication occurred.

## Owner-confirmed input inventory

On October 5, 2026, the owner confirmed that the external working-folder inputs produced the supplied app_data and that no other input locations exist. The source manifest now preserves observed file sizes, DDI production/version dates, sample/variable request metadata, source access instructions, and available SHA-256 values. [Source inputs](SOURCE_INPUTS.md) and [input provenance](releases/2.0.0/input_provenance.json) distinguish completed fingerprints from pending large-file reads and retain unrecorded historical publisher releases as explicit limits. The relationship extract's requested years end in 2024 while the activity extract includes 2025; this was recorded for scientific review without changing supplied estimates. No raw/cleaned records were copied into the public package, and no statistical regeneration or database/GitHub write occurred.

## Environment capture and verification October 6, 2026

The owner selected R 4.4.0. Its existing user library was identified, correcting the earlier default-library limitation. Installed package versions and their dependencies were captured in `renv.lock`, with renv activation/settings and the selected dependency list. Reticulate discovered Python 3.11.14; pandas, NumPy, matplotlib, and their required installed dependencies were pinned in `requirements.txt`. Quarto 1.8.27 was recorded. Machine-specific paths, local libraries, and private session evidence remain excluded from GitHub.

All 24 selected R packages loaded. The unchanged provider-window and eldercare regression checks passed; synthetic DataFrame conversion between R and Python and in-memory matplotlib rendering passed. The master rendered to HTML with all analysis/download/database flags false. Aggregate structure and all 22 original payload hashes passed. The [environment record](releases/2.0.0/environment.json) preserves the evidence and limits. This capture does not establish the original generation environment, a clean dependency restore, or a verified full statistical rebuild. Source fingerprints and scientific/source-period review remain outstanding. No app_data recalculation, database write, or GitHub publication occurred.

## Snapshot sync scope selected October 6, 2026

The owner chose to sync the materials as currently supplied and defer methodological review, source-note corrections, and troubleshooting to subsequent work. Existing calculations and the 22 supplied app_data files remain unchanged. Known discrepancies, incomplete external fingerprints, and unverified restoration/rebuild limits remain recorded for follow-up. This update is a data-and-methods snapshot, without a claim of statistical regeneration or completed methodological review.
