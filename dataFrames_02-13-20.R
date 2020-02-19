# Finishing data frames, lists
# Formatting data 
# 13 Feb 2020
# Hanusia Higgins

# -------------------------------------------------------------------------

#matrices and data frames similarities and differences
z_mat <- matrix(data=1:30,ncol=3,byrow=TRUE)
z_dataframe <- as.data.frame(z_mat)

#structure
str(z_mat) #30 obs of integers
str(z_dataframe) #10 obs each w/in 3 variables (columns are classified as variables)

#appearance
head(z_mat)
head(z_dataframe)

#element referencing
z_mat[2,3]
z_dataframe[2,3]

#column referencing
z_mat[,2]
z_dataframe[,2]
z_dataframe$V2 #does the same thing as previous line

#rows referencing
z_mat[2,]
z_dataframe[2,]

#specifying single elements is different
z_mat[2] #matrix has an underlying atomic vector #AKA: z_mat[1,2]
z_dataframe[2] #but for the dataframe, it grabs the whole second column # AKA: z_dataframe$V2


#complete.cases for scrubbing atomic vectors

zD <- c(runif(3),NA,NA,runif(2))
zD

complete.cases(zD) #use this tool to get what we want
zD[complete.cases(zD)] #this is what we want!

m <- matrix(1:20,nrow=5)
m[1,1] <- NA
m[5,4] <- NA
print(m)

#sweep out all rows with missing values
m[complete.cases(m),]

# get complete cases for only certain columns!
m[complete.cases(m[,1:2]),] #drop row #1 b/c it's only looking @ rows 1 and 2 to test "complete cases"
m[complete.cases(m[,c(2,3)]),] #don't exclude anything b/c there are not missing values in columns 2 or 3
m[complete.cases(m[,c(4,3)]),] #drop row #4
m[complete.cases(m[,c(1,4)]),] #should drop both rows w/ the missing values

#techniques for assignments and subsetting matrices and data frames

m <- matrix(data=1:12,nrow=3)
dimnames(m) <- 
  list(paste("Species",LETTERS[1:nrow(m)],sep=""),
       paste("Site",1:ncol(m),sep=""))
print(m)

m[1:2,3:4]
m[c("SpeciesA","SpeciesB"),c("Site3","Site4")]

#use blanks to pull all rows or columns
m[c(1,2),]
m[,c(1,2)]

#use logicals for more complex subsetting
#e.g. select all columns that have totals > 15

colSums(m) > 15
m[, colSums(m) > 15]

#select all rows for which row total equal 22

m[rowSums(m)==22,]

m[, "Site1"]<3
m["SpeciesA",]<5
m[m[,"Site1"]<3,m["SpeciesA",]<5]

#CAUTION: simple subscripting can change data type!!

z <- m[1,]
print(z)
str(z)

#use drop=FALSE to retain dimensions
z2 <- m[1, ,drop=FALSE]
str(z2)

#basic format is a csv file
#can create data set in a plaintext editor in R

#basic format is a csv file

# -------------------------------------------------------------------------

my_data <- read.table(file="firstData_2-13-20.csv",
                      header=TRUE,
                      sep=",",
                      stringsAsFactors=FALSE)
str(my_data)

#Nick says: don't save R objects as csvs....Instead,

saveRDS(my_data, file="my_DSobject")

z <- readRDS("my_RDSojbect")

# -------------------------------------------------------------------------

#what is data curation?

#editing w/in the eexcel file itself!















