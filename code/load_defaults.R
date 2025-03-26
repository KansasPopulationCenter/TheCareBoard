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
  rlang
)

options(scipen = 999)

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
