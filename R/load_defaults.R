if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(
  tidyverse, 
  data.table,
  haven,
  janitor, 
  ggplot2,
  scales,
  DescTools, 
  Hmisc, 
  slider, 
  readxl, 
  rlang,
  skimr,
  DT,
  scales,
  writexl
)

options(scipen = 999)

read_api_key_from_terminal <- function(prompt) {
  if (requireNamespace("getPass", quietly = TRUE) && interactive()) {
    return(getPass::getPass(prompt))
  }

  cat(prompt)
  flush.console()
  key <- readLines("stdin", n = 1, warn = FALSE)
  if (length(key) == 0) key <- ""
  key
}

prompt_for_api_key <- function(service, envvar) {
  key <- Sys.getenv(envvar, unset = "")

  if (!nzchar(key)) {
    prompt <- paste0("Enter your ", service, " API key: ")
    key <- read_api_key_from_terminal(prompt)
    key <- trimws(key)
  }

  if (!nzchar(key)) {
    stop(
      service,
      " API key was not provided. Set ",
      envvar,
      " or enter it when prompted.",
      call. = FALSE
    )
  }

  do.call(Sys.setenv, as.list(stats::setNames(key, envvar)))
  key
}

register_census_api_key <- function(install = FALSE, overwrite = FALSE) {
  if (!requireNamespace("tidycensus", quietly = TRUE)) {
    stop("The tidycensus package is required for Census API access.", call. = FALSE)
  }

  key <- prompt_for_api_key("Census", "CENSUS_API_KEY")
  tidycensus::census_api_key(key, install = install, overwrite = overwrite)
  invisible(key)
}

register_ipums_api_key <- function(save = FALSE) {
  if (!requireNamespace("ipumsr", quietly = TRUE)) {
    stop("The ipumsr package is required for IPUMS API access.", call. = FALSE)
  }

  key <- prompt_for_api_key("IPUMS", "IPUMS_API_KEY")
  ipumsr::set_ipums_api_key(key, save = save)
  invisible(key)
}

ensure_output_dirs <- function(base_dir = "./data") {
  dirs <- file.path(base_dir, c("CSV", "Dta", "Excel"))
  purrr::walk(dirs, dir.create, recursive = TRUE, showWarnings = FALSE)
  invisible(dirs)
}

stata_safe_names <- function(nms) {
  nms <- janitor::make_clean_names(nms)
  nms <- substr(nms, 1, 32)

  while (anyDuplicated(nms)) {
    dupes <- duplicated(nms) | duplicated(nms, fromLast = TRUE)
    nms[dupes] <- paste0(substr(nms[dupes], 1, 28), "_", seq_len(sum(dupes)))
  }

  nms
}

write_careboard_outputs <- function(data,
                                    stem,
                                    app_path = NULL,
                                    base_dir = "./data",
                                    excel_max_rows = 1048575) {
  ensure_output_dirs(base_dir)

  out <- as.data.frame(data)
  csv_path <- file.path(base_dir, "CSV", paste0(stem, ".csv"))
  dta_path <- file.path(base_dir, "Dta", paste0(stem, ".dta"))
  xlsx_path <- file.path(base_dir, "Excel", paste0(stem, ".xlsx"))

  if (!is.null(app_path)) {
    dir.create(dirname(app_path), recursive = TRUE, showWarnings = FALSE)
    write.csv(out, app_path, row.names = FALSE)
  }

  write.csv(out, csv_path, row.names = FALSE)

  dta_out <- out
  names(dta_out) <- stata_safe_names(names(dta_out))
  haven::write_dta(dta_out, dta_path)

  sheets <- if (nrow(out) == 0) {
    list(data = out)
  } else {
    row_groups <- ceiling(seq_len(nrow(out)) / excel_max_rows)
    split(out, row_groups)
  }
  names(sheets) <- if (length(sheets) == 1) {
    "data"
  } else {
    paste0("data_", stringr::str_pad(seq_along(sheets), 2, pad = "0"))
  }
  writexl::write_xlsx(sheets, xlsx_path, format_headers = TRUE, use_zip64 = TRUE)

  invisible(list(csv = csv_path, dta = dta_path, xlsx = xlsx_path, app = app_path))
}

atus_yr_range <- function(df){
  yr_range <- df |> 
    select(year) |> 
    filter(year != 2020) |> 
    unique() |> 
    arrange() |> 
    mutate(
      yr_start = slide_min(
        x = year, before = 4, complete = TRUE)
    )
  
  return(yr_range)
}
