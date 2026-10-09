# Source inputs and replication outputs

The owner confirmed on October 5, 2026 that the working-folder inputs produced the supplied `app_data` files and that no inputs are elsewhere. [input_manifest.csv](input_manifest.csv) records observed sizes, available SHA-256 values, metadata dates, access instructions, and checksum status. [Source input record](../docs/SOURCE_INPUTS.md) explains the requested samples and remaining provenance limits.

Six small public inputs are included under `data/CSV/`: three crosswalks, two IPUMS request lists, and the GDP input. [Crosswalks and small inputs](../docs/CROSSWALKS.md) describes them. Raw/cleaned survey records, large geographic inputs, optional research/legacy inputs, backups, and replication exports remain external or ignored.

```text
data/CSV/             Six public small inputs; ignored working inputs/replication outputs
data/Dta/             Ignored Stata replication outputs
data/Excel/           Ignored Excel replication outputs
data/IPUMS Pulls/     Ignored raw extract definitions and payloads
```

`EXTERNAL_AVAILABLE` identifies an input observed in the owner's storage, rather than present in CB. `EXTERNAL_OPTIONAL` identifies retained research/legacy material. `UNUSED_ALTERNATIVE` identifies an accepted filename that is not required for this snapshot. A blank digest labeled `PENDING_EXTERNAL_READ` is unfinished fingerprint work. Six `PRESENT` inputs have verified included-copy hashes.

Preprocessing uses monthly CPS `cps_00453`, ASEC `cps_00452`, ATUS activities `atus_00035`, and eldercare roster `atus_00036`. Market details also use relationship extract `atus_00029`. [Extract request metadata](../docs/source_extracts.json) preserves selected periods and variable names; each extract requires paired XML and `.dat.gz` files. Extract IDs are project/account-specific. Metadata production dates are distinct from original download dates.

The current tract file is `nighis_populationbytract.csv`, an NHGIS AV0 nominal tract time series for ACS five-year ending years 2010–2023. Historical BEA/LODES/NHGIS publisher release labels remain unrecorded where the original documentation does not identify them. Verified file hashes pin the archived snapshots without guessing those labels.

For an authorized rebuild, make source inputs available at the expected relative paths in a working copy while preserving the external archive. Git tracks only this README, the manifest, and the six allowlisted small CSVs. See [Reproducibility](../docs/REPRODUCIBILITY.md).
