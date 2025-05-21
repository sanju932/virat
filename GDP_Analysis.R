library(tidyverse)
library(janitor)
library(stringr)
dir()
dir(path="GDP Data")
  

  "Nad-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
    str_split("-") %>% 
    unlist()->state_name_vector
  state_name_vector[2]->st_name
  
  
  sf1 %>% 
    slice(-c(7,11,27:33)) %>%
    pivot_longer(-c(1,2),names_to = "year",values_to = "gsdp") %>% 
    clean_names() %>% 
    select(-1) %>% 
    mutate(state=st_name)
    
  "GDP Data/Nad-Arunachal_Pradesh-GSVA_cur_2015-16.csv" %>% 
    read_csv()->sf2
  
  
  "Nad-Arunachal_Pradesh-GSVA_cur_2015-16.csv" %>% 
    str_split("-") %>% 
    unlist()->state_name_vector
  state_name_vector[2]->st_name
  
  
  sf2 %>% 
    slice(-c(7,11,27:33)) %>%
    pivot_longer(-c(1,2),names_to = "year",values_to = "gsdp") %>% 
    clean_names() %>% 
    select(-1) %>% 
    mutate(state=st_name)
  
 
  
  #step 2
  #extract state names from file name
  tibble( ) -> tempdf
  dir(path = "GDP Data",
      pattern = "NAD")->state_files
  #read all csv files
  for(i in state_files){
    i %>% 
      str_split("-") %>% 
      unlist() -> state_name_vector
    
    state_name_vector[2] -> st_name
    
    #print(paste0("state name:", st_name))
    #read csv file
    paste0("GDP Data/",i) %>% 
      read_csv() -> st_df1
    print(st_df1)
    
    st_df1 %>% 
      slice(-c(7,11,27:33)) %>% 
      pivot_longer(-c(1,2), names_to = "year", values_to = "gsdp") %>% 
      clean_names()  %>% 
      select(-1) %>% 
      mutate(state=st_name) -> state_df
    print(state_df)
   
    bind_rows(tempdf, state_df) ->tempdf
  }
  
  tempdf->final_statewise_gsdp
  
  
  
  
 