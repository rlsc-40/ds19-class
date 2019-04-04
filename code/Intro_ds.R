# This is my practice script for the R data science course. 
# We are using this to learn packages and functions with Joe.

install.packages("fortunes")
fortune()
# playing with values to see how we get the code to execute
x = 7
y = 9
rm(x)
rm(y)
# end of experiment, back to fortunes

library(fortunes)
fortunes::fortune() #means using the library to call on the function
fortune()
# I have a question about fortunes...
?fortune

# just created data file, now about to play with it
read.csv("data/bikes.csv")
# we need to give it a name so it comes into our environment
bikes <- read.csv("data/bikes.csv")
bikes
str(bikes)
# changed data file, but it does not change "bikes"
bikes <- read.csv("data/bikes.csv")
bikes
str(bikes)
# changed "30" to "30-35"; R now describes the weights as a factor (string) rather than an integer
bikes <- read.csv("data/bikes.csv")
bikes
str(bikes)
# changed "18" to "17.5", R now describes as "num"
mean(bikes$weight) # in pounds

bikes$weight <- bikes$weight + 2 # good example of reassinging the value of a variable
bikes
# couldn't do things, e.g., a mean of a categorical values (e.g., mean(bikes$color)) even when R assigned the variable numeric values

# can create lists, e.g., the below, which can include all sorts of info...not sure how useful this is yet.
joes_list <- list(bikes, "joe", "2 bananas")
str(joes_list)
 #Tammy says that if we have all the same type of values, we should convert the dataframe to a matrix - will be much faster.

#Tammy's scripting part
# can build the dataframe in the script itself
cats <- data.frame(coat = c("tabby", "calico", "tuxedo"), 
                   weight = c(8, 12, 20), 
                   fur.length = c("short", "long", "medium"))
# the "c" creates the column
str(cats)
age <- c(5, 12, 90)
cats <- cbind(cats, age) # binds age to cats; if you were to append a row, it would be rbind
str(cats)
toes <- c(6, 5) # will not work because I don't have the right number of rows
cats <- cbind(cats, toes)

new_cat <- list("tortoise_shell", 11, "short", 5) 
# this is a new observation
levels(cats$coat) <- c(levels(cats$coat), "tortoise_shell") 
# need this to go in and add the tortoise_shell value ("factor")
cats <- rbind(cats, new_cat)
str(cats)

# removing old variables to redo
rm(cats)
rm(new_cat)
# script does not show that I reran

# learning to remove a row with an error
cats[-4, ] #open brackets [x] call up the specific dataframe ("x"), and the "-" deletes the row number
# if I fill in both values [x, y], it will delete both that row and that column
cats <- cats[-4, ] 
#have to reassign, even though I've changed the dataframe, bc it only changes it temporarily
cats

# doing work in R allows you to make changes without changing the raw data
rm(joes_list)
gapminder <- read.csv("Home/Dropbox/Professional/Training/data-shell/data/gapminder_data.csv")
gapminder <- read.csv("gapminder_data.csv")
str(gapminder)

# to show first 6 rows
head(gapminder) 

# to show last 6 rows
tail(gapminder) 

# to show number of rows per country
summary(gapminder$country) 

# another way to show number of rows per country
table(gapminder$country) 

# to get table of country x continent (or any two variables)
table(gapminder$country, gapminder$continent) 

# to show number of variables in dataset
length(gapminder) 

# to see the number of rows and columns
dim(gapminder)

# to see the column names
colnames(gapminder)

# Moving to work on subsetting data

# to look at one row
gapminder[8, ]

# to look at more than one row
gapminder[450:475, ]
 
# to save as a subset
subset_1 <- gapminder[450:475, ]
subset_1
subset_afg <- gapminder[levels(gapminder$country) == "Afghanistan", ]
subset_afg
subset_afg <- gapminder[gapminder$country == "Afghanistan", ]
subset_afg
subset_highlife <- gapminder[gapminder$lifeExp > 40, ]
subset_highlife
mean(gapminder$lifeExp)
summary(subset_highlife)

# need to learn more about the diff btwn lists and dataframes
