source("load_defaults.R")

asec <- read.csv("./data/CSV/ASECdata.csv") |>
  filter(YEAR == max(YEAR)) |>  
  filter(AGE >= 18) |> 
  select(YEAR, OCC2010, empstat, occ_label, UHRSWORKT, EARNWT, INCWAGE, 
         occ_care_focus, ASECWT, sex, gender_parent, poverty, empstat, race_ethnicity, prime_age, STATEFIP) |> 
  clean_names() 


# create columns required by the app
cp_formal_state <- asec |> 
  filter(empstat == "Employed") |>
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    time_use = ifelse(occ_care_focus == "none", "non_care", "care"),
    care_focus = occ_care_focus,
    care_type	= "formal", 
    provider_attention = "active",
    geo_level = statefip,
    race = race_ethnicity
  ) 


cp_pop <- asec |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    time_use = ifelse(occ_care_focus == "none", "non_care", "care"),
    care_focus = occ_care_focus,
    care_type	= "formal", 
    provider_attention = "active",
    geo_level = statefip,
    race = race_ethnicity
  ) 

# summarise formal stats
cp_summary <- cp_formal_state %>%
  filter(uhrsworkt != 997) |> 
  mutate(uhrsworkt = ifelse(uhrsworkt == 999, 0, uhrsworkt)) |> 
  summarise(
    provision_interval = sum(uhrsworkt/7*60*asecwt),
    count = n(),
    .by = c(geo_level, gender, race, provider_status, time_use, care_type, 
            care_focus, provider_attention)
  )

cp_summary$geo_level <- sprintf("%02d", as.numeric(cp_summary$geo_level))
cp_summary$geo_level <- paste0("state", cp_summary$geo_level)

population_df <- cp_pop |> 
  summarise(
    population = sum(asecwt),
    .by = c(geo_level, gender, race, provider_status)
  )

population_df$geo_level <- sprintf("%02d", as.numeric(population_df$geo_level))
population_df$geo_level <- paste0("state", population_df$geo_level)

cp_formal_state <- cp_summary |> 
  left_join(population_df, by = c("geo_level", "gender", "race", "provider_status"))


# create columns required by the app
cp_formal_nation <- asec |> 
  filter(empstat == "Employed") |>
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    time_use = ifelse(occ_care_focus == "none", "non_care", "care"),
    care_focus = occ_care_focus,
    care_type	= "formal", 
    provider_attention = "active",
    geo_level = "national",
    race = race_ethnicity
  ) 

cp_pop <- asec |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    time_use = ifelse(occ_care_focus == "none", "non_care", "care"),
    care_focus = occ_care_focus,
    care_type	= "formal", 
    provider_attention = "active",
    geo_level = "national",
    race = race_ethnicity
  ) 

# summarise formal stats
cp_summary <- cp_formal_nation %>%
  filter(uhrsworkt != 997) |> 
  mutate(uhrsworkt = ifelse(uhrsworkt == 999, 0, uhrsworkt)) |> 
  summarise(
    provision_interval = sum(uhrsworkt/7*60*asecwt),
    count = n(),
    .by = c(geo_level, gender, race, provider_status, time_use, care_type, 
            care_focus, provider_attention)
  )

population_df <- cp_pop |> 
  summarise(
    population = sum(asecwt),
    .by = c(gender, race, provider_status)
  )

cp_formal_nation <- cp_summary |> 
  left_join(population_df, by = c("gender", "race", "provider_status"))

cp_formal <- rbind(cp_formal_state, cp_formal_nation)


# load data
atus <- read.csv("./data/CSV/ATUSdata.csv") |> 
  filter(activity != "Formal Work") |> 
  filter(AGE >= 18) |>
  filter(YEAR >= 2019 & YEAR != 2020) |> 
  select(YEAR, CASEID, WT06, sex, gender_parent, race_ethnicity, act_care_focus, 
         DURATION, SCC_ALL_LN, SEC_ALL_LN, STATEFIP) |> 
  clean_names() 

# get most recent 5 year and clean up columns
yr_range <- atus_yr_range(atus) |> 
  filter(year == max(year))

# prep secondary care time
cp_informal <- atus |> 
  pivot_longer(
    cols = c(duration, scc_all_ln, sec_all_ln), 
    names_to = "metric", 
    values_to = "duration"
  ) |> 
  filter(!is.na(duration)) 

# create columns required by the app
cp_informal_state <- cp_informal |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    care_type	= "informal", 
    provider_attention = case_when(
      metric == "scc_all_ln" ~ "passive_child", 
      metric == "sec_all_ln" ~ "passive_elder",
      TRUE ~ "active"
    ), 
    care_focus = case_when(
      metric == "scc_all_ln" ~ "developmental", 
      metric == "sec_all_ln" ~ "health",
      act_care_focus == "non-care" ~ "none", 
      TRUE ~ act_care_focus
    ), 
    time_use = ifelse(care_focus == "none", "non_care", "care"),
    weight = wt06/365/5,
    geo_level = statefip,
    race = race_ethnicity
  ) 

cp_informal_state <- cp_informal_state %>%
  filter(duration != 0)

# summarise informal stats
cp_summary <- cp_informal_state |> 
  summarise(
    total_time = sum(duration),
    weight = median(weight),
    count = n(),
    .by = c(year, caseid, geo_level, gender, race, provider_status, time_use, 
            care_type, care_focus, provider_attention)
  ) |> 
  summarise(
    provision_interval = sum(total_time*weight),
    count = sum(count),
    .by = c(geo_level, gender, race, provider_status, time_use, 
            care_type, care_focus, provider_attention)
  )

cp_summary$geo_level <- sprintf("%02d", as.numeric(cp_summary$geo_level))
cp_summary$geo_level <- paste0("state", cp_summary$geo_level)

cp_pop <- cp_informal_state %>%
  group_by(caseid) %>%
  summarise(
    weight = median(weight),
    geo_level = first(geo_level),
    gender = first(gender),
    provider_status = first(provider_status),
    race = first(race)
  )

population_df <- cp_pop |> 
  summarise(
    population = sum(weight),
    .by = c(geo_level, gender, race, provider_status)
  )

population_df$geo_level <- sprintf("%02d", as.numeric(population_df$geo_level))
population_df$geo_level <- paste0("state", population_df$geo_level)

cp_informal_state <- cp_summary |> 
  left_join(population_df, by = c("geo_level", "gender", "race", "provider_status"))

cp_save <- cp_informal_state
# NATAIONAL

# create columns required by the app
cp_informal_nation <- cp_informal |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    care_type	= "informal", 
    provider_attention = case_when(
      metric == "scc_all_ln" ~ "passive_child", 
      metric == "sec_all_ln" ~ "passive_elder",
      TRUE ~ "active"
    ), 
    care_focus = case_when(
      metric == "scc_all_ln" ~ "developmental", 
      metric == "sec_all_ln" ~ "health",
      act_care_focus == "non-care" ~ "none", 
      TRUE ~ act_care_focus
    ), 
    time_use = ifelse(care_focus == "none", "non_care", "care"),
    weight = wt06/365/5,
    geo_level = "national",
    race = race_ethnicity
  ) 

cp_informal_nation <- cp_informal_nation %>%
  filter(duration != 0)

# summarise formal stats
cp_summary <- cp_informal_nation |> 
  summarise(
    total_time = sum(duration),
    count = n(),
    weight = median(weight),
    .by = c(year, caseid, weight, geo_level, gender, race, provider_status, time_use, 
            care_type, care_focus, provider_attention)
  ) |> 
  summarise(
    provision_interval = sum(total_time*weight),
    count = sum(count),
    .by = c(geo_level, gender, race, provider_status, time_use, 
            care_type, care_focus, provider_attention)
  )

cp_pop <- cp_informal_nation %>%
  group_by(caseid) %>%
  summarise(
    weight = median(weight),
    geo_level = first(geo_level),
    gender = first(gender),
    provider_status = first(provider_status),
    race = first(race)
  )


population_df <- cp_pop |> 
  summarise(
    population = sum(weight),
    .by = c(gender, race, provider_status)
  )

cp_informal_nation <- cp_summary |> 
  left_join(population_df, by = c("gender", "race", "provider_status"))

cp_informal <- rbind(cp_informal_state, cp_informal_nation)


cp_combined <- bind_rows(
  cp_formal, 
  cp_informal
) |> 
  arrange(care_type, time_use, gender, provider_status, care_focus) %>%
  select(geo_level, gender, race, provider_status, time_use, care_type,
         care_focus, provider_attention, provision_interval, population, count)

cp_combined <- cp_combined |> 
  mutate(
    race = case_when(
      race == "White" ~ "white",
      race == "Black" ~ "black",
      race == "Hispanic" ~ "hispanic",
      race == "Asian/Pacific Island" ~ "asian",
      race == "American Indian" ~ "native",
      race == "Two or More Races" ~ "two_or_more",
      TRUE ~ "other"  # catch-all
    )
  )


provider_category <- read_excel("./app_data/provider_group.xlsx")

cp_combined <- cp_combined %>%
  mutate(race = if_else(count < 5 & geo_level != "national", "other", race))

## Define Criteria

criteria_black <-'race == "black"'
criteria_white <- 'race == "white"'
criteria_hispan <- 'race == "hispanic"'
criteria_asian <- 'race == "asian"'
criteria_native <- 'race == "native"'
criteria_multi <- 'race == "two_or_more"'
criteria_other <- 'race == "other"'

criteria_female <- 'gender == "female"'
criteria_male <- 'gender == "male"'

criteria_w_child <- 'provider_status == "with_children"'
criteria_wo_child <- 'provider_status == "without_children"'

group_list = list(
  "male" = criteria_male,
  "female" = criteria_female,
  "male-parent" = paste(criteria_male, criteria_w_child, sep = " & "),
  "male-non-parent" = paste(criteria_male, criteria_wo_child, sep = " & "),
  "female-parent" = paste(criteria_female, criteria_w_child, sep = " & "),
  "female-non-parent" = paste(criteria_female, criteria_wo_child, sep = " & "),
  "male-white" = paste(criteria_male, criteria_white, sep = " & "),
  "male-black" = paste(criteria_male, criteria_black, sep = " & "),
  "male-hispan" = paste(criteria_male, criteria_hispan, sep = " & "),
  "male-asian" = paste(criteria_male, criteria_asian, sep = " & "),
  "male-native" = paste(criteria_male, criteria_native, sep = " & "),
  "male-multi" = paste(criteria_male, criteria_multi, sep = " & "),
  "male-other" = paste(criteria_male, criteria_other, sep = " & "),
  "female-white" = paste(criteria_female, criteria_white, sep = " & "),
  "female-black" = paste(criteria_female, criteria_black, sep = " & "),
  "female-hispan" = paste(criteria_female, criteria_hispan, sep = " & "),
  "female-asian" = paste(criteria_female, criteria_asian, sep = " & "),
  "female-native" = paste(criteria_female, criteria_native, sep = " & "),
  "female-multi" = paste(criteria_female, criteria_multi, sep = " & "),
  "female-other" = paste(criteria_female, criteria_other, sep = " & "),
  "white-parent" = paste(criteria_w_child, criteria_white, sep = " & "),
  "black-parent" = paste(criteria_w_child, criteria_black, sep = " & "),
  "hispan-parent" = paste(criteria_w_child, criteria_hispan, sep = " & "),
  "asian-parent" = paste(criteria_w_child, criteria_asian, sep = " & "),
  "native-parent" = paste(criteria_w_child, criteria_native, sep = " & "),
  "multi-parent" = paste(criteria_w_child, criteria_multi, sep = " & "),
  "other-parent" = paste(criteria_w_child, criteria_other, sep = " & "),
  "white-non-parent" = paste(criteria_wo_child, criteria_white, sep = " & "),
  "black-non-parent" = paste(criteria_wo_child, criteria_black, sep = " & "),
  "hispan-non-parent" = paste(criteria_wo_child, criteria_hispan, sep = " & "),
  "asian-non-parent" = paste(criteria_wo_child, criteria_asian, sep = " & "),
  "native-non-parent" = paste(criteria_wo_child, criteria_native, sep = " & "),
  "multi-non-parent" = paste(criteria_wo_child, criteria_multi, sep = " & "),
  "other-non-parent" = paste(criteria_wo_child, criteria_other, sep = " & ")
)

results_list <- list()

for (group_name in names(group_list)) {
  # Get the filter expression as a string
  filter_expr <- group_list[[group_name]]
  
  # Filter the cp_informal data based on the current group's criteria
  filtered_data <- cp_combined |> 
    filter(eval(parse(text = filter_expr)))
  
  # Summarize the filtered data
  summarized_data <- filtered_data |>
    group_by(geo_level, time_use, care_type, care_focus, provider_attention) |>
    summarise(
      population = sum(population, na.rm = TRUE),
      provision_interval = sum(provision_interval, na.rm = TRUE),
      .groups = "drop"
    ) |>
    mutate(group_by_value = group_name)
  
  # Store each summarized result in the list
  results_list[[group_name]] <- summarized_data
}

final_summary_table <- bind_rows(results_list)

provider_datum <- final_summary_table |>
  left_join(provider_category, by = c("group_by_value" = "name")) |>
  rename(category_id = id) |>
  rename(subcategory_id = group_by_value) |>
  select(-c("order")) |>
  select(geo_level, category_id, subcategory_id, care_type, care_focus, provider_attention, provision_interval, population)

provider_datum <- provider_datum %>%
  group_by(
    geo_level,
    category_id,
    subcategory_id,
    care_type,
    care_focus,
    provider_attention
  ) %>%
  summarise(
    provision_interval = sum(provision_interval, na.rm = TRUE),
    population = sum(population, na.rm = TRUE),
    .groups = "drop"
  )

write.csv(provider_datum, "./app_data/provider_datum.csv", row.names = FALSE)

## Provider

asec <- read.csv("./data/CSV/ASECdata.csv") |>
  filter(YEAR == max(YEAR)) |>  
  filter(AGE >= 18) |> 
  select(YEAR, OCC2010, empstat, occ_label, UHRSWORKT, EARNWT, INCWAGE, 
         occ_care_focus, ASECWT, sex, gender_parent, poverty, empstat, race_ethnicity, prime_age, STATEFIP) |> 
  clean_names() 


asec <- asec |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    time_use = ifelse(occ_care_focus == "none", "non_care", "care"),
    care_focus = occ_care_focus,
    care_type	= "formal", 
    provider_attention = "active",
    geo_level = statefip,
    race = tolower(race_ethnicity),
    race = case_when(
      race == "white" ~ "white",
      race == "black" ~ "black",
      race == "hispanic" ~ "hispanic",
      race == "asian/pacific island" ~ "asian",
      race == "american indian" ~ "native",
      race == "two or more races" ~ "two_or_more",
      TRUE ~ "other"  # catch-all
    )
  ) 



asec$geo_level <- sprintf("%02d", as.numeric(asec$geo_level))
asec$geo_level <- paste0("state", asec$geo_level)


for (group_name in names(group_list)) {
  # Get the filter expression as a string
  filter_expr <- group_list[[group_name]]
  
  # Filter the cp_informal data based on the current group's criteria
  filtered_data <- asec |> 
    filter(eval(parse(text = filter_expr)))
  
  # Summarize the filtered data
  summarized_data <- filtered_data |>
    group_by(geo_level) |>
    summarise(
      population = sum(asecwt, na.rm = TRUE),
    ) |>
    mutate(group_by_value = group_name)
  
  # Store each summarized result in the list
  results_list[[group_name]] <- summarized_data
}

final_summary_table <- bind_rows(results_list)

asec <- read.csv("./data/CSV/ASECdata.csv") |>
  filter(YEAR == max(YEAR)) |>  
  filter(AGE >= 18) |> 
  select(YEAR, OCC2010, empstat, occ_label, UHRSWORKT, EARNWT, INCWAGE, 
         occ_care_focus, ASECWT, sex, gender_parent, poverty, empstat, race_ethnicity, prime_age, STATEFIP) |> 
  clean_names() 


asec <- asec |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other"
    ), 
    time_use = ifelse(occ_care_focus == "none", "non_care", "care"),
    care_focus = occ_care_focus,
    care_type	= "formal", 
    provider_attention = "active",
    race = tolower(race_ethnicity),
    race = case_when(
      race == "white" ~ "white",
      race == "black" ~ "black",
      race == "hispanic" ~ "hispanic",
      race == "asian/pacific island" ~ "asian",
      race == "american indian" ~ "native",
      race == "two or more races" ~ "two_or_more",
      TRUE ~ "other"  # catch-all
    )
  ) 

results_list <- list()

for (group_name in names(group_list)) {
  # Get the filter expression as a string
  filter_expr <- group_list[[group_name]]
  
  # Filter the cp_informal data based on the current group's criteria
  filtered_data <- asec |> 
    filter(eval(parse(text = filter_expr)))
  
  # Summarize the filtered data
  summarized_data <- filtered_data |>
    summarise(
      population = sum(asecwt, na.rm = TRUE),
    ) |>
    mutate(group_by_value = group_name)
  
  # Store each summarized result in the list
  results_list[[group_name]] <- summarized_data
}

final_summary_table_nation <- bind_rows(results_list)
final_summary_table_nation$geo_level <- "national"
final_summary_table <- rbind(final_summary_table, final_summary_table_nation)

provider <- final_summary_table |>
  left_join(provider_category, by = c("group_by_value" = "name")) |>
  rename(category_id = id) |>
  rename(subcategory_id = group_by_value) |>
  select(-c("order")) |>
  select(geo_level, category_id, subcategory_id, population)

provider <- provider %>%
  semi_join(provider_datum, by = c("geo_level", "category_id", "subcategory_id"))

new_rows <- anti_join(provider_datum, provider, 
                      by = c("geo_level", "category_id", "subcategory_id"))
new_rows <- new_rows %>%
  select(geo_level, category_id, subcategory_id, population)

new_rows <- new_rows %>%
  group_by(geo_level, category_id, subcategory_id) %>%
  summarise(
    population = max(population)
  )

provider <- bind_rows(provider, new_rows)

write.csv(provider, "./app_data/provider.csv", row.names = FALSE)


provider_category <- read_excel("./app_data/provider_category.xlsx")
write.csv(provider_category, "./app_data/provider_category.csv", row.names = FALSE)
