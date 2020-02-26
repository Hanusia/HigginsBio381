# More probability distributions (continuous ones this time!)
# Computational Bio
# 20 February 2020
# Hanusia Higgins

library(ggplot2)
library(MASS)

# Uniform -----------------------------------------------------------------

qplot(x=runif(n=100,min=1,max=6),
              color=I("black"),
              fill=I("goldenrod"))

qplot(x=runif(n=1000,min=1,max=6), #increasing the sample size......
      color=I("black"),
      fill=I("goldenrod"))

qplot(x=sample(1:6,size=1000,replace=TRUE))

# Normal ------------------------------------------------------------------


my_norm <- rnorm(n=100,mean=100,sd=2) # 2 parameters are mean and sd

qplot(x=my_norm,
      color=I("black"),
      fill=I("goldenrod"))

# problems with normal distribution when mean is small
# b/c it has a lot of negative values...which can be a problem...
my_norm <- rnorm(n=100,mean=2,sd=2) # 2 parameters are mean and sd

qplot(x=my_norm,
      color=I("black"),
      fill=I("goldenrod"))

toss_zeroes <- my_norm[my_norm>0] #getting rid of negative values

qplot(x=toss_zeroes,
      color=I("black"),
      fill=I("goldenrod"))

mean(toss_zeroes) #mean has increased b/c the lower end was truncated
sd(toss_zeroes) #the SD also changed which is also bad

#so instead of just tossing negative values 
#when you can't use them w/ a low mean,
#switch to a different distribution.........

# Gamma -------------------------------------------------------------------

#use for continuous data that is all greater than zero
my_gamma <- rgamma(n=100,shape=1,scale=10)
qplot(x=my_gamma,
      color=I("black"),
      fill=I("goldenrod"))

#gamma with shape = 1 is an exponential distribution with scale = mean
my_gamma <- rgamma(n=100,shape=1,scale=0.1)
qplot(x=my_gamma,
      color=I("black"),
      fill=I("goldenrod"))

#increasing shape parameter means the distribution looks more normal
my_gamma <- rgamma(n=100,shape=20,scale=1)
qplot(x=my_gamma,
      color=I("black"),
      fill=I("goldenrod"))

#scale parameter changes both the mean AND the variance of our distribution...
#mean = shape * scale
#variance = shape * scale^2

# Beta --------------------------------------------------------------------

#useful for a lot of probability models

#beta dist is continuous, but bounded between 0 and 1

#analagous to binomial, 
#but with a continuous distribution of possible values

# p(data|parameters)
# the probability of the data, given the parameters

#opposite from the way we usually think a lot of the time: p(parameters|data)
#this is more like a maximum likelihood estimator of the parameters

#shape1 = number of successes + 1
#shape2 = number of failures + 1

my_beta <- rbeta(n=1000,shape1=5,shape2=5) 
#in this situation, we got "heads" 4 times and "tails" 4 times
qplot(x=my_beta,
      color=I("black"),
      fill=I("goldenrod"))
#this distribution is so broad because we don't have much data
#only 4 heads and 4 tails...it's not so unlikely to get something else

my_beta <- rbeta(n=1000,shape1=50,shape2=50) 
qplot(x=my_beta,
      color=I("black"),
      fill=I("goldenrod"))

# beta with 3 heads and no tails
my_beta <- rbeta(n=1000,shape1=4,shape2=1) 
qplot(x=my_beta,
      color=I("black"),
      fill=I("goldenrod"))
#the distribution of this one is biased toward heads!

my_beta <- rbeta(n=1000,shape1=200,shape2=1) 
qplot(x=my_beta,
      color=I("black"),
      fill=I("goldenrod"))

#shape and scale less than 1.0 gives a u-shaped curve
my_beta <- rbeta(n=1000,shape1=0.2,shape2=0.1)
qplot(x=my_beta,
      color=I("black"),
      fill=I("goldenrod"))

# Estimate parameters from data -------------------------------------------

x <- rnorm(1000,mean=92.5,sd=2.5)
qplot(x=x,
      color=I("black"),
      fill=I("goldenrod"))

#this function has 2 inputs: 1) a vector of numbers, 
#2) the name of the distribution you are fitting the data to
fitdistr(x,"normal")
#this is its best estimate of what those parameters would be, 
#plus a confidence/error interval
fitdistr(x,"gamma") #this gives us best guesses for shape and rate
#simulating the distribution with the given parameters
#suggested for the gamma distribution:
x_sim <- rgamma(n=1000,shape=1298.98,rate=14.03)
qplot(x=x_sim,
      color=I("black"),
      fill=I("goldenrod"))


# Regression analysis -----------------------------------------------------

n <- 50 #number of observations(rows)
var_a <- runif(n) #50 random uniforms (independent)
var_b <- runif(n) #dependent variable
var_c <- 5.5 + var_a*10 #tester variable to make sure this function works
id <- seq_len(n) #gives us a sequence from 1 to the length of n
reg_df <- data.frame(id,var_a,var_b,var_c)
str(reg_df)

#regression model
reg_model <- lm(var_c~var_a,data=reg_df) #do it w/ both b and c as response
reg_model #sparse output
str(reg_model)
head(reg_model$residuals)

#summary of model usually has what we want
summary(reg_model)
summary(reg_model)$coefficients
str(summary(reg_model))

z <- unlist(summary(reg_model))
z
#a way to consolidate the elements you want from the regression output:
reg_sum <- list(intercept=z$coefficients1,
                slope=z$coefficients2,
                intercept_p=z$coefficients7,
                slope_p=z$coefficients8,
                r2=z$r.squared)
print(reg_sum)

#now, if you want to know the intercept, just type:
print(reg_sum$intercept)

#can also add on to the list later!


#regression plot for data:
reg_plot <- ggplot(data=reg_df,
                   aes(x=var_a,y=var_c)) + #shift from var_b to var_c
                   geom_point() +
                   stat_smooth(method=lm,se=0.95)
print(reg_plot)

# Basic ANOVA -------------------------------------------------------------

n_group <- 3 #number of treatment groups
n_name <- c("Control","Treat1","Treat2")
n_size <- c(12,17,9)
#don't set up an experiment with less than 10 observations in each group!

n_mean <- c(40,41,60)
n_sd <- c(5,5,5)
t_group <- rep(n_name,n_size)
print(t_group)
table(t_group) #confirming the treatments are right

id <- 1:(sum(n_size))

#simulating data as the response variable:
res_var <- c(rnorm(n=n_size[1],mean=n_mean[1],sd=n_sd[1]),
             rnorm(n=n_size[2],mean=n_mean[2],sd=n_sd[2]),
             rnorm(n=n_size[3],mean=n_mean[3],sd=n_sd[3])) 
res_var

ano_data <- data.frame(id,t_group,res_var)
str(ano_data)

# ANOVA model -------------------------------------------------------------

ano_model <- aov(res_var~t_group,data=ano_data)
print(ano_model)
print(summary(ano_model))
z <- summary(ano_model)
str(z)
# aggregate(): apply the specified function to each group w/in the data set
aggregate(res_var~t_group,data=ano_data,FUN=mean)

unlist(z)
unlist(z)[7]
ano_sum <- list(Fval=unlist(z)[7], #based on looking at unlist(z)
                probF=unlist(z)[9])
print(ano_sum) #here is the small list we have created

# ggplot for anova data ---------------------------------------------------

ano_plot <- ggplot(data=ano_data, #plotting the anova results
                   aes(x=t_group, #by treatment group
                       y=res_var,
                   fill=t_group)) +
                   geom_boxplot() #specifies the type of graph we want
print(ano_plot)

#if we went back to change n_mean to 60 for each group,
#then there wouldn't be a significant dif between groups
#and that would be reflected in the ANOVA plot as well.

#the following command saves a copy of the plot to my working directory
ggsave(filename="Plot2.pdf",plot=ano_plot,device="pdf")

# data frame for logistic regression --------------------------------------

#discrete y variable (0,1), continuous x variable

#"sort" function puts values in consec. order
x_var <- sort(rgamma(n=200,shape=5,scale=5)) 
head(x_var)
#y_var will sample a vector made of: 100 "0" followed by 100 "1"
#with "prob" weighting it (higher weights as we go further in the sequence)
#I don't exactly understand how that part is working...but will produce 
#something like: 0 0 0 0 1 0 1 0 1 1 1 0 1 1 1 1 
y_var <- sample(rep(c(0,1),each=100),prob=seq_len(200))
head(y_var)

l_reg_data <- data.frame(x_var,y_var)

# logistic regression code ------------------------------------------------

#glm() is "general linear model," an anova-like model
l_reg_model <- glm(y_var ~ x_var,
                   data=l_reg_data,
                   family=binomial(link=logit)) #???

summary(l_reg_model)
summary(l_reg_model)$coefficients

# basic ggplot of logistic regression data --------------------------------

lreg_plot <- ggplot(data=l_reg_data,
                    aes(x=x_var,y=y_var)) +
             geom_point() +
             stat_smooth(method=glm,
                         method.args=list(family=binomial))

print(lreg_plot)

# contingency table data --------------------------------------------------

# both x and y variables are discrete ( = counts)
#integer counts of different groups
vec_1 <- c(50,66,22)
vec_2 <- c(120,22,30)
data_matrix <- rbind(vec_1,vec_2) #note: it's a matrix, not a dataframe
rownames(data_matrix) <- c("Cold","Warm")
colnames(data_matrix) <- c("Aphaenogaster",
                           "Camponotus",
                           "Crematogaster")

str(data_matrix)
data_matrix

# simple association test -------------------------------------------------

print(chisq.test(data_matrix))
#p-val is highly significant
#this means that the relative frequency of each species differs
#in the cold vs. warm habitat

# plotting contingency data -----------------------------------------------

#base R graphics

#in this plot, the size of each tile illustrates relative freq. of each group
mosaicplot(x=data_matrix,
           col=c("goldenrod","grey","black"),
           shade=FALSE)

#another way to visualize the data: here, portraying counts
barplot(height=data_matrix,
        beside=TRUE,
        col=c("cornflowerblue","tomato"))

#now using ggplot graphics

library(dplyr)
library(tidyverse)

d_frame <- as.data.frame(data_matrix) #coerces the matrix into a df
str(d_frame)

d_frame <- cbind(d_frame,list(Treatment=c("Cold","Warm")))

#Lauren will cover this code...later
#gather() is actually a function in dplyr
d_frame <- gather(d_frame,
                  key=Species,
                  Aphaenogaster:Crematogaster,
                  value=Counts)
data_matrix 
#"wide form" includes aggregate summary variables as part of matrix

#vs. "long form" includes the associated labels for each data point
#labels each data point w/ the species & the treatment, included as variable

head(d_frame)

#created a similar graph in ggplot as we did w/ the base R graphics
p <- ggplot(data=d_frame,
            aes(x=Species,y=Counts,fill=Treatment)) +
   geom_bar(stat="identity",
            position="dodge",
            color=I("black")) +
            scale_fill_manual(values=c("cornflowerblue","coral"))
print(p)
