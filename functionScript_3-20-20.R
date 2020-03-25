# --------------------------------------------------
# Illustrate the use of functions and structured programming
# 23 Mar 2020
# HH
# --------------------------------------------------
#

# --------------------------------------------------
# All functions must be included at the top of the program
# before they are called
# --------------------------------------------------

# load libraries-------------------------------
library(ggplot2) #need to call this before the source call

# source files -------------------------------
#calling this function allows us to commit the functions in that file to memory
source("myFunctions_3-20-20.R") #need to match exact filename
#IF NEEDED, can include the file path w/in "source" function

# global variables -------------------------------
#the global variables are what we should be changing...
ant_file <- "antcountydata.csv"
x_col <- 7 # column 7, latitude center of each county
y_col <- 5 # column 5, number of ant species
##############################################

#for this program we will need some temp variables:
temp1 <- get_data(file_name=ant_file) #creates a dataframe

x <- temp1[,x_col] #extracts column of predictor variable
y <- temp1[,y_col] #s response variable

#fit regression model
temp2 <- calculate_stuff(x_var=x, y_var=y)

#extract residuals
temp3 <- summarize_output(z=temp2) #functions we created are working together!

# create graph
graph_results(x_var=x, y_var=y)

print(temp3) # show residuals
print(temp2) # show model summary

#don't need these right now since I used them above......
#get_data() #these functions are "dummy"
#calculate_stuff() #they aren't doing anything really
#summarize_output() #but since we created & set them up,
#graph_results() #they are technically running
