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

#filter to get the 10 countries with the lowest HDI mean
hdi_summary_low <- hdi_summary %>% 
  filter(rank(mean_index) < 11)
hdi_summary_low

#plot the lowest 10
hdi_summary_low %>% 
  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se_index,
                    ymax = mean_index + se_index)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()

hdi_total <- hdi2 %>% 
  filter(!is.na(index)) %>% 
  group_by(Country) %>% 
  summarise(mean_index = mean(index),
            n = length(index),
            sd_index = sd(index), 
            se_index = (sd_index/(sqrt(n)))) %>% 
  ggplot() +
  geom_point(aes(x = Country,
                 y = mean_index)) +
  geom_errorbar(aes(x = Country,
                    ymin = mean_index - se_index,
                    ymax = mean_index + se_index)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()

hdi_total







