#'### Title: "Spawnwatch_map"
#' author: "Elizabeth Boville"



#'# Map Use and Overview

#'The aim of this project is to visualize coral spawning data over many reproductive cycles in multiple locations throughout the Caribbean. The reproductive timing of many species is shifting due to climate change and specific factors in each reef system such as temperature, bleaching events, and light pollution. To understand how these factors impact each coral species I have developed a method to visually assess spawning time at each field site. This example code focuses specifically on spawning time in hours after sunset, however the code can be easily adapted to capture timing based on days after the full moon (DAFM) and environmental factors collected in the field such as temperature. 

#'Map generation code is adapted from multiple tutorials and packages, specifically:
#'<https://r-spatial.org/r/2018/10/25/ggplot2-sf-2.html>
#'<https://conservancy.umn.edu/bitstream/handle/11299/220339/time-maps-tutorial-v2.html?sequence=3>

#'Please refer to them if you have questions on map layout and setup for different geographic locations.

#'The following packages were used when I created my spawning maps
#'
#Load Packages
library("ggplot2")
theme_set(theme_bw())
library("sf")
library(gganimate)
library(gifski)
library("rnaturalearth")
library("rnaturalearthdata")
library("ggspatial")

#'#Load data 
#'Data should be loaded as a CSV file with the headings "Lat", "Long", "Average.Time". Latitude and Longitude should be in decimal degrees, not degrees minutes seconds. Average time should be a value for the mean hour after sunset that the coral colonies spawned in that location. 
#'
#'
#'As an example for *Orbicella annularis*:
#'
oann <- read.csv("path")


#'This is the world map setup used for this project
#'
#Select world map
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)


#'To continue with the *Orbicella annularis* dataset example,

#OBICELLA ANNULARIS SPAWNING DATA MAP
#Set up map and plot these points from the sample data

oann_map <- ggplot(data = world) +
  geom_sf() +
  geom_sf(fill = "antiquewhite1") +
  geom_point(data = oann, aes(x = Long, y = Lat, color=Average.Time), size = 3) +
  coord_sf(xlim = c(-102.15, -60), ylim = c(7.65, 33.97), expand = FALSE)+
  theme( panel.background = element_rect(fill = "aliceblue")) + 
  scale_color_gradient(low="orange", high = "blue", name = "Hrs. Post-Sunset", limits = c(min(oann$Average.Time), max(oann$Average.Time))) 

oann_map

#' Currently this map takes in the coral dataset, in this case "oann" and uses the latitude and longitude values to plot points on a map. It then uses the average spawning time in hours after sunset for each data point to generate a range of color values. All colors can be altered based on personal preference. The color range is based on the max and min values for the data, this can be altered as well. 

