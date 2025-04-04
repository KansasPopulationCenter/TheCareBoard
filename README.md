# Care Board Data Repository
[Download ZIP file of all data & code](https://bit.ly/DataLibraryZip)

The Care Board (https://thecareboard.org) is a dashboard of statistics on the care economy.
This repository contains replication code, statistical tables, data crosswalks, and microdata compiled from IPUMS ATUS, IPUMS CPS, and IPUMS CPS-ASEC to support researchers, policymakers, and the public. 

## How to Download Data 

All data displayed on The Care Board can be downloaded freely.
Each dataset in the repository is available in multiple formats (.csv, .xlsx, .dta).
Users can navigate to individual files in the tables below to access and download the data. 

If you use our data, we ask that you cite: 

Misty Heggeness, Joseph Bommarito, and Lucie Prewitt. The Care Board: Version 1.0 [dataset]. Lawrence, KS: Kansas Population Center, 2025. https://thecareboard.org.  
If you have any questions or require additional data support, please refer to our documentation (MARKDOWN LINK HERE) or contact careboard@ku.edu. 

# Statistical Tables
|Name | Description |  .csv file | .xlsx file | .dta file | Notes | Data Sources|
|----------------------------------------------------------------|-------------------------------------------------------------------------------------------|------------|------------|-----------|-------|-------------|
|Table 1: Care and Care Provision |Information about the amount of time a person receives care and time spent providing care | [Care and Provision CSV](https://bit.ly/NeedProvisionCSV)  | [Care and Provision Excel](https://bit.ly/NeedProvisionXLSX) | [Care and Provision DTA](https://bit.ly/NeedProvisionDTA) | 2007 onward 5 year rolling averages. | [IPUMS ATUS](https://timeuse.ipums.org/) |
|Table 2: Care Provider Demographics   | Demographic information on who is providing (formal and informal) care  | [Provider Demographic CSV](https://bit.ly/ProvidersDemographicsCSV) | [Provider Demographic Excel](https://bit.ly/ProvidersDemographicsXLSX) | [Provider Demographic DTA](https://bit.ly/ProvidersDemographicsDTA) | 1990 onward | [IPUMS ASEC](https://cps.ipums.org/cps/) |
|Table 3: Care Provider Data | Statistics related to the population and time use of different care provider groups | [Provider Data CSV](https://bit.ly/CareProviderDatumCSV) | [Provider Data Excel](https://bit.ly/CareProviderDatumXLSX) | [Provider Data DTA](https://bit.ly/CareProviderDatumDTA) | 1994 onward for formal, 2007 onward for informal| [IPUMS ASEC](https://cps.ipums.org/cps/), [IPUMS ATUS](https://timeuse.ipums.org/) |
|Table 4: Care Activities | Data for formal and informal care activities including population of providers and time spent across the US population | [Care Activities CSV](https://bit.ly/ActivitiesCSV) | [Care Activities Excel](https://bit.ly/ActivitiesXLSX) | [Care Activities DTA](https://bit.ly/ActivitiesDTA) | 2024 for Formal, 2023 for Informal. | [IPUMS ASEC](https://cps.ipums.org/cps/), [IPUMS ATUS](https://timeuse.ipums.org/) |
|Table 5: Care Ratios |Ratios of care provision to need ability in the US | [Care Ratio CSV](https://bit.ly/CareRatioCSV) | [Care Ratio Excel](https://bit.ly/CareRatioXLSX) | [Care Ratio DTA](https://bit.ly/CareRatioDTA) | 2020 onward at the national level. | 5 year ACS, (IPUMS ASEC)(https://cps.ipums.org/cps/), [IPUMS ATUS](https://timeuse.ipums.org/) |
|Table 6: Care Gini Coefficients |GINI Index coefficients calculated for care inequality measures | [GINI CSV](https://bit.ly/GINICSV) | [GINI Excel](https://bit.ly/GINIXLSX) | [GINI DTA](https://bit.ly/GINIDTA) | Provides stats at the national (2015 onward) and state level (2016 onward). | Quarterly Census of Employment and Wages, 5 YR ACS. |
|Table 7: Labor Force Participation by Gender and Parental Status|Replication of BLS Labor Force Participation statistics broken out by gender and parenthood status | [LFP by Gender and Parenthood CSV](https://bit.ly/CareforceCSV) | [LFP by Gender and Parenthood Excel](https://bit.ly/CareforceXLSX) | [LFP by Gender and Parenthood DTA](https://bit.ly/CareforceDTA) | For years 1994 and onward for formal, and 2007 and onward for informal. | IPUMS ASEC and [IPUMS ATUS](https://timeuse.ipums.org/) |
|Table 8: Care Force Participation by Gender and Parental Status |Number and proportion of individuals providing formal and informal care work to others  | [Care Labor Force CSV](https://bit.ly/BLSGenderParenthoodCSV) | [Care Labor Force Excel](https://bit.ly/BLSGenderParenthoodXLSX) | [Care Labor Force DTA](https://bit.ly/BLSGenderParenthoodDTA) | Provides labor force participation for gender and parent combinations for those aged 16+ for years 1990 onward. | (IPUMS CPS Monthly Survey)(https://cps.ipums.org/cps/)|
|Table 9: Sandwich Generation                                    |Data related to individuals engaged in caring for children and engaged in elder care       |[Sandwich Generation CSV](https://bit.ly/SandwichCSV)|[Sandwich Generation Excel](https://bit.ly/SandwichXLSX)|[Sandwich Generation DTA](https://bit.ly/SandwichDTA)|Calculates the number of people aged 18+ who are "sandwiched," 2015 onward, and the time these people spend on caregiving. |[IPUMS ATUS](https://timeuse.ipums.org/)|
|Table 10: Value of Care                                          |Estimates of the value of care activities in the economy across formal and informal caregiving | [Value of Care CSV](https://bit.ly/CareforceValueCSV) | [Value of Care Excel](https://bit.ly/CareforceValueXLSX) | [Value of Care DTA](https://bit.ly/CareforceValueDTA) | For years 1994 and onward for formal, and 2007 and onward for informal. | [IPUMS ASEC](https://cps.ipums.org/cps/) and [IPUMS ATUS](https://timeuse.ipums.org/) |
|Table 11: Minutes of Care | Total minutes spent in caregiving across formal and informal sectors | [Time Spent in Care CSV](https://bit.ly/CareforceTimeCSV) | [Time Spent in Care Excel](https://bit.ly/CareforceTimeXLSX) | [Time Spent in Care DTA](https://bit.ly/CareforceTimeDTA) | For years 1994 and onward for formal, and 2007 and onward for informal. | [IPUMS ASEC](https://cps.ipums.org/cps/) and [IPUMS ATUS](https://timeuse.ipums.org/) |


# Data Crosswalks
|Name| Description| .csv file | .xlsx file    | Notes |
|-----------------------------------------------------------------|-------------------------------------------------------------------------------------------|-----------|---------------|-----------|
|Crosswalk-Formal Jobs to Care Focus                   |Links between care focus and OCC2010 codes                                                 | [Formal Occupation CW CSV](https://bit.ly/FormalOccs_CrossoverCSV) |[Fomral Occupation CW Excel](https://bit.ly/FormalOccs_CrossoverXLXS) | SOC codes obtained from IPUMS CPS OCC2010 variable. |
|Crosswalk-Informal Care Activities to Care Focus      |Links between care focus and ATUS activities |  [Informal Activities CW CSV](https://bit.ly/ATUSActivityCrossoverCSV) | [Informal Activities CW Excel](https://bit.ly/ATUSActivityCrossoverXLSX) | ATUS activity codes obtained from IPUMS ATUS Activity variable. |
|Crosswalk-Formal Jobs to Informal Activities          |Links between OCC2010 codes and ATUS activities                                            | [Informal to Formal CW CSV](https://bit.ly/InformalFormalCrosswalkCSV) | [Informal to Formal CW Excel](https://bit.ly/InformalFormalCrosswalkXLSX) | SOC codes obtained from IPUMS CPS OCC2010 variable, Activity codes obtained from IPUMS ATUS Activity variable.|

# Micro Data
|Name | Description | Code Files | XML Files | DAT Files| Source |
|-----|-------------|------------|-----------|----------|--------|
|ATUS Activities| Activity structured data from ATUS |  | [ATUS Data Metadata](https://bit.ly/ATUSActivityMetaDataXML) | [ATUS Data Zip](https://bit.ly/ATUSActivityMetaDataDAT) | [IPUMS ATUS](https://timeuse.ipums.org/) |
|ATUS Hierarchical| Hierarchical structured data from ATUS |  | [Hierarchical Data Metadata](https://bit.ly/ATUSHierarchicalMetaDataXML) | [Hierarchical Data Zip](https://bit.ly/ATUSHierarchicalMetaDataDAT) | [IPUMS ATUS](https://timeuse.ipums.org/)
|Micro Data Download | Code to use IPUMS API to download ASEC and CPS Monthly data | [CPS and ASEC Download](https://bit.ly/MicroDataDownloadR) |  | | [IPUMS CPS](https://cps.ipums.org/cps/) |
|Micro Data Cleaning Functions| Functions used to clean ATUS, ASEC, and CPS Monthly data | [CPS and ASEC Download](https://bit.ly/MicroDataPrepR) |  | | [IPUMS CPS](https://cps.ipums.org/cps/) |
|Micro Data Processing | Code to Process and format Micro Data from ATUS, ASEC, and CPS Monthly data | [CPS and ASEC Processing](https://bit.ly/MicroDataProcessingR) |  | | [IPUMS CPS](https://cps.ipums.org/cps/) |

# Code
|Name                         | Description|.R file| Notes |
|-----------------------------|------------|-------|------|
| Formal Activities | Code compiling statistics related to formal care activities | https://bit.ly/ActivityFormalR | Code feeds into the Voronoi chart of the Care Economy section. |
| Informal Activities | Code compiling statistics related to informal care activities | https://bit.ly/ActivityInformalR |  Code feeds into the Voronoi chart of the Care Economy section. |
| Broad Impacts | Code compiling statistics related to the broad impacts section | https://bit.ly/BroadImpactsR | Code feeds into the Broad Impacts section. |
|Care Providers | Code compiling statistics on the people providing care | https://bit.ly/CareProvidersR |  Code feeds into the Chord chart of the Care Economy section. |
|Care Ratio | Code calculating the Care Ratio | https://bit.ly/CareRatioR |  Code feeds the Care Ratio card on the Flow of Care section. |
|GINI | Code calculating Care GINI Coefficients | https://bit.ly/GiniCoefficientR| Code feeds the GINI card on the Flor of Care section.  |
|Sandwich | Code calculating Sandwich generation stats | https://bit.ly/SandwichGenerationR | Code feeds the Sandwich generation charts on the Flow of Care Section |
|Population Information | Code reporting data on the population, including age | https://bit.ly/AgeR | Code feeds into the care provision area chart of the Care Economy section. |
|Care and Provision | Code calculating the need and provision of care | https://bit.ly/NeedProvisionR |  Code feeds into the care provision area chart of the Care Economy section. |

# Replication Data
|Name                         | Description|.csv file| .xlsx file| .dta file| Code|Data Sources|
|-----------------------------|------------|---------|-----------|----------|------|------------|

    
