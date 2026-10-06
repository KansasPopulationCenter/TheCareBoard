# The Care Board — Version 2.0.0 release record

**Formal release status: scheduled.** The owner approved the release for **October 12, 2026**. This record was prepared on October 5, 2026. The current snapshot was uploaded to an update branch on October 6, 2026 with [draft pull request #2](https://github.com/KansasPopulationCenter/TheCareBoard/pull/2); the pull request is not merged, and no formal GitHub release or release tag has been created.

| Item | Recorded value |
| --- | --- |
| Repository | [KansasPopulationCenter/TheCareBoard](https://github.com/KansasPopulationCenter/TheCareBoard); update the existing repository |
| Version | 2.0.0 |
| Planned public date | 2026-10-12 |
| Actual public date | Not yet recorded |
| Authors, in approved order | Misty Heggeness; Joseph Bommarito; Lucie Prewitt |
| Copyright holder | Kansas Population Center, University of Kansas |
| Dataset/documentation license | CC BY 4.0 |
| Code license | MIT |
| Intended release tag | `v2.0.0`; not yet created |
| Release commit | Not yet assigned; the published tag/release must identify the full commit hash |
| DOI | None assigned in supplied materials |

## Contents and provenance

The supplied package has 19 CSVs and three XLSX metadata workbooks. All 22 original data/metadata files remain byte-identical to the files supplied for preparation. No statistical regeneration occurred. All 14 current pipeline QMDs, the legacy QMD, master methodology, five R helpers, existing tests, six small inputs, and selected configuration/source-access metadata are accompanying materials. Their presence does not prove that this exact code revision generated the tables. See the [restoration record](../../PIPELINE_RESTORATION.md).

- [File checksums](file_checksums.csv): SHA-256 hashes and byte sizes for the 22 payload files, accompanying code/helpers/tests, small inputs, and selected methodology/configuration/citation/schema/input-manifest files. The manifest excludes its own hash to avoid circular references.
- [Metric reference periods](metric_reference_periods.csv): observed nonmissing coverage and documented window rules for 34 dated numeric fields.
- [Table reference periods](table_reference_periods.csv): periods and evidence limits for all 22 payload/metadata files.
- [Machine-readable provenance](provenance.json): approved release metadata, status, evidence, and missing provenance details.
- [Environment record](environment.json): October 6, 2026 R/Python/Quarto capture, dependency files, checks, and remaining verification limits.
- [Reference-period report](../../REFERENCE_PERIODS.md): interpretation of mixed date labels, pooled windows, undated tables, and the source-note/code discrepancy.

The preparation date, planned release date, CSV reporting labels, ASEC income reference years, and source pooling windows serve different purposes. Preserve them separately. All eight previously missing pipeline QMDs are restored. Source microdata and geographic payloads remain outside this package. The owner has confirmed the external input set, and [input provenance](input_provenance.json) preserves metadata/fingerprint status. Installed dependencies were captured and available environment checks passed on October 6, 2026; [Software environment](../../ENVIRONMENT.md) provides setup. Historical publisher labels not recorded in the inputs, original generation date/run and environment, clean dependency restoration, and a verified rebuild remain explicit limits. See [Reproducibility](../../REPRODUCIBILITY.md).

## Finalize at publication

1. Review the unresolved period details in the reference-period report and complete applicable source/dependency/scientific review tasks in the [upload guide](../../GITHUB_UPLOAD_GUIDE.md).
2. If the planned files change before publication, refresh this snapshot's checksums and coverage records. Confirm the actual public date and update the scheduled status here, in `provenance.json`, the root README, and `CITATION.cff`.
3. Commit the finalized files in the existing repository. Create `v2.0.0` from the approved commit and publish the GitHub release on the actual publication date. Record the full tagged commit hash in the GitHub release description or an archive record alongside the snapshot, avoiding a self-referential commit hash inside the commit itself.
4. Preserve this version's records and historical releases when preparing later versions. Add a DOI only if one is registered for the corresponding release/archive.

The current snapshot has been committed and pushed to the update branch, with a draft pull request. Release tags, a formal GitHub release, and DOI registrations have not been created. See [Snapshot sync scope](../../SNAPSHOT_SYNC.md).
