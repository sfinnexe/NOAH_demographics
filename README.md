# Naturally Occuring Affordable Housing (NOAH) Demographics

The goal of this analysis was to find information on vulnerable populations in census tracts in Philadelphia where there is a high concentration of vulnearable NOAH properties.  

## Definitions
**vulnerable populations:** single mothers with children, people with disabilities, and racial/ethnic minorities
**high concentration of NOAH properties:** census tracts in which there are more than 50 identified vulnerable NOAH properties. These census tracts account for less than half of census tracts in Philadelphia.  
**vulnerable NOAH properties must meet at least 1 of 3 criteria:**
1. They are within a census tract with a displacement risk ratio (DRR) of over 0.78
2. Have a property condition of less than 6 on a 10 point scale as defined by the City of Philadelphia
3. They are in a strong market according to the Reinvestment Fund's Market Value Analysis

## Code and Resources used
**R version:** 4.1.1  
**R packages:** tidyverse  
**ArcMap version:** 10.8.2 
- Used ArcGIS to filter census tracts and spacially join American Community Survey (ACS) data to the City's NOAH data.  
- Used R to clean and manipulate the data and create visualizations. 
**Data:**  
- Division of Housing and Community Development NOAH Analysis Data
- American Community Survey data

## Findings
1. Average estimated percent of all families that are headed by single females with children in census tracts with high concentrations of NOAH properties: 15.9 (The City as a whole has an average estimated percent of 17.8)
2. Average estimated percent of people with one or more disabilities in census tracts with a high concentration of vulnerable NOAH properties: 15.3 (Compared to the City's average estimated percent of 16.3) 
3. 41% of tracts with high concentrations of vulnerable NOAH properties are predominantly populated by a ***single*** minority racial/ethnic group.
4. In another 11% of tracts, non-White residents are the majority of the population. 
5. In total, 52% of tracts with high concentrations of vulnerable NOAH properties are majority non-White.  
6. Ultimately the target tracts have slighlty lower proportions of vulnerable populations than the City as a whole.  
7. 
## Visualizations 
In the following visualization, "Majority Non-White" indicates tracts where White residents are a plurality of the population, "Majority one minority racial/ethnic group" indicates tracts where a single minority racial or ethnic group makes up the majority of the population, and "Plurality one minority racial/ethnic group" indicates tracts where a single minority racial or ethnic group makes up a plurality of the population.  
![alt text](https://github.com/sfinnexe/NOAH_demographics/blob/main/Racial%20Demographics%20OTF%20NOAH.jpeg)  
Number of Minority Housholds:  
![alt text](https://github.com/sfinnexe/NOAH_demographics/blob/main/Minority%20Households%20NOAH%20OTF.jpeg) 
