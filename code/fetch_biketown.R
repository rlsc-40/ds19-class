# functions to fetch the public biketown trip data
# http://www.biketownpdx.com/system-data

# pacman allows checking for and installing missing packages
# require will return false if pkg not able to be loaded
if (!require("pacman"))(install.packages("pacman")); library(pacman)
# semicolon separates lines without returns

# I have to upgrade my operating system for mac, but this is the code I would use
# if I had pacman
# lubridate - quick way to work with dates
pacman::p_load("lubridate")
pacman::p_load("")
pacman::p_load("")
pacman::p_load("")

# doing this way to work around pacman
if (!require("lubridate"))(install.packages("lubridate")); library(lubridate)
if (!require("dplyr"))(install.packages("dplyr")); library(dplyr)
if (!require("stringr"))(install.packages("stringr")); library(stringr)
if (!require("readr"))(install.packages("readr")); library(readr)

# could also have done (simpler)
pkgs <- c("lubridate", "dplyr", "stringr", "readr")
install.packages(pkgs)

# will now write function to download data from biketown

get_data <- function(start="7/2016", end, 
                     base_url="https://s3.amazonaws.com/biketown-tripdata-public/",
                     outdir="Users/rebecca/Desktop/DS19-class/ds19-class/data/biketown/") {
  # takes start and end in mm/yyyy format, and tries to download files
  
  # if no end date given, set to now
  # setting parameter values within the function
  # end <- ifelse(is.null(end), format(now(), "%m/%Y"), end)
  
  # make url function only available within get_data
  make_url <- function(date, base_url) {
    url <- paste0(base_url, format(date, "%Y_%m"), ".csv") #the cap Y tells it we want the 
    # four-char year; %Y%m is a formatting aspect in baseR
    return(url)
  }
  # parse date range
  start_date <- lubridate::myd(start, truncated = 2)
  end_date <- myd(end, truncated = 2)
  date_range <- seq(start_date, end_date,by="months")
  # function starting to get really long, may need to debug as we go along
  
  # lapply(a, b) just applies function b to sequence a 
  # and returns a list of the modified sequence
  urls <- lapply(date_range, make_url, base_url=base_url)
  
  # for loops can be easier for early development of code (a little more readable)
  for (u in urls) { # "u" is just a name, could be "x", etc.
    download.file(u, destfile = paste0(outdir, str_sub(u, -11))) #just pulls last 11 chars
  }
}
  
# can differentiate between required (x, ...) and default (y = ...)
# for loops are expensive because it loops each time. But good for checking if apply not working.
# Apply is a better option when possible in R; in Python and Stata, for loops are std.

# at this point, we have not called the function - have just assigned it.

### manual run ###
# params
# start = "6/2018"
# end = "8/2018"
# # outdir = "Users/rebecca/Desktop/"
# outdir = "biketown/"

get_data(start, end, outdir = outdir)
# problem is that we did not pass to the outdir!

# to scrape the web, need something more like python 
# (e.g., to get data from a private source that requires log-in, like TIMS)

# we changed end=NULL, then defined end
