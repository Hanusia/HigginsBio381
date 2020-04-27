# --------------------------------------------------
# Basics of ggplot grammar and graphics
# 08 Apr 2020
# HH
# --------------------------------------------------
#

# 1. data (in a data frame)
# 2. aesthetic mapping (variables are mapped to an aesthetic)
# 3. geom (geometric object used to draw the layer; 
#    points, bars, polygons, etc.)
# 4. stat (raw data and transforms it for somehing useful
#    in a plot- like a confidence interval, etc.)
# 5. position (adjust points for overplotting) 
# 6. facet function

# template for ggplot components -------------------------------

# p1 <- ggplot(data= <DATA>,
#              mapping=aes(<MAPPING>)) +
#       <GEOM_FUNCTION(mapping=aes(<MAPPING),
#                       stat=<STAT>,
#                       position=<POSITION>) +
#       <COORDINATE_FUNCTION> +
#       <FACET_FUNCTION>
# print(p1)
# ggsave(plot=p1, filename="MyPlot",
#        width=5, height=3, units="in", device="pdf")

# Preliminaries -------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("doubling time")

d <- mpg #use built in data set

str(d)

table(d$fl)

# fast plotting with qplot -------------------------------

# basic histogram
qplot(x=d$hwy)
#defaults to grayscale colors
qplot(x=d$hwy, fill=I("tan"), color=I("black"))


# make your own custom histogram function
my_histo <- function(x_var,fil, fil_col="goldenrod"){
  qplot(x=x_var,color=I("black"),fill=I(fil_col))
}

my_histo(d$hwy)
my_histo(d$hwy, "thistle")

# basic density plot
qplot(x=d$hwy,geom="density")

# basic scatter plot
qplot(x=d$displ,
      y=d$hwy,
      geom=c("smooth","point"),method="lm")

# basic boxplot
qplot(x=d$fl, y=d$cty, geom="boxplot", fill=I("tan"))

# basic barplot ("long format")
qplot(x=d$fl, geom="bar", fill=I("tan"))

# common mistake!!
qplot(x=d$fl,geom="bar",fill="tan") #this doesn't do what you want it to

# bar plot with specified counts or means ("short format")
x_treatment = c("Control","Low", "High")
y_response = c(12,2.5,22.9)
qplot(x=x_treatment, y=y_response, geom="col",
      fill=I(c("grey20", "grey50", "grey90")))

# basic curves and functions
my_vec <- seq(1,100,by=0.1)
head(my_vec)
my_fun <- function(x) sin(x) + 0.1*x

#built in function
qplot(x=my_vec,y=sin(my_vec),geom="line")

#density functin for stats
qplot(x=my_vec,y=dgamma(my_vec,shape=5,scale=3),geom="line")
qp

#user defined function
qplot(x=my_vec,y=my_fun(my_vec), geom="line") 

# Themes and fonts -------------------------------

p1 <- ggplot(data=d,
             mapping=aes(x=displ,y=cty)) +
      geom_point()
print(p1)

p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_base()
p1 + theme_void()
p1 + theme_economist()
p1 + theme_bw()
p1 + theme_grey() #default theme for ggplot

# Major theme modifications -------------------------------

#changing the sizes of multiple factors at once
p1 + theme_classic(base_size=40)
p1 + theme_classic(base_family="serif")

# defaults: theme_Grey, base_size=16, base_family="Helvetica"

# default font families (Mac): Times, Arial, Monaco,
# Courier, Helvetica, serif, sans

# use coordinate_flip to invert entire plot

p2 <- ggplot(data=d,mapping=aes(x=fl, fill=fl)) +
      geom_bar()
print(p2)

p2 + coord_flip()

# Minor theme modifications -------------------------------

p1 <- ggplot(data=d,
             mapping=aes(x=displ,y=cty)) +
      geom_point(size=7,shape=21,
                 color="black",fill="steelBlue") +
      labs(title="My graph title here",
           subtitle="An extended subtitle that will print below the main title",
           x='My x axis label',
           y='My y axis label') +
      xlim(0,4) +
      ylim(0,20)
print(p1)




