# structured programming: more
# 19 March 2020
#Computational Bio
#Hanusia Higgins

# -------------------------------------------------------------------------

#first, we're learning about SNIPPETS...


# getting input -----------------------------------------------------------

#command: fun creates the following ->

name <- function(variables) {
  
}

#which can then be used as a template to create the following

my_fun <- function(x=5) {
  z<- 5 + runif(1)
  return(z)
}

my_fun()

#we can create our OWN snippets!

#just created our own snippet called m_bar
#via: Tools -> Global Options -> Code -> Edit Snippets

#try using m_bar: (tab to return)
#######################################

#######################################

#now trying m_sec (another snippet I just created)
# section label -------------------------------

#"section label" is highlighted, able to replace it easily
#with whatever I want

#can also write snippets with code IN them!:
#end of video A

# get data -------------------------------

# load libraries -------------------------------

#now we're try m_head (which we just created)
#for set up of a new script

#the default is: 
# --------------------------------------------------
# script description
# 23 Mar 2020
# HH
# --------------------------------------------------
#

#so it actually looks like:
# --------------------------------------------------
# Tells what this script is about
# 23 Mar 2020
# HH
# --------------------------------------------------
#

#gonna create one more snippet: a "function" one
#here it is (default):
# --------------------------------------------------
# FUNCTION function_name
# description: description
# inputs: input_description
# outputs: output_description
####################################################
function_name <- function(x=5) {

# function body

return("Checking...function_name")

} # end of function_name
#---------------------------------------------------

#now with an example:
# --------------------------------------------------
# FUNCTION trial_funct
# description: one line explanation here
# inputs: just x=5 for now
# outputs: real number
####################################################
trial_funct <- function(x=5) {

# function body

return("Checking...trial_funct")

} # end of trial_funct
#---------------------------------------------------  
trial_funct()

