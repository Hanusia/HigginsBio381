#more notes on data types in R- continued
#working with matrices, lists, and data frames
#Hanusia Higgins
#Feb. 11, 2020

# -------------------------------------------------------------------------

library(ggplot2)


# Matrices ----------------------------------------------------------------

#a matrix is just an atomic vector reorganized into two dimensions!
#create a matrix with matrix function
m <- matrix(data=1:12, nrow=4, ncol=3)
print(m)
#could also do it this way and get the same result:
m <- matrix(data=1:12,nrow=4)

#use byrow=TRUE to change filling direction
#default is to fill in by column
m <- matrix(data=1:12,nrow=4, byrow=TRUE)
print(m)

#a matrix has dimensions: can use dim() function find out the dimensions
dim(m) #spits out: nrow ncol
#can also use it to change dimensions of a matrix
dim(m) <- c(6,2) #for this to work, nrow*ncol MUST equal the length of the vector
print(m) #the order of the numbers looks "messed up"

dim(m) <- c(4,3)
print(m)

#individual row and column dimensions
nrow(m)
ncol(m)

#length of atomic vector is still there!
length(m) #so this command still works

#add names
rownames(m) <- c("a","b","c","d")
print(m)
colnames(m) <- LETTERS[1:ncol(m)]
print(m)
rownames(m) <- letters[nrow(m):1]
print(m)

#grabbing an entire atomic vector
z <- runif(3)
z[]

#specify rows and columns, separated by a comma
m[2,3]

#choose row 2 and all columns
m[2,]
m[,3]

#print everything
print(m)
print(m[])
print(m[,])

#dimnames requires a list
dimnames(m) <- list(paste("site",1:nrow(m),sep=""),
                    paste("Species",1:ncol(m),sep="_"))
print(m)

#transpose a matrix
m2 <- t(m)
print(m2)

#add a row to a matrix with rbind()
m2 <- rbind(m2, c(10,20,30,40))
print(m2)
rownames(m2) #goal: name the last row that we just added ("bound") to the matrix

#call the function to get the atomic
rownames(m2)[4] <- "myfix"
rownames(m2)
print(m2)

#access rows and columns with names as well as index numbers
m2["myfix","Site3"]
m2[4,3]
m2[c("myfix","Species_1"),c("site2","site2")] #flexibility

# cbind() will add a column to a matrix

my_vec <- as.vector(m)
print(my_vec)


# Lists -------------------------------------------------------------------

#Lists are like atomic vectors (1-dimensional), but each element can hold 
#different things of different types and sizes

my_list <- list(1:10,
                matrix(1:8,nrow=4,byrow=TRUE),
                letters[1:3],
                pi)

str(my_list)

# try grabbing one of our list components
my_list[4]
my_list[4] - 3
typeof(my_list[4])
#single brackets always return a list from a list!

typeof(my_list[[4]])
my_list[[4]] - 3

##double bracket always extracts a single element of the correct type

#if a list has 10 elements it is like a train with 10 cars
#[[5]] gives me the contents of car no. 5
#[5] gives me the whole 5th train car
# [c(4,5,6)] gives me a little train with cars 4, 5, and 6

print(my_list)
my_list[[2]][2,2]

#name list items as we create them
my_list2 <- list(Tester=FALSE,
                 little_m=matrix(runif(9),nrow=3))
print(my_list2)

my_list2$little_m[2,3]
my_list2$little_m
t(my_list2$little_m)
my_list2$little_m[2,]
my_list2$little_m[2]

#using a list to access output from a linear model
y_var <- runif(10)
x_var <- runif(10)
my_model <- lm(y_var ~ x_var)
qplot(x=x_var, y=y_var)
print(my_model)
summary(my_model)
str(summary(my_model))

#use the unlist() function to flatten the output
z <- unlist(summary(my_model),recursive=TRUE)
print(z)
my_slope <- z$coefficients2
my_pval <- z$coefficients8
print(c(my_slope,my_pval))


# Data Frames -------------------------------------------------------------

#data frame is a list of equal-lengthed vectors, each of which is a column in a data frame.

#a data frame differs from a matrix only in that different columns may be of different data types.

var_a <- 1:12
var_b <- rep(c("Con","LowN","HighN"),each=4)
var_c <- runif(12)
d_frame <- data.frame(var_a,var_b,var_c,stringsAsFactors=FALSE)
print(d_frame)

#first column in a data frame SHOULD be an ID variable to reference each row

head(d_frame)
str(d_frame)

#adding a new row as a formatted list
new_data <- list(var_a=13,var_b="HighN",var_c=0.668)
d_frame = rbind(d_frame,new_data)
print(d_frame)

#adding a new column is easier b/c it's all one data type!
#add it as an atomic vector:

new_var <-runif(nrow(d_frame))
d_frame = cbind(d_frame,new_var)
print(d_frame)

#dplyr has more advanced tools for working with data sets
