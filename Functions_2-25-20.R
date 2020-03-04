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

function_name #returns the internal part of the function
function_name() #runs the function (w/ default parameters)
function_name(par_x=my_matrix, #running the function w/ parameters
              par_y="order",
              par+y=1:10)

#style tips for functions:
#use prominent hash fencing around your function code
#give a header with function name, description of input and output
#names inside functions can be short
#functions should be short & simple, no more than 1 screen full of text
#(if it's longer, suggests the function may be too complex-break it down)
#provide default values for all input parameters
#make default values from random number generators

#####################################################################
# FUNCTION: hardy_weinberg
# input: an allele freqeuncy p (0,1)
# output: p and the frequencies of genotypes AA AB BB

# -------------------------------------------------------------------------

hardy_weinberg <- function(p=runif(1)){ #setting a default val for p if none provided
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p=p,
                  f_AA=f_AA,
                  f_AB=f_AB,
                  f_BB=f_BB)
  return(vec_out) #R will automatically return last variable, but good to do this anyway
}
#########################################################################

hardy_weinberg()
hardy_weinberg(p=0.5)
pp = 0.6
hardy_weinberg(p=pp)
print(hardy_weinberg(p=pp))


#####################################################################
# FUNCTION: hardy_weinberg2
# input: an allele freqeuncy p (0,1)
# output: p and the frequencies of genotypes AA AB BB

# -------------------------------------------------------------------------

hardy_weinberg2 <- function(p=runif(1)){ #setting a default val for p if none provided
 if(p > 1.0 | p < 0.0){ 
   return("Function failure: p must be <=1 and >=0")
 }
    q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p=p,
                  f_AA=f_AA,
                  f_AB=f_AB,
                  f_BB=f_BB)
  return(vec_out) #R will automatically return last variable, but good to do this anyway
}
#########################################################################

hardy_weinberg2() #it works...
hardy_weinberg(1.1) #doesn't stop us from running the function
hardy_weinberg2(1.1) #spits out an error message
z <- hardy_weinberg2(1.1) #that's no good, because it gives the error string
#to this variable (z)

#Use the "stop" function for true error tracking

#####################################################################
# FUNCTION: hardy_weinberg3
# input: an allele freqeuncy p (0,1)
# output: p and the frequencies of genotypes AA AB BB

# -------------------------------------------------------------------------

hardy_weinberg3 <- function(p=runif(1)){ #setting a default val for p if none provided
  if(p > 1.0 | p < 0.0){ 
    #stop function TERMINATES the function & gives a non-data error message
    stop("Function failure: p must be <=1 and >=0") 
  }
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p=p,
                  f_AA=f_AA,
                  f_AB=f_AB,
                  f_BB=f_BB)
  return(vec_out) #R will automatically return last variable, but good to do this anyway
}
#########################################################################

hardy_weinberg3(1.1) #sends out the error message!
z <- hardy_weinberg3(1.1) #won't let me do this either!
#the above functions are in the global environment.....

#...but anything created INSIDE a function are inside the local environment

#global variables: visible in all parts of code, declared in main body of program
#local variables: visible only within the function; declared in the functino or passed to it through input parameters

#functions can "see" variables in global environment
#global environment cannot "see" variables in the function environment

my_func <- function(a=3,b=4){
  z <- a+b
  return(z)
}
my_func()

my_func_bad <- function(a=3){ #doesn't include b as a parameter
  z <- a+b
  return(z)
}
my_func_bad() #it doesn't run!
b <- 100
my_func_bad() #this function behaves differently depending on 
#what's happening in the global environment. BAD!

#functions shouldn't have to go to the global environment 
#to find the variables they need

my_func_ok <- function(a=3){
  bb=100 #this is ok b/c variable is consistent within the function
  z <- a+bb
  return(z)
}

my_func_ok()
print(bb) #error b/c local variable "bb" doesn't exist in global environment

#######################################################################
# FUNCTION: fit_linear
# fits simple regression line
# inputs: numeric vectors of predictor (x) and response (y)
# output: slope and p-val of regression

# -------------------------------------------------------------------------
fit_linear <- function(x=runif(20),
                       y=runif(20)){
  my_mod <- lm(y~x)
  my_out <- list(slope=summary(my_mod)$coefficients[2,1],
                 p_val=summary(my_mod)$coefficients[2,4])
  plot(x=x,y=y)
  return(my_out)
}
# -------------------------------------------------------------------------

fit_linear()

#######################################################################
# FUNCTION: fit_linear2
# fits simple regression line
# input: a list p including items "x" and "y" (numeric variables)
# output: slope and p-val of regression

# -------------------------------------------------------------------------
fit_linear2 <- function(p=NULL){
  if(is.null(p)){
    p <- list(x=runif(20),y=runif(20))
  }
  my_mod <- lm(p$y~p$x)
  my_out <- list(slope=summary(my_mod)$coefficients[2,1],
                 p_val=summary(my_mod)$coefficients[2,4])
  plot(x=p$x,y=p$y)
  return(my_out)
}
# -------------------------------------------------------------------------

fit_linear2() #works with default values that it generated
my_pars <- list(x=1:10,y=runif(10)) #bundling inputs nto a single list
fit_linear2(p=my_pars)

#use do.call to pass a list of parameters to a function

z <- c(runif(99),NA)
mean(z)
mean(x=z,na.rm=TRUE) #this combs to remove NA values
mean(x=z,na.rm=TRUE,trim=0.05) #"trim" parameter also removes the ends
my_list=list(x=z,na.rm=TRUE,trim=0.05)
mean(my_list)
do.call(mean,my_list)  #what does this function do again?
