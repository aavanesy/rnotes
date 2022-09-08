
library(dplyr)
library(tidyr)
library(lubridate)

df <- read.csv('data/file.csv') %>% 
  mutate(Period = as.Date(Period, format = '%m/%d/%Y')) %>% 
  # arrange(desc(Period)) %>%
  group_by(Portfolio) %>% 
  mutate(lag_m = as.numeric(Period - lag(Period))) %>%
  mutate(switch = ifelse(!is.na(lag_m) & abs(lag_m) > 31, 1, 0)) %>% 
  mutate(ID = cumsum(switch)) %>%
  select(-lag_m, -switch) %>% 
  group_by(Portfolio, ID) %>%
  summarise(Benchmark = last(Benchmark), minp = min(Period), maxp = max(Period)) %>%
  group_by(Portfolio) %>% 
  mutate(n = n()) %>% 
  filter(n == 1) %>% 
  # arrange(minp) %>%
  mutate(minp = paste(month.abb[month(minp)],year(minp), sep = ' '),
         maxp = paste(month.abb[month(maxp)],year(maxp), sep = ' ')
  ) %>%
  rowwise() %>%
  mutate(names = paste0(Benchmark,' from ',minp,' to ',maxp)) %>%
  mutate(names = paste(names, collapse = '; '))
  
  pull(names) %>% paste(., collapse = '; ')
