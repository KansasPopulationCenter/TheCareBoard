# List of all ages from 0 to 85
age_list <- data.frame(age = seq(0, 85, by = 1))

# Load and clean the data
age_data <- read.csv("./data/CSV/ASECdata.csv") |>
  select(YEAR, AGE, ASECWT) |>
  clean_names()

# Loop through each year and calculate population by age
age_modified_all <- age_data |>
  group_by(year, age) |>
  summarise(population = sum(asecwt, na.rm = TRUE), .groups = "drop") |>
  right_join(expand.grid(age = age_list$age, year = unique(age_data$year)), 
             by = c("year", "age")) |>
  mutate(population = coalesce(population, 0)) |>
  arrange(year, age)

write.csv(age_modified_all, "./data/CSV/market.csv", row.names = FALSE)
write_dta(age_modified_all, "./data/DTA/market.dta")
