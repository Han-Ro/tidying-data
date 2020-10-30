library(tidyverse)
getwd()
filehdi <- '../tidying-data/data/human-development-index.csv'
hdi <- read_csv(filehdi)

#pivotlonger didn't work - go back to later?
#hdi2 <- hdi %>% 
#  pivot_longer(names_to = 'country',
 #               = 'year',
  #             values_to = 'hdi',
   #cols = -`HDI Rank (2018)`)
str(hdi)
#ignore columns 1 and 2 with 3:2
hdi2 <- hdi %>% 
  gather('year','index', 3:32)
str(hdi2)


#filter out the country-year combos without results
hdi_nona <- hdi2 %>% 
  filter(!is.na(index))
str(hdi_nona)


#summarise the data
hdi_summary <- hdi_nona %>% 
  group_by(Country) %>% 
  summarise(mean_index = mean(index),
            n = length(index))
hdi_summary
#length is how many years there is data for

#add a column for sd and se
hdi_summary <- hdi_nona %>% 
  group_by(Country) %>% 
  summarise(mean_index = mean(index),
            n = length(index),
            sd_index = sd(index), 
            se_index = (sd_index/(sqrt(n))))






