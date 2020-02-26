# Functions structure and use
# Computational bio
# 25 Feb. 2020
# Hanusia Higgins

# -------------------------------------------------------------------------

#everything in R is a function!

#the following 3 statements do the same thing:
sum(3,2) # "prefix" function
3 + 2 # an "operator", but it is actually a function
`+`(3,2) # rewritten as an "infix" function

y <- 3 #assignment operator is still a function
print(y)

`<-`(yy,3) #rewritten the assignment operator as an infix function
print(yy)

#to see contents of a function, print it
print(read.table) #spits out the code underlying the function

sd #prints out the "under the hood" of this built-in function
sd(c(3,2)) #vs. calling a function w/ parameters
sd()       #call function w/ no inputs- returns an error
#some functions can operate w/ default parameters, but not this one

#will start writing our own functions......next time?!
#no...starting now :(

# the anatomy of a user-defined function ----------------------------------

#create a function w/ a specific name, and give it parameters
#which can have a default value
function_name <- function(par_x=default_x,
                          par_y=default_y,
                          par_z=default_z) { #curly bracked designates...
  #...start of the code of the function itself
  #function body
  #lines of R code and annotation
  #may call other functions inside it
  #can create functions
  #create local variables
  
  return(z) #this is the single-element output of the function
} #closing the function

