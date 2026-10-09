# Maintainers may copy this to local_only/credentials/db_connect.r.
# Supply values through environment variables or an ignored .Renviron file.
# Sourcing a configured copy opens a connection; this file does not upload data.
required_vars <- c("CAREBOARD_DB_NAME", "CAREBOARD_DB_HOST", "CAREBOARD_DB_USER", "CAREBOARD_DB_PASSWORD")
db_values <- Sys.getenv(required_vars, unset = "")
missing_vars <- required_vars[!nzchar(db_values)]
if (length(missing_vars)) {
  stop("Missing database environment variables: ", paste(missing_vars, collapse = ", "), call. = FALSE)
}
db_port_text <- Sys.getenv("CAREBOARD_DB_PORT", unset = "5432")
if (!grepl("^[0-9]+$", db_port_text)) stop("CAREBOARD_DB_PORT must be an integer.", call. = FALSE)
db_port <- suppressWarnings(as.integer(db_port_text))
if (is.na(db_port) || db_port < 1L || db_port > 65535L) {
  stop("CAREBOARD_DB_PORT must be between 1 and 65535.", call. = FALSE)
}
if (!requireNamespace("DBI", quietly = TRUE) || !requireNamespace("RPostgres", quietly = TRUE)) {
  stop("Install DBI and RPostgres before using the warehouse connection.", call. = FALSE)
}
library(DBI)
library(RPostgres)
cn <- DBI::dbConnect(
  RPostgres::Postgres(),
  dbname = db_values[["CAREBOARD_DB_NAME"]],
  host = db_values[["CAREBOARD_DB_HOST"]],
  user = db_values[["CAREBOARD_DB_USER"]],
  password = db_values[["CAREBOARD_DB_PASSWORD"]],
  port = db_port
)
