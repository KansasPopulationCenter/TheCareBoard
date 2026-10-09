# Respondent-level eldercare features. Keep the activity extract as the base;
# joining recipient records directly would multiply activities and diary minutes.

atus_eldercare_groups <- c("spouse_partner", "parent", "grandparent",
                         "other_relative", "nonrelative")

atus_eldercare_columns <- function(max_recipients = 5L) {
  c("eldercare_provider", "eldercare_roster_available",
    "eldercare_recipient_count", "eldercare_hh_recipient",
    "eldercare_nonhh_recipient", paste0("eldercare_", atus_eldercare_groups),
    "eldercare_relationship_unknown",
    unlist(lapply(seq_len(max_recipients), function(i) paste0(
      "ec", i, "_", c("lineno", "age", "age_topcoded", "relater",
                      "relationship", "hh_member"))), use.names = FALSE))
}

atus_eldercare_relationship <- function(code) {
  result <- rep(NA_character_, length(code))
  result[code %in% c(200, 210)] <- "spouse_partner"
  result[code %in% 240:244] <- "parent"
  result[code %in% 263:265] <- "grandparent"
  result[code %in% c(220, 230, 250:252, 260:262)] <- "other_relative"
  result[code %in% c(280, 290, 300, 310, 320)] <- "nonrelative"
  # RELATER=400 means "Other", without identifying whether related. Keep NA.
  result
}

clean_atus_eldercare_recipients <- function(records) {
  required <- c("YEAR", "CASEID", "LINENOR", "HH_EC", "RELATER", "ECAGE")
  stopifnot(all(required %in% names(records)))
  out <- as.data.frame(records)[, required, drop = FALSE]
  out$CASEID <- as.character(out$CASEID)
  for (nm in setdiff(required, "CASEID")) out[[nm]] <- as.integer(out[[nm]])
  if (anyNA(out[c("YEAR", "CASEID", "LINENOR")]) ||
      anyDuplicated(out[c("YEAR", "CASEID", "LINENOR")])) {
    stop("Missing or duplicate eldercare recipient identifiers.", call. = FALSE)
  }
  out <- out[order(out$YEAR, out$CASEID, out$LINENOR), , drop = FALSE]
  out$hh_member <- ifelse(out$HH_EC %in% 0:1, out$HH_EC, NA_integer_)
  # IPUMS ECAGE codes: 0-79, 80 (80-84), 85 (85+). No age-65 cutoff.
  out$age <- ifelse(out$ECAGE %in% c(0:80, 85), out$ECAGE, NA_integer_)
  out$age_topcoded <- ifelse(is.na(out$age), NA_integer_,
                            as.integer(out$age %in% c(80, 85)))
  out$relationship <- atus_eldercare_relationship(out$RELATER)
  rownames(out) <- NULL
  out
}

read_atus_eldercare <- function(ddi_path = "data/IPUMS Pulls/atus_00036.xml") {
  # The hierarchy contains millions of unused activity/who records. Discard
  # them in bounded chunks rather than materializing the entire hierarchy.
  records <- ipumsr::read_ipums_micro_chunked(
    ddi_path, callback = ipumsr::IpumsDataFrameCallback$new(function(x, pos) {
      x[as.character(x$RECTYPE) %in% c("1", "5"), ]
    }), chunk_size = 100000L,
    vars = c("RECTYPE", "YEAR", "CASEID", "LINENOR", "HH_EC", "RELATER", "ECAGE"),
    var_attrs = NULL, verbose = FALSE
  )
  stopifnot(all(c("RECTYPE", "YEAR", "CASEID", "LINENOR") %in% names(records)))
  coverage <- as.data.frame(records[as.character(records$RECTYPE) == "1", c("YEAR", "CASEID")])
  coverage$CASEID <- as.character(coverage$CASEID)
  if (anyNA(coverage) || anyDuplicated(coverage)) {
    stop("Invalid household coverage in hierarchical ATUS extract.", call. = FALSE)
  }
  list(coverage = coverage,
       recipients = clean_atus_eldercare_recipients(records[as.character(records$RECTYPE) == "5", ]))
}

atus_eldercare_key <- function(data) paste(data$YEAR, as.character(data$CASEID), sep = ":")

build_atus_eldercare_features <- function(respondents, roster, max_recipients = 5L) {
  required <- c("YEAR", "CASEID", "ECPRIOR")
  stopifnot(all(required %in% names(respondents)))
  people <- unique(as.data.frame(respondents)[, required, drop = FALSE])
  people$CASEID <- as.character(people$CASEID)
  keys <- atus_eldercare_key(people)
  if (anyNA(people[c("YEAR", "CASEID")]) || anyDuplicated(keys)) {
    stop("ECPRIOR must be constant within each ATUS respondent.", call. = FALSE)
  }
  if (!all(keys %in% atus_eldercare_key(roster$coverage))) {
    stop("Hierarchical extract does not cover every activity respondent; check source years.",
         call. = FALSE)
  }
  recipients <- roster$recipients
  recipient_keys <- atus_eldercare_key(recipients)
  recipient_person <- match(recipient_keys, keys)
  # A subset of activity respondents is allowed; retain only their recipients.
  keep <- !is.na(recipient_person)
  recipients <- recipients[keep, , drop = FALSE]
  recipient_person <- recipient_person[keep]
  # CSV refreshes can supply the literal NA marker; raw IPUMS supplies real NA.
  raw_prior <- suppressWarnings(as.integer(people$ECPRIOR))
  provider <- ifelse(raw_prior %in% 0:1, raw_prior, NA_integer_)
  if (any(is.na(provider[recipient_person]) | provider[recipient_person] != 1L)) {
    stop("Recipient roster conflicts with ECPRIOR; check extract linkage.", call. = FALSE)
  }
  out <- people[, c("YEAR", "CASEID"), drop = FALSE]
  for (nm in atus_eldercare_columns(max_recipients)) {
    out[[nm]] <- if (grepl("^ec[0-9]+_relationship$", nm)) NA_character_ else NA_integer_
  }
  out$eldercare_provider <- provider
  out$eldercare_roster_available[which(provider == 1L)] <- 0L
  # Three-valued logic: absence is 0 only when every recipient is classified.
  any_known <- function(x) {
    if (any(x, na.rm = TRUE)) 1L else if (anyNA(x)) NA_integer_ else 0L
  }
  if (!nrow(recipients)) return(out)
  rec <- data.table::as.data.table(recipients)
  data.table::set(rec, j = ".person", value = recipient_person)
  rec[, slot := seq_len(.N), by = .person]
  if (max(rec$slot) > max_recipients) {
    stop("More recipient records than available slots; increase max_recipients.", call. = FALSE)
  }
  summary <- rec[, c(list(
    eldercare_roster_available = 1L,
    eldercare_recipient_count = .N,
    eldercare_hh_recipient = any_known(hh_member == 1L),
    eldercare_nonhh_recipient = any_known(hh_member == 0L),
    eldercare_relationship_unknown = as.integer(anyNA(relationship))),
    stats::setNames(lapply(atus_eldercare_groups, function(group) {
      any_known(relationship == group)
    }), paste0("eldercare_", atus_eldercare_groups))), by = .person]
  for (nm in setdiff(names(summary), ".person")) {
    out[[nm]][summary$.person] <- summary[[nm]]
  }
  source_columns <- c(lineno = "LINENOR", age = "age", age_topcoded = "age_topcoded",
                      relater = "RELATER", relationship = "relationship", hh_member = "hh_member")
  for (j in seq_len(max_recipients)) {
    rows <- which(rec$slot == j)
    for (nm in names(source_columns)) {
      out[[paste0("ec", j, "_", nm)]][rec$.person[rows]] <- rec[[source_columns[[nm]]]][rows]
    }
  }
  out
}

add_atus_eldercare <- function(activities, roster = read_atus_eldercare()) {
  people <- unique(as.data.frame(activities)[, c("YEAR", "CASEID", "ECPRIOR"), drop = FALSE])
  features <- build_atus_eldercare_features(people, roster)
  index <- match(atus_eldercare_key(activities), atus_eldercare_key(features))
  stopifnot(!anyNA(index))
  # Assignment preserves activity row order and count, and is safe to rerun.
  for (nm in atus_eldercare_columns()) activities[[nm]] <- features[[nm]][index]
  activities
}
