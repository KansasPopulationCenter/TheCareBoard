# Data dictionary and table catalog

This catalog records the supplied aggregate snapshot as inspected on October 5, 2026, for the planned Version 2.0.0 release on October 12, 2026. Schemas, rows, and date ranges are observed; they do not establish statistical validity. No table values were changed. See [reference periods](REFERENCE_PERIODS.md) for field-specific coverage and source windows, and the [release record](releases/2.0.0/README.md) for provenance.

## Shared fields and units

| Field | Interpretation |
| --- | --- |
| `geo`, `geo_level` | National/state geography; `national` or `state` plus a two-digit FIPS code. Coverage differs by file. |
| `date` | Reporting label. January 1 is not proof of a January observation; nonempty periods differ by indicator. |
| `population`, workforce/population count fields | Population estimates, generally survey-weighted in the available calculations. |
| `category_id`, `subcategory_id` | Demographic/metric group keys; use the category metadata and generating code. |
| `care_type`, `care_focus` | Paid/unpaid distinction and care classification. |
| `provider_attention` | Active or secondary/concurrent care classification; inspect the relevant implementation. |
| `provision_interval` | Aggregate daily minutes in the activity/provider code; not per-person hours. Use each restored implementation's matching population and source period when deriving per-person measures. |
| `median_wage` | Replacement/occupation wage estimate; consult the code for units, population, and period. |
| `*_proportion`, `share_of_income` | Fractions; multiply by 100 only for percentage display. Denominators vary by measure. |
| `gini`, `lq`, `cares` | Care-job inequality, relative employment concentration, and composite index. Current generating code is restored in `analysis/gini.qmd`; verify original source inputs before a rebuild. |

Blank cells and `NA`/`NULL` tokens are missingness markers in context. Do not replace them with zero. The schema preserves exact field spellings; geography naming differs across exports. Fields absent from the glossary retain their implementation-specific definitions in the methodology/code.

## CSV tables

| File | Role | Rows | Observed date labels |
| --- | --- | ---: | --- |
| [activity_formal.csv](../app_data/activity_formal.csv) | Paid-care activity classification and wages | 1,299 | No date column |
| [activity_formal_datum.csv](../app_data/activity_formal_datum.csv) | Paid-care activity time and populations | 1,299 | No date column |
| [activity_informal.csv](../app_data/activity_informal.csv) | Unpaid-care activity classification and wages | 3,052 | No date column |
| [activity_informal_datum.csv](../app_data/activity_informal_datum.csv) | Unpaid-care activity attention, time, and populations | 3,052 | No date column |
| [care_provider_datum.csv](../app_data/care_provider_datum.csv) | Care-provider flows and time by demographic group | 2,919 | No date column |
| [care_provider_population.csv](../app_data/care_provider_population.csv) | Care-provider group population denominators | 312 | No date column |
| [market.csv](../app_data/market.csv) | Population by age | 82 | No date column |
| [market_datum.csv](../app_data/market_datum.csv) | Care need and provision by age | 258 | No date column |
| [metric_labels.csv](../app_data/metric_labels.csv) | Dashboard metric labels and display types | 33 | No date column |
| [metrics_formal.csv](../app_data/metrics_formal.csv) | Paid-care workforce, time, value, parental labor indicators | 36,552 | 1990-01-01 to 2026-01-01 |
| [metrics_informal.csv](../app_data/metrics_informal.csv) | Unpaid-care workforce, time, value, parental care/labor indicators | 30,567 | 1994-01-01 to 2026-01-01 |
| [metrics_maternal_power.csv](../app_data/metrics_maternal_power.csv) | Mothers' within-couple wage/salary income shares | 1,872 | 1990-01-01 to 2025-01-01 |
| [metrics_priviledge.csv](../app_data/metrics_priviledge.csv) | Care-privileged adult population and proportion | 936 | 2007-01-01 to 2025-01-01 |
| [metrics_sandwich_generation.csv](../app_data/metrics_sandwich_generation.csv) | Sandwich caregiving population and time | 306 | 2019-01-01 to 2025-01-01 |
| [metrics_state_care_gini.csv](../app_data/metrics_state_care_gini.csv) | Care-job Gini, location quotient, and CaRES | 703 | 2010-01-01 to 2023-01-01 |
| [provider.csv](../app_data/provider.csv) | Provider demographics and population | 1,606 | No date column |
| [provider_category.csv](../app_data/provider_category.csv) | Provider category definitions and display order | 39 | No date column |
| [provider_datum.csv](../app_data/provider_datum.csv) | Provider time/populations by care type, focus, and attention | 11,018 | No date column |
| [source.csv](../app_data/source.csv) | Dashboard source and explanatory notes | 8 | No date column |

A date range spans all rows. Different fields may have shorter or intermittent coverage. `metrics_sandwich_generation.csv` has six distinct date labels within its observed range; **2020 is absent**. The [field coverage file](releases/2.0.0/metric_reference_periods.csv) records nonmissing coverage for all 34 dated numeric fields. The [reference-period report](REFERENCE_PERIODS.md) also records the source-note and code evidence for undated tables.

## Exact CSV schemas

### activity_formal.csv

`id`, `name`, `care_focus`, `median_wage`, `geo`

### activity_formal_datum.csv

`activity_id`, `provision_interval`, `population`, `geo`

### activity_informal.csv

`id`, `name`, `care_focus`, `median_wage`, `geo_level`

### activity_informal_datum.csv

`activity_id`, `geo_level`, `provider_attention`, `provision_interval`, `population`

### care_provider_datum.csv

`geo`, `gender`, `provider_status`, `time_use`, `care_type`, `care_focus`, `provider_attention`, `provision_interval`, `population`

### care_provider_population.csv

`geo`, `gender`, `provider_status`, `population`

### market.csv

`age`, `population`

### market_datum.csv

`age`, `care_focus`, `need_interval`, `provision_interval`

### metric_labels.csv

`id`, `metric_id`, `category_id`, `subcategory_id`, `type`, `label`

### metrics_formal.csv

`date`, `geo_level`, `category_id`, `subcategory_id`, `formal_care_labor_force`, `formal_care_labor_force_proportion`, `formal_care_time`, `formal_care_time_proportion`, `formal_value`, `formal_value_proportion`, `mothers_labor_force_participation`, `fathers_labor_force_participation`, `mothers_labor_force_participation_proportion`, `fathers_labor_force_participation_proportion`

### metrics_informal.csv

`date`, `geo_level`, `category_id`, `subcategory_id`, `informal_care_labor_force`, `informal_care_labor_force_proportion`, `informal_care_time`, `informal_care_time_proportion`, `informal_value`, `informal_value_proportion`, `mothers_care_absence`, `fathers_care_absence`, `mothers_care_absence_proportion`, `fathers_care_absence_proportion`, `mothers_nilf_care`, `fathers_nilf_care`, `mothers_nilf_care_proportion`, `fathers_nilf_care_proportion`

### metrics_maternal_power.csv

`share_of_income`, `date`, `geo_level`

### metrics_priviledge.csv

`date`, `geo_level`, `care_privileged_population`, `care_privileged_population_proportion`

### metrics_sandwich_generation.csv

`date`, `geo_level`, `sandwich_population`, `sandwich_population_proportion`, `sandwich_time_total`, `sandwich_time_median`

### metrics_state_care_gini.csv

`gini`, `lq`, `cares`, `date`, `geo_level`

### provider.csv

`geo_level`, `category_id`, `subcategory_id`, `population`

### provider_category.csv

`id`, `name`, `order`

### provider_datum.csv

`geo_level`, `category_id`, `subcategory_id`, `care_type`, `care_focus`, `provider_attention`, `provision_interval`, `population`

### source.csv

`id`, `text`, `url`

## Metadata workbooks

These workbooks are input metadata, not disposable Excel copies of the CSV statistics. Keep all three.

| Workbook | Sheets | Role |
| --- | --- | --- |
| [metric_tables.xlsx](../app_data/metric_tables.xlsx) | metric, metric_group | Metric metadata used by the warehouse upload |
| [provider_category.xlsx](../app_data/provider_category.xlsx) | provider_category | Provider category metadata workbook |
| [provider_group.xlsx](../app_data/provider_group.xlsx) | Sheet1 | Provider demographic group metadata |

For method details, see [Methodology](METHODOLOGY.md). For machine-readable fields and byte checksums, see [app_data_schema.json](app_data_schema.json) and [APP_DATA_INVENTORY.csv](APP_DATA_INVENTORY.csv). Rebuild both when an approved new snapshot is released.
