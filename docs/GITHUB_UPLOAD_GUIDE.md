# GitHub upload guide

CB is organized for a public data-and-methods update to the [existing repository](https://github.com/KansasPopulationCenter/TheCareBoard). The owner selected that repository for Version 2.0.0, scheduled for October 12, 2026. The 101-file snapshot was pushed on October 6, 2026 to [careboard-2.0.0-snapshot](https://github.com/KansasPopulationCenter/TheCareBoard/tree/careboard-2.0.0-snapshot), with [draft pull request #2](https://github.com/KansasPopulationCenter/TheCareBoard/pull/2). The default `main` branch and existing historical paths were retained. No formal release or release tag was created. CB itself remains the preparation folder; the separate clone is held in ignored local storage.

## Upload

| Path | Purpose |
| --- | --- |
| `README.md`, `CONTRIBUTING.md`, `CITATION.cff` | Introduction, contribution process, citation. |
| `.gitignore`, `.gitattributes`, `_quarto.yml` | Exclusions, file handling, render configuration. |
| `.Rprofile`, `renv.lock`, `renv/activate.R`, `renv/settings.json`, `renv/.gitignore`, `renv/LICENSE`, `renv/README.md`, `requirements.txt`, `config/r-packages.txt` | Project environment activation, captured dependencies, upstream renv notice, and Python pins; exclude local package libraries. |
| `LICENSE`, `LICENSES/CC-BY-4.0.txt` | Approved MIT code license and CC BY 4.0 data/documentation license. |
| `TheCareBoard_Master.qmd` | Master methodology and run order. |
| `analysis/`, including `legacy/` | All 14 current pipeline QMDs and one labeled legacy QMD. |
| `R/`, `tests/` | Shared/preprocessing/eldercare helpers and existing checks. |
| `app_data/` | All 19 CSVs, three XLSX metadata workbooks, and folder README. |
| `config/db_connect.example.R` | Credential-free example. |
| `docs/` | Methodology, dictionary, schemas, inventories, and publishing guidance. |
| `data/README.md`, `data/input_manifest.csv`, six allowlisted `data/CSV/` inputs | Source access record, three crosswalks, two request lists, GDP input. |
| `scripts/check_repository.py` | Structural checks. |
| `.github/pull_request_template.md` | Change and validation template. |

[FILE_MANIFEST.csv](FILE_MANIFEST.csv) lists every current file individually. `UPLOAD` means recommended repository inclusion; it does not certify a statistical release or assign reuse rights.

## Do not upload

| Location | Reason |
| --- | --- |
| `local_only/credentials/db_connect.r` | Local connection details. |
| `local_only/state/.Rhistory` | Local history may contain private values and paths. |
| `local_only/notes/CareBoardNotes.docx` | Internal notes. |
| `local_only/research/care_privilege_atus_privilege_focus.docx` | Research draft; publication status unresolved. |
| `local_only/press_release/` | Draft figures, notes, media calculations, and ZIP pending editorial/publication review. |
| `local_only/preparation/` | Backups, preparation scripts, and local audits. |
| `local_only/recovered_reviews/` | Internal historical release, provider, and sandwich review records. |
| `generated/` | Existing PDFs and previews; publish a reviewed current artifact separately if desired. |
| Other source payloads under `data/` | Raw/cleaned records, large geographic inputs, and replication exports remain excluded; six small inputs are explicitly allowlisted. |
| Keys, environments, libraries, caches, editor state | Local configuration/generated material. |

Draft Word/media materials may be published later after reviewing authorship, source years, graphics, and editorial notes. Copy only approved content into a deliberate public location or release. No local source files were discarded.

**Browser uploads do not apply `.gitignore` to files you drag into GitHub.** Choose only the manifest's `UPLOAD` files or use a Git client that honors the ignore rules. Do not drag the whole CB folder into a browser upload.

## Preparation status and follow-up review

On October 6, 2026, the owner chose to sync the current data-and-methods snapshot and defer methodological review and corrections. The unresolved items below remain documented. They do not block this snapshot upload; do not describe it as a verified statistical rebuild.

See [Snapshot sync scope](SNAPSHOT_SYNC.md) for the existing repository baseline and historical paths retained by this update.

1. **Completed October 5, 2026:** the owner approved open reuse, including commercial reuse. `LICENSE` applies MIT to code; `LICENSES/CC-BY-4.0.txt` applies CC BY 4.0 to project-created aggregate data, metadata, and prose. The copyright holder is Kansas Population Center, University of Kansas. See [licensing scope](LICENSE_AND_CITATION.md).
2. **Metadata confirmed October 5, 2026:** update `KansasPopulationCenter/TheCareBoard`; retain Misty Heggeness, Joseph Bommarito, and Lucie Prewitt in that order; use Version 2.0.0 with planned public date October 12, 2026. `CITATION.cff`, the [reference-period report](REFERENCE_PERIODS.md), and [release provenance](releases/2.0.0/README.md) are prepared. At publication, record the actual commit/tag and date. The report identifies timing details that cannot be recovered from the supplied files and one source-note/code discrepancy for review under item 6.
3. **Completed October 5, 2026 for file recovery:** all eight missing pipeline QMDs, required helpers, three crosswalks, request sample lists, GDP input, and existing checks were recovered from the owner's working directory. All master steps are present. See [restoration record](PIPELINE_RESTORATION.md); full replication still needs items 4 and 5 and a verified run.
4. **Input set confirmed October 5, 2026; fingerprint work in progress:** the owner confirmed that the working-folder inputs produced the supplied exports and that no other input locations exist. `data/input_manifest.csv` now records observed sizes, extract version dates/sample lists, access instructions, and available hashes. [Source inputs](SOURCE_INPUTS.md) and [input provenance](releases/2.0.0/input_provenance.json) track pending external checksums and explicitly unrecorded historical BEA/LODES/NHGIS publisher versions. Pending external fingerprints remain a follow-up task; the published package retains their explicit status. Source records remain outside GitHub.
5. **Environment captured and available checks passed October 6, 2026:** owner-selected R 4.4.0; `renv.lock` and activation files; Python 3.11.14 pins in `requirements.txt`; Quarto 1.8.27. All 24 selected R packages loaded. Provider-window/eldercare checks, an R/Python plotting smoke check, and documentation-mode HTML rendering passed. See [Software environment](ENVIRONMENT.md). A fresh dependency restore and full statistical build remain unverified; the original generation environment is not established by this capture.
6. **Deferred by the owner October 6, 2026:** methodological review, source-note corrections, and any recalculation will follow the GitHub sync. [Reference periods](REFERENCE_PERIODS.md) retains the pooled-ASEC source note versus latest-year unpaid wage code, conditional parental CPS endpoint, ATUS relationship coverage gap, and other review details. The current calculations, source notes, and supplied estimates are retained. Structural checks alone do not audit the statistics.

Optional improvements: reviewed methodology HTML/PDF, a release DOI/archive, a dataset changelog, and automated structural checks.

## Sync

1. Clone the existing repository into a separate checkout using GitHub Desktop or your Git client. Create a branch for the Version 2.0.0 update so the existing history is preserved.
2. Copy only CB's `UPLOAD` files into that checkout, retaining their relative paths. Keep `local_only/`, `generated/`, and source payloads out. Compare old and new paths before removing or replacing previously tracked files; check dashboard scripts and links that depend on them.
3. Run `python scripts/check_repository.py` in the updated checkout. Review the file manifest, Git changes, and staged files. Refresh the planned release checksums if the files change.
4. Commit the reviewed update and open a pull request to the existing repository. Check rendered README links and coordinate the planned publication date with merging/release visibility.
5. On the actual publication date, finalize the release record and citation date, record the final commit, and create the intended `v2.0.0` tag/GitHub release. Preserve historical releases and their provenance. The tag/release has not been created by this preparation work.

Ignore rules do not remove tracked files or past copies; see [GitHub's ignore guidance](https://docs.github.com/en/get-started/git-basics/ignoring-files). Previously exposed credentials require separate maintainer action.

All recommended repository uploads in CB are below the [100 MiB ordinary-file limit](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github). The aggregate package does not need Git LFS. Large source inputs remain in external storage.
