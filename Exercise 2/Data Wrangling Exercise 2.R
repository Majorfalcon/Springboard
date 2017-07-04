## Load packages and data ##
library(tidyr)
library(dplyr)
titanic_original <- read_csv("titanic_original.csv")

## Fill missing $embarked data ##
## Account for both empty strings and NA values ##
titanic_embarked <- titanic_original %>%
  mutate(embarked = ifelse(.$embarked %in% c("", " "), NA, embarked))%>% 
  mutate(embarked = ifelse(is.na(embarked), "S", embarked))

## Fill missing $age data using mean ##
titanic_age <- titanic_embarked %>% 
  mutate(age = ifelse(.$age %in% c("", " "), NA, age)) %>% 
  mutate(age = ifelse(is.na(age), mean(.$age, na.rm = TRUE), age))

## Fill missing $boat data ##
titanic_boat <- titanic_age %>% 
  mutate(boat = ifelse(.$boat %in% c("", " "), NA, boat)) %>% 
  mutate(boat = ifelse(is.na(boat), "None", boat))

## Track individuals with missing cabin numbers ##
titanic_cabin <- titanic_boat %>% 
  mutate(cabin = ifelse(.$cabin %in% c("", " "), NA, cabin)) %>%
  mutate(has_cabin_number = ifelse(.$cabin %in% NA, 0, 1))

## Save as new .csv for github ##
write.csv(titanic_cabin, "titanic_clean.csv")