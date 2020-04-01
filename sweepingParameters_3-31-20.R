# --------------------------------------------------
# writing functions for equations 
# and sweeping over parameters
# 31 Mar 2020
# HH
# --------------------------------------------------
#
library(ggplot2)

# S=cA^2 describes species-area relationship

# --------------------------------------------------
# FUNCTION species_area_curve
# description: creates a power function for S and A
# inputs: A is a vector of island areas
#         c is the intercept constant
#         z is the slope constant 
# outputs: S is a vector of species richness
####################################################
species_area_curve <- function(A=1:5000,
                               c=0.5,
                               z=0.26) {

S <- c*(A^z)

return(S)

} # end of species_area_curve
#---------------------------------------------------
head(species_area_curve())

# --------------------------------------------------
# FUNCTION species_area_plot
# description: plots species area curves w/ parameter values
# inputs: A = vector of areas 
#         c = single value for c parameter
#         z = single value for z parameter
# outputs: smoothed curve w/ parameters printed in graph
####################################################
species_area_plot <- function(A=1:5000,
                              c=0.5,
                              z=0.26) {

  plot(x=A,y=species_area_curve(A,c,z),
       type="l",
       xlab="Island Area",
       ylab="S",
       ylim=c(0,2500))
  mtext(paste("c=",c," z=",z), cex=0.7)

} # end of species_area_plot
#---------------------------------------------------
species_area_plot()


# build a grid of plots!

# global variables
#can adjust these & keep running the same loop 
#with updated values
c_pars <- c(100,150,175)
z_pars <- c(0.10,0.16,0.26,0.30)
par(mfrow=c(4,3)) #setting parameters for the graphics space

for (i in seq_along(c_pars)) { #start of outer loop
  for (j in seq_along(z_pars)) { #start of outer loop
    species_area_plot(c=c_pars[i],z=z_pars[j])
  } #end of inner loop
} #end of outer loop
#outputs: each graph represents a different combo
#of c and z values


# expand.grid -------------------------------

#generates a dataframe as output
#each row of the dataframe corresponds to a different
#combination of parameters
expand.grid(c_pars,z_pars)

# --------------------------------------------------
# FUNCTION sa_output
# description: summary stats for species-area power function
# inputs: vector of predicted species richness values
# outputs: list of max-min, coefficient of variation
####################################################
sa_output <- function(S=runif(1:10)) {

  sum_stats <- list(s_gain=max(S)-min(S),
                    s_cv=sd(S)/mean(S))

  return(sum_stats)
  
} # end of sa_output
#---------------------------------------------------
sa_output()

# build program body -------------------------------

# Global variables
Area <- 1:5000
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.30)

# set up model data frame
model_frame <- expand.grid(c=c_pars,z=z_pars)
print(model_frame)
str(model_frame)

#now adding variables to the dataframe:
model_frame$SGain <- NA
model_frame$SCV <- NA
head(model_frame)

# cycle through model calculations
for (i in 1:nrow(model_frame)) {
  
  #generate S vector
  temp1 <- species_area_curve(A=Area,
                              c=model_frame[i,1],
                              z=model_frame[i,2])
  
  # calculate output status
  temp2 <- sa_output(temp1)
  
  # pass results to columns in data frame
  model_frame[i,c(3,4)] <- temp2
  
}
print(model_frame) #output dataframe!

# parameter sweep redux with ggplot graphics

area <- 1:5
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.30)

# set up model frame
model_frame <- expand.grid(c=c_pars, 
                           z=z_pars,
                           A=area)
head(model_frame)
length(model_frame)
nrow(model_frame)

# add response variable
model_frame$S <- NA

# loop through parameters and fill with sa function

for (i in 1:length(c_pars)) {
  for (j in 1:length(z_pars)) {
    model_frame[model_frame$c==c_pars[i] & 
                  model_frame$z==z_pars[j], "S"] <-
      species_area_curve(A=area,c=c_pars[i], z=z_pars[j])
  }
}
head(model_frame) #modified w/ previous for loop

#plotting w/ ggplot!
p1 <- ggplot(data=model_frame)
p1 + geom_line(mapping=aes(x=A,y=S)) +
  #facet_grid knows to do combos of c & z
  facet_grid(c~z)

p2 <- p1
p2 + geom_line(mapping=aes(x=A,y=S,group=z)) +
  facet_grid(.~c)
#this results in 3 plots, 1 w/ each value of c
#w/in each plot are 4 lines each representing a val of z

p3 <- p1
p3 + geom_line(mapping=aes(x=A,y=S,group=c)) +
  facet_grid(z~.)
#this one does the reverse of previous