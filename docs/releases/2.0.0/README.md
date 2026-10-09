# The Care Board — Version 2.0.0 release record

**Formal release status: published on GitHub October 9, 2026.** The official launch date is **October 12, 2026**. The owner authorized early public availability so the repository and download links would be ready for launch. This record was first prepared on October 5, 2026; the update branch was uploaded on October 6 and merged into `main` through [pull request #2](https://github.com/KansasPopulationCenter/TheCareBoard/pull/2). The [published release](https://github.com/KansasPopulationCenter/TheCareBoard/releases/tag/v2.0.0) identifies the full tagged commit.

| Item | Recorded value |
| --- | --- |
| Repository | [KansasPopulationCenter/TheCareBoard](https://github.com/KansasPopulationCenter/TheCareBoard); update the existing repository |
| Version | 2.0.0 |
| Originally planned public date | 2026-10-12 |
| Official launch date | 2026-10-12 |
| Actual GitHub public date | 2026-10-09 |
| Authors, in approved order | Misty Heggeness; Joseph Bommarito; Lucie Prewitt |
| Copyright holder | Kansas Population Center, University of Kansas |
| Dataset/documentation license | CC BY 4.0 |
| Code license | MIT |
| Release tag | [`v2.0.0`](https://github.com/KansasPopulationCenter/TheCareBoard/tree/v2.0.0) |
| Release commit | Full commit hash recorded in the [GitHub release description](https://github.com/KansasPopulationCenter/TheCareBoard/releases/tag/v2.0.0); also resolved by the tag |
| DOI | None assigned in supplied materials |

## Contents and provenance

The supplied package has 19 CSVs and three XLSX metadata workbooks. All 22 original data/metadata files remain byte-identical to the files supplied for preparation. No statistical regeneration occurred. All 14 current pipeline QMDs, the legacy QMD, master methodology, five R helpers, existing tests, six small inputs, and selected configuration/source-access metadata are accompanying materials. Their presence does not prove that this exact code revision generated the tables. See the [restoration record](../../PIPELINE_RESTORATION.md).

- [File checksums](file_checksums.csv): SHA-256 hashes and byte sizes for the 22 payload files, accompanying code/helpers/tests, small inputs, and selected methodology/configuration/citation/schema/input-manifest files. The manifest excludes its own hash to avoid circular references.
- [Metric reference periods](metric_reference_periods.csv): observed nonmissing coverage and documented window rules for 34 dated numeric fields.
- [Table reference periods](table_reference_periods.csv): periods and evidence limits for all 22 payload/metadata files.
- [Machine-readable provenance](provenance.json): approved release metadata, status, evidence, and missing provenance details.
- [Environment record](environment.json): October 6, 2026 R/Python/Quarto capture, dependency files, checks, and remaining verification limits.
- [Reference-period report](../../REFERENCE_PERIODS.md): interpretation of mixed date labels, pooled windows, undated tables, and the source-note/code discrepancy.

The preparation date, actual GitHub publication date, official launch date, CSV reporting labels, ASEC income reference years, and source pooling windows serve different purposes. Preserve them separately. All eight previously missing pipeline QMDs are restored. Source microdata and geographic payloads remain outside this package. The owner has confirmed the external input set, and [input provenance](input_provenance.json) preserves metadata/fingerprint status. Installed dependencies were captured and available environment checks passed on October 6, 2026; [Software environment](../../ENVIRONMENT.md) provides setup. Historical publisher labels not recorded in the inputs, original generation date/run and environment, clean dependency restoration, and a verified rebuild remain explicit limits. See [Reproducibility](../../REPRODUCIBILITY.md).

## Publication and subsequent work

Citation metadata and this release record distinguish the October 9 GitHub publication from the October 12 official launch. File checksums were refreshed for the final publication metadata; the 22 supplied data/metadata payloads remain unchanged. The `v2.0.0` tag identifies the released files. The full tagged commit hash is recorded in the GitHub release description, avoiding a self-referential hash inside the commit itself.

The owner deferred methodological review, source-note corrections, and troubleshooting until after this snapshot was published. The unresolved period details, remaining source fingerprints, clean dependency restoration, and a verified statistical rebuild remain follow-up work in the [upload guide](../../GITHUB_UPLOAD_GUIDE.md).

Preserve this version's tag, records, and historical releases when preparing later versions. Add a DOI only if one is registered for the corresponding release/archive. No DOI has been assigned. See [Snapshot sync scope](../../SNAPSHOT_SYNC.md).
