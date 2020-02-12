#atomic vectors notes cont'd.
#6 Feb. 2020
#Hanusia Higgins

# -------------------------------------------------------------------------

#create empty vector, specify its mode and length
z <- vector(mode='numeric', length=0)
z <- c(z,5)
print(z)
#dynamic sizing: 
#the size of the vector will change as we add elements to it (don't do this!!)
#it's slow when it's inside of the loop

#preferred: preallocate space to a vector
z <- rep(0,100)
head(z)

#fill with NA values
z <- rep(NA,100) #ready to start working with it
typeof(z)
z[1] <- "Washington"
typeof(z)

#if you're not sure how long your vector should be, just overestimate- can clean it up later

v_size <- 100
my_vector <- runif(v_size)
my_names <- paste("Species",seq(1:length(my_vector)), sep="")
head(my_names)
names(my_vector) <- my_names
head(my_vector)

#rep function for repeating elements
rep(0.5,6)
?rep
rep(x=0.5, times=6)
my_vec <- c(1,2,3)
rep(x=my_vec,times=2) #can use this function to repeat an entire vector
rep(x=my_vec,each=2) #can specify repeating EACH element instead of collating
rep(x=my_vec,times=my_vec)
rep(x=my_vec,each=my_vec) #R gives a warning- just uses the first element of my_vec for "each"

#using seq to create regular sequences
seq(from=2, to=4)
2:4 #the colon is an 'inline operator'
`:`(2,4) #but can make it explicit by doing it this way
seq(from=2,to=4,by=0.5)
x <- seq(from=2,to=4,length=7)
print(x)
my_vec <- 1:length(x)
seq_along(my_vec)

#using random number generators
runif(5)
runif(n=5,min=100,max=110)

#rnorm for normal distributions
rnorm(6)
rnorm(n=5, mean=100, sd=30)

library(ggplot2)
z <- runif(1000)
qplot(x=z)

z <- rnorm(1000)
qplot(x=z)

#use the sample function to draw random values from an existing vector
long_vec <- seq_len(10)
print(long_vec)
sample(x=long_vec)
sample(x=long_vec,size=3)
sample(x=long_vec,size=16, replace = TRUE)

my_weights <- c(rep(20,5), rep(100,5)) #setting up a vector for the probability that each element will be chosen!
print(my_weights) 
sample(x=long_vec,replace=TRUE,prob=my_weights) #weighting each element differently

#techniques for subsetting atomic vectors

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)

#subset with positive index values
z[c(2,3)]

#subset with negative values
z[-c(1,5)]

#create a logical vector of conditions for subsetting
z[z<3]

tester<- z<3
print(tester)
z[tester]

#which function to find slots
which(z<3) #returns the index markers IN your vector that are less than 3
z[which(z<3)] #feels redundant to just subsetting z[z<3]

#use length for relative positioning
z[-c(length(z):(length(z)-2))] #returns all EXCEPT the final 2 elements of the vector

#can also subset using named vector elements
names(z) <- letters[1:5]
z
z[c("b","b")]

#relational operators: I know these!

#logical operators
# ! NOT
# & and (vector)
# | or (vector- INCLUDES "a or b")
# xor(a,b) #EXCLUDES "a and b"
# && and (only operates on the FIRST element of the vector)
# || or (only operates on the first element of the vector)

x <- 1:5
y <- c(1:3, 7, 7)
x == 2
x != 2
x == 1 & y == 7
x == 1 | y == 7
x == 3 | y == 3
xor(x==3,y==3)
x == 3 && y == 3 #only evaluating the first element of each!

#subscripting with missing values
set.seed(90) #puts everyone's random number generators in line together
z <- runif(10)
z
z < 0.5
z[z<0.5]
z[which(z<0.5)]

zD <- c(z,NA,NA)
zD[zD<0.5] #includes the NAs
zD[which(zD<0.5)] #does not include the NAs (drops missing values)





