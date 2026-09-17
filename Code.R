library(readxl)
library(dplyr)

#Import data
crustal_properties <- read_excel("Project Data/Crustal properties.xlsx")
eruption_counts <- read_excel("Project Data/Eruption Counts.xlsx")
geochemistry <- read_excel("Project Data/Geochemistry.xlsx")
morphology <- read_excel("Project Data/Morphology.xlsx")
volcanoes <- read_excel("Project Data/Volcano List.xlsx")

#Correct data type of `Holocene Volcano?`
volcanoes <- 
  volcanoes %>%
  mutate(`Holocene Volcano?` = if_else(`Holocene Volcano?` == "true", 
                                       true = TRUE,
                                       false = FALSE,
                                       missing = NA))
#Aggregate morphology
morphology_mean <-
  morphology %>%
  group_by(VNUM) %>%
  summarise_all(mean) %>%
  select(!(ID:Longitude))

morphology_max <-
  morphology %>%
  group_by(VNUM) %>%
  summarise_all(max) %>%
  select(!(ID:Longitude))

morphology_min <-
  morphology %>%
  group_by(VNUM) %>%
  summarise_all(min) %>%
  select(!(ID:Longitude))

#Get mean values from crustal properties
crustal_means <-
  crustal_properties %>%
  select(c(VNUM, ends_with("mean")))

