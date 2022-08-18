

# Load libraries
library(dplyr) # data wrangling
library(tidyr) # data wrangling
library(ggplot2) # data visualisation
library(sf) # simple features - geospatial geometries
library(osmdata) # obtaining OpenStreetMap vector data
library(units) # working with units
library(mapview) # interactive geometry viewing
library(ggmap) # downloading raster maps from a variety of sources
library(ggspatial) # map backgrounds and annotations for ggplot
library(tmap) # static/interactive map library with ggplot-like syntax



#install.packages('ggspatial')
#install.packages('tmap')



nai_bb <- getbb("Nairobi")
nai_bb


nai_bb %>%
  opq()


nai_hospitals <- nai_bb %>%
  opq() %>%
  add_osm_feature(key = "amenity", value = "hospital") %>%
  osmdata_sf()


nai_hospitals 


# bounding box used in query
nai_hospitals$bbox



# metadata
nai_hospitals$meta


# osm_points
nai_hospitals$osm_points


# osm_polyogns
nai_hospitals$osm_polygons


# install.packages("ggplot2")
library(ggplot2)

ggplot() +
  geom_sf(data = nai_hospitals$osm_polygons)



library(ggmap)
nai_map <- get_map(nai_bb, maptype = "roadmap")



ggmap(nai_map) +
  geom_sf(
    data = nai_hospitals$osm_polygons,
    inherit.aes = FALSE,
    colour = "#08519c",
    fill = "#08306b",
    alpha = .5,
    size = 1
  ) +
  labs(x = "", y = "")



# library ("leaflet")
library(leaflet)

leaflet() %>%
  addTiles() %>%
  addPolygons(
    data = nai_hospitals$osm_polygons,
    label = nai_hospitals$osm_polygons$name
  )

