# Current snapshot and deferred review

On October 6, 2026, the owner chose to sync the supplied Care Board data and methods to the existing GitHub repository, with methodological review and troubleshooting deferred to subsequent work. The existing calculations, dashboard source notes, and all 22 supplied aggregate/metadata payloads are retained. [Reference periods](REFERENCE_PERIODS.md) preserves known discrepancies and coverage limits for that later review.

**Snapshot uploaded October 6, 2026:** [careboard-2.0.0-snapshot](https://github.com/KansasPopulationCenter/TheCareBoard/tree/careboard-2.0.0-snapshot), with [draft pull request #2](https://github.com/KansasPopulationCenter/TheCareBoard/pull/2). The 101 recommended upload files are available on that branch. The pull request has not been merged, and the formal release/tag has not been created.

The update is based on the existing `main` branch at `d3675ef8e2a467bb16765e33253f22ba9b28ad03`. The organized snapshot is added at the repository root. Existing historical paths under `Previous Versions/` and `zzz_lib/` are retained, preserving older download links and repository history. Their contents were not re-reviewed as part of this update. CB's [file manifest](FILE_MANIFEST.csv) identifies this preparation's recommended upload files, rather than inventorying every historical file already in the remote repository.

Only the manifest's `UPLOAD` files are copied into the update. New source records, credentials, local history, drafts, generated previews, installed libraries, and preparation backups remain excluded. The statistical calculations were not executed to regenerate the exports. Aggregate structure, crosswalks, original payload hashes, available helper checks, and documentation rendering passed during preparation.

Git attributes preserve file bytes, including line endings, so the committed snapshot agrees with the release checksum record. Existing source whitespace is retained.

The formal Version 2.0.0 release remains scheduled for October 12, 2026. Syncing an update branch or opening a pull request does not create that release or its tag. The original generation environment, a clean dependency restore, a full statistical rebuild, historical publisher editions, and five external input fingerprints remain unverified or incomplete; these are recorded follow-up work rather than prerequisites to uploading this snapshot.
