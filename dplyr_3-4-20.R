# Manipulating data using dplyr
# March 4, 2020
#Hanusia Higgins

library(tidyverse)

## What is dplyr?
# new-ish package: provides a set of tools for manipulating data
# part of the tidyverse: a collection of packages 
#             that share the same philosophy, grammar, and data structure
# specifically written to be fast!
# individual functions that correspond to the most common operations
# easier to figure out what you want to do with your data

#"mask" means that a function in one package has the same name as
#a function in another package. R will use the one in the package you
#most recently loaded in, but it warns you first that masking is happening.

library(dplyr)

# Core verbs
# filter() #filters out data (rows)
# arrange() #arranges your data
# select() #selects columns
# summarize () and group_by() #these 2 usually go hand-in-hand!
# mutate() #performing some sort of mutation......

data(starwars)
class(starwars) #it's a tibble data frame?

# What is a tibble?
# 'modern take' on data frames
# keeps great aspects of dataframes, drops frustrating ones
# (like changing variable names, changing input type)

glimpse(starwars) #sometimes a better option than str()
head(starwars)

# clean up data
# complete.cases not part of dplyr

starwarsClean <- starwars[complete.cases(starwars[,1:10]),]

is.na(starwarsClean[,1])
anyNA(starwarsClean) # outputs 1 T/F value if there are ANY NAs in dataset

# What does our data look like now?
glimpse(starwarsClean)
head(starwarsClean)

# filter(): pick/subset observations by their values
# uses >, >=, <, <=, !=, == for comparisons
# logical operators: &, |, !,
# filter automatically excludes NAs

filter(starwarsClean, gender=="male", height<180, height>100)
#can use commas- defaults to "and"
#can specify multiple conditions for the same variable!

filter(starwarsClean, eye_color %in% c("blue","brown"))
#in this case, the comma defaults to "or"
# %in% is similar to ==

# arrange(): reorders rows
arrange(starwarsClean, by=height)
#default is ascending order (aka, shortest to tallest)

arrange(starwarsClean, by=desc(height)) #this specifies descending order
#desc() changes the order

arrange(starwarsClean, height, desc(mass))
#add additional argument to break ties in preceding column

starwars1 <- arrange(starwars, height)
tail(starwars1) #NAs get put at the end of the list!

# select(): choose variables by their names

starwarsClean[1:10,2] #does a similar thing to subsetting, as in base R

select(starwarsClean, 1:5) #selected first 5 columns/categories!- use numbers
select(starwarsClean, name:height) #use variable/column names-another option

select(starwarsClean,-(films:starships)) #can EXclude variables too

#rearrange columns
select(starwarsClean, name, gender, species, everything()) 
#everything() means "everthing else goes after those selected in the same order
#it's a helper function! useful if you want to move 
#a couple variables to the beginning

select(starwarsClean, contains("color"))
#other helpers: ends_with, starts_with, matches(regular expression), num_range

select(starwarsClean, height, skin_color, films)

#rename columns w/ select:
select(starwars, haircolor=hair_color, films) #original on the right, new name on the left of the equals sign

# or: can use the rename() function
rename(starwarsClean, haricolor=hair_color) #doesn't preserve past this line

# mutate(): creates new variables with functions of existing variables

mutate(starwarsClean, ratio=height/mass)
#we can use arithmetic operators

starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2)
head(starwars_lbs)
select(starwars_lbs, 1:3, mass_lbs, everything()) 
#reordering to see our mutated variables at the beginning of the dataset

# transmute() - just keeps the NEW variable (not old ones)
transmute(starwarsClean,mass_lbs=mass*2.2)
#now it's just that one new column...

transmute(starwarsClean, mass_lbs=mass*2.2, mass)

# summarize() and group_by(): collapses values down to a single summary

summarize(starwarsClean, meanHeight=mean(height))

# working with NAs
summarize(starwarsClean,meanHeight=mean(height, na.rm=TRUE), TotalNumber = n())
#this one gives us the mean height w/o NAs and the total # of obs used
#n() is a helper function calculating sample size

starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders) #looks the same, but now it has GROUPS

summarize(starwarsGenders,meanHeight=mean(height, na.rm=TRUE), number=n())

# Piping
# used to emphasize a sequence of actions
# lets you pass an intermediate result onto a next function

# takes the output of one statement and 
# makes it the input of the next statement

# useful when you need to do a series of operations 
# to get to a final result, and don't care about the in-betweens

# avoid if you have meaningful intermediate results or if you want to 
# manipulate more than one object at a time

#formatting: have a space before the pipe, followed by a new line
# %>%

starwarsClean %>% 
  group_by(gender) %>%
  summarize(meanHeight=mean(height), number=n())

heightsSW <- starwarsClean %>%  #saving end result as a variable
  group_by(gender) %>%
  summarize(meanHeight=mean(height), number=n())

glimpse(iris) #the dataset we will be using for the homework assignment
