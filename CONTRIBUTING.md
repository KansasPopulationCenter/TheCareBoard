# Contributing to The Care Board

Contributions should make the care economy data easier to understand, reproduce, or use. Open an issue describing the affected table/analysis and proposed change before revising a statistical definition.

1. Use a branch and keep the change focused.
2. Run commands from the repository root. Preserve filenames and fields used by dashboard consumers.
3. For calculation changes, document populations, weights, pooling windows, exclusions, units, and source vintages. Compare affected estimates with the prior release.
4. Update methodology, the dictionary, and schemas when interfaces change. Retain provenance for each release.
5. Run `python scripts/check_repository.py`. Full regeneration also requires the inputs and checks in `docs/REPRODUCIBILITY.md`.

Explain the problem, resulting change, affected measures, and verification in the pull request. Statistical changes should receive maintainer review before publication.

Project code is licensed under MIT; project-created aggregate data, metadata, and prose use CC BY 4.0. Contributions intended for inclusion should be compatible with those terms, with any third-party material identified. See [licensing scope](docs/LICENSE_AND_CITATION.md).

Keep survey records and replication payloads in ignored `data/` storage, and credentials in `local_only/credentials/` or environment variables. Do not include keys, raw records, connection strings, private notes, or R history in contributions.

Database uploads delete/reload warehouse tables and refresh views. Treat them as an intentional maintainer release step. Documentation previews and structural checks need no database access.

When reporting a problem, include the file, reporting period, geography/group, expected result, and reproduction steps. For private-data or credential concerns, contact [careboard@ku.edu](mailto:careboard@ku.edu) rather than posting the material publicly.
