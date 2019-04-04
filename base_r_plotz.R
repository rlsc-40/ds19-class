#plotting Biketown trip data with Base R
install.packages("tidyverse") #just for installing, won't need again
library(tidyverse)
biketown <- read.csv("data/biketown-2018-trips.csv")
str(biketown)
summary(biketown)
library(lubridate)

#this in tidyverse
biketown$hour <- 
  hms(biketown$StartTime) %>%
  hour()
#the %>% eliminates the need to create intermediate variables like "stime" in the example below

#same as start_time in base
stime <- hms(biketown$StartTime)
biketown$hour <- hour(stime)

table(biketown$hour)
#hms --> hour, minute, second; we extracted the hour
freq_by_hr <- table(biketown$hour)
barplot(freq_by_hr)
barplot(40000,freq_by_hr) #this did not work
freq_by_month <- table(biketown$month)
barplot(freq_by_month)

# investigating hourly bins
hist(biketown$hour) #computer chooses breaks
hist(biketown$hour, breaks = seq(0, 24, 3)) #we choose the bins

# focus on a.m. peak
am_peak <- subset(biketown, hour >= 7 & hour < 10) # this is how we write an if; 
# the comma indicates a condition; can accomplish the same using the brackets like day 1


hist(am_peak$hour, breaks = seq(7, 10, 1)) # not very informative
barplot(table(am_peak$hour))
