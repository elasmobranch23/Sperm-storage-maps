library(ggplot2)
library(sf)
library(rnaturalearth)
library(readxl)
library(ggsn)

####### Code for map for the Indian Ocean

#Load data used
Indian <- read_excel("C:/Users/G00303872/OneDrive/Masters/Data Sheets/Spatial.xlsx", sheet = "Indian")
Cou <- read_excel("C:/Users/G00303872/OneDrive/Masters/Data Sheets/Spatial.xlsx", sheet = "Indian_countries")
Ocean  <- read_excel("C:/Users/G00303872/OneDrive/Masters/Data Sheets/Spatial.xlsx", sheet = "Indian_label")
Cruise <- read_excel("C:/Users/G00303872/OneDrive/Masters/Data Sheets/Spatial.xlsx", sheet = "Research_Cruise")

#Crop the study area 
worldmap <- ne_countries(scale = 'medium', type = 'map_units',
                         returnclass = 'sf')

oman_cropped <- st_crop(worldmap, xmin = 50, xmax = 65,
                          ymin = 15, ymax = 32.5)

# plot map 
attach(Indian)
NIO <- ggplot() + geom_sf(data = oman_cropped, fill = "white") + theme(panel.grid = element_blank(), panel.background = element_rect("grey81"), 
                                                legend.text =element_text(size = 15)) +
  #geom_point(data = Cou, aes(x = Lon, y = Lat), pch = 16, col = "black") +
  geom_point(data = Ocean, aes(x = Lon, y = Lat), pch = 16, col = "grey") +
  geom_line(data = Cruise, aes(x = Lon, y = Lat), col = "black", size = 1) +
  geom_point(data = Indian, aes( x= Lon, y = Lat, shape = Site), size = 2) +
  scale_shape_manual(values = c(0,16,15,11,17,18,6,8)) + 
  geom_text(data = Cou, aes(x = Lon, y = Lat, label = Country), size = 3) +
  geom_text(data = Ocean, aes(x = Lon, y = Lat, label = Country), size = 2.5) +
  labs(x = "Longtitude", y = "Latitude")

#Add North arrow 
north2(NIO, x = .25, y = .80, symbol = 3)

####### Code for map for the Indian Ocean 

# Load data for Atlantic Ocean
Atlantic <- read_excel("C:/Users/G00303872/OneDrive/Masters/Data Sheets/Spatial.xlsx", sheet = "Atlantic")
Atlantic_label <- read_excel("C:/Users/G00303872/OneDrive/Masters/Data Sheets/Spatial.xlsx", sheet = "Atlantic_label")

#Crop the study area 
ire_cropped <- st_crop(worldmap, xmin = -13, xmax = -4, ymin = 48, ymax = 57.5)

# plot map 
NEA <- ggplot() + geom_sf(data = ire_cropped, fill = "white") +theme(panel.grid = element_blank(), panel.background = element_rect("grey81"), 
                                              legend.text =element_text(size = 15)) +
  geom_point(data = Atlantic, aes(x= Lon, y = Lat), pch=16, cex=1) +
  geom_point(data = Atlantic_label, aes(x =Lon, y = Lat), pch =16, colour = "grey81") +
  geom_text(data = Atlantic_label, aes(x =Lon, y = Lat, label =Country)) +
  labs(x = "Longtitude", y = "Latitude")
  
#Add North arrow 
north2(NEA, x=.3, y=.9, symbol=3)

