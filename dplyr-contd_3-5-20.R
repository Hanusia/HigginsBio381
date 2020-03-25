# dplyr- continued
# 5 March 2020
# Hanusia Higgins


# exporting and importing data --------------------------------------------

library(dplyr)
data(starwars)

starwars1 <- select(starwars, name:species) #only some of the vraiables

## write.table function
write.table(starwars1,  #creating a csv file from this tibble
            file="StarwarsNamesInfo.csv", 
            row.names=FALSE, 
            sep=",")

## reading in data
data <- read.csv(file="StarwarsNamesInfo.csv",
                 header=TRUE,
                 sep=",",
                 stringsAsFactors=FALSE,
                 comment.char="#") #tells program to ignore any lines that begin with this symbol

head(data) #now it looks good- doesn't try to pull in metadata

data <- read.table(file="StarwarsNamesInfo.csv",
                   header=TRUE,
                   sep=",",
                   stringsAsFactors=FALSE) #don't have to add argument about the metadata
head(data) #looks right!

class(data) #it's a data frame
data <- as_tibble(data)
glimpse(data)
class(data) #now it's a tibble (since we converted it)

saveRDS(starwars1, file="StarWarsTibble")
# this saves the R objecta s a file

sw <- readRDS("StarWarsTibble") #this restores the R object into R
class(sw) #retains its tibble characteristics
#still a good idea to use file name suffixes so you know what type the file is!


# Further into dplyr! -----------------------------------------------------

glimpse(sw) #87 obs of 10 variables

## count of NAs:
sum(is.na(sw)) #sums all the NAs- logical coercion
#on the other hand: how many are NOT NAs?
sum(!is.na(sw))

swSp <- sw %>% 
  group_by(species) %>% 
  arrange(desc(mass))

#determine the sample
swSp %>% 
  summarize(avgMass=mean(mass, na.rm=TRUE), 
            avgHeight=mean(height, na.rm=TRUE),
            n=n())

#filter out the species with a low sample size!
swSp %>% 
  summarize(avgMass=mean(mass, na.rm=TRUE), 
            avgHeight=mean(height, na.rm=TRUE),
            n=n()) %>% 
  filter(n >= 2) %>% 
  arrange(desc(n))

#### count helper
swSp %>% 
  count(eye_color) #gives the number of individuals with a given eye color

swSp %>% 
  count(wt=height) #gives 'wieght' (sum) using count function


# useful summary functions ------------------------------------------------

#use base R functions a lot

starwarsSummary <- swSp %>% 
  summarize(avgHeight=mean(height, na.rm=TRUE),
            medHeight=median(height, na.rm=TRUE),
            height_sd=sd(height, na.rm=TRUE),
            height_IQR=IQR(height, na.rm=TRUE),
            min_height=min(height, na.rm=TRUE),
            first_height=first(height),
            n=n(),
            n_eyecolors=n_distinct(eye_color)) %>% 
  filter(n>=2) %>% 
  arrange(desc(n))

head(starwarsSummary)

print(starwarsSummary)


# grouping & ungrouping multiple variables --------------------------------

sw2 <- sw[complete.cases(sw),] #cleaning it up to remove rows w/ NAs

sw2groups <- group_by(sw2, species, hair_color)
sw2groups #adds groups to the beginning of the tibble

summarize(sw2groups, n=n()) #number of individuals w/in each group

sw3groups <- group_by(sw2, species, hair_color, gender)
summarize(sw3groups, n=n()) #fewer individuals per group as we increase # of groups

## UNgrouping!
sw3groups %>% 
  ungroup() %>% #use ungroup in the pipe to avoid reverting your dataset
  summarize(n=n())

## grouping with mutate function
## ex: standardize within groups

sw3 <- sw2 %>% 
  group_by(species) %>% 
  mutate(prop_height=height/sum(height)) %>% 
  select(species, height, prop_height)
sw3

sw3 %>% 
  arrange(species) #arranges in alphabetical order!

## pivot_longer function
## compare to gather() and spread()

TrtA <- rnorm(n=20, mean=50, sd=10)
TrtB <- rnorm(n=20, mean=45, sd=10)
TrtC <- rnorm(n=20, mean=62, sd=10)
z<-data.frame(TrtA, TrtB, TrtC)
library(tidyr) #in the package tidyverse!

#to use data in ANOVA- easier to have treatment names in one column, data in another
#this code can convert to different formats

#long_z <- gather(z, Treatment, Data, TrtA:TrtC) #what we did last week!

z2 <- z %>% 
  pivot_longer(TrtA:TrtC, #specify I am using these columns
               names_to="Treatment", #what the column name of the category becomes
               values_to="Data") #what the column name of values becomes
z2 #visualize it
#now we can use z2 in an ANOVA, boxplot, or similar! Yay :)

#pivot_wider() works the same way, except w/ parameters names_from and values_from
#instead of names_to and values_to

vignette("pivot") #this gives additional info!
