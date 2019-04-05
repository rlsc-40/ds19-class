# Intro to dplyr
library(dplyr)
# if something is masking something, it's because there's a version in dplyr; 
# if you want to use a function from another package, "package name :: function name"

# loading gapminder data
gapminder <- read.csv("gapminder_data.csv")
gapminder <- read.csv("gapminder_data.csv", stringsAsFactors = F)

# to load without strings as factors:
# gapminder <- read.csv("gapminder_data.csv", stringsAsFactors = F)
# this will allow strings to remain as text, important for text analysis
# to change a string back: gapminder$continent <- as.factor(gapminder$continent)
# to change to string one/time: gapminder$continenet <- as.character(gapminder$continent)
# to check in console: is.factor(gapminder$continent) --> will give a TRUE or FALSE
# same as is.character(dataset$varname)

# base R mean
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"]) #use brackets to call the dataframe

# the pipe (== short-cut!): %>%
# Today we are learning from dplyr:
# 1. select()
# 2. filter()
# 3. group_by()
# 4. summarize()
# 5. mutate()

# to see attributes in gapminder:
colnames(gapminder)

# select three attributes in gapminder
subset_1 <- gapminder %>% 
  select(country, continent, lifeExp)

# in base R, this would look like
# subset_1 <- gapminder[gapminder$country]
# subset_2 <- gapminder[gapminder$continent]
# subset_3 <- gapminder[gapminder$lifExp]

# select every attribute except two:
subset_2 <- gapminder %>%
  select(-lifeExp, -pop)

# select some attributes but rename a few of them for clarity
subset_3 <- gapminder %>%
  select(country, population = pop, lifeExp, gdp = gdpPercap)

# pipe shortcut: control+shift+m

# using filter()
Africa_subset <- gapminder %>% 
  filter(continent == "Africa") %>%
  select(country, population = pop, lifeExp)
table(Africa_subset$country) # will show all of the other countries, just as a 0 factor value

# without pipe
Africa_subset <- filter(gapminder, continent == "Africa")
Africa_subset <- select(Africa_subset, country, population = pop, lifeExp)
# now shows only the countries in Africa

# select year, population, country for Europe
Europe_sub <- gapminder %>% 
  filter(continent == "Europe") %>% 
  select(country, population = pop, year)
table(Europe_sub$country)

# to view data as a table, but it's doing a frequency count
Africa_table <- table(Africa_subset$country)
View(Africa_table)

# working with group_by() & summarize()
# group_by subsets within main dataframe; treats as subsets w/o having to actually subset
str(gapminder %>% group_by(continent))

# summarize mean gdp per continent
gdp_continent <- gapminder %>% 
  group_by(continent) %>% 
  summarise(mean_gdp = mean(gdpPercap), mean_lifeExp = mean(lifeExp))
View(gdp_continent)

# just a quick mean for all of the countries, could add other vars, as well - will not add to dataset

library(ggplot2)
summary_plot <- gdp_continent %>% 
  ggplot(aes(x = mean_gdp, y = mean_lifeExp)) +
  geom_point(stat = "identity") +
  theme_bw()
summary_plot

# calculate mean pop for all continents
mean_pop <- gapminder %>% 
  group_by(continent) %>% 
  summarise(mean_population = mean(pop))
View(mean_pop)
mean_pop

# count () and n ()
gapminder %>% 
  filter(year == 2002) %>% 
  count(continent, sort = TRUE)

# want to calculate the s.e. for each continent but don't know the number of obsv, use "n"
gapminder %>% 
  group_by(continent) %>% 
  summarise(se = sd(lifeExp)/sqrt(n()))

# mutate() is my friend - used to create a brand new column to add to dataframe
xy <- data.frame(x = rnorm(100), # this just generated 100 random numbers
                 y = rnorm(100))
head(xy)
xyz <- xy %>% 
  mutate(z = x * y)
head(xyz) # just shows first 6 rows

# only creating these variables in the dataframe that is currently being used 
# will not modify .csv unless you "write to..."

# add a column to gapminder that gives full GDP per continent, grouped by country
gdp_per_continent <- gapminder %>% 
  mutate(total_gdp = gdpPercap * pop) %>% 
  group_by(continent) %>% 
  summarise(cont_gdp = sum(total_gdp))














