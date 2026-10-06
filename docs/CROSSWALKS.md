# Project crosswalks and small pipeline inputs

Recovered from the owner-supplied working folder on October 5, 2026 for the planned Version 2.0.0 release. The files below remain byte-identical to the supplied copies. They are explicitly eligible for Git under `data/CSV/`; raw/cleaned survey records and large geographic inputs remain excluded.

| File | Purpose | Structure |
| --- | --- | --- |
| [FormalOccs_Crossover.csv](../data/CSV/FormalOccs_Crossover.csv) | Occupation codes, labels, and paid-care focus | 518 rows; `code`, `occ_category`, `occ_name`, `occ_label`, `occ_care_focus` |
| [ATUSActivityCrossover.csv](../data/CSV/ATUSActivityCrossover.csv) | Primary activity codes and care/activity flags | 461 rows: 459 unique numbered activity codes and two uncoded secondary-care annotations |
| [Informal_Formal_Crosswalk.csv](../data/CSV/Informal_Formal_Crosswalk.csv) | Unpaid activity to occupation-range replacement-wage mapping | 258 rows; `Code_Informal`, `Type`, `Activity`, `Code_Formal` |
| [ASECSampleIDs.csv](../data/CSV/ASECSampleIDs.csv) | ASEC sample names used for optional IPUMS requests | Request metadata, not person-level records |
| [CPSSampleIDs.csv](../data/CSV/CPSSampleIDs.csv) | Monthly CPS sample names used for optional IPUMS requests | Request metadata, not observed indicator coverage |
| [GdpByState.csv](../data/CSV/GdpByState.csv) | State/national GDP input for care valuation | Small BEA-sourced aggregate input; retain BEA attribution |

The ATUS rows named **Secondary Childcare** and **Secondary Eldercare** intentionally have blank `Code` values. They describe secondary-care classifications; they are not duplicate numbered primary activities. Replacement mappings may have multiple rows for an unpaid activity to identify multiple occupation groups. Do not force a one-to-one mapping or discard these annotations.

All nonempty occupation/activity keys are numeric, numbered activity keys are unique, and replacement activities refer to the ATUS lookup. Occupation ranges have valid ascending bounds. These checks establish structure and linkage, not the scientific appropriateness of each mapping.

[Crosswalk schema](crosswalk_schema.json) preserves exact columns, row counts, encoding, byte sizes, and SHA-256 values for the three crosswalks. [Input manifest](../data/input_manifest.csv) and [release checksums](releases/2.0.0/file_checksums.csv) also identify the small inputs. The owner has confirmed the working-folder input set's relationship to the supplied exports. [Source input records](SOURCE_INPUTS.md) preserve DDI request metadata and available fingerprints. A request sample list still describes requested selections rather than observed nonmissing survey coverage.

Project-created crosswalks and request metadata use CC BY 4.0; source materials retain their terms and attribution. See [licensing scope](LICENSE_AND_CITATION.md). CSV line endings are preserved by `.gitattributes`.
