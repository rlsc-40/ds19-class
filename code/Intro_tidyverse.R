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

# getting into plotting (data; coordinate frame (aes) - x, y; how do you want to represent?)
p <- ggplot(fac_lengths, aes(year, miles, group = facility,
                             color = facility))
# these are just the decisions aobut the data, but have not decided how to represent
# these are global settings, e.g., all p plots will group by facility

p + geom_line()
p + geom_point() # both of these more effective with color
p + geom_line() + scale_y_log10() # gives us a better picture of how things have changed
p + geom_line() + labs(title = "Change in Portland Bike Facilities", 
                       subtitle = "2008-2013", 
                       caption = "Source: Portland Metro") +
ylab("Total Miles") +
xlab("Year")

# look into the software carpentry

p2 <- ggplot(fac_lengths, aes(x = year, y = miles,
                              group = facility))
p2 + geom_line(size = 1, color = "blue") + 
  facet_wrap( ~ facility)
# splits into separate plots for each line

p2 + geom_line(size = 1, color = "blue") + 
  facet_wrap( ~ facility) + scale_y_log10()

rm(Europe_sub, Africa_subset, Africa_table, gdp_continent, gdp_per_continent)
rm(subset_1, subset_2, subset_3, xy, xyz)
rm(mean_pop, total_gdp_country)

install.packages("fivethirtyeight")
library(fivethirtyeight)
?fivethirtyeight
d <- love_actually_adj
x <- love_actually_appearance
mas <- masculinity-survey # not yet committed
murder <- murder_2016_prelim

rm(murder, x, d)
d <- steak_survey
colnames(d)

# want to get an idea of the prevalence of various values in the data
str(d)

table(d$skydiving)
summary(d)

?summarise
library(dplyr)

steak_pref <- d %>%
  filter(steak==TRUE) %>% 
  group_by(region) %>%
  summarise(f_smoke = frequency(smoke), f_alc = frequency(alcohol))
# this did not work

steak_pref <- d %>%
  filter(steak==TRUE) %>% 
  group_by(region) %>% 
  summarise(n = n(), n_smoke = sum(smoke, na.rm = T), n_alc = sum(alcohol, na.rm = T)) %>% 
  mutate((smok_prev = n_smoke/n), (alc_prev = n_alc/n))
# if there are any N/As, the whole response is N/A

steak_pref

summary(d)

# simple cross-tab of the data
table(d$steak_prep, d$hhold_income)

# jitter plot of steak_prep x hhold_inc...not very informative

steak_inc <- ggplot(d, aes(steak_prep, hhold_income, group = region,
                             color = region))
steak_inc + geom_jitter()

steak_inc_noreg <- ggplot(d, aes(steak_prep, hhold_income))
steak_inc_noreg + geom_jitter()

steak_educ <- ggplot(d, aes(steak_prep, educ))
steak_educ + geom_jitter()
table(d$steak_prep, d$educ)


install.packages("summarytools")

prop.table(table(tips$smoker))

