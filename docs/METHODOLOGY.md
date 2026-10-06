# Methodology and analysis map

[TheCareBoard_Master.qmd](../TheCareBoard_Master.qmd) is the primary methodology source. All 14 documents in its active pipeline are now present. Read the narrative together with the implementations and [reference periods](REFERENCE_PERIODS.md); an earlier PDF does not establish that current tables were regenerated.

The Care Board draws on CPS, CPS ASEC, ATUS, and geographic employment/population inputs. Exact universes, filters, survey weights, units, and pooling windows are defined by each implementation.

| Available document | Purpose | Main outputs |
| --- | --- | --- |
| [IPUMS access](../analysis/IPUMS_API.qmd) | Source extract requests and access workflow. | Maintainer source acquisition |
| [Preprocessing](../analysis/data_processing.qmd) | Clean CPS, ASEC, and ATUS extracts; prepare eldercare fields. | Local analytical inputs under `data/` |
| [Care need](../analysis/market.qmd) | Population groups and care needs. | `market` |
| [Care need details](../analysis/market_datum.qmd) | Care need attributes and time measures. | `market_datum` |
| [Paid care activities](../analysis/activity_formal.qmd) | Paid activity populations, time, and wages. | `activity_formal`, `activity_formal_datum` |
| [Unpaid care activities](../analysis/activity_informal.qmd) | Unpaid activities and replacement-wage estimates. | `activity_informal`, `activity_informal_datum` |
| [Care provider flows](../analysis/care_provider.qmd) | Provider groups, populations, attention, and time. | `care_provider_population`, `care_provider_datum` |
| [Provider attributes](../analysis/provider.qmd) | Care provider characteristics and time measures. | `provider`, `provider_datum` |
| [Broader impacts](../analysis/broad_impacts.qmd) | Workforce, time, valuation, and parental labor indicators. | `metrics_formal`, `metrics_informal` |
| [Geographic care equity](../analysis/gini.qmd) | Care employment distribution, location quotients, and CaRES. | `metrics_state_care_gini` |
| [Sandwich caregiving](../analysis/sandwich_generation.qmd) | Adults with younger own children and reported eldercare. | `metrics_sandwich_generation` |
| [Household measures](../analysis/bargainin_power.qmd) | Mothers' within-couple wage/salary income shares and below-baseline adult care time. | `metrics_maternal_power`, `metrics_priviledge` |
| [Parental labor monitor](../analysis/parental_labor_monitor.qmd) | Parental labor force summaries and reporting graphics. | Monitor/report products |
| [Database upload](../analysis/_database_upload.qmd) | Aggregate reshaping and warehouse writes; maintainer operation. | Warehouse tables/views |
| [Legacy care ratio](../analysis/legacy/care_ratio.qmd) | Earlier care-ratio implementation outside the active pipeline. | Legacy `metrics_care_ratio`, absent here |

## Interpretation

Reference periods and populations differ across indicators. A table's minimum/maximum dates do not mean every field is observed throughout the range. Several activity/provider tables have no date field and need a release record.

In the available provider/activity calculations, `provision_interval` is an aggregate time quantity. Divide only by the matching population and use documented units when deriving per-person time. Replacement-wage valuation is an estimate of value, not an observed payment to unpaid caregivers.

### Geographic care equity and CaRES

The restored Gini workflow combines annual LODES Workplace Area Characteristics (WAC) employment with tract population from ACS five-year estimates. Care employment is the sum of `CNS15`, `CNS16`, and `CNS18`; total employment is `C000`. It calculates a population-weighted Gini of tract care employment and a location quotient (LQ): a state's care share of employment divided by the national care share. National LQ is one.

The implementation standardizes the state-year Gini and LQ values over the available state panel and sets `cares = min(1, max(0, (z_gini - z_lq + 4) / 8))`. The national series uses those state-panel standardization parameters. All 703 supplied CaRES values match this scaling rule within `1e-12` when using the supplied Gini/LQ fields. This verifies index scaling; rebuilding the underlying Gini and LQ still requires the geographic source inputs. The master maps CaRES into the existing `care-ratio` warehouse slot.

### Sandwich caregiving

The restored workflow selects adults age 18 or older with an own child age 10 or younger and positive reported eldercare time. It uses five eligible ATUS years, excludes 2020, and starts the input period at 2015. The latest documented window is 2021–2025. Its total time is expressed as hours per day; its median time is expressed as minutes per day.

The code's national proportion and median summaries average state estimates without population weighting; they are not pooled national estimates. Confirm this convention during scientific review. The [eldercare documentation](ATUS_ELDERCARE.md) describes the diary/roster cleaning and time variables.

Care privilege identifies below-baseline adult care time; it does not directly observe who supplies care to whom or establish causality.

## Snapshot limits

Code, helper, and crosswalk recovery is complete for publishing item 3. All 22 original dashboard payloads are unchanged, and no full statistical rebuild occurred during preparation. The restored code's presence does not prove which revision and input vintages originally generated those exports.

The owner-confirmed source inputs are available externally; [source records](SOURCE_INPUTS.md) identify metadata and fingerprint limits. Verified dependencies, original run provenance, and a verified rebuild remain necessary for full replication; see [Reproducibility](REPRODUCIBILITY.md) and the [restoration record](PIPELINE_RESTORATION.md).

Research drafts and internal notes are held locally until publication status is established. Previously rendered PDFs are retained in ignored `generated/`; regenerate and review them before distributing them as current methodology.
