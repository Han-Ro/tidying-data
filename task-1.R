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
  gather('year','hdi', 3:32)
str(hdi2)









?gather
