# Read in Excel bike count and tabular weather data

library(readxl)
install.packages("readxl")
library(lubridate)
library(dplyr)
library(readr)
getwd()

# Jenny Bryan @ UBC
# Hadley Wickam
setwd("Users/rebecca/DS19-class/ds19-class/")

input_file <- "data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx"
bridge_names <- c("Hawthorne", "Tilikum", "Steel")

# define a function that loads excel sheets
load_data <- function(bridge_name, input_file) {
  bikecounts <- read_excel(input_file, sheet = bridge_name, 
                           skip = 1) %>% 
    filter(total > 0) %>% 
    select(date, total) %>% 
    mutate(bridge = bridge_name, date = as.Date(date)) # drops useless time
}

h <- load_data("Hawthorne", input_file)
library(dplyr)
# restart R and then reload packages to try to troubleshoot

# load data from each sheet into a list (readxl)
# combine all three into one data frame
# lapply applies something to a list
bikecounts <- lapply(bridge_names, load_data, input_file = input_file) %>% 
  bind_rows() # use bind_rows() to lengthen a dataframe
# base r: bind_rows(bikecounts$bridge_names)

head(bikecounts)
tail(bikecounts)

# factorize bridge name, since here it makes sense to do so
bikecounts <- bikecounts %>% mutate(bridge = factor(bridge))

# read in weather data
weather <- read_csv("data/NCDC-CDO-USC00356750.csv")




