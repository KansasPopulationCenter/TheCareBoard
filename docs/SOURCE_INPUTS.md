# Source inputs for Version 2.0.0

On October 5, 2026, the owner confirmed that the working-folder inputs produced the supplied `app_data` files and that no inputs are stored elsewhere. This is owner-confirmed provenance; no full regeneration or independent verification of the original run occurred.

[Input manifest](../data/input_manifest.csv) records each expected path, file size, source snapshot, date evidence, access instructions, GitHub inclusion, and checksum status. [Input provenance](releases/2.0.0/input_provenance.json) gives the current fingerprint completion status. A blank checksum with `PENDING_EXTERNAL_READ` is unfinished work, not a verified file. `UNUSED_ALTERNATIVE` rows are accepted filename alternatives rather than required missing inputs.

The six small inputs remain included in Git. Raw/cleaned survey records, large geographic inputs, and optional legacy/research inputs stay in authorized external project storage. Private drive paths and account details are excluded from the public manifest.

## Survey extracts

[Extract request summary](source_extracts.json) preserves the DDI's requested periods and variable names without survey records or account-holder details. The dates below are metadata production/version dates, not verified download dates.

| Extract | Role | DDI production/version date | Requested samples |
| --- | --- | --- | --- |
| `cps_00453` | Monthly CPS | 2026-09-14 | 439 months, January 1990–August 2026; October 2025 absent |
| `cps_00452` | CPS ASEC | 2026-09-14 | 36 March/ASEC samples, 1990–2025 |
| `atus_00035` | Diary activity data | 2026-07-20 | 2003–2025 |
| `atus_00036` | Hierarchical eldercare recipient roster | 2026-09-21 | 2003–2025; eldercare availability differs from full extract coverage |
| `atus_00029` | Hierarchical WHO/relationship records | 2025-07-21 | 2018, 2019, 2021, 2022, 2023, 2024 |

Use the [IPUMS CPS](https://cps.ipums.org/cps/) and [ATUS-X](https://www.atusdata.org/atus/) extract services through a registered account. Match requested samples, variables, and record structure to the preserved DDI, then obtain its paired XML and `.dat.gz`. Extract numbers are account/project-specific; a fresh request can have different IDs and updated data. Update corresponding code paths together and compare hashes to the archived release inputs when exact reproduction is required.

Requested samples do not establish nonmissing observed coverage after preprocessing. Analyses also apply their own filters, including excluding ATUS 2020. The relationship extract lacks 2025 even though the activity extract includes it; review effects on market need/provision and source-note windows under publishing item 6.

## GDP, employment, and tract population

- **BEA GDP:** the owner identified the [GDP portal](https://www.bea.gov/data/gdp/gross-domestic-product). The code cites `SAGDP9 Real GDP by state` and access on July 31, 2025. The included CSV has annual columns 1997–2025 and no embedded release/unit label; that older source note does not establish this file's revision. Use [GDP by state](https://www.bea.gov/data/gdp/gdp-state), preserve the original table/revision documentation, and retain the frozen input hash.
- **LODES:** access state WAC/RAC files from the [Census LODES archive](https://lehd.ces.census.gov/data/lodes/). Preserve `version.txt`, original filenames, job type, segment, years, and acquisition date. Current CaRES uses the assembled WAC input; RAC is optional research material. The original release and assembly selections were not identified. The current website's newest version does not establish the historical project version. [Census source and citation guidance](https://lehd.ces.census.gov/data/).
- **NHGIS population:** the observed `NHGISCODE`, `GJOIN2010`–`GJOIN2023`, and `AV0AA` columns identify the tract file as NHGIS time-series data. Use [IPUMS NHGIS](https://www.nhgis.org/) and its [Data Finder](https://data2.nhgis.org/) for nominal tract table `AV0 Total Population`, ACS five-year ending years 2010–2023. Preserve its codebook and release/extract ID. The owner linked the broader [IPUMS USA portal](https://usa.ipums.org/usa/); NHGIS provides the summary-table workflow matching this file. [NHGIS table details](https://data2.nhgis.org/main/all_tst_details).

The historical BEA revision/unit vintage, LODES release/assembly parameters, and NHGIS release/extract ID remain explicitly unrecorded. File hashes identify the actual archived snapshots when verified; they do not recover undocumented publisher release labels or assembly methods. A fresh download may require a reviewed update rather than silently replacing the frozen inputs.

## Preserve and verify

Keep an immutable, access-controlled institutional copy of the owner-confirmed input set. Store source codebooks and acquisition/assembly records with it. For an authorized rebuild, make the inputs available at the manifest's expected relative paths in a working copy; Git's allowlist continues to exclude the source records.

Checksums are SHA-256 over the file bytes as stored, including compressed `.dat.gz` bytes. Different compression or CSV formatting can change hashes without changing values; compare the correct file representation. Recheck a changed input deliberately, update provenance, and review outputs before replacing a release snapshot.

Publishing item 4 remains pending wherever the manifest marks an external checksum unfinished. Dependency verification, rendering, and statistical regeneration remain separate work in items 5 and 6. No source records were copied into the public repository or redistributed during this inventory work.
