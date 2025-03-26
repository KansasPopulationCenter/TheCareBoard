## ------------------------------------------------------------------------------------------------
source("load_libraries.R")
options(scipen = 999)

# set the filepaths for the recently downloaded IPUMS data
ipums_atus <- "./data/IPUMS Pulls/atus_00027.xml"
ipums_cps <- "./data/IPUMS Pulls/cps_00419.xml"
ipums_asec <- "./data/IPUMS Pulls/cps_00418.xml"


## ----message=FALSE-------------------------------------------------------------------------------
ddi_asec <- read_ipums_ddi(ipums_asec)
label_asec <- ddi_asec$var_info$var_label
lbl_tbl_asec <- ddi_asec$var_info$val_labels

ddi_cps <- read_ipums_ddi(ipums_cps)
label_cps <- ddi_cps$var_info$var_label
lbl_tbl_cps <- ddi_cps$var_info$val_labels

ddi_atus <- read_ipums_ddi(ipums_atus)
label_atus <- ddi_atus$var_info$var_label
lbl_tbl_atus <- ddi_atus$var_info$val_labels


## ------------------------------------------------------------------------------------------------
check_lookups <- function(sel_tbl){
  index_asec <- which(str_detect(label_asec, sel_tbl))
  index_cps <- which(str_detect(label_cps, sel_tbl))
  index_atus <- which(str_detect(label_atus, sel_tbl))
    
  if(length(index_asec) > 0){
    lu_asec <- lbl_tbl_asec[[index_asec]] |> 
      rename(lbl_asec = lbl)
  } else {
    lu_asec <- data.frame(val = NA, lbl_asec = NA)
  }
  
  if(length(index_cps) > 0){
    lu_cps <- lbl_tbl_cps[[index_cps]] |> 
      rename(lbl_cps = lbl)
  } else {
    lu_cps <- data.frame(val = NA, lbl_cps = NA)
  }
  
  if(length(index_atus) > 0){
    lu_atus <- lbl_tbl_atus[[index_atus]] |> 
      rename(lbl_atus = lbl)
  } else {
    lu_atus <- data.frame(val = NA, lbl_atus = NA)
  }

  lu_combined <- lu_asec |> 
    full_join(lu_cps, by = c("val")) |>
    full_join(lu_atus, by = c("val"))

  return(lu_combined)

}


## ------------------------------------------------------------------------------------------------
f_age_category <- function(col){
  lbl <- case_when(
    col < 18 ~ "Under 18",
    col >= 18 & col < 25 ~ "Eighteen/Twenty-Four",
    col >= 25 & col < 35 ~ "Twenty-Five/Thirty-Five",
    col >= 35 & col < 45 ~ "Thirty-Five/Forty-Five",
    col >= 45 & col < 55 ~ "Forty-Five/Fifty-Five",
    col >= 55 & col < 65 ~ "Fifty-Five/Sixty-Five",
    col >= 65 ~ "Sixty-Five Plus"
    )
  
  return(lbl)
} 


## ------------------------------------------------------------------------------------------------
f_prime_age <- function(col){
  lbl <- case_when(
    col < 25 ~ "Under Twenty-Five",
    col >= 25 & col < 55 ~ "Prime Age",
    col >= 55 ~ "Fifty-Five Plus"
    )
  
  return(lbl)
}


## ------------------------------------------------------------------------------------------------
f_child_age <- function(col){
  lbl <- case_when(
    col < 5 ~ "Under Five",
    col >= 5 & col < 12 ~ "Five_Eleven",
    col >= 12 & col < 18 ~ "Twelve_Eighteen",
    col >= 18 & col < 99  ~ "Eighteen Plus",
    col == 99  ~ "NIU"
    )
  
  return(lbl)
} 


## ------------------------------------------------------------------------------------------------
f_gender_parent <- function(YNGCH, sex, AGE) {
  lbl <- case_when(
    YNGCH <= 18 & sex == "Female" & AGE >= 18 ~ "Mothers",
    YNGCH <= 18 & sex == "Male" & AGE >= 18 ~ "Fathers",
  
    YNGCH == 99 & sex == "Female" & AGE >= 18 ~ "Childless Women",
    YNGCH == 99 & sex == "Male" & AGE >= 18 ~ "Childless Men",
    
    TRUE ~ "Other"
  )
  
  return(lbl)
} 


## ------------------------------------------------------------------------------------------------
f_race_ethnicity <- function(hispan, race){
  
  lbl <- ifelse(hispan == "Hispanic", "Hispanic", race)
  
  return(lbl)
} 


## ------------------------------------------------------------------------------------------------
f_laborstatus <- function(wkstat, empstat){
  
  lbl <- ifelse(empstat == "Employed", wkstat, empstat)
  
  return(lbl)
} 


## ------------------------------------------------------------------------------------------------
f_month <- function(col) {
  lbl <- recode(
    as.character(col),
    `1` = "January",
    `2` = "February",
    `3` = "March",
    `4` = "April",
    `5` = "May",
    `6` = "June",
    `7` = "July",
    `8` = "August",
    `9` = "September",
    `10` = "October",
    `11` = "November",
    `12` = "December"
  )
  
  return(lbl)
} 


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Hispanic origin")

# CPS and ASEc are different from ATUS
f_hispanic_atus <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
    `100` = "Not Hispanic",
    `9999` = "NIU",
    .default = "Hispanic"
    )
  
  return(lbl)
} 

f_hispanic_cps <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
    `0` = "Not Hispanic",
    `901` = "NIU",
    `902` = "NIU",
    .default = "Hispanic"
    )
  
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    hispan_cps = f_hispanic_cps(val),
    hispan_atus = f_hispanic_atus(val)
  ) |> 
  relocate(hispan_cps, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Race")

# CPS and ASEc are different from ATUS
f_race_atus <- function(col){

  lbl <- dplyr::recode(
    as.character(col),
    `100` = "White",
    `110` = "Black",
    `120` = "American Indian",
    `130` = "Asian/Pacific Island",
    `131` = "Asian/Pacific Island",
    `132` = "Asian/Pacific Island",
    `9999` = "NIU",
    .default = "Two or More Races"
    )
  
  return(lbl)
} 

f_race_cps <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
    `100` = "White",
    `200` = "Black",
    `300` = "American Indian",
    `650` = "Asian/Pacific Island",
    `651` = "Asian/Pacific Island",
    `652` = "Asian/Pacific Island",
    .default = "Two or More Races"
    )
  
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    race_cps = f_race_cps(val),
    race_atus = f_race_atus(val)
  ) |> 
  relocate(race_cps, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Sex")

f_sex <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
    `1` = "Male", 
    `2` = "Female", 
    `9` = "NIU",
    `99` = "NIU",      
    )
  
  return(lbl)
} 


lookup_KU_labels <- lookup_compare |> 
  mutate(
    sex = f_sex(val),
  ) 


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Marital status")

f_marst <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
    `1` = "Married",
    `2` = "Married",
    `3` = "Separated, Widowed, or Divorced",
    `4` = "Separated, Widowed, or Divorced",
    `5` = "Separated, Widowed, or Divorced",
    `6` = "Single-Never-Married",
    `7` = "Separated, Widowed, or Divorced",
    `9` = "NIU",
    `99` = "NIU",      
    )
  
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    marst = f_marst(val)
  )


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Education|school")

f_educ_atus <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
     `999` = "NIU",
     `10` = "No HS Diploma",
     `11` = "No HS Diploma",
     `12` = "No HS Diploma",
     `13` = "No HS Diploma",
     `14` = "No HS Diploma",
     `15` = "No HS Diploma",
     `16` = "No HS Diploma",
     `17` = "No HS Diploma",
     `20` = "High School",
     `21` = "High School",
     `30` = "Some College",
     `31` = "Some College",
     `32` = "Some College",
     `80` = "Some College",
     `110` = "Some College",
     `40` = "Bachelor's Degree",
     `41` = "Graduate Degree",
     `42` = "Graduate Degree",
     `43` = "Graduate Degree"
    )
  
  return(lbl)
} 

f_educ_cps<- function(col){
  
  lbl <- case_when(
    col == 999 ~ "Missing/Unknown",
    col <= 1 ~ "NIU",
    col >= 2 & col <= 72 ~ "No HS Diploma",
    col == 73 ~ "High School",
    col >= 80 & col <= 110  ~ "Some College",
    col >= 120 & col <= 122  ~ "Some College",
    col == 111 ~ "Bachelor's Degree",
    col >= 123 ~ "Graduate Degree"
    )
  
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    educ_cps = f_educ_cps(val),
    educ_atus = f_educ_atus(val)
  ) |> 
  relocate(educ_cps, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("poverty")

f_poverty_asec <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
    `0` = "NIU",
    `10` = "Below Poverty",
    `20` = "Above Poverty",
    `21` = "100-124 Percent of Poverty",
    `22` = "125-149 Percent of Poverty",
    `23` = "150+ Percent of Poverty"    
    )
  
  return(lbl)
} 

f_poverty_atus <- function(col){
  
  lbl <- dplyr::recode(
    as.character(col),
    `10` = "Below Poverty",
    `11` = "Below Poverty",
    `12` = "Below Poverty",
    `20` = "Above Poverty",
    .default = "NIU"     
    )
  
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    pov_asec = f_poverty_asec(val), 
    pov_atus = f_poverty_atus(val)
  ) |> 
  relocate(pov_asec, .after = "lbl_asec")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Labor force status")

f_labforce_atus <- function(col){
  
  lbl <- case_when(
    col >= 1 & col <= 4 ~ "In the Labor Force",
    col == 5 ~ "Not in the Labor Force",
    col == 99 ~ "NIU"
    )
  
  return(lbl)
} 

f_labforce_cps <- function(col){
  
  lbl <- case_when(
    col == 0 ~ "NIU",
    col == 1 ~ "Not in the Labor Force",
    col == 2 ~ "In the Labor Force"
    )

  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    labforce_cps = f_labforce_cps(val), 
    labforce_atus = f_labforce_atus(val)
  ) |> 
  relocate(labforce_cps, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Employment status")

f_empstat_cps <- function(col){
  
  lbl <- case_when(
    col == 0 ~ "NIU",
    col == 1 ~ "Armed Forces",
    col %in% c(10, 12) ~ "Employed",
    col >= 20 & col <= 22~ "Unemployed",
    col >= 30 & col <= 36~ "NILF"
    )
  
  return(lbl)
} 

f_empstat_atus <- function(col) {
  lbl <- recode(
    as.character(col),
    `1` = "Employed",
    `2` = "Employed",
    `3` = "Unemployed",
    `4` = "Unemployed",
    `5` = "NILF"
  )
  
  return(lbl)
}

lookup_KU_labels <- lookup_compare |> 
  mutate(
    empstat_cps = f_empstat_cps(val), 
    empstat_atus = f_empstat_atus(val)
  ) |> 
  relocate(empstat_cps, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Full or part time status")

f_wkstat <- function(col){
  
  lbl <- case_when(
    col >= 10 & col <= 15 ~ "Full Time",
    col >= 20 & col <= 22 ~ "Part Time",
    col >= 40 & col <= 42 ~ "Part Time",
    col %in% c(50, 60) ~ "Unemployed",
    col == 99 ~ "NIU"
    )
 
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    wkstat = f_wkstat(val),
  ) |> 
  relocate(wkstat, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Class of worker")

f_classwkr <- function(col){
  
  lbl <- case_when(
    col == 0 ~ "NIU",
    col == 99 ~ "Missing/Unknown",
    col %in% c(10, 13, 14) ~ "Self_Employed",
    col >= 20 & col <= 23 ~ "Wage/Salary",
    col >= 24 & col <= 28 ~ "Government",
    col == 29 ~ "Unpaid"
    )
 
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    classwkr = f_classwkr(val),
  ) |> 
  relocate(classwkr, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("NILF")

f_nilf_actvity <- function(col){
  
  lbl <- case_when(
    col == 1 ~ "Disabled",
    col == 2 ~ "Ill",
    col == 3 ~ "School",
    col == 4 ~ "Homemaker",
    col == 6 ~ "Other",
    col == 99 ~ "NIU"
    )
 
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    nilf_activity = f_nilf_actvity(val),
  ) |> 
  relocate(nilf_activity, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("telework")

f_telwrkpay <- function(col){
  
  lbl <- recode(
    as.character(col),
    `0` = "NIU",
    `1` = "Teleworked",
    `2` = "No Telework"
    )
 
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    telwrkpay = f_telwrkpay(val),
  ) |> 
  relocate(telwrkpay, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Absent")

f_absent <- function(col){
  
  lbl <- recode(
    as.character(col),
    `0` = "NIU",
    `1` = "No",
    `2` = "Yes, Laid Off",
    `3` = "Yes, Other"
    )
 
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    absent = f_absent(val),
  ) |> 
  relocate(absent, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
lookup_compare <- check_lookups("Reason")

f_whyabsnt <- function(col) {
  lbl <- recode(
    as.character(col),
    `0` = "NIU",
    `5` = "Vacation/Personal days",
    `6` = "Own illness/medical problem",
    `7` = "Care Reason",
    `8` = "Care Reason",
    `9` = "Care Reason",
    `10` = "Non-Care Reason",
    `11` = "Non-Care Reason",
    `12` = "Non-Care Reason",
    `13` = "Non-Care Reason",
    `15` = "Other"
  )
  
  return(lbl)
} 

lookup_KU_labels <- lookup_compare |> 
  mutate(
    whyabsnt = f_whyabsnt(val),
  ) |> 
  relocate(whyabsnt, .after = "lbl_cps")


## ------------------------------------------------------------------------------------------------
recode_all_common <- function(df) {
  if("MONTH" %in% names(df)){
    df <- df |> 
      mutate(date = 
               as.Date(paste(YEAR, MONTH, "01", sep = "-")))
  } else {
    df <- df |> 
      mutate(date = as.Date(paste(YEAR, "01-01", sep = "-")))
  }
  
  df <- df |>
    mutate(
      id = row_number(),
      nchild = as.numeric(NCHILD),
      child_age = f_child_age(YNGCH),
      age_category = f_age_category(AGE),
      prime_age = f_prime_age(AGE),
      sex = f_sex(SEX),
      marst = f_marst(MARST), 
      gender_parent = f_gender_parent(YNGCH, sex, AGE)
    )
  
  return(df)
}


## ------------------------------------------------------------------------------------------------
recode_asec_cps <- function(df) {
  df <- df |>
    mutate(
      statefip = as_factor(STATEFIP),
      region = as_factor(REGION),
      famsize = as.numeric(FAMSIZE),
      month = f_month(MONTH),
      
      hispan = f_hispanic_cps(HISPAN),
      race = f_race_cps(RACE),
      race_ethnicity = f_race_ethnicity(hispan, race),
      educ = f_educ_cps(EDUC),

      wkstat = f_wkstat(WKSTAT),     
      empstat = f_empstat_cps(EMPSTAT), 
      laborstatus = f_laborstatus(wkstat, empstat),      
      absent = f_absent(ABSENT),
      whyabsnt = f_whyabsnt(WHYABSNT)
    )
  
  return(df)
}


## ------------------------------------------------------------------------------------------------
recode_asec <- function(df) {
  df <- df |>
    mutate(
      pernum = as.numeric(PERNUM),
      momloc = as.numeric(MOMLOC),
      poverty = f_poverty_asec(POVERTY)
    )
  
  return(df)
}


## ------------------------------------------------------------------------------------------------
recode_cps <- function(df) {
  df <- df |>
    mutate(
      labforce = f_labforce_cps(LABFORCE),
      classwrk = f_classwkr(CLASSWKR),
      telwrkpay = f_telwrkpay(TELWRKPAY),
      nilf_activity = f_nilf_actvity(NILFACT)
    )
  
  return(df)
}


## ------------------------------------------------------------------------------------------------
recode_atus <- function(df) {
  df <- df |>
    mutate(
      day = case_when(
        DAY == 1 ~ "Sunday",
        DAY == 2 ~ "Monday",
        DAY == 3 ~ "Tuesday",
        DAY == 4 ~ "Wednesday",
        DAY == 5 ~ "Thursday",
        DAY == 6 ~ "Friday",
        DAY == 7 ~ "Saturday"
      ),
      
      poverty = f_poverty_atus(POVERTY185),
      hispan = f_hispanic_atus(HISPAN),
      race = f_race_atus(RACE),
      race_ethnicity = f_race_ethnicity(hispan, race),
      
      empstat = f_empstat_atus(EMPSTAT),
      educ = f_educ_atus(EDUC)
    )
    
  return(df)
}


## ------------------------------------------------------------------------------------------------
col_order <- c(
  "id",
  "YEAR",
  "SERIAL",
  "MONTH",
  "month",
  "DAY",
  "date",
  
  "CPSID",
  "ASECFLAG",
  "HFLAG",
  "ASECWTH",
  "COMPWT",
  "WT06",
  "WT20",
  "HWTFINL",
  "WTFINL",
  "pernum",
  "CASEID",
  "STRATA",
  
  "REGION",
  "region",
  "STATEFIP",
  "statefip",
  
  "PERNUM",
  "CPSIDP",
  "CPSIDV",
  "ASECWT",
  
  "AGE",
  "age_category",
  "prime_age",
  
  "SEX",
  "sex",

  "HISPAN",
  "hispan",
  "RACE",
  "race",
  "race",
  "race_ethnicity",
  
  "MARST",
  "marst",
  "MOMLOC",
  "momloc",
  "POPLOC",
  "SPLOC",

  "gender_parent",
  "HH_SIZE",
  "FAMINCOME",
  "HH_NUMADULTS",
  "FAMSIZE",
  "famsize",
  "NCHILD",
  "nchild",
  "YNGCH",
  "child_age",
  
  "EDUC",
  "educ",
  
  "EMPSTAT",
  "empstat",
  "laborstatus",
  "OCC2010",
  "IND1990",
  "UHRSWORKT",
  "AHRSWORKT",
  "ABSENT",
  "absent",
  "WHYABSNT",
  "whyabsnt",
  "WKSTAT",
  "wkstat",
  
  "EARNWT",
  "INCWAGE",
  "POVERTY",
  "poverty",

  "LABFORCE",
  "labforce",
  "CLASSWKR",
  "classwkr",
  "NILFACT",
  "nilf_activity",
  "DIFFCARE",
  "TELWRKPAY",
  "telwrkpay",

  "KIDWAKETIME",
  "KIDBEDTIME",
  "POVERTY185",
  "LINENO",
  "OCC2",
  "OCC_CPS8",
  "EARNWEEK",
  "HRSWORKT_CPS8",
  "SPEMPSTAT",
  "ECPRIOR",
  "ACTLINE",
  "ACTIVITY",
  "DURATION_EXT",
  "DURATION",
  "SCC_ALL_LN",
  "SCC_OWN_LN",
  "SEC_ALL_LN",
  "START",
  "STOP",
  
  "activity",
  "developmental",
  "health",
  "daily_living",
  "paid_work",
  "formal_work",
  "child_care",
  "elder_care",
  "householdcare",
  "selfcare",
  "leisure",
  "sleeping",
  "volunteering",
  "education"
)

