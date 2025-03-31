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
