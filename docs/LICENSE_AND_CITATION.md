# Citation and licensing

Copyright (c) 2026 Kansas Population Center, University of Kansas.

The project owner approved open reuse, including commercial reuse, on October 5, 2026. Public project code uses MIT; project-created aggregate data, metadata, and written methodology use CC BY 4.0. The scope below identifies which terms apply, including the code and prose in QMD documents.

## License scope

| Material | Applicable license |
| --- | --- |
| R/Python source, embedded code comments/help, and executable code chunks in QMD documents | [MIT](../LICENSE) |
| Software/render configuration, including `_quarto.yml`, `.gitignore`, and `.gitattributes` | MIT |
| Project-created crosswalks and request metadata in `data/CSV/` | [CC BY 4.0](../LICENSES/CC-BY-4.0.txt) |
| Project-created aggregate CSV tables and XLSX dashboard metadata in `app_data/` | [CC BY 4.0](../LICENSES/CC-BY-4.0.txt) |
| Written methodology, QMD narrative, Markdown documentation, public inventories/schemas, and citation metadata | CC BY 4.0 |

QMD documents contain two kinds of material: their executable code and code comments use MIT; surrounding narrative uses CC BY 4.0. This is a division of scope, rather than a choice to apply either license to the entire file. The licenses' own texts remain the standard texts provided by their publishers.

The generated renv activation script retains its upstream MIT notice for Posit Software, PBC in [renv/LICENSE](../renv/LICENSE). Installed third-party packages are excluded from GitHub and retain their own licenses.

Local unpublished drafts, notes, credentials, press materials, and backup files under `local_only/` are outside this public release. Third-party source records and materials retain their existing terms. These project licenses grant only rights the project holds and do not impose copyright on facts or other material outside applicable rights.

## Credit and reuse

Both licenses permit commercial use and modification. MIT requires retaining its copyright and license notice in copies or substantial portions of the code. It does not require a formal academic citation or require that modified code be published.

When sharing CC BY 4.0 data or prose, provide appropriate credit, retain supplied notices required by the license, link to the license, and indicate changes. A suitable attribution identifies **The Care Board, Kansas Population Center, University of Kansas**, together with supplied authorship and a link to the original repository/release. Adapt that credit to the medium and retain the original source notes. There is no added noncommercial or share-alike restriction.

For example:

> Source: The Care Board, Kansas Population Center, University of Kansas. Licensed under CC BY 4.0. Derived from the identified release/commit; changes described by the reuser.

Include a link to the actual source release/commit and [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) when using this example. Do not substitute the preparation date for the dataset's reporting or release date.

The full license texts govern reuse: [MIT](../LICENSE) and [CC BY 4.0](../LICENSES/CC-BY-4.0.txt). [CITATION.cff](../CITATION.cff) describes the dataset and therefore records `CC-BY-4.0`; the repository's software license is separately documented here.

## Research citation

Academic citation is requested in addition to the applicable license notices. The owner approved the existing repository address, author order, Version **2.0.0**, and planned publication date **October 12, 2026**. The following citation is prepared for that release:

Misty Heggeness, Joseph Bommarito, and Lucie Prewitt. The Care Board: Version 2.0.0 [dataset]. Lawrence, KS: Kansas Population Center, University of Kansas, 2026. [The Care Board repository](https://github.com/KansasPopulationCenter/TheCareBoard).

Version 2.0.0 is scheduled as of the October 5 preparation record. Its release tag and commit have not yet been assigned. When citing the published version, also record the actual tag/commit, access date, and tables used. [CITATION.cff](../CITATION.cff) contains the approved authors in order and the planned version/date. If the actual publication date changes, update both the CFF and [release record](releases/2.0.0/README.md). No DOI has been assigned in the supplied materials.

The existing public repository supplies this historical citation for its published Version 1.0 dataset:

Misty Heggeness, Joseph Bommarito, and Lucie Prewitt. The Care Board: Version 1.0 [dataset]. Lawrence, KS: Kansas Population Center, 2025. [thecareboard.org](https://thecareboard.org/).

Source: [The Care Board repository](https://github.com/KansasPopulationCenter/TheCareBoard). Retain that citation for Version 1.0. The Version 2.0.0 record does not change the identity or citation of the earlier release.

## Third-party sources and release provenance

Source terms remain separate. See [IPUMS CPS terms](https://cps.ipums.org/cps/terms.shtml) before publishing source records; this project's license does not grant redistribution permission for someone else's extracts. Source citations should accompany the project attribution where supplied.

See [reference periods](REFERENCE_PERIODS.md) for the supplied indicators' coverage, documented source windows, and timing uncertainties. The [Version 2.0.0 record](releases/2.0.0/README.md) preserves accompanying file hashes and known replication limits. Add a DOI only if one is actually registered; do not use placeholder identifiers.
