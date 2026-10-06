# Reference periods for Version 2.0.0

Compiled October 5, 2026 for the planned public release on **October 12, 2026**. These periods describe the supplied files; preparing this record did not recalculate estimates. The release date is separate from the years measured by the data.

On October 6, 2026, the owner deferred methodological review and corrections until after syncing the current snapshot to GitHub. The discrepancies and verification limits below are retained for that later review; this preparation does not resolve them or change the supplied estimates.

Evidence has three levels: **observed** labels and nonmissing fields in the CSVs; **documented** source notes and rules in the supplied code; and **unverified** original input vintages or details requiring source payloads or a generation-run record. All 14 master pipeline documents are now present. The owner confirmed the external input set; [source input records](SOURCE_INPUTS.md) preserve DDI version dates/requested periods and fingerprint status. This adds input evidence without independently reproducing the original generation run. A code rule describes the accompanying implementation, but does not establish which inputs or exact code revision produced these exports.

The [release record](releases/2.0.0/README.md) preserves file checksums. [Metric reference periods](releases/2.0.0/metric_reference_periods.csv) lists all 34 dated numeric fields individually, including available years, gaps, nonmissing row counts, and latest geography coverage. [Table reference periods](releases/2.0.0/table_reference_periods.csv) covers all 22 aggregate/metadata files.

## Dated indicators

All date labels in these six tables use January 1. The label is a reporting year or rolling-window ending year; it does not establish a literal January observation. Coverage below counts only nonmissing values in each indicated field; zeros count as present. A span does not guarantee every geography or subgroup is present in every year.

| File and indicators | Observed reporting labels | Source/window rule in available files |
| --- | --- | --- |
| `metrics_formal.csv`: `formal_care_labor_force`, `formal_care_time`, and their proportions | 1994–2025; every year | Annual CPS ASEC `YEAR`; the paid-care calculations do not pool years. |
| `metrics_formal.csv`: `formal_value` and its proportion | 1997–2025; every year | Annual CPS ASEC wage-based valuation, linked to the reporting year's GDP. Income reference-year caution below applies. |
| `metrics_formal.csv`: mothers' and fathers' labor force participation counts/proportions | 1990–2026; every year | Monthly CPS, pooled over three calendar months for each reporting year. The ending calendar month is selected from the latest CPS input and reused across years. That month is not retained in the CSV. These are not full-year 2026 averages. |
| `metrics_informal.csv`: `informal_care_labor_force`, `informal_care_time`, and their proportions | 2007–2025; **2020 absent** | Five eligible ATUS survey years ending in the reporting year, excluding 2020. The latest documented window is 2021–2025. |
| `metrics_informal.csv`: `informal_value` and its proportion | 2007–2025; **2020 absent** | The same pooled ATUS time, valued at the code's fixed $7.25 hourly amount and CPI-adjusted; the proportion uses the reporting year's GDP. The separate market-replacement output is not included in this CSV. |
| `metrics_informal.csv`: mothers' and fathers' care absence counts/proportions | 1994–2026; every year | Monthly CPS, using the same three-month window rule as parental participation. Exact ending month is unavailable. |
| `metrics_informal.csv`: mothers' and fathers' not-in-labor-force-for-care counts/proportions | 1994–2026; every year | Monthly CPS, using the same three-month window rule as parental participation. Exact ending month is unavailable. |
| `metrics_maternal_power.csv`: `share_of_income` | 1990–2025; every year | Annual CPS ASEC `YEAR`. The code prefers `INCTOT` when present, otherwise `INCWAGE`; its narrative identifies current inputs as wage/salary income. |
| `metrics_priviledge.csv`: population and proportion | 2007–2025; **2020 absent** | Five eligible ATUS years ending in each label year, excluding 2020. The solo-dweller benchmark is calculated from the analytic input before the rolling estimates; its full input-year range is unavailable. |
| `metrics_sandwich_generation.csv`: population, proportion, total time, median time | 2019, 2021, 2022, 2023, 2024, 2025 | Five eligible ATUS years ending in each label, excluding 2020, with input `YEAR >= 2015`. Latest documented window: 2021–2025. Restored code selects adults 18+ with an own child age 10 or younger and positive eldercare time; actual input-year list/run remain unverified. |
| `metrics_state_care_gini.csv`: `gini`, `lq`, `cares` | 2010–2023; every year | Annual WAC employment with ACS five-year tract population. Restored code requests 2009–2023 and retains overlapping available input years; exports contain 2010–2023. A 2023 ACS ending label represents 2019–2023 under this rule; actual source vintages/run remain unverified. |

Sandwich total time is reported in hours per day, while median time is in minutes per day. The national proportion and median fields average state summaries without population weighting. The own-child cutoff is inclusive of age 10; retain this definition in public explanations and confirm the national-summary convention during scientific review.

The latest Gini/LQ/CaRES label (2023) has **47 states plus the national aggregate**. Latest labels in the other five dated tables have 52 distinct geography codes per field; this is coverage of the supplied export, not a guarantee of complete subgroup data. Consult the metric coverage file for counts and geography codes.

Rules above come from [broader impacts](../analysis/broad_impacts.qmd), [household measures](../analysis/bargainin_power.qmd), [sandwich caregiving](../analysis/sandwich_generation.qmd), [geographic care equity](../analysis/gini.qmd), and the `atus_yr_range()` helper in [R/load_defaults.R](../R/load_defaults.R). The ATUS helper uses the last five available eligible survey years. A window crossing the excluded 2020 year can span more than five calendar years. The activity and eldercare DDI files request 2003–2025, including 2020; the analyses exclude 2020. Full observed cleaned-record coverage has not yet been independently audited.

The monthly CPS DDI requests January 1990–August 2026, with October 2025 absent. If the cleaned file preserves that endpoint, the latest parental three-month window is June–August 2026; the actual cleaned endpoint and original run remain to be verified under item 6.

The parental CPS rows produced by the child-age functions, including their overall rows, use parents ages 25–54. If the selected month is January or February, the three-month window crosses a calendar-year boundary and the code assigns it to the ending/reporting year. The earliest window may be incomplete if the input starts within it; the CSV alone cannot establish completeness.

The broader-impact code also calculates `informal_value_replacement` using five eligible ATUS years and three ASEC calendar years ending in each reporting year. This is a separate replication output under `data/`, absent from the supplied `app_data/` package; its wage window should not be assigned to `metrics_informal.csv`'s `informal_value` fields.

## Undated analytical tables

These ten CSVs contain no date column. Their periods come from code or related dashboard source notes, rather than date labels in the exports. Preserve the release checksums when using them.

| Files | Documented period and evidence | Limit |
| --- | --- | --- |
| `activity_formal.csv`, `activity_formal_datum.csv` | [Paid-activity code](../analysis/activity_formal.qmd) explicitly filters CPS ASEC to **2021–2025** and pools five years. | Inputs are owner-confirmed and available externally; the original run is not independently reproduced. The CSVs do not independently confirm this window. |
| `activity_informal.csv`, `activity_informal_datum.csv` | [Unpaid-activity code](../analysis/activity_informal.qmd) uses the latest five eligible ATUS years, excluding 2020; [source notes](../app_data/source.csv) identify **2021–2025**. Its wage code selects **only the latest ASEC `YEAR`**, rather than a five-year wage pool. | The ASEC DDI includes 1990–2025 and the owner confirms this input set. The original run is not independently reproduced. The pooled-ASEC note discrepancy below needs review. |
| `care_provider_population.csv`, `care_provider_datum.csv` | [Care-provider code](../analysis/care_provider.qmd) selects the latest ASEC year for population/paid-care components and the latest five eligible ATUS years for unpaid time. `CoC_CareProviders` identifies **2025 CPS ASEC and ATUS 2021–2025**. | The windows are dynamic in code; DDI request coverage supports ASEC through 2025 and ATUS through 2025. Observed cleaned-record coverage and the original run remain unverified. |
| `market.csv`, `market_datum.csv` | Related `CE_CareNeedCategorizing`, `CE_CareNeedDefining`, and `CE_StageOfLife` notes identify **2025 CPS ASEC and ATUS 2021–2025**. | Restored `market.qmd` selects the latest ASEC year; `market_datum.qmd` uses the latest five eligible ATUS years and `atus_00029`. That relationship DDI requests only 2018, 2019, 2021–2024, so it lacks 2025 WHO records. Review the effect on field coverage/source-note windows under item 6; no estimates were changed. |
| `provider.csv`, `provider_datum.csv` | Related `CE_CareProvisionBar` and `CoC_CareProviders` notes identify **2025 CPS ASEC and ATUS 2021–2025**. Circle of Care notes separately identify pooled **ASEC 2021–2025 and ATUS 2021–2025**. | Restored `provider.qmd` uses the latest ASEC year for ASEC fields and the latest five eligible ATUS years excluding 2020 for ATUS fields. Different charts still use different windows; actual inputs/run are unverified. |

### Source-note discrepancy to resolve

`source.csv` rows `CE_CircleOfCare` and `CoC_CircleOfCare` describe five-year pooled CPS ASEC **2021–2025**. Pooling agrees with the supplied paid-activity code. The supplied unpaid-activity replacement-wage code instead filters `YEAR == max(YEAR)`. Confirm whether the intended unpaid wage estimate is based on the latest ASEC year or a five-year pool, then align the source note or implementation and corresponding outputs. This record preserves both pieces of evidence and does not change the supplied estimates.

## Metadata and income reference years

`metric_labels.csv`, `provider_category.csv`, `source.csv`, `metric_tables.xlsx`, `provider_category.xlsx`, and `provider_group.xlsx` are lookup/source-note metadata. They have no independent statistical observation period. They are included in the Version 2.0.0 checksum record; the dates mentioned inside `source.csv` apply to particular charts, not to every table.

CPS ASEC survey year and earnings year are distinct. IPUMS defines `INCWAGE` as wage/salary income for the **previous calendar year**. If the cleaned input preserves the original survey `YEAR`, a 2025 ASEC wage observation concerns **2024 earnings**, and a 2021–2025 ASEC wage pool concerns **2020–2024 earnings**. See [IPUMS INCWAGE documentation](https://cps.ipums.org/cps-action/variables/INCWAGE). The recovered preprocessing helper preserves input survey `YEAR` when constructing dates, and the analyses retain it for labels/filters. The owner has confirmed the external input set; original preprocessing/generation runs have not been independently reproduced. Do not silently relabel exported dates as earnings years or apply that lag to all ASEC variables.

## Remaining provenance details

- The exact calendar month ending the three-month parental CPS summaries, and whether each early window contains all three months.
- Original publisher release labels/acquisition records, observed cleaned-record coverage, and the run/code revision that generated these exports. DDI version dates/requested sample lists are now preserved in the source-input record. Restored preprocessing references `cps_00453`, `cps_00452`, `atus_00035`, and `atus_00036`; market details additionally reference `atus_00029`.
- The Circle of Care pooled-ASEC note versus latest-year unpaid-activity wage code.
- Verification of observed geographic/ATUS/CPS record coverage against the restored implementations, including the 2025 gap in ATUS relationship extract `atus_00029` and the original geographic release/assembly parameters.
- Consistent sandwich own-child age wording (10 or younger) and review of the national proportion/median summary convention.
- Full ATUS input-year coverage used to construct the care-privilege baseline.

These gaps are documented rather than assigned guessed periods. Updating the citation metadata does not resolve the scientific review and input-manifest tasks in the [upload guide](GITHUB_UPLOAD_GUIDE.md).
