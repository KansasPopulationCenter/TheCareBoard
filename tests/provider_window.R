# Run from the repository root: Rscript --vanilla tests/provider_window.R
# Evaluate the actual selection blocks without loading data or packages.
scripts <- c("analysis/care_provider.qmd", "analysis/provider.qmd")
blocks <- lapply(scripts, function(script) {
  lines <- readLines(script, warn = FALSE)
  start <- grep("^atus_years <-", lines)
  end <- grep("^atus <- atus\\[", lines)
  stopifnot(length(start) == 1L, length(end) == 1L, end > start)
  parse(text = lines[start:end])
})
stopifnot(identical(blocks[[1]], blocks[[2]]))

run_window <- function(block, years) {
  env <- new.env(parent = baseenv())
  env$tail <- utils::tail
  env$atus <- data.frame(year = years, record = seq_along(years))
  eval(block, envir = env)
  env$atus
}

cases <- list(
  current_release = list(c(2019L, 2020L, 2021L:2025L), 2021L:2025L),
  shuffled_duplicates = list(c(2025L, 2019L, 2023L, NA, 2021L, 2020L,
                                2024L, 2022L, 2025L), 2021L:2025L),
  next_release = list(c(2019L, 2020L, 2021L:2026L), 2022L:2026L),
  gaps = list(c(2016L:2021L, 2023L), c(2017L:2019L, 2021L, 2023L))
)

for (i in seq_along(scripts)) {
  for (name in names(cases)) {
    years <- cases[[name]][[1]]
    expected <- cases[[name]][[2]]
    actual <- run_window(blocks[[i]], years)
    stopifnot(
      identical(sort(unique(actual$year)), expected),
      identical(actual$record, which(years %in% expected)),
      ncol(actual) == 2L
    )
    cat("PASS", scripts[i], name, "\n")
  }
  for (years in list(2022L:2025L, c(2020L, 2022L:2025L, NA), integer())) {
    error <- tryCatch({run_window(blocks[[i]], years); NULL}, error = identity)
    stopifnot(inherits(error, "error"),
              grepl("require five eligible ATUS survey years", conditionMessage(error)))
  }
  # Six equal annual contributions must no longer be divided by five.
  selected <- run_window(blocks[[i]], c(2019L, 2021L:2025L))
  stopifnot(sum(rep(365, nrow(selected)) / 365 / 5) == 1)
  cat("PASS", scripts[i], "insufficient years and weight normalization\n")
}

cat("All provider-window regression checks passed.\n")
