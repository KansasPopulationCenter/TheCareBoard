# Pipeline restoration for Version 2.0.0

Restoration date: October 5, 2026. **Publishing item 3 is complete for code, helper, and crosswalk recovery.** All 14 master pipeline documents are present. Full statistical reproducibility additionally requires the source-input and environment work in items 4 and 5, followed by a verified rebuild.

## Files recovered and placement

| Material | Repository location |
| --- | --- |
| Eight previously missing QMDs | `analysis/` |
| Library loader, preprocessing functions, eldercare cleaner and refresh helper | `R/` |
| Three project crosswalks, two IPUMS request sample lists, GDP input | Six allowlisted files in `data/CSV/` |
| Existing provider-window and eldercare checks | `tests/` |
| Eldercare variable/method documentation | [ATUS_ELDERCARE.md](ATUS_ELDERCARE.md) |
| Four additionally supplied rendered PDFs | Ignored `generated/restored_pipeline/`; current rendering not verified |
| Recovered internal release/provider/sandwich reviews and source backups | Ignored local storage |

Six QMDs and three crosswalks were first supplied in CB. The two remaining QMDs and their supporting files were then recovered directly from the working directory identified by the owner. No predecessor from the old GitHub was substituted. Original copies/hashes are retained locally; all 22 original `app_data` payloads remain unchanged.

## Integration and review

Helper references use `R/` and the existing tests use `analysis/` paths. The preprocessing helper had older metadata filenames (`cps_00451` and `cps_00450`) than the recovered preprocessing (`cps_00453` and `cps_00452`); these references and the master/input inventory were aligned. Statistical formulas and output values were preserved.

Crosswalk schemas, row widths, numbered key uniqueness, replacement activity linkage, and ascending occupation ranges were checked. The two blank ATUS keys are intentional secondary-childcare/secondary-eldercare annotations, so the check excludes them from numbered-key uniqueness. No crosswalk rows were removed or rewritten.

Restored statistical exports match the supplied dashboard schemas. All 703 supplied CaRES values agree with the recovered state-panel scaling formula to within `1e-12`; the maximum observed difference was approximately `6.74e-15`. National LQ equals one as in the code. This checks scaling using supplied Gini/LQ fields; it does not reproduce the source-data Gini or LQ calculation.

The existing provider-window checks passed for current/future windows, shuffled records, gaps, insufficient years, and weight normalization. All 199 embedded R chunks, eight helper/example/test R files, and two embedded Python chunks passed syntax parsing without statistical evaluation. The master safeguard passed with all 14 pipeline files present and with a simulated missing file. The initial eldercare attempt could not access `data.table` in the default library. On October 6, 2026, the existing R 4.4 user library was located and the unchanged eldercare and provider-window tests passed under R 4.4.0. Package capture, an R/Python smoke check, and HTML documentation rendering also passed; see [Software environment](ENVIRONMENT.md).

## Remaining work

- Source input set now owner-confirmed and available externally; [input records](SOURCE_INPUTS.md) preserve DDI dates/requested periods, access instructions, and fingerprint progress. Pending checksums and unrecorded publisher editions remain item 4.
- R/Python/Quarto versions and dependencies are captured for item 5; clean restoration and the full statistical build remain unverified.
- Source-note wording, exact parental CPS ending month, input coverage and scientific review: item 6.
- A full verified rebuild, updated reviewed renders, and final release commit/tag on publication.

No statistical regeneration, large source-payload copy, extract submission, database write, GitHub push, or release publication occurred during this restoration. [Release provenance](releases/2.0.0/README.md) now includes accompanying code and small-input checksums. [Upload guide](GITHUB_UPLOAD_GUIDE.md) and [file manifest](FILE_MANIFEST.csv) reflect the new public files.
