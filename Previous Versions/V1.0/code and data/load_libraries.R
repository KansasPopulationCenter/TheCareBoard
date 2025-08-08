if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(
  ipumsr, 
  tidyverse, 
  janitor,
  data.table,
  haven
)

options(scipen = 999)
