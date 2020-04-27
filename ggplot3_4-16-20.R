# --------------------------------------------------
# bar plot geoms and colors in ggplot
# 16 Apr 2020
# HH
# --------------------------------------------------
#

# preliminaries -------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
library(colorBlindness)
library(cowplot)
library(colorspace)
library(ggsci)
library(wesanderson)
library(TeachingDemos)

char2seed("Dark Star")
d <- mpg

##############################################
# bar plots
table(d$drv)

p1 <- ggplot(d, aes(x=drv)) +
  geom_bar(color="black",
           fill="cornsilk")
print(p1)

# aesthetic mapping for mupltiple groups in each bar
#5 dif fuel types represented in each bar
#but the stacked nature makes it hard to compare each category
p1 <- ggplot(d,aes(x=drv, fill=fl)) +
      geom_bar()
print(p1)

# stacking with color transparency, adjust alpha
# which is color transparency of each bar
# alpha = 0 : all colors invisible
# alpha = 1 : all colors opaque
p1 <- ggplot(d,aes(x=drv, fill=fl)) +
  geom_bar(alpha=0.3, position="identity")
print(p1)

# better to use position=fill for stacking
# with constant height
#y-axis represents proportion (relative vals), not height
p1 <- ggplot(d,aes(x=drv, fill=fl)) +
  geom_bar(position="fill")
print(p1)

# best to use position = dodge to generate multiple bars
p1 <- ggplot(d,aes(x=drv, fill=fl)) +
  geom_bar(position="dodge",color="black",
           size=0.8)
print(p1)

# more typical bar plot has heights as values
# (mean, total)
d_tiny <- tapply(X=d$hwy,
                 INDEX=as.factor(d$fl),
                 FUN=mean)
d_tiny <- data.frame(hwy=d_tiny)
d_tiny <- cbind(fl=row.names(d_tiny),d_tiny)

p2 <- ggplot(d_tiny,aes(x=fl,y=hwy,fill=fl)) +
      geom_col()
print(p2)


# much better for a box plot!
p2 <- ggplot(d, aes(x=fl, y=hwy, fill=fl)) +
  geom_boxplot()
print(p2)

# overlay the raw data (if there aren't too many)
p2 <- ggplot(d, aes(x=fl, y=hwy)) +
  geom_boxplot(fill="thistle", outlier.shape=NA) +
  geom_point()
print(p2)

# improve visualization of the data!
p2 <- ggplot(d, aes(x=fl, y=hwy)) +
  geom_boxplot(fill="thistle", outlier.shape=NA) +
  geom_point(position=position_jitter(width=0.1,
                                      height=0.7),
             color="gray60", #60% white, 40% black
             size=2) 
print(p2)


# Color -------------------------------

# hue - wavelength / portion of visible light spectrum
# saturation - intensity, vibrance of the color
# lightness - black to white
# red, blue, green
# named colors in R: PDF avail in course materials!!
#can also define colors by their R,G,B values


# Aesthetics
# attractive colors
# - large geoms (bars, boxplots), light, pale colors
# - small geoms (points, lines), dark, vibrant colors
# coor palettes that are visible to colorblind people
# color palettes that convert well to black & white

# Information content: graphs use color to convey info
# use colors to group similar treatments
# neutral colors (black,grey,white) for control groups
# symbolic colors (heat=red, cool=blue, photosynthesis
# /growth=green, oligotrophic=blue, infected=red)
# dyes or staines, or even colors of organisms

# discrete scales - distinct groups

# continuous scales (as in a heat map)
# monochromatic (different shades of one color)
# 2-tone chromatic scale (from color x to color y)
# 3-tone divergent scale (from color x through color
# y to color z)

# consistent color scheme for manuscript
# use consistent colors within and between your figures

#"color brewer" as a colour scheme tester?

my_cols <- c('#ca0020', '#f4a582', '#92c5de', '#0571b0')

# visualizing to test it out:
demoplot(my_cols,"map")
demoplot(my_cols,"bar")
demoplot(my_cols,"scatter")
demoplot(my_cols,"spine")
demoplot(my_cols,"heatmap")
demoplot(my_cols,"perspective")

my_r_colors <- c("red","brown","cyan","green")
demoplot(my_r_colors,"pie")

