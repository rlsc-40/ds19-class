# tidy data must have single obsv for each id, table of obvs x vars
# can't have obs values in the variables, e.g., facility2008, facility2009 in Joes' ex. - need to gather
# second example clearer to me, with mult IDs; need to make wider
# functions include unite(), separate()
library(tidyverse) # could have just loaded tidyr and also ggplot2 and readr
bikenet <- read.csv("bikenet-change.csv")
# tidyr: read_csv("")
library(dplyr)
head(bikenet)
bikenet <- read_csv("bikenet-change.csv")
summary(factor(bikenet$facility2013))
# allows us to see what's in the factor

# gather facility columns into single year variables
colnames(bikenet)
bikenet_long <- bikenet %>% 
  gather(key= "year", value="facility",
         facility2008:facility2013, na.rm = T) %>% 
  mutate(year = stringr::str_sub(year, start = -4))
# overwrote the year values added a column to our bikenet_long dataframe

head(bikenet_long)
  
?gather
# may need to interpret n/a values from, e.g, STATA
# can set n/a settings when reading in the files

# combine/unite fname and ftype to get, e.g., "7th AVE"
bikenet_long <- bikenet_long %>% 
  unite(col = "street", c("fname", "ftype"), sep = " ")
head(bikenet_long)

#Danger below! fname can have multiple street names
# separate street and suffix back to two values
bikenet_long <- bikenet_long %>% 
  separate(street, c("name", "suffix")) 
head(bikenet_long)
# if values are separated by commas, would say c("x", "x"), sep ",")
# Tammy mentioned if else statements...we lost some data

bikenet_long %>% filter(bikeid == 139730)
# sometimes loops can be avoided by simply reshaping the data

fac_lengths <- bikenet_long %>% 
  filter(facility %in% c("BKE-LANE", "BKE-BLVD", "BKE-BUFF", "BKE-TRAK", 
                         "PTH-REMU")) %>% 
  group_by(year, facility) %>% 
  summarise(metres = sum(length_m)) %>% 
  mutate(miles = metres / 1609) # added the miles column
head(fac_lengths)
fac_lengths
 

