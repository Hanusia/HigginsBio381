# --------------------------------------------------
# Basic anatomy and use of for loops
# 26 Mar 2020
# HH
# --------------------------------------------------
#
# anatomy of a for loop -------------------------------

# for (var in seq) { #start of loop

# body of for loop

#  } # end of loop 

# var is a counter variable that holds the current value
# of the counter in the loop
# seq is an integer vector (or vector of character strings)
# that defines the startign and ending values of the loop

# suggest using i,j,k for var (counter)

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

#the wrong way...
for (i in my_dogs) {
  print(i)
}

#versus the right way to do it:
for (i in 1:length(my_dogs)) {
  
  cat("i=", i, " my_dogs[i]=", my_dogs[i], "\n")
  
}

#potential hazard: suppose our vector is empty!
my_bad_dogs = NULL

for (i in 1:length(my_bad_dogs)) {
  
  cat("i=", i, " my_bad_dogs[i]=", my_bad_dogs[i], "\n")
  
} #this output is bad!

# safer way to code var in the for loop is to use seq_along
for (i in seq_along(my_dogs)) {
  
  cat("i=", i, " my_dogs[i]=", my_dogs[i], "\n")
  
}

# seq_along also handles the empty vector correctly
for (i in seq_along(my_bad_dogs)) {
  
  cat("i=", i, " my_bad_dogs[i]=", my_bad_dogs[i], "\n")
  
} #don't get any input (and we shouldn't!)

# could also define vector length from a constant
zz <- 5
for(i in seq_len(zz)){ #creates a sequence from 1-5
  cat("i=", i, " my_dogs[i]=", my_dogs[i], "\n")
} #get the same (correct) output!

# for loop tips -------------------------------

# tip #1: do NOT change object dimensions inside a loop
# avoid these functions (cbind, rbind, c, list)

#so basically, don't do this:
my_dat <- runif(1)
for (i in 2:10) {
  temp <- runif(1)
  my_dat <- c(my_dat,temp) #adding another element to vector
  cat("loop number=", i, "vector element=", my_dat[i], "\n")
}

print(my_dat)

# tip #2: Don't do things in a loop if you do not need to!

for (i in 1:length(my_dogs)) {
  my_dogs[i] <- toupper(my_dogs[i]) #this doesn't need to be in the loop
  cat("i=", i, " my_dogs[i]=", my_dogs[i], "\n")
}

z <- c("dog","cat","pig")
toupper(z) #this can exist outside of the loop

# tip #3: do not use a loop at all if you can vectorize!

my_dat <- seq(1:10)
for(i in seq_along(my_dat)) {
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number=", i, "vector element=",my_dat[i],"\n")
}

# no loop needed here!
z <- 1:10
z <- z+z^2 #vectorization does the trick!
print(z)

# tip #4: understand distinctions between the counter variable i,
# and the vector element z[i]

z <- c(10,2,4)
for (i in seq_along(z)) {
  cat("i=",i,"z[i]=",z[i],"\n")
}

# what is the value of i at the end of the loop?
print(i) #the end/last val

# what is the value of z at the end of the loop?
print(z) #same

# tip #5: use next to skip certain elements in the loop

z <- 1:20
#suppose we want to work only odd-numbered elements?

for (i in seq_along(z)) {
  if (i%%2==0){ #IF it's an even number... (b/c remainder=0)
    next #jumps to the end of the for loop and starts next round
  }
  print(i)
}

#another method, probably faster(why?)

z<- 1:20
z_sub <- z[z%%2!=0] #contrast w/ logical expression in loop: opp result
length(z)
length(z_sub)

for (i in seq_along(z_sub)) { #faster b/c it only has 10 iterations
  cat("i=",i,"z_sub[i]=",z_sub[i],"\n")
}

#tip #6: use break to set up a conditional to break out of a loop early

# create a simple random walk population model function

# --------------------------------------------------
# FUNCTION ran_walk
# description: stochastic random walk
# inputs: times = number of time steps,
#         n1 = initial population size (=n[1])
#         noise_sd = standard deviation of a normal distribution
#                    with mean 0
# outputs: vector n with population sizes >0
#         until extinction, then NA values
####################################################
library(tcltk)
library(ggplot2)
ran_walk <- function(times=100,
                     n1=50,
                     lambda=1.0,
                     noise_sd=10) {

n <- rep(NA,times) #create output vector
n[1] <- n1 #initialize starting population size
#create random noise vector
noise <- rnorm(n=times,mean=0,sd=noise_sd)

for (i in 1:(times-1)) {
  n[i+1] = n[i]*lambda+noise[i]
  if(n[i+1] <= 0) {
    n[i+1] <- NA #set all inst w/ "negative" pops to NA
    cat("Population extinction at time", i-1, "\n")
    tkbell()
    break
  } #end of if statement
} #end of for loop
  return(n)
} # end of ran_walk
#---------------------------------------------------

##############################################

# picking up here on March 31st lecture! -------------------------------

# explore our model parameters interactively
# with simple graphics

pop <- ran_walk()
qplot(x=1:100,y=pop,geom="line")

# check out performance with NO noise
pop <- ran_walk(noise_sd=0) #flat line
qplot(x=1:100,y=pop,geom="line")

#gives us exponential growth
pop <- ran_walk(noise_sd=0, lambda=1.1) 
qplot(x=1:100,y=pop,geom="line")

#gives us decline
pop <- ran_walk(noise_sd=0, lambda=0.98) 
qplot(x=1:100,y=pop,geom="line")

#a little bit of noise....
pop <- ran_walk(noise_sd=1, lambda=0.98) 
qplot(x=1:100,y=pop,geom="line")

# double for loops -------------------------------

m <- matrix(round(runif(20),digits=2),nrow=5)

# loop over rows 
for (i in 1:nrow(m)){
  m[i,] <- m[i,] + i
}

print(m) #loop added 1 to each # in row 1,
#added 2 each # in row 2, etc etc.

m <- matrix(round(runif(20),digits=2),nrow=5)

#loop over columns
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}

print (m) #does the same but with columns

# loop over rows and columns with double for loop

m <- matrix(round(runif(20),digits=2),nrow=5)
for(i in 1:nrow(m)) { #start of outer loop
  for (j in 1:ncol(m)) { #start of inner loop
    m[i,j] <- m[i,j] + i + j
  } #end of inner (column) loop
} #end of outer (row) loop

print(m)
