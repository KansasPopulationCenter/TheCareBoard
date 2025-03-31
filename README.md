# Care Board Data Repository 

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
|Table 2: Care Provider Demographics   |Demographic information on who is providing (formal and informal) care  | CSV HERE | XLSX HERE | DTA HERE | NOTES HERE | SOURCE HERE |
|Table 3: Care Provider Data | Statistics related to the population and time use of different care provider groups | CSV HERE | XLSX HERE | DTA HERE | NOTES HERE | SOURCE HERE |
|Table 4: Care Activities | Data for formal and informal care activities including population of providers and time spent across the US population | CSV HERE | XLSX HERE | DTA HERE | NOTES HERE | SOURCE HERE |
|Table 5: Care Ratios |Ratios of care provision to need ability in the US | CSV HERE | XLSX HERE | DTA HERE | NOTES HERE | SOURCE HERE |
|Table 6: Care Gini Coefficients |GINI Index coefficients calculated for care ineqaulity measures | CSV HERE | XLSX HERE | DTA HERE | NOTES HERE | SOURCE HERE |
|Table 7: Labor Force Participation by Gender and Parental Status|Replication of BLS Labor Force Participation statistics broken out by gender and parenthood status | https://bit.ly/CareforceCSV | https://bit.ly/CareforceXLSX | https://bit.ly/CareforceDTA | For years 1994 and onward for formal, and 2007 and onward for informal. | IPUMS ASEC and IPUMS ATUS |
|Table 8: Care Force Participation by Gender and Parental Status |Number and proportion of individuals providing formal and informal care work to others  | CSV HERE | XLSX HERE | DTA HERE | NOTES HERE | SOURCE HERE |
|Table 9: Sandwich Generation                                    |Data related to individuals engaged in caring for children and engaged in elder care       |https://bit.ly/SandwichCSV|https://bit.ly/SandwichXLSX|https://bit.ly/SandwichDTA|NOTES HERE|SOURCE HERE|
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
|ATUS Activities| Activity structured data from ATUS |  | XML HERE | DAT EHRE |
|ATUS Hierarchical| Hierarchical structured data from ATUS |  | XML HERE | DATA HERE |
|Micro Data Download | Code to use IPUMS API to download ASEC and CPS Monthly data | CODE HERE |  |  |
|Micro Data Cleaning Functions| Functions used to clean ATUS, ASEC, and CPS Monthly data | CODE HERE |  |  |
|Micro Data Processing | Code to Process and format Micro Data from ATUS, ASEC, and CPS Monthly data | CODE HERE | | |

# Code
|Name                         | Description|.R file| Notes |Data Sources|
|-----------------------------|------------|-------|------|------------|
| Formal Activities | Code compiling statistics related to formal care activities | CODE HERE | SOURCE HERE |
| Informal Activities | Code compiling statistics related to informal care activities | CODE HERE |  SOURCE HERE |
| Broad Impacts | Code compiling statistics related to the broad impacts section | https://bit.ly/BroadImpactsR | Code feeds into the Broad Impacts section of the Care Board |
|Care Proviers | Code compiling statistics on the people providing care | CODE HERE |  SOURCE HERE |
|Care Ratio | Code calculating the Care Ratio | CODE HERE |  SOURCE HERE |
|GINI | Code calculating Care GINI Coefficients | CODE HERE |  SOURCE HERE |
|Population Information | Code reporting data on the population, including age | https://bit.ly/AgeR | Code feeds into the care provision area chart of the Care Economy section. |
|Care and Provision | Code calculating the need and provision of care | https://bit.ly/NeedProvisionR |  Code feeds into the care provision area chart of the Care Economy section. |

# Replication Data
|Name                         | Description|.csv file| .xlsx file| .dta file| Code|Data Sources|
|-----------------------------|------------|---------|-----------|----------|------|------------|

    
