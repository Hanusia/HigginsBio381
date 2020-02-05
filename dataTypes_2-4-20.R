#Computational Bio notes: Basic examples of data types and their uses
#Feb. 4th, 2020
#Hanusia Higgins

# -------------------------------------------------------------------------

#using the assignment operator
x <- 5 #preferred way
y = 4 #legal but not preferred except in function deafults
print(y) #use this instead of just 'y' in general! (will always work)

# -------------------------------------------------------------------------

# variable names
z <3 #use lower case to start the name of a variable
plantHeight <- 3 #camel case naming (b/c it has a "hump"- but this isn't the easiet to read)
plant.height <- 3 #AVOID periods b/c they can be used in other ways
plant_height <3 #snake case- preferred: use the underscore between words, all lowercase
. <- 3 #use a single period for the name of a temporary variable?


# -------------------------------------------------------------------------

#combine or concatenate function
z <- c(3.2, 5, 5, 6)
typeof(z)
is.numeric(z)
is.character(z)

#character variable bracketed by quotes (single or double)
z <- c("perch", "striped bass", 'trout')
print(z)
typeof(z)

z <- c("this is one 'character string'", "and another") #can utilize single quotes inside double quotes
print(z)

z<- c(c(2,3), c(4.4,6))
print(z) #c() "flattens" the above command into a simple, 4-element atomic vector
z <- c(TRUE,FALSE,FALSE)
print(z)
typeof(z)

# -------------------------------------------------------------------------

#properties of atomic vectors:
#has a unique type
typeof(z)
is.logical(z)

#has a specified length
length(z)

#optional: names
z <- runif(5)
print(z)
names(z)
names(z) <- c("chow",
              "pug",
              "beagle",
              "greyhound",
              "akita")
names(z)
print(z)
z[3] #single element
z["beagle"] #using its name
z[c("beagle","greyhound")] #multiple elements
z[c(3, 3, 3)] #can call multiple "copies" of the same element

#add names when varaible is first built (with or without quotes)
z2 <- c(gold=3.3, silver=10, lead=2) #name doesn't have to be in quotes in initial assignment.
print(z2)

#reset names
names(z2) <- NULL
print(z2)

#name some elements, but not others
names(z2) <- c("copper", "zinc")
print(z2)
names(z2[3])
names(z2[2])

# -------------------------------------------------------------------------

#NA for missing data
#use this in data files to represent missing data- INSTEAD OF 0
z <-c(3.2, 3.3, NA)
typeof(z) #doesn't clue you in about the NA w/in z
typeof(z[3]) #type is STILL double, even though it's an NA
z[3]
z[1]
z[4]

z1 <- NA
typeof(z1) #returns: logical. is this the default type for NA data?
#Boolean to find NA:
is.na(z) #returns logical values for each element in the vector!
!is.na(z) #flips the results (makes it opposite: ! = "not")

mean(z) #R cannot calculate the mean of a vector that has a missing value
mean(!is.na(z)) #WRONG because...it actually is just dividing the # of not-NA values by total # of values b/c it's converted the values to 0s and 1s as booleans.
mean(z[!is.na(z)]) #changed order of operation to make it work correctly via subsetting

# Nan, -Inf, Inf from numeric division
z <- 0/0
print(z) #NaN means "not a number" (undefined result)
typeof(z)
z <- 1/0
print(z) #Inf means positive infinity
z<- -1/0
print(z) # -Inf means negative infinity

#null is nothing
z<- NULL
print(z)
typeof(z)
length(z)
is.null(z)

# -------------------------------------------------------------------------

# Three features of atomic vectors

# 1. Coercion
# All atomics are of the same type
# If elements are different, R "coerces" them to be the same
# logical -> integer -> double -> character

z <- c(0.1, 5, "O.2")
typeof(z)
print(z) #the numbers have all been coerced into characters

#use coercion for useful calculations
a <- runif(10)
print(a)
a > 0.5
sum(a>0.5) #"sum" function expects a numeric value, so it coerces the logical into integers
mean(a > 0.7) #finds the PROPORTION of elements in a that are >0.7

#qualifying exam question for PhD students:
#in a normal distribution, approximately what percent of observations 
#from a normal (0,1) are larger than 2.0?

mean(rnorm(100000)>2)

# 2. Vectorization
z <- c(10, 20, 30)
z + 1 #R carries out this operation on each element in the vector
z2 <- c(1,2,3)
z+z2 #adding the first element of each vector together, then the second, etc...

# 3. Recycling
#What happens if we try an operation where vectors are not of equal length?
z <- c(10,20,30)
z2 <- c(1, 2)
z+z2
