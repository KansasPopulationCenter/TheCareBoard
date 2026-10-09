# Run from the repository root: Rscript --vanilla tests/atus_eldercare.R
source("R/atus_eldercare.R")

people <- data.frame(YEAR = 2025L, CASEID = as.character(1:6),
                     ECPRIOR = c(1L, 1L, 0L, 99L, 1L, 1L))
raw <- data.frame(YEAR = 2025L, CASEID = c("1", "2", "2", "6"),
  LINENOR = c(3L, 4L, 2L, 7L), HH_EC = c(1L, 0L, 1L, 0L),
  RELATER = c(210L, 400L, 241L, 264L), ECAGE = c(80L, 85L, 64L, 99L))
roster <- list(coverage = people[, c("YEAR", "CASEID")],
              recipients = clean_atus_eldercare_recipients(raw))
features <- build_atus_eldercare_features(people, roster)
stopifnot(identical(features$eldercare_provider, c(1L, 1L, 0L, NA_integer_, 1L, 1L)))
# A provider with no roster keeps known provider status, with unknown recipients.
stopifnot(features$eldercare_roster_available[5] == 0L,
          is.na(features$eldercare_recipient_count[5]))
# Nonproviders and unavailable survey responses have NA recipient fields.
stopifnot(all(is.na(features[3:4, setdiff(atus_eldercare_columns(), "eldercare_provider")])) )
# Sort recipients by LINENOR and retain both household and nonhousehold care.
stopifnot(features$ec1_lineno[2] == 2L, features$ec2_lineno[2] == 4L,
          features$ec1_age[2] == 64L, features$ec2_age[2] == 85L,
          features$eldercare_hh_recipient[2] == 1L,
          features$eldercare_nonhh_recipient[2] == 1L,
          features$eldercare_parent[2] == 1L,
          is.na(features$eldercare_nonrelative[2]),
          is.na(features$ec2_relationship[2]), features$ec2_relater[2] == 400L,
          features$eldercare_relationship_unknown[2] == 1L,
          features$ec1_age_topcoded[1] == 1L,
          features$ec1_age_topcoded[2] == 0L,
          is.na(features$ec1_age[6]), is.na(features$ec1_age_topcoded[6]))
# All documented RELATER codes, including the broad and older coding variants.
codes <- c(200, 210, 240:244, 263:265, 220, 230, 250:252, 260:262,
           280, 290, 300, 310, 320, 400, 999, NA)
expected <- c(rep("spouse_partner", 2), rep("parent", 5), rep("grandparent", 3),
              rep("other_relative", 8), rep("nonrelative", 5), rep(NA_character_, 3))
stopifnot(identical(atus_eldercare_relationship(codes), expected))
# Activity count, order, minutes and weights survive; no diary time is required.
activities <- people[c(2, 1, 2, 3, 4, 5, 6), ]
activities$ACTLINE <- c(2L, 1L, 1L, 1L, 1L, 1L, 1L)
activities$DURATION <- c(30, 60, 1410, 1440, 1440, 1440, 1440)
activities$SEC_ALL_LN <- 0
activities$WT06 <- 123.456789
result <- add_atus_eldercare(activities, roster)
stopifnot(identical(result[, names(activities)], activities),
          identical(result, add_atus_eldercare(result, roster)),
          result$eldercare_provider[2] == 1L)
expect_error <- function(expr) stopifnot(inherits(tryCatch(expr, error = identity), "error"))
expect_error(clean_atus_eldercare_recipients(rbind(raw, raw[1, ])))
expect_error(build_atus_eldercare_features(rbind(people, transform(people[1, ], ECPRIOR = 0)), roster))
uncovered <- roster
uncovered$coverage <- roster$coverage[-1, ]
expect_error(build_atus_eldercare_features(people, uncovered))
expect_error(build_atus_eldercare_features(transform(people, ECPRIOR = 0L), roster))
expect_error(build_atus_eldercare_features(people, roster, max_recipients = 1L))
empty <- roster
empty$recipients <- roster$recipients[0, ]
stopifnot(all(is.na(build_atus_eldercare_features(people, empty)$ec1_age)))

# Exercise the CSV staging, cell-preservation checks and repeated refresh in
# small chunks. Include quoted commas and a 14-digit ID in an unrelated column.
source("R/refresh_atus_eldercare.R")
csv <- tempfile(fileext = ".csv")
activities$note <- c('quoted "text", comma', "", "NA", "20110101020210", "a", "b", "c")
utils::write.csv(activities, csv, row.names = FALSE, na = "NA")
reader <- read_atus_eldercare
read_atus_eldercare <- function(ddi_path) roster
tryCatch({
  first <- refresh_atus_eldercare(csv, "synthetic", chunk_size = 3L)
  before_rerun <- readLines(csv)
  second <- refresh_atus_eldercare(csv, "synthetic", chunk_size = 2L)
  stopifnot(identical(readLines(csv), before_rerun), first$rows == nrow(activities),
            file.exists(first$backup), file.exists(second$backup))
}, finally = { read_atus_eldercare <- reader })
cat("ATUS eldercare regression checks passed.\n")
