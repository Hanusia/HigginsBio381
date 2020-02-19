#Hanusia Higgins
#Probability distributions
#Computational bio
#18 February 2020

# -------------------------------------------------------------------------

#function names that begin with.... give us....
# d --> probability density function
# p --> cumulative probability distribution
# q --> quantile function (inverse of p)
# r --> random number generator that gives values drawn from that distribution

library(ggplot2)
library(MASS)

# Poisson distribution ----------------------------------------------------

#discrete: 0 to infinity (no negative values)
#parameter lambda > 0 (continuous value- even though poisson dist itself is discrete)
#lambda is the constant rate parameter (observations per unit time or unit area)

#d function for probability density 
hits <- 0:10
my_vec <- dpois(x=hits, lambda=1)
qplot(x=hits, 
      y=my_vec, #contains the probability mass for each x-var
      geom="col",
      color=I("black"),
      fill=I("goldenrod")) #want to visualize it as columns of data

#now explore other possibilities, changing lambda...
my_vec <- dpois(x=hits, lambda=4.4)
qplot(x=hits, 
      y=my_vec, #contains the probability mass for each x-var
      geom="col",
      color=I("black"),
      fill=I("goldenrod")) #want to visualize it as columns of data

sum(my_vec) #should be = to 1.0 (if you include the entire density distribution)

#for a poisson with lambda=2,
#what is the probability that a single draw will yield x=0?

dpois(x=0,lambda=2) #gives the exact probability of that outcome

#p function for cumulative density distribution
hits <- 0:10
my_vec <- ppois(q=hits, lambda=2)
qplot(x=hits, 
      y=my_vec, #contains the density mass for each x-var
      geom="col",
      color=I("black"),
      fill=I("goldenrod")) #want to visualize it as columns of data

#cumulative function always goes up to the limit of 1.0

#for poisson with lambda equals 2,
#what is the probability that a single random draw will yield x <= 1?

ppois(q=1,lambda=2) #gives the exact, cumulative probability
#(prob of observing either a zero or a one)

p1 <- dpois(x=1, lambda=2)
print(p1)
p2 <- dpois(x=0, lambda=2)
print(p2)
p1+p2 #equal to the same value we got above for cumulative prob of x <= 1

#the q functino is the inverse of p
qpois(p=0.5, lambda=2.5)
#if lambda = 2.5, what is the value of x that will give me the LOWER half
#of the probability mass?
#the answer (per the result above) is x=2

#simulate a poisson to get actual values
ran_pois <- rpois(n=1000,lambda=2.5)
qplot(x=ran_pois, #plotting the sampling data
      color=I("black"),
      fill=I("goldenrod"))

#quantile function
quantile(x=ran_pois,probs=c(0.25,0.975)) #calculates a 95% confidence interval
#results: gives a min and max for the 95% confidence intervals

# Binomial ----------------------------------------------------------------

# p = probability of dichotomous outcome
# (p = # of successes / # of trials)
# size = # of trials
# x = distribution of the possible outcomes we could get from this set of trials
# outcome x is bounded between 0 (if no events are successful) 
# and size (if all trials are successful)

# density function for binomial 
hits <- 0:10
my_vec <- dbinom(x=hits,size=10,prob=0.5)
qplot(x=hits, 
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod")) #want to visualize it as columns of data

#what is the probability of getting 5 heads out of 10 tosses?
dbinom(x=5,size=10,prob=0.5) #gives the answer to this

#biased coin
my_vec <- dbinom(x=hits,size=10,prob=0.15) #varying the probability
qplot(x=hits, 
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod")) #want to visualize it as columns of data

#p function for tail probability
#probability of 5 or fewer heads
#out of 10 tosses
pbinom(q=5, size=10,prob=0.5) #cumulative probability is greater than 5 
#b/c we are including the 0
pbinom(q=4,size=9,prob=0.5) #this one gives 0.5 b/c it's right "in the middle"

#what is a 95% confidence interval for 100 trials of a coin with p=0.7?
qbinom(p=c(0.025,0.975),
       size=100,
       prob=0.7)
#this gives us the upper and lower limits of the 95% confidence interval

#how does this compare to a sample interval for real data?
my_coins <- rbinom(n=50,
                   size=100,
                   prob=0.5)
qplot(x=my_coins, #plotting the sampling data
      color=I("black"),
      fill=I("goldenrod"))

#these are my data...what's the 95% confidence interval?
quantile(x=my_coins,probs=c(0.025,0.975))

# Negative binomial -------------------------------------------------------

#number of failures
#in a series of (Bernouli) with p=probability of success
#before a targeted number of successes (=size)
#generaties a distribution that is more heterogenous ("overdispersed")
#than the Poisson distribution

hits <- 0:40
my_vec <- dnbinom(x=hits,
                 size=5,#how many failures will I get until I accumulate 5 "heads"?
                 prob=0.5) 
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))

#geometric series is a special case where number of successes = 1
#each bar is a constant fraction of the one that came before it 
#with probability 1-p
my_vec <- dnbinom(x=hits,
                  size=1,
                  prob=0.1) #does size = 1/prob always for geometric series?
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))

#alternatively, specify mean = mu of distribution and size
#this gives us a poisson distribution with a lambda value that varies
#dispersion parameter is the shape parameter from a gamma distribution
#as it increases, the distribution
#the variance gets smaller

nbi_ran <- rnbinom(n=1000,size=10,mu=5)
qplot(nbi_ran,
      color=I("black"),
      fill=I("goldenrod"))

#changing the size parameter:
nbi_ran <- rnbinom(n=1000,size=0.1,mu=5)
qplot(nbi_ran,
      color=I("black"),
      fill=I("goldenrod"))
#the mean is still 5, but the distribution is more heterogeneous 
#b/c we have increased the variance (b/c we decreased the size)