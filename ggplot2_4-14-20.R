# --------------------------------------------------
# ggplot multiple plots and aesthetics
# 14 Apr 2020
# HH
# --------------------------------------------------
#

# preliminaries -------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("crocus")
d <- mpg # use built-in mpg data set 

# multiple plots -------------------------------

# create a series of plots

g1 <- ggplot(data=d,
             mapping=aes(x=displ,y=cty)) +
             geom_point() +
             geom_smooth()

print(g1)

g2 <- ggplot(data=d,
             mapping=aes(x=fl,
                         fill=I("tomato"),
                         color=I("black"))) +
             geom_bar(stat="count")
             theme(legend.position="none") #removes legend

print(g2)

g3 <- ggplot(data=d,
             mapping=aes(x=displ,
                         fill=I("royalblue"),
                         color=I("black"))) +
             geom_histogram()

print(g3)

g4 <- ggplot(data=d,
             mapping=aes(x=fl,y=cty,fill=fl)) +
             geom_boxplot() +
             theme(legend.position="none") #removes legend

print(g4)

# use patchwork to combine plots -------------------------------

# place two plots horizontally
g1 + g2

# place 3 plots vertically
g1 + g2 + g3 + plot_layout(ncol=1)

# change relative area of each plot
#this line causes the plot on top to be twice as tall
#as the plot on the bottom
g1 + g2 + plot_layout(ncol=1, heights=c(2,1))

#the next line of code does the opposite with width:
g1 + g2 + plot_layout(ncol=2, widths=c(1,2))

# add a spacer plot (blank area in between plots)
g1 + plot_spacer() + g2

# use nested plots
#aka: fit 2 plots in the same "space" as another one
g1 + {
  g2 + {
    g3 + 
      g4 +
      plot_layout(ncol=1)
  }
} + 
  plot_layout(ncol=1)

# - operator for subtract element
#not sure if I understand this......
g1 + g2 - g3 + plot_layout(ncol=1)

# / and | for intuitive plot layouts
#this is so awesome!!!!
(g1 | g2 | g3)/g4

(g1 | g2)/(g3 | g4)

# Add title, subtitle to patchwork
g1 + g2 + plot_annotation ("This is a title",
                           caption='made with patchwork')

# change the styling of patchwork annotations
g1 + g2 + plot_annotation (
          title= "This is a title",
          caption='made with patchwork',
          theme=theme(plot.title=element_text(size=16)))

# Add tags to plots (A,B,C etc.)
g1 / (g2 | g3) + 
  plot_annotation(tag_levels= 'A')

# swapping axes, orientation -------------------------------
g3a <- g3 + scale_x_reverse() #flips x axis
g3b <- g3 + scale_y_reverse() #flips y axis
g3c <- g3 + scale_x_reverse() + scale_y_reverse() #flips both axes

(g3 | g3a)/(g3b | g3c) #compare the difs!

# coordinate flipping: switch x with y
(g3 + coord_flip() | g3a + coord_flip())/
  (g3b + coord_flip() | g3c + coord_flip())

# aesthetic mappings -------------------------------
# mapping of discrete variable to point color
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          color=class))) +
      geom_point(size=3)
print(m1)

# mapping of a discrete variable to point shape
# (use with <= 6 groups for this to work)
#if more than 6 data types/groups, they will remove others!!
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          shape=class))) +
  geom_point(size=3)
print(m1)

# mapping of a discrete variable to point size 
# (not recommended!)
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          size=class))) +
  geom_point()
print(m1)
#this assigns the sizes randomly (or alphabetically, if applicable) to the categories
#so it's not really a useful representation of the data
#however, it could be useful for a continuous variable:

# mapping a continuous variable to point size

m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          size=hwy))) +
  geom_point()
print(m1)

# mapping a continuous variable to point color
#ggplot is smart enough to create a color gradient!!
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          color=hwy))) +
  geom_point(size=5)
print(m1)

# map two variables to different aesthetics at the same time
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          shape=class,
                          color=hwy))) +
  geom_point(size=5)
print(m1)

# use shape for a smaller number of categories...
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          shape=drv,
                          color=fl))) +
  geom_point(size=5)
print(m1)

# use all 3 (size, shape, color) to indicate 5 
# data attributes!
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          shape=drv,
                          color=fl,
                          size=hwy))) +
  geom_point()
print(m1)
#your scientists were so focused on whether or not they could,
#they didn't stop to think if they should...

# mapping a variable to the same aesthetic 
# in two different geoms

m1 <- ggplot(data=d,
             mapping=aes(x=displ,
                         y=cty,
                         color=drv)) +
      geom_point(size=2) + geom_smooth(method="lm")
print(m1)


# faceting -------------------------------

# basic faceting with variables split by row, column,
# or both

m1 <- ggplot(data=d,
             mapping=aes(x=displ, y=cty)) +
      geom_point()
m1 + facet_grid(class~fl)
#rows of this graph represent the class of each car
#columns of the graph represent dif fuel types

# change axes by letting some of them be free
m1 + facet_grid(class~fl, scales="free_y")

# let both axes be free in scale (aka not all the same scale)
m1 + facet_grid(class~fl, scales="free")
#makes the details in each plot more apparent
#but at the same time, makes it harder to compare between plots
#b/c they are on different sacles

# facets also work with a one-way layout (vs. 2-way)
m1 + facet_grid(.~class)

# one way layout with differing rows (vs columns)
m1 + facet_grid(class~.)

# use facet wrap when variables are not crossed

m1 + facet_grid(.~class) #what we've been doing:
m1 + facet_wrap(.~class) #this one maximizes "squareness" instead
#aka, individual plots aren't connected to each other in same way

# add a second variable to facet_wrap
#un-grouped
m1 + facet_wrap(~class + fl)

# include "empty" combos in facet_wrap
m1 + facet_wrap(~class + fl,drop=FALSE)

# contrast with grid two-way layout
m1 + facet_grid(class~fl)

# use facet with other aesthetic mappings 
# within rows or columns

m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                         y=cty,
                         color=drv))) +
      geom_point()
m1 + facet_grid(.~class)

# easy to switch to other geoms

m1 <- ggplot(data=d,
             mapping=(aes(x=displ,
                          y=cty,
                          color=drv))) +
  geom_smooth(se=FALSE,method="lm")
m1 + facet_grid(.~class)

# fitting boxplots with a continuous variable
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,y=cty))) +
      geom_boxplot()
m1 + facet_grid(.~class)

# add a "group" and fill mappings for subgroups
m1 <- ggplot(data=d,
             mapping=(aes(x=displ,y=cty,
                         group=drv,fill=drv))) +
      geom_boxplot()
m1 + facet_grid(.~class)

# Aesthetic mappings 2 -------------------------------

# standard plot with all data
p1 <- ggplot(data=d,
             mapping=aes(x=displ,y=hwy)) +
  geom_point() + geom_smooth()
print(p1)

# break out drive types (note what "group" affects)

p1 <- ggplot(data=d,
             mapping=aes(x=displ, y=hwy,
                         group=drv)) +
  geom_point() + geom_smooth()
print(p1)

# break out drive types (note what "color" affects)
#changes all the pts & line associated w/ each to the same color
p1 <- ggplot(data=d,
             mapping=aes(x=displ, y=hwy,
                         color=drv)) +
  geom_point() + geom_smooth()
print(p1)

# break out drive types (note what "fill" affects)
#this one ONLY changes the fill/confidence interval color!!
p1 <- ggplot(data=d,
             mapping=aes(x=displ, y=hwy,
                         fill=drv)) +
  geom_point() + geom_smooth()
print(p1)

# color both points and confidence interval
p1 <- ggplot(data=d,
             mapping=aes(x=displ, y=hwy,
                         color=drv,fill=drv)) +
  geom_point() + geom_smooth()
print(p1)

# use aesthetic mappings to override defaults
# subset data to plot what is needed
p1 <- ggplot(data=d,
             mapping=aes(x=displ, y=hwy,
                         color=drv)) +
  geom_point(data=d[d$drv=="4",]) + geom_smooth()
print(p1)

# instead of subsetting, just map an aesthetic
p1 <- ggplot(data=d,
             mapping=aes(x=displ,y=hwy)) +
      geom_point(mapping=aes(color=drv)) +
      geom_smooth()
print(p1)

# conversely, map the smoother, but not the points.

p1 <- ggplot(data=d,mapping=aes(x=displ,y=hwy)) +
  geom_point() + geom_smooth(mapping=aes(color=drv))
print(p1)

# also, subset in the first layer to eliminate some data entirely
# instead of subsetting, just map an aesthetic
p1 <- ggplot(data=d[d$drv!="4",],mapping=aes(x=displ,y=hwy)) +
  geom_point(mapping=aes(color=drv)) + geom_smooth()
print(p1)
