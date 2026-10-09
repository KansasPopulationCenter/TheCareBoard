# Run from the repository root: Rscript --vanilla R/refresh_atus_eldercare.R
# Optional arguments: input CSV, hierarchical DDI. Refreshes only this CSV.
# Original cells are handled as text to preserve IDs, weights and time values.
source("R/atus_eldercare.R")

refresh_atus_eldercare <- function(path = "data/CSV/ATUSdata.csv",
                                 ddi_path = "data/IPUMS Pulls/atus_00036.xml",
                                 chunk_size = 50000L) {
  path <- normalizePath(path, winslash = "/", mustWork = TRUE)
  directory <- dirname(path)
  stage <- tempfile(".atus-eldercare-", tmpdir = directory, fileext = ".csv")
  backup <- tempfile("ATUSdata-before-eldercare-", tmpdir = directory, fileext = ".csv.bak")
  header <- names(data.table::fread(path, nrows = 0L, check.names = FALSE))
  stopifnot(!anyDuplicated(header), all(c("YEAR", "CASEID", "ECPRIOR") %in% header))
  added <- atus_eldercare_columns()
  retained <- setdiff(header, added)
  message("Reading respondent identifiers and the hierarchical eldercare roster...")
  people <- unique(data.table::fread(path, select = c("YEAR", "CASEID", "ECPRIOR"),
    colClasses = "character", na.strings = NULL, showProgress = FALSE, nThread = 2L))
  message("Loaded ", nrow(people), " respondents; reading recipient records in chunks...")
  roster <- read_atus_eldercare(ddi_path)
  message("Loaded ", nrow(roster$recipients), " recipients; building respondent features...")
  features <- build_atus_eldercare_features(people, roster)
  keys <- atus_eldercare_key(features)
  raw_prior <- people$ECPRIOR
  stopifnot(identical(keys, atus_eldercare_key(people)))

  read_block <- function(connection, header_line) {
    lines <- readLines(connection, n = chunk_size, warn = FALSE)
    if (!length(lines)) return(NULL)
    # Base CSV parsing decodes escaped quotes, unlike fread's character reader.
    # This avoids doubling embedded quotes on each refresh.
    block <- utils::read.csv(text = paste(c(header_line, lines), collapse = "\n"),
      colClasses = "character", na.strings = NULL, check.names = FALSE,
      stringsAsFactors = FALSE, strip.white = FALSE)
    if (nrow(block) != length(lines)) {
      stop("Unexpected multiline CSV records; original CSV was not replaced.", call. = FALSE)
    }
    block
  }
  input <- file(path, "rt")
  on.exit(try(close(input), silent = TRUE), add = TRUE)
  input_header <- readLines(input, n = 1L)
  total <- 0L
  repeat {
    block <- read_block(input, input_header)
    if (is.null(block)) break
    index <- match(atus_eldercare_key(block), keys)
    stopifnot(!anyNA(index), identical(block$ECPRIOR, raw_prior[index]))
    out <- block[, retained, drop = FALSE]
    for (nm in added) out[[nm]] <- features[[nm]][index]
    data.table::fwrite(out, stage, append = total > 0L, col.names = total == 0L,
                      na = "NA", quote = "auto", nThread = 2L)
    total <- total + nrow(block)
    if (total %% 500000L == 0L) message("Wrote ", format(total, big.mark = ","), " activities...")
  }
  close(input)
  if (total == 0L) stop("Input has no activities; original CSV was not replaced.")

  # Re-read every saved cell before replacing the source. Existing columns must
  # match exactly as CSV text values; derived columns must match respondent data.
  message("Verifying all original columns and all added columns in the saved CSV...")
  original <- file(path, "rt")
  saved <- file(stage, "rt")
  on.exit(try(close(original), silent = TRUE), add = TRUE)
  on.exit(try(close(saved), silent = TRUE), add = TRUE)
  original_header <- readLines(original, n = 1L)
  saved_header <- readLines(saved, n = 1L)
  checked <- 0L
  repeat {
    before <- read_block(original, original_header)
    after <- read_block(saved, saved_header)
    if (is.null(before)) { stopifnot(is.null(after)); break }
    stopifnot(!is.null(after), identical(names(after), c(retained, added)))
    if (!identical(before[, retained, drop = FALSE], after[, retained, drop = FALSE])) {
      stop("Existing CSV cells changed during export: ", paste(all.equal(
        before[, retained, drop = FALSE], after[, retained, drop = FALSE]), collapse = "; "))
    }
    index <- match(atus_eldercare_key(after), keys)
    stopifnot(!anyNA(index))
    for (nm in added) {
      expected <- as.character(features[[nm]][index])
      expected[is.na(expected)] <- "NA"
      stopifnot(identical(after[[nm]], expected))
    }
    checked <- checked + nrow(after)
    if (checked %% 500000L == 0L) message("Verified ", format(checked, big.mark = ","), " activities...")
  }
  close(original)
  close(saved)
  stopifnot(checked == total)

  # All paths are in the resolved input directory; no recursive move/delete.
  # Retain a backup and restore it if replacement fails (Windows rename rules).
  stopifnot(identical(dirname(stage), directory), identical(dirname(backup), directory))
  if (!file.rename(path, backup)) stop("Could not retain the original CSV; staged CSV: ", stage)
  if (!file.rename(stage, path)) {
    restored <- file.rename(backup, path)
    stop("CSV replacement failed. Original restored: ", restored, "; backup: ", backup)
  }
  message("Rebuilt ", path, " (", format(total, big.mark = ","), " activity rows; ",
          length(added), " eldercare columns).")
  message("Original retained at ", backup)
  invisible(list(path = path, backup = backup, rows = total, respondents = nrow(features)))
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) > 2L) stop("Usage: Rscript R/refresh_atus_eldercare.R [CSV] [hierarchical DDI]")
  do.call(refresh_atus_eldercare, as.list(args))
}
