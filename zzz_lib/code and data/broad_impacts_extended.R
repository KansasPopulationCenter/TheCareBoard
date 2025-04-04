asec <- read.csv("./data/CSV/ASECdata.csv") |>
  # incorporate HFLAG clause due to survey redesign in 2014
  # https://blog.popdata.org/2014sample/
  filter(HFLAG == 1 | is.na(HFLAG)) |> 
  filter(AGE >= 18) |>
  filter(YEAR >= 1990) |>
  select(YEAR,
         ASECWT,
         UHRSWORKT,
         INCWAGE,
         empstat,
         race_ethnicity,
         educ,
         marst,
         statefip,
         occ_care_focus,
         gender_parent) |>
  clean_names() |>
  mutate(
    date = as.Date(paste0(year, "-01-01")),
    uhrsworkt = ifelse(uhrsworkt == 999, 0, uhrsworkt),
    occ_type = ifelse(occ_care_focus == "none", "non-care", "care"),
    overall = "overall"
  ) 

atus <- read.csv("./data/CSV/ATUSdata.csv") |> 
  filter(activity != "Formal Work") |> 
  filter(AGE >= 18) |>
  filter(YEAR != 2020) |> 
  select(YEAR, CASEID, WT06, ACTIVITY, DURATION, SCC_ALL_LN, SEC_ALL_LN,
         race_ethnicity, educ, marst,
         act_care_focus, activity, gender_parent) |> 
  clean_names() |> 
  pivot_longer(
    cols = c(duration, scc_all_ln, sec_all_ln),
    names_to = "metric", 
    values_to = "duration"
  ) |>   
  mutate(
    duration = coalesce(duration, 0),
    care_flag = case_when(
      metric %in% c("scc_all_ln", "sec_all_ln") | 
        act_care_focus != "non-care" ~ "care", 
      TRUE ~ "non-care" 
    ), 
    overall = "overall"
  )

source("load_defaults.R")
case_year <- atus |> 
  mutate(weight = wt06 / 365) |> 
  summarise(
    total_time = sum(duration),
    .by = c(year, caseid, race_ethnicity, educ, marst, gender_parent, weight, care_flag)
  ) |> 
  mutate(overall = "overall")

yr_range <- atus_yr_range(atus)




formal_lfp_all <- bind_rows(
  get_formal_lfp(asec, "overall"),
  get_formal_lfp(asec, "gender_parent"),
  get_formal_lfp(asec, "race_ethnicity"),
  get_formal_lfp(asec, "educ"),
  get_formal_lfp(asec, "marst"),
  get_formal_lfp(asec, "statefip")
)

informal_lfp_all <- bind_rows(
  get_informal_lfp("overall"),
  get_informal_lfp("gender_parent"),
  get_informal_lfp("race_ethnicity"),
  get_informal_lfp("educ"),
  get_informal_lfp("marst")
)

informal_lfp_all <- informal_lfp_all |>
  mutate(sector = "informal")

formal_lfp_all <- formal_lfp_all |>
  mutate(sector = "formal")


combined_lfp <- bind_rows(informal_lfp_all, formal_lfp_all)

care_force_data <- combined_lfp |>
  transmute(
    date,
    category_id,
    subcategory_id,
    sector,
    care_force = coalesce(informal_care_labor_force, formal_care_labor_force),
    care_force_proportion = coalesce(informal_care_labor_force_proportion, formal_care_labor_force_proportion)
  )

write.csv(care_force_data, "./data/CSV/care_force_data.csv")
write_dta(care_force_data, "./data/DTA/care_force_data.dta")

formal_time_all <- bind_rows(
  get_formal_time(asec, "overall"),
  get_formal_time(asec, "gender_parent"),
  get_formal_time(asec, "educ"),
  get_formal_time(asec, "marst"),
  get_formal_time(asec, "race_ethnicity"),
  get_formal_time(asec, "statefip")
)

informal_time_all <- bind_rows(
  get_informal_time("overall"),
  get_informal_time("gender_parent"),
  get_informal_time("educ"),
  get_informal_time("marst"),
  get_informal_time("race_ethnicity"),
  
) 

informal_time_all <- informal_time_all |>
  mutate(sector = "informal")

formal_time_all <- formal_time_all |>
  mutate(sector = "formal")


combined_time <- bind_rows(informal_time_all, formal_time_all)

care_force_time_data <- combined_time |>
  transmute(
    date,
    category_id,
    subcategory_id,
    sector,
    care_force_minutes = coalesce(informal_care_time, formal_care_time),
    care_force_proportion = coalesce(informal_care_time_proportion, formal_care_time_proportion)
  )

write.csv(care_force_time_data, "./data/CSV/care_force_time_data.csv")
write_dta(care_force_time_data, "./data/DTA/care_force_time_data.dta")

us_gdp <- read.csv("./data/CSV/USGDP.csv") |>
  clean_names() |>
  mutate(
    date = as.Date(paste0(
      substr(
        observation_date,
        nchar(observation_date) - 3,
        nchar(observation_date)
      ), "-01-01"
    )),
    fygdp = fygdp * 1e9,
    gdp_daily = fygdp / 365
  ) |>
  filter(year(date) >= 1990) |>
  select(date, gdp_daily)


formal_value_all <- bind_rows(
  get_formal_value(asec, "overall"),
  get_formal_value(asec, "gender_parent"),
  get_formal_value(asec, "educ"),
  get_formal_value(asec, "marst"),
  get_formal_value(asec, "race_ethnicity"),
  get_formal_value(asec, "statefip")
)


informal_value_all <- informal_time_all |> 
  left_join(us_gdp, by = "date") |> 
  mutate(informal_value = (informal_care_time / 60) * 7.25) |> 
  mutate(informal_value_proportion = informal_value/gdp_daily)

informal_value_all <- informal_value_all |>
  mutate(sector = "informal")

formal_value_all <- formal_value_all |>
  mutate(sector = "formal")


combined_value <- bind_rows(informal_value_all, formal_value_all)

care_force_value_data <- combined_value |>
  transmute(
    date,
    category_id,
    subcategory_id,
    sector,
    care_force_value = coalesce(informal_value, formal_value),
    care_force_value_proportion = coalesce(informal_value_proportion, formal_value_proportion)
  )

write.csv(care_force_value_data, "./data/CSV/care_force_value_data.csv")
write_dta(care_force_value_data, "./data/DTA/care_force_value_data.dta")
