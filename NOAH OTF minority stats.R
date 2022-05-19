library(tidyverse)

# import demographic info for census tracts with high concentrations of NOAH properties
# NOAH = Natuarally Occuring Affordable Housing
# high concentration = >50
# these are specifically vulnerable NOAH properties, 
## meaning there is a DRR of >0.78, or a property condition rating of <6, or it is in a strong market according to the reinvestment fund's market analysis

demoinfo_highdensityNOAH_TableToExcel <- read_excel("NOAH Landlord OTF/demoinfo_highdensityNOAH_TableToExcel.xls")
#View(demoinfo_highdensityNOAH_TableToExcel)

# create a table with the counts of each predominant race/percentage of predominant race
predom <- demoinfo_highdensityNOAH_TableToExcel %>% group_by(demoinfo_highdensityNOAH.predominan) %>% count()
# create a variable for total tracts (181)
totaltracts <- sum(predom$n)
# create a column that calculates the percent of total tracts for each category
predom$percent <- (predom$n / totaltracts) * 100
# sum of the percent of minority tracts
sum(predom[1:9, 3])
# sum of percent of majority minority tracts
majoritymin <- sum(predom[2, 3], predom[4:6, 3], predom[8:9, 3])
# sum of percent of plurality minority tracts
pluralitymin <- sum(predom[1, 3], predom[3, 3], predom[7, 3])

# create a new variable that groups row together based on what kind of demographic majority or pluarlity there is
predom$group <- ifelse(predom$demoinfo_highdensityNOAH.predominan %in% c("Asian 50-70%",
                                                                         "Black >90%", 
                                                                         "Black 50-70%", 
                                                                         "Black 70-90%", 
                                                                         "Hispanic 50-70%", 
                                                                         "Hispanic 70-90%"), "Majority one minority racial/ethnic group",
                       ifelse(predom$demoinfo_highdensityNOAH.predominan %in% c("Asian <50%",
                                                                                "Black <50%",
                                                                                "Hispanic <50%"), "Plurality one minortiy racial/ethnic group",
                              ifelse(predom$demoinfo_highdensityNOAH.predominan == "White <50%", "Majority Non-White",
                                     ifelse(predom$demoinfo_highdensityNOAH.predominan %in% c("White >90%",
                                                                                              "White 50-70%",
                                                                                              "White 70-90%"), "Majority White", NA))))
# create another variable that consolidates these groups even further (for graphing purposes)
predom$majority <- ifelse(predom$group %in% c("Plurality one minortiy racial/ethnic group",
                                              "Majority one minority racial/ethnic group",
                                              "Majority Non-White"), "Non-White", "White")

# set a custom theme that looks good
theme_set(theme(plot.title = element_text(hjust= 0, face="bold", size = 15),
                plot.background=element_rect(fill="#f7f7f7", color = "#f7f7f7"),
                panel.background=element_rect(fill = "#f7f7f7", color = NA),
                panel.grid.minor=element_blank(),
                panel.grid.major.y=element_line(color = "#cfcfcf"),
                panel.grid.major.x=element_blank(),
                axis.ticks=element_blank(),
                legend.position="top",
                legend.title = element_blank(),
                panel.border=element_blank()))

# plot the predominant racial group data 
ggplot(predom, aes(x = majority, y = percent, fill = group)) +
  geom_col()+
  scale_fill_manual(values = c("#2176d2", "#58c04d", "#a1a1a1", "#f3c613")) +
  xlab("") +
  ylab("Percent") +
  labs(title = "Racial Demographics of Census Tracts with High Concentrations of Vulnurable NOAH Properties")




################################################################################################################################################
# load count of minority (black, hispanic, and asian) households in these census tracts
black <- read.csv("C:/Users/sean.finnegan/Documents/NOAH Landlord OTF/blackhhcount2020.csv")
hispanic <- read.csv("C:/Users/sean.finnegan/Documents/NOAH Landlord OTF/hispanichhcount2020.csv")
asian <- read.csv("C:/Users/sean.finnegan/Documents/NOAH Landlord OTF/asianhhcount2020.csv")

# left_join these data sets to the original data set to filter for our NOAH target tracts
demo_pct <- left_join(demoinfo_highdensityNOAH_TableToExcel, black, by = c("demoinfo_highdensityNOAH.FIPS_Code" = "FIPS_Code")) %>%
  left_join(., hispanic, by = c("demoinfo_highdensityNOAH.FIPS_Code" = "FIPS_Code")) %>%
  left_join(., asian, by = c("demoinfo_highdensityNOAH.FIPS_Code" = "FIPS_Code"))

# create a small data frame with counts of racial minority households (for graphic purposes)
race_ct <- demo_pct %>% summarise(Black = sum(as.double(demo_pct$num_black_hhs), na.rm = TRUE),
                       Hispanic = sum(as.double(demo_pct$num_hispanichh), na.rm = TRUE),
                       Asian = sum(as.double(demo_pct$num_asianhh), na.rm = TRUE)) %>%
  pivot_longer(everything(), names_to = "Race", values_to = "Count")

# create a bar chart of count of households by race
ggplot(race_ct, aes(x = Race, y = Count, fill = Race)) +
  geom_col() +
  scale_fill_manual(values = c("#2176d2", "#58c04d", "#f3c613")) +
  theme(plot.title = element_text(hjust= 0, face="bold", size = 15),
        plot.background=element_rect(fill="#f7f7f7", color = "#f7f7f7"),
        panel.background=element_rect(fill = "#f7f7f7", color = NA),
        panel.grid.minor=element_blank(),
        panel.grid.major.y=element_line(color = "#cfcfcf"),
        panel.grid.major.x=element_blank(),
        axis.ticks=element_blank(),
        legend.position="none",
        legend.title = element_blank(),
        panel.border=element_blank()) +
  ylab("Number of Households") +
  labs(title = "Number of Minority Households in Census Tracts with High Concentrations of Vulnurable NOAH Properties")


