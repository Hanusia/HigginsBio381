# --------------------------------------------------
# Randomization Tests
# 31 Mar 2020
# HH
# --------------------------------------------------
#
# statistical p is probability of obtaining 
# the observed results (or something more extreme)
# if the null hypothesis were truep(data|H0)
# requires some underlying assumptions
# null hypothesis is a hypeothesis of "no effect"
# variation is caused by measurement error or other 
# unspecified (and less important) sources of variation
# null hypothesis is the simplest possible explanation

# two advantages of randomization tests:
# 1. relaxes assumptions of standard parametric tests 
# (normality, balanced sample sizes, common variance)
# 2. gives a more intuitive understanding of statistical
# probability

# Steps in randomization test -------------------------------

# 1. Define a metric X as a single number to represent
# pattern that we are interested in
# 2. Calculate X(obs) the metric for the empirical
# (observed) data that we start with.
# 3. Randomize or reshuffle the data. Randomize in a way 
# that would uncouple the association between observed data
# and their assignment to treatment groups. Ideally, the
# randomization only affects the pattern of treatment effects
# in the data. Other aspects of the data (such as sample 
# sizes) are preserved in the randomization. Simulate the 
# null hypothesis!
# 4. For this single randomization, calculate X(sim). If
# null hypothesis is true X(obs) is similar to X(sim).
# If null hypothesis is false X(obs) is very different from
# X(sim).
# 5. Repeat steps 3 and 4 many times (typically n=1000).
# This will let us visualize as a histogram the distribution
# of X(sim); distribution of X values when the null hypothesis
# is true.
# 6. Estimate the tail probability of the observed metric
# (or something more extreme) given the null distribution
# p(X(obs)|H0)

# Preliminaries -------------------------------

library(ggplot2)
library(TeachingDemos)

set.seed(100)
char2seed("espresso withdrawal") 
options(digits=10)
char2seed("espresso withdrawal", set=FALSE)

Sys.time()
as.numeric(Sys.time())
my_seed <- as.numeric(Sys.time())
set.seed(my_seed)
char2seed("espresso withdrawal")

# create treatment groups
trt_group <- c(rep("Control",4),rep("Treatment",5))
print(trt_group)

# create response variable
z <- c(runif(4) + 1, runif(5) + 10)
print(z)

# combine vectors into data frame
df <- data.frame(trt=trt_group, res=z)
print(df)
#we made it so that groups are preeetty different

# look at means in the two groups
obs <- tapply(df$res,df$trt,mean)
print(obs)

# create a simulated data set

# set up a new data frame
df_sim <- df
df_sim$res <- sample(df_sim$res)
print(df_sim) #this randomly re-shuffled them!
#(we preserved sample sizes in each group just switched
#around the numbers)

# look at the mean in the two groups of randomized data
sim <- tapply(df_sim$res,df_sim$trt,mean)
print(sim)
#then, compare these means to the ones in your orig data
#to see if the differences are the same

# build functions -------------------------------

# --------------------------------------------------
# FUNCTION read_data
# description: read in (or generate) data set for analysis  
# inputs: file name (or nothing, as in this demo)
# outputs: 3-column dataframe of observed data (ID, x, y)
####################################################
read_data <- function(z=NULL) {

      if(is.null(z)){
        x_obs <- 1:20
        y_obs <- x_obs + 10*rnorm(20)
        df <- data.frame(ID=seq_along(x_obs),
                         x_obs,
                         y_obs)
      }

 #     df <- read.table(file=z,
 #                     header=TRUE,
 #                       stringsAsFactors=FALSE)
      
return(df)

} # end of read_data
#---------------------------------------------------
# read_data() #testing!

# --------------------------------------------------
# FUNCTION get_metric
# description: calculate metric for randomization test
# inputs: 2-column data frame for regression
# outputs: regression slope
####################################################
get_metric <- function(z=NULL) {

      if(is.null(z)){
        x_obs <- 1:20
        y_obs <- x_obs + 10*rnorm(20)
        z <- data.frame(ID=seq_along(x_obs),
                        x_obs,
                        y_obs)
      }
  
  . <- lm(z[,3]~z[,2])
  . <- summary(.)
  . <- .$coefficients[2,1]
  slope <- .
  return(slope)

} # end of get_metric
#---------------------------------------------------
#get_metric() #testing!

# --------------------------------------------------
# FUNCTION shuffle_data
# description: randomize data for regression analysis
# inputs: 3 column data frame (ID, xvar, yvar)
# outputs: 3 column data frame (ID, xvar, yvar)
####################################################
shuffle_data <- function(z=NULL) {

      if(is.null(z)){
        x_obs <- 1:20
        y_obs <- x_obs + 10*rnorm(20)
        z <- data.frame(ID=seq_along(x_obs),
                        x_obs,
                        y_obs)
      }
  
  z[,3] <- sample(z[,3]) #this will reshuffle y-vals
  
return(z)

} # end of shuffle_data
#---------------------------------------------------
# shuffle_data() #testing!

# --------------------------------------------------
# FUNCTION get_pval
# description: calculate p value from simulation
# inputs: list of observed metric and vector of 
#         simulated metrics 
# outputs: lower and upper tail probability value
####################################################
get_pval <- function(z=NULL) {

      if(is.null(z)){
        z <- list(rnorm(1), rnorm(1000)) 
      }
        p_lower <- mean(z[[2]]<=z[[1]])
        p_upper <- mean(z[[2]]>=z[[1]])

return(c(pL=p_lower,pU=p_upper))

} # end of get_pval
#---------------------------------------------------
# get_pval() #testing!

# --------------------------------------------------
# FUNCTION plot_ran_test
# description: create a ggplot of histogram of 
#              simulated values
# inputs: list of observed metric and vector of
#         simulated metrics
# outputs: saved ggplot graph
####################################################
plot_ran_test <- function(z=NULL) {

            if(is.null(z)){
              z <- list(rnorm(1),rnorm(1000))
            }
        df <- data.frame(ID=seq_along(z[[2]]),
                         sim_x=z[[2]])
        p1 <- ggplot(data=df, mapping=aes(x=sim_x))
        p1 + geom_histogram(mapping=aes(fill=I("goldenrod"),
                                        color=I("black"))) +
          geom_vline(aes(xintercept=z[[1]],col="blue"))


} # end of plot_ran_test
#---------------------------------------------------
# plot_ran_test()

n_sim <- 1000 # number of simulated data sets
x_sim <- rep(NA,n_sim) #set up empty vector for 
# simulated slopes
df <- read_data() # get (fake, default) data
x_obs <- get_metric(df) # get slope of obs data

for (i in seq_len(n_sim)){ #could also do i in 1:n_sim 
  x_sim[i] <- get_metric(shuffle_data(df)) #run simulation
}

slopes <- list(x_obs,x_sim) #get observed
get_pval(slopes)
plot_ran_test(slopes)