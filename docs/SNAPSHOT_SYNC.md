# Current snapshot and deferred review

On October 6, 2026, the owner chose to sync the supplied Care Board data and methods to the existing GitHub repository, with methodological review and troubleshooting deferred to subsequent work. The existing calculations, dashboard source notes, and all 22 supplied aggregate/metadata payloads are retained. [Reference periods](REFERENCE_PERIODS.md) preserves known discrepancies and coverage limits for that later review.

**Published on GitHub October 9, 2026:** the 101 recommended upload files were merged into `main` through [pull request #2](https://github.com/KansasPopulationCenter/TheCareBoard/pull/2). The [Version 2.0.0 release](https://github.com/KansasPopulationCenter/TheCareBoard/releases/tag/v2.0.0) and `v2.0.0` tag preserve the published snapshot. The official launch date remains **October 12, 2026**. The preparation branch was first uploaded on October 6, 2026.

The update is based on the existing `main` branch at `d3675ef8e2a467bb16765e33253f22ba9b28ad03`. The organized snapshot is added at the repository root. Existing historical paths under `Previous Versions/` and `zzz_lib/` are retained, preserving older download links and repository history. Their contents were not re-reviewed as part of this update. CB's [file manifest](FILE_MANIFEST.csv) identifies this preparation's recommended upload files, rather than inventorying every historical file already in the remote repository.

Only the manifest's `UPLOAD` files are copied into the update. New source records, credentials, local history, drafts, generated previews, installed libraries, and preparation backups remain excluded. The statistical calculations were not executed to regenerate the exports. Aggregate structure, crosswalks, original payload hashes, available helper checks, and documentation rendering passed during preparation.

Git attributes preserve file bytes, including line endings, so the committed snapshot agrees with the release checksum record. Existing source whitespace is retained.

The owner authorized early public availability on October 9, 2026 so the repository and download links would be ready ahead of the October 12 launch. The citation and release provenance record the actual GitHub publication date separately from the official launch date. The original generation environment, a clean dependency restore, a full statistical rebuild, historical publisher editions, and five external input fingerprints remain unverified or incomplete; these are recorded follow-up work rather than prerequisites to uploading this snapshot.
