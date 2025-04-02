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
|Table 1: Care and Care Provision |Information about the amount of time a person receives care and time spent providing care | https://bit.ly/NeedProvisionCSV | https://bit.ly/NeedProvisionXLSX | https://bit.ly/NeedProvisionDTA | 2003 onward using 5-year rolling averages, excluding 2020. | IPUMS ATUS |
|Table 2: Care Provider Demographics   |Demographic information on who is providing (formal and informal) care  | https://bit.ly/ProvidersDemographicsCSV | https://bit.ly/ProvidersDemographicsXLSX | https://bit.ly/ProvidersDemographicsDTA | 1990 onward | IPUMS ASEC |
|Table 3: Care Provider Data | Statistics related to the population and time use of different care provider groups | https://bit.ly/CareProviderDatumCSV | https://bit.ly/CareProviderDatumXLSX | https://bit.ly/CareProviderDatumDTA | 1990 onward for formal, 2007 onward for informal| IPUMS ASEC, IPUMS ATUS |
|Table 4: Care Activities | Data for formal and informal care activities including population of providers and time spent across the US population | https://bit.ly/ActivitiesCSV | https://bit.ly/ActivitiesXLSX | https://bit.ly/ActivitiesDTA | 1990 onward for formal, 2007 onward for informal. | IPUMS ASEC, IPUMS ATUS |
|Table 5: Care Ratios |Ratios of care provision to need ability in the US | https://bit.ly/CareRatioCSV | https://bit.ly/CareRatioXLSX | https://bit.ly/CareRatioDTA | 2020 onward at the national level. | 5 year ACS, IPUMS ASEC, IPUMS ATUS |
|Table 6: Care Gini Coefficients |GINI Index coefficients calculated for care ineqaulity measures | https://bit.ly/GINICSV | https://bit.ly/GINIXLSX | https://bit.ly/GINIDTA | Provides stats at the national level for 2020 onward. | Quarterly Census of Employment and Wages, 5 YR ACS. |
|Table 7: Labor Force Participation by Gender and Parental Status|Replication of BLS Labor Force Participation statistics broken out by gender and parenthood status | https://bit.ly/CareforceCSV | https://bit.ly/CareforceXLSX | https://bit.ly/CareforceDTA | For years 1994 and onward for formal, and 2007 and onward for informal. | IPUMS ASEC and IPUMS ATUS |
|Table 8: Care Force Participation by Gender and Parental Status |Number and proportion of individuals providing formal and informal care work to others  | https://bit.ly/BLSGenderParenthoodCSV | https://bit.ly/BLSGenderParenthoodXLSX | https://bit.ly/BLSGenderParenthoodDTA | Provides labor force participation for gender and parent combinations for those aged 16+ for years 1990 onward. | IPUMS CPS Monthly Survey|
|Table 9: Sandwich Generation                                    |Data related to individuals engaged in caring for children and engaged in elder care       |https://bit.ly/SandwichCSV|https://bit.ly/SandwichXLSX|https://bit.ly/SandwichDTA|Calculates the number of people aged 18+ who are "sandwiched," going back to 2007, and the time these people spend on caregiving. |IPUMS ATUS data|
|Table 10: Value of Care                                          |Estimates of the value of care activities in the economy across formal and informal caregiving | https://bit.ly/CareforceValueCSV | https://bit.ly/CareforceValueXLSX | https://bit.ly/CareforceValueDTA | For years 1994 and onward for formal, and 2007 and onward for informal. | IPUMS ASEC and IPUMS ATUS |
|Table 11: Minutes of Care | Total minutes spent in care giving across formal and informal sectors | https://bit.ly/CareforceTimeCSV | https://bit.ly/CareforceTimeXLSX | https://bit.ly/CareforceTimeDTA | For years 1994 and onward for formal, and 2007 and onward for informal. | IPUMS ASEC and IPUMS ATUS |

# Data Crosswalks
|Name| Description| .csv file | .xlsx file    | Notes |
|-----------------------------------------------------------------|-------------------------------------------------------------------------------------------|-----------|---------------|-----------|
|Crosswalk-Formal Jobs to Care Focus                   |Links between care focus and OCC2010 codes                                                 | https://bit.ly/FormalOccs_CrossoverCSV |https://bit.ly/FormalOccs_CrossoverXLXS | SOC codes obtained from IPUMS CPS OCC2010 variable. |
|Crosswalk-Informal Care Activities to Care Focus      |Links between care focus and ATUS activities |  https://bit.ly/ATUSActivityCrossoverCSV | https://bit.ly/ATUSActivityCrossoverXLSX | ATUS activity codes obtained from IPUMS ATUS Activity variable. |
|Crosswalk-Formal Jobs to Informal Activities          |Links between OCC2010 codes and ATUS activities                                            | https://bit.ly/InformalFormalCrosswalkCSV | https://bit.ly/InformalFormalCrosswalkXLSX | SOC codes obtained from IPUMS CPS OCC2010 variable, Activity codes obtained from IPUMS ATUS Activity variable.|

# Micro Data
|Name | Description | Code Files | XML Files | DAT Files|
|-----|-------------|------------|-----------|----------|
|ATUS Activities| Activity structured data from ATUS |  | https://bit.ly/ATUSActivityMetaDataXML | https://bit.ly/ATUSActivityMetaDataDAT |
|ATUS Hierarchical| Hierarchical structured data from ATUS |  | https://bit.ly/ATUSHierarchicalMetaDataXML | https://bit.ly/ATUSHierarchicalMetaDataDAT |
|Micro Data Download | Code to use IPUMS API to download ASEC and CPS Monthly data | https://bit.ly/MicroDataDownloadR |  |  |
|Micro Data Cleaning Functions| Functions used to clean ATUS, ASEC, and CPS Monthly data | https://bit.ly/MicroDataPrepR |  |  |
|Micro Data Processing | Code to Process and format Micro Data from ATUS, ASEC, and CPS Monthly data | https://bit.ly/MicroDataProcessingR | | |

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

    
