# ATUS eldercare variables

`data/CSV/ATUSdata.csv` remains one row per diary activity. The new columns
describe the respondent and their reported recipients, and repeat on every
activity row for that respondent. They do **not** identify which recipient a
particular diary activity served. Do not sum these flags or recipient counts
over activity rows to count people.

The base remains `data/IPUMS Pulls/atus_00035.xml` and its data payload. The
recipient source is the type-5 eldercare roster in `atus_00036.xml` and its
payload. Both cover 2003–2025, with eldercare questions available from 2011.
Linkage uses `YEAR` and `CASEID`; recipient identity additionally uses `LINENOR`.
`SERIAL` is not used across extracts. Who-record relationships (`RELATEW`) are
not substituted for recipient relationships (`RELATER`).

The recipient roster concerns care in the prior three-month reference period,
including providers who did no eldercare on their diary day. It is collected for
people reporting care more than once during roughly the prior 3–4 months; the
reference period starts on the first day of the reference month. A positive
`ECPRIOR` can therefore exist without a recipient roster. See the
[IPUMS ECPRIOR definition](https://www.atusdata.org/atus-action/variables/ECPRIOR)
and [BLS file documentation](https://www.bls.gov/tus/other-documentation/howto.htm).

## Respondent columns

| Column | Meaning |
|---|---|
| `eldercare_provider` | Cleaned `ECPRIOR`: 1=yes, 0=no in the reference period; refused, don't know, not in universe and missing become NA. This is not a lifetime or diary-day indicator. The original `ECPRIOR` is retained. |
| `eldercare_roster_available` | 1=recipient records available; 0=known provider with no recipient roster; NA=nonprovider or unknown provider status. |
| `eldercare_recipient_count` | Number of recorded recipients, 1–5; NA when no roster. Five records need not mean there were only five recipients, because the roster is capped. |
| `eldercare_hh_recipient` | 1=at least one recipient lives in the respondent's household; 0=all recorded recipients live elsewhere. |
| `eldercare_nonhh_recipient` | 1=at least one recipient lives elsewhere; 0=all recorded recipients live in the household. Both household flags can be 1. |
| `eldercare_spouse_partner` | Any recipient is a spouse/unmarried partner. |
| `eldercare_parent` | Any recipient is a parent, including a parent-in-law. |
| `eldercare_grandparent` | Any recipient is a grandparent/great-grandparent. |
| `eldercare_other_relative` | Any recipient is another relative. |
| `eldercare_nonrelative` | Any recipient is a nonrelative. |
| `eldercare_relationship_unknown` | 1=at least one recipient has an unknown/unclassified relationship; 0=all recorded relationships are classified. |

All recipient characteristics and category flags are NA for nonproviders and
unknown provider status, and for providers without a roster. Within an available
roster, each category indicator is 1 if any recipient matches, 0 if all recipients
are known and none match, or NA if an unclassified recipient prevents ruling out
that category. The five relationship flags are not mutually exclusive.

## Recipient slots

For each `i` from 1 to 5, slots are ordered by ascending source `LINENOR`, **not**
by care intensity, age, household membership or relationship priority. Unused
slots are NA. The first slot does not mean the main recipient.

| Column pattern | Meaning |
|---|---|
| `ec{i}_lineno` | Source recipient line number (`LINENOR`). |
| `ec{i}_age` | Cleaned numeric `ECAGE`, preserving valid ages below 65. Codes 80 and 85 retain their source topcoding. |
| `ec{i}_age_topcoded` | 1 for age code 80 or 85, 0 for an exact age 0–79; NA for unavailable age. |
| `ec{i}_relater` | Source `RELATER` code, retained to support alternative groupings. |
| `ec{i}_relationship` | `spouse_partner`, `parent`, `grandparent`, `other_relative`, `nonrelative`, or NA. |
| `ec{i}_hh_member` | Cleaned `HH_EC`: 1=household member, 0=nonhousehold member, NA=unavailable. |

[IPUMS ECAGE](https://www.atusdata.org/atus-action/variables/ECAGE) codes ages
80–84 as **80**, and ages 85+ as **85**; these are not exact ages. Household ages
refer to the diary day; nonhousehold ages refer to the first of the reference
month, three months before the interview. Other age codes become NA.

Relationship mapping from the extract's codebook and
[IPUMS RELATER](https://www.atusdata.org/atus-action/variables/RELATER):

| Group | Source codes |
|---|---|
| Spouse/unmarried partner | 200, 210 |
| Parent, including in-laws | 240–244 |
| Grandparent, including great-grandparents | 263–265 |
| Other relative (children, grandchildren, siblings, aunts/uncles, other relatives) | 220, 230, 250–252, 260–262 |
| Nonrelative (housemates, boarders, other nonrelatives, friends, neighbors) | 280, 290, 300, 310, 320 |
| Unknown/unclassified | 400 (source label “Other”), missing or any unrecognized code |

## Refresh and checks

The full `data_processing.qmd` workflow calls the helpers in `R/atus_eldercare.R`
after recoding and selecting the activity columns. This keeps all eldercare
fields in future builds without altering shared CPS/ASEC column selection.

To update only an existing cleaned ATUS CSV from the new raw recipient extract:

```powershell
Rscript --vanilla tests/atus_eldercare.R
Rscript --vanilla R/refresh_atus_eldercare.R
```

Run from the repository root with `ipumsr` and `data.table` installed.
The refresh accepts optional input-CSV and hierarchical-DDI paths, in that order.
It replaces existing eldercare columns on repeat runs, stages the new CSV, and
re-reads every row to verify that all pre-existing non-eldercare cell values and
all new features match. Original numeric text is preserved, including IDs,
weights and durations; CSV quoting may be normalized. A uniquely named
`ATUSdata-before-eldercare-*.csv.bak` in the same directory retains the old file.
No aggregate statistics, CPS/ASEC files or app tables are regenerated.

The cleaner rejects duplicate recipient keys, inconsistent within-person
`ECPRIOR`, uncovered activity respondents, recipient records inconsistent with
provider status, and more recipients than available slots. Missing roster
details are never interpreted as zero recipients or a known negative category.
