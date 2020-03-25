# --------------------------------------------------
# Booleans and if/else control structures
# 24 Mar 2020
# HH
# --------------------------------------------------
#
# review of Boolean operators -------------------------------

# simple inequality
# uses logical operators
5 > 3
5 < 3
5 >= 5
5 <= 5
5 == 3
5 != 3

# compound statements use & or |

# use & for AND
FALSE & FALSE = FALSE
TRUE & TRUE = TRUE
TRUE & FALSE = FALSE
5 > 3 & 1 != 2 #OUTCOME = TRUE
1==2 & 1!=2 #outcome = FALSE b/c 1st statement is false

# use | for OR
FALSE | FALSE = FALSE
TRUE | TRUE = TRUE
FALSE | TRUE = TRUE
1==2 | 1!=2 #OUTCOME = TRUE

# Boolean operators work with vectors

1:5 > 3 #returns a vector of Boolean values

a <- 1:10
b <- 10:1

a > 4 & b > 4 #runs through both vectors comparing them
sum(a > 4 & b > 4) #tallies the TRUEs, coercing Booleans to numeric values

# "long" form evaluates only the first element

# evaluate all elements and give a vector of T/F
a < 4 & b > 4

#evaluate & return only the FIRST comparison that gives a Boolean
a < 4 && b > 4

# also a long form for or: ||

# vector result
a<4 | b>4

# a single boolean result
a < 4 || b > 4 #just returns the first comparison result

# xor for exclusive "or" testing of vectors
# fors for (TRUE FALSE) but NOT for (TRUE TRUE) or (FALSE FALSE)

a <- c(0,0,1)
b <- c(0,1,1)

xor(a,b) #returns TRUE only for (0,1), not (0,0) or (1,1)

# by comparison with ordinary | 

a | b #returns FALSE TRUE TRUE

# Set operations -------------------------------

# boolean algebra on sets of atomic vectors
# (numeric, logical, character strings)

a <- 1:7
b<- 5:10

# union to get all elements (OR for a set)
union(a,b) # returns 1:10

# intersect to get shared/common elements (AND for a set)
intersect(a,b) #returns 5:7 (the overlap)

#setdiff is kind of the opposite of intersect

# setdiff to get distinct elements in a
setdiff(a,b) #returns 1:4

# setdiff to get distinct elements in b
setdiff(b,a) #returns 8:10

# setequal to check for identical elements
setequal(a,b) #returns FALSE because these are not identical

# more generally, to compare any two objects
z <- matrix(1:12, nrow=4, byrow=TRUE)
z1 <- matrix(1:12, nrow=4, byrow=FALSE)

# this just compares element by element
z==z1

identical(z,z1) #what is the dif between identical and setequal???
z1 <- z
identical(z,z1)

# most useful in if statements is %in% or is.element
# These are equivalent, but I prefer %in% for readability

d <- 12
d %in% union(a,b) #this phrase and the next are equivalent
is.element(d,union(a,b))

a <- 2
a==1 | a==2 | a==3 #this is not ideal
a %in% c(1,2,3) #this does the same thing, more cleanly

# check for partial matching with vector comparisons
a <- 1:7

d <- c(10,12)
d %in% union(a,b) #returns TRUE, FALSE
#b/c each element of d is compared, one at a time, to the union of a and b
d %in% a

# if statement -------------------------------

# anatomy of if statements

# if (condition) expression

# if (condition) expression1 else expression2

# if (condition1) expression1 else
# if(condition2) expression2 else
# expression3

# the final unspecified else captures rest of 
# unspecified conditions
# else statement MUST appear on the same line as 
# previous expression
# instead of single expression, can use curly brackets 
# to execute a set of lines when condition is met

z <- signif(runif(1), digits=2)
print(z)

# simple if statement with no else (no alternative if condition is not met)
if (z > 0.5) cat(z, "is a bigger than average number",
                 "\n")

# compount if statement with 3 outcomes (2 if statements)
if(z>0.8) cat(z, "is a large number", "\n") else
  if(z<0.2) cat(z, "is a small number","\n") else
    {cat(z,"is a number of typical size","\n")
      cat("z^2=",z^2,"\n")}

# if statement wants a single boolean value (TRUE or FALSE)
# if you give an if statement a vector of booleans,
# it will only operate on the very first element in that vector

z <- 1:10

# this does not do anything
if (z>7) print(z)

#probably not what you want
if (z<7) print(z)

#instead...use subsetting!
print(z[z<7])

# ifelse function -------------------------------

# ifelse(test,yes,no)
# "test" is an object that can be coerced into a logical
# TRUE/FALSE
# "yes" returns values for true elements in the test
# "no" returns values for false elements in the test

# suppose we have an insect population in which each
# female lays, on average, 10.2 eggs, following a Poisson
# distribution. lambda=10.2. However, there is a 35% chance
# of parasitism, in which case, no eggs are laid. Here is a
# random sample of eggs laid for a group of 1000 individuals.

tester <- runif(1000) # start with random uniform elements
eggs <- ifelse(tester>0.35,rpois(n=1000,lambda=10.2),0)
hist(eggs)

# suppose we have a vector of probability values (perhaps 
# from a simulation). We want to highlight significant
# values in the vector for plotting

p_vals <- runif(1000)
z <- ifelse(p_vals<0.025,"lower_tail","non_sig")
z[p_vals>=0.975] <- "upper_tail" #assigning a label!
table(z) #looking @ the number of values in each category

# Here is how I would do it

z1 <- rep("non_sig",1000)
z1[p_vals<=0.025] <- "lower_tail" #subsetting
z1[p_vals>=0.975] <- "upper_tail" #subsetting
table(z1)
