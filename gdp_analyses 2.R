library(tidyverse)
library(janitor)


"final_statewise_gsdp.csv" %>% 
  read.csv() %>% 
  rename("sector"="item")-> statewise_gsdp

statewise_gsdp %>% 
  pull(sector) %>% 
  unique()

statewise_gsdp


##1. for every financial year, which sector has performed well
statewise_gsdp %>% 
  group_by(year,sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm=T)) %>%  #na.rm= if data not available remove the data
  arrange(year,desc(total_gsdp)) %>% 
  slice(1)-> year_wise_topsector
print(year_wise_topsector)

##2. for every financial year, which sector has performed least
statewise_gsdp %>% 
  group_by(year,sector) %>% 
  summarise(total_gsdp = sum(gsdp,na.rm=T)) %>%
  arrange(year,(total_gsdp)) %>% 
  slice(1)-> year_wise_least_sector
print(year_wise_least_sector)  #in default data will be in ascending order


##3. for every financial year, which state has performed well
statewise_gsdp %>% 
  group_by(year,state) %>% 
  summarise(total_gsdp = sum(gsdp,na.rm=T)) %>%
  arrange(year,desc(total_gsdp)) %>% 
  slice(1) -> well_performance
paste(well_performance)


##4. for every financial year, which state has performed least
statewise_gsdp %>% 
  group_by(year,state) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm=T)) %>% 
  arrange((total_gsdp)) %>% 
  slice(1) 



##5. top 5 performing states in manufacturing 
statewise_gsdp %>% 
  
  filter(sector =="Manufacturing") %>% 
  group_by(state) %>%
  summarise(total_gsdp=sum(gsdp, na.rm=T)) %>% 
  arrange(state,desc(total_gsdp)) %>% 
  slice(1:5) -> top_performance_states
print(top_performance_states)

##6. top 5 performing states in construction

statewise_gsdp %>% 
  
  filter(sector =="Construction") %>% 
  group_by(state) %>%
  summarise(total_gsdp=sum(gsdp, na.rm=T)) %>% 
  arrange(state,desc(total_gsdp)) %>% 
  slice(1:5) -> top_performance_states
print(top_performance_states)



##7. for financial year 2016-17, for every sate get top performing sector
statewise_gsdp %>% 
  filter(year=="2016-17") %>% 
  group_by(state,sector) %>%
  summarise(total_gsdp=sum(gsdp, na.rm=T)) %>% 
  arrange(state,sector,desc(total_gsdp)) %>% 
  slice(1) -> top_performance_states
print(top_performance_states)


##8. for financial year 2016-17 , for every state get top5 performing sectors
statewise_gsdp %>% 
  filter(year=="2016-17") %>% 
  group_by(state,sector) %>%
  summarise(total_gsdp=sum(gsdp, na.rm=T)) %>% 
  arrange(state,sector,desc(total_gsdp)) %>% 
  slice(1:5) -> top_performance_states
print(top_performance_states)
##9. how many states are performing well in manufacturing , (if manufacturing is in top 3)

statewise_gsdp %>% 
  # filter(sector =="Manufacturing") %>% 
  group_by(state,sector) %>%
  summarise(total_gsdp=sum(gsdp, na.rm=T)) %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:3) %>% 
  filter(sector =="Manufacturing") -> top_performance_states
nrow(top_performance_states)


##10. what is the GROSS GSDP of karnataka for all financial years

statewise_gsdp %>% 
  filter(state=="Karnataka") %>% 
  group_by(year) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm=T)) ->gandadagudi

print(gandadagudi)

