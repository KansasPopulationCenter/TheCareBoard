cps <- read.csv("./data/CSV/CPSdata.csv") |>
  # incorporate HFLAG clause due to survey redesign in 2014
  # https://blog.popdata.org/2014sample/
  filter(AGE >= 16) |>
  filter(YEAR >= 1990) |>
  select(YEAR,
         month,
         AGE,
         WTFINL,
         EMPSTAT,
         gender_parent) |>
  clean_names()

lfpr_by_gender_parent <- cps %>%
  filter(age >= 16) %>%  # Consider only those 16 and older
  mutate(in_labor_force = ifelse(empstat %in% c(10, 12, 20), 1, 0)) %>%  # Mark those in labor force
  group_by(year, month, gender_parent) %>%
  summarise(
    total_population = sum(wtfinl, na.rm = TRUE),
    labor_force = sum(wtfinl[in_labor_force == 1], na.rm = TRUE),
    lfpr = labor_force / total_population * 100
  ) %>%
  ungroup()

write.csv(lfpr_by_gender_parent, "./data/CSV/lfpbygenderparent.csv", row.names = FALSE)
write_dta(lfpr_by_gender_parent, "./data/DTA/lfpbygenderparent.dta")
