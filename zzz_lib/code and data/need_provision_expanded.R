library(tidyverse)
library(janitor)
library(Hmisc)

atus <- read.csv("./data/CSV/ATUSdata.csv") %>%
  select(
    YEAR, CASEID, WT06, ACTLINE, HH_SIZE, AGE, marst, nchild, 
    activity, act_care_focus, FOCUS, 
    paid_work, child_care, elder_care, sleeping, 
    DURATION, SCC_ALL_LN, SEC_ALL_LN
  ) %>%
  clean_names() 

atus$sec_all_ln[is.na(atus$sec_all_ln)] <- 0


ddi_file <- read_ipums_ddi("./data/IPUMS Pulls/atus_00026.xml")
atus_hh <- read_ipums_micro(ddi_file) |> 
  clean_names()

# List of 5-year windows
year_windows <- lapply(2003:2019, function(start_year) start_year:(start_year + 4))

# Final output list
all_market_datum <- list()

# Loop over year windows
for (years_include in year_windows) {
  
  year_tag <- max(years_include)
  
  atus_filtered <- atus |>
    filter(year %in% years_include) |> 
    rename(care_focus = act_care_focus) |> 
    mutate(
      care_job = ifelse(focus == "none", 0, 1),
      weight = wt06 / 365 / 5,
      work_time = duration * paid_work * care_job
    )
  
  atus_filtered <- atus_filtered |> 
    left_join(
      atus_hh |> select(caseid, actlinew, relatew),
      by = c("caseid" = "caseid", "actline" = "actlinew")
    )
  
  # --- Needs Calculation ---
  needs_atus_calc <- list()
  for (a in age_modified$age) {
    data <- atus_filtered |> 
      group_by(caseid) |> 
      filter(all(scc_all_ln == 0), all(sec_all_ln == 0), 
             all(child_care == 0), all(elder_care == 0)) |> 
      ungroup() |> 
      filter(care_focus != "non-care" , hh_size == 1, 
             age %in% (a-2):(a+2)) |> 
      reframe(duration = sum(duration, na.rm = TRUE),
              weight = first(weight),
              .by = c(care_focus, caseid)) |> 
      reframe(need_interval = weighted.mean(duration, w = weight, na.rm = TRUE),
              .by = c(care_focus)) |> 
      mutate(age = a)
    
    if (nrow(data) > 0) {
      needs_atus_calc[[as.character(a)]] <- data
    }
  }
  needs_atus_calc <- bind_rows(needs_atus_calc)
  
  # --- Provision Calculation ---
  provision_atus_calc <- list()
  for (a in age_modified$age) {
    data <- bind_rows(
      atus_filtered |> filter(activity == "Formal Work" & focus != "none") |> 
        mutate(care_focus = focus),
      atus_filtered |> filter(care_focus != "non-care"),
      atus_filtered |> 
        filter(scc_all_ln > 0, !(activity == "Formal Work" & focus != "none"),
               !(care_focus != "non-care"), sec_all_ln == 0) |> 
        mutate(care_focus = "developmental", duration = scc_all_ln),
      atus_filtered |> 
        filter(sec_all_ln > 0, !(activity == "Formal Work" & focus != "none"),
               !(care_focus != "non-care"), scc_all_ln == 0) |> 
        mutate(care_focus = "health", duration = sec_all_ln)
    ) |> 
      filter(age %in% (a-2):(a+2)) |> 
      reframe(duration = sum(duration, na.rm = TRUE),
              weight = first(weight),
              .by = c(caseid, care_focus)) |> 
      reframe(provision_interval = wtd.quantile(duration, weights = weight, probs = 0.5, normwt = FALSE),
              .by = care_focus) |> 
      mutate(age = a)
    
    if (nrow(data) > 0) {
      provision_atus_calc[[as.character(a)]] <- data
    }
  }
  provision_atus_calc <- bind_rows(provision_atus_calc)
  
  # --- KU Overrides (assumes static override logic) ---
  needs_ku_override <- prepare_overrides(need_interval, age_ranges, "need_override")
  provision_ku_override <- prepare_overrides(provision_interval, age_ranges, "provision_override")
  
  # --- Merge all data ---
  df_list <- list(
    market_datum,
    needs_atus_calc, 
    needs_ku_override, 
    provision_atus_calc, 
    provision_ku_override
  ) 
  
  market_datum2 <- reduce(df_list, full_join, by = c("age", "care_focus")) |> 
    mutate(
      need_interval = coalesce(need_override, need_interval, 0),
      provision_interval = coalesce(provision_override, provision_interval, 0)
    ) |> 
    select(age, care_focus, need_interval, provision_interval)
  
  # --- Smooth ---
  market_datum_smoothed <- smooth_data(market_datum2) %>%
    select(age, care_focus, smoothed_need, smoothed_prov) %>%
    rename(need_interval = smoothed_need,
           provision_interval = smoothed_prov) |> 
    mutate(YEAR = year_tag)
  
  all_market_datum[[as.character(year_tag)]] <- market_datum_smoothed
}

# Final combined dataset
final_data <- bind_rows(all_market_datum)

market_datum_all <- final_data %>% 
  filter(!is.na(age))

write.csv(market_datum_all, "./data/CSV/need_provision_data.csv", row.names = FALSE)
write_dta(market_datum_all, "./data/DTA/need_provision_data.dta")

