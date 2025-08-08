library(dplyr)
library(stringr)

asec <- read.csv("./data/CSV/ASECdata.csv") |>
  filter(AGE >= 18) |> 
  select(YEAR, OCC2010, empstat, occ_label, UHRSWORKT, EARNWT, INCWAGE, 
         occ_care_focus, ASECWT, sex, gender_parent, poverty, empstat, race_ethnicity, prime_age) |> 
  clean_names() 


cp_population_ext <- asec |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      gender_parent %in% c("Non-Mothers", "Non-Fathers") ~ "without_children",
      TRUE ~ "other")
  ) |> 
  summarise(
    population = sum(asecwt),
    .by = c(year, prime_age, race_ethnicity, empstat, poverty,  gender, provider_status)
  ) |> 
  arrange(year, prime_age, race_ethnicity, empstat, poverty,  gender, provider_status)

write.csv(cp_population_ext, "./data/CSV/care_provider_population.csv", 
          row.names = FALSE)
write_dta(cp_population_ext, "./data/DTA/care_provider_population.dta")


asec <- read.csv("./data/CSV/ASECdata.csv") |>
  filter(AGE >= 18) |> 
  select(YEAR, OCC2010, empstat, occ_label, UHRSWORKT, EARNWT, INCWAGE, 
         occ_care_focus, ASECWT, sex, gender_parent, poverty, empstat, race_ethnicity, prime_age) |> 
  clean_names() 

# create columns required by the app
cp_formal <- asec |> 
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
    provider_attention = "active"
  ) 

# summarise formal stats
cp_formal <- cp_formal %>%
  filter(uhrsworkt != 997) |> 
  mutate(uhrsworkt = ifelse(uhrsworkt == 999, 0, uhrsworkt)) |> 
  summarise(
    population = sum(asecwt),
    provision_interval = sum(uhrsworkt/7*60*asecwt), 
    .by = c(year, prime_age, race_ethnicity, empstat, poverty, gender, provider_status, time_use, care_type, 
            care_focus, provider_attention)
  )


##### INFORMAL


atus <- read.csv("./data/CSV/ATUSdata.csv") |> 
  filter(activity != "Formal Work") |> 
  filter(AGE >= 18) |>
  select(YEAR, CASEID, WT06, sex, gender_parent, act_care_focus, 
         DURATION, SCC_ALL_LN, SEC_ALL_LN, prime_age, race_ethnicity, empstat, poverty) |> 
  clean_names() 


# prep secondary care time
cp_informal <- atus |> 
  pivot_longer(
    cols = c(duration, scc_all_ln, sec_all_ln), 
    names_to = "metric", 
    values_to = "duration"
  ) |> 
  filter(!is.na(duration)) 

# create columns required by the app
cp_informal <- cp_informal |> 
  mutate(
    gender = str_to_lower(sex), 
    provider_status = case_when(
      gender_parent %in% c("Mothers", "Fathers") ~ "with_children",
      TRUE ~ "without_children"
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
    weight = wt06/365
  ) 

# summarise formal stats
cp_informal <- cp_informal |> 
  summarise(
    total_time = sum(duration), 
    .by = c(year, caseid, race_ethnicity, empstat, poverty,prime_age, weight, gender, provider_status, time_use, 
            care_type, care_focus, provider_attention)
  ) |> 
  summarise(
    provision_interval = sum(total_time*weight/5),
    population = sum(weight/5), 
    .by = c(year, prime_age, race_ethnicity, empstat, poverty, gender, provider_status, time_use, 
            care_type, care_focus, provider_attention)
  )

cp_combined <- bind_rows(
  cp_formal, 
  cp_informal
) |> 
  arrange(year, care_type, time_use, prime_age, race_ethnicity, empstat, poverty, gender, provider_status, care_focus)



write.csv(cp_combined, "./data/CSV/care_provider_data.csv", 
          row.names = FALSE)
write_dta(cp_combined, "./data/DTA/care_provider_data.dta")
