
#Visualization of mosquito’s populations
data <- read.csv("aegypti_albopictus.csv")
library(dplyr)
library(ggplot2)
#library(MASS)

library(plotly)
# Part 1
#library(dplyr)
#mapbox
#Create dot map for year=2004
Sys.setenv('MAPBOX_TOKEN' = "pk.eyJ1IjoibW9ubW81MzgiLCJhIjoiY2xtbnZ3MDRsMHkwNjJrcG5jaW1raXVybyJ9.HxbeuV14U8LSJL_nG5fGiw")

data1 <- data%>%filter(YEAR=="2004")
p<-plot_mapbox(data1)%>%
  add_trace(type="scattermapbox",lat=~Y, lon=~X,
            color=~VECTOR, text=~COUNTRY)
p <- p %>% layout(
  title = "Mosquito Populations in 2004",
  mapbox=list(
    style="open-street-map")
)
p


#Create dot map for year=2013
Sys.setenv('MAPBOX_TOKEN' = "pk.eyJ1IjoibW9ubW81MzgiLCJhIjoiY2xtbnZ3MDRsMHkwNjJrcG5jaW1raXVybyJ9.HxbeuV14U8LSJL_nG5fGiw")

data2 <- data%>%filter(YEAR=="2013")
p<-plot_mapbox(data2)%>%
  add_trace(type="scattermapbox",lat=~Y, lon=~X,
            color=~VECTOR, text=~COUNTRY)
p <- p %>% layout(
  title = "Mosquito Populations in 2013",
  mapbox=list(
    style="open-street-map")
)
p


# Part 2
library(dplyr)
Z <- data%>%
  group_by(COUNTRY)%>%
  #n() function specifically counts the number of rows (observations) within each group
  summarise(Total_num_Mosquitos = n())

# Merge the total mosquito counts (Z) with the original data using COUNTRY as the key
merged_data <- merge(data, Z, by = "COUNTRY")


# Create the choropleth map
library(plotly)

# WORLD MAP
g <- list(
  projection = list(type = 'equirectangular')  # Use equirectangular projection
)

p <- plot_geo(merged_data) %>%
  add_trace(
    z = ~Total_num_Mosquitos, color = ~Total_num_Mosquitos, colors = 'Reds',
    text = ~COUNTRY, locations = ~COUNTRY_ID
  ) %>%
  layout(
    title = "Numbers of Mosquitos per Country",
    geo = g
  )

p


#Create the choropleth map: Equirectangular projection with choropleth color log(𝑍)
library(plotly)

# WORLD MAP
g <- list(
  projection = list(type = 'equirectangular')  # Use equirectangular projection
)

p <- plot_geo(merged_data) %>%
  add_trace(
    z = ~log(Total_num_Mosquitos), color = ~log(Total_num_Mosquitos), colors = 'Reds',
    text = ~COUNTRY, locations = ~COUNTRY_ID
  ) %>%
  layout(
    title = "Numbers of Mosquitos per Country_Equirectangular projection with choropleth color log (𝑍)",
    geo = g
  )

p



#Create the choropleth map: Conic equal area projection with choropleth color log(𝑍)
library(plotly)

# WORLD MAP
g <- list(
  projection = list(type = 'conic equal area')  # Use conic equal area projection
)

p <- plot_geo(merged_data) %>%
  add_trace(
    z = ~log(Total_num_Mosquitos), color = ~log(Total_num_Mosquitos), colors = 'Reds',
    text = ~COUNTRY, locations = ~COUNTRY_ID
  ) %>%
  layout(
    title = "Numbers of Mosquitos per Country_Conic equal area projection with choropleth color log (𝑍)",
    geo = g
  )

p


#Filtering data from 2013 only for Brazil
data3 <- data%>%filter(YEAR=="2013" & COUNTRY=="Brazil")

# Create variable X1 by cutting X into 100 piecies
data3$X1 <- cut_interval(data3$X, n = 100)


#Create variable Y1 by cutting Y into 100 piecies
data3$Y1 <- cut_interval(data3$Y, n = 100)

# Part 4-c
#Compute mean values of X and Y per group (X1,Y1) and the amount of observations
#N per group (X1,Y1)
mean_X_Y <- data3%>%
  group_by(X1,Y1)%>%
  summarize(mean_X = mean(X),
            mean_Y = mean(Y), 
            N=n())

head(mean_X_Y)


#Visualize mean X,Y and N by using MapBox

Sys.setenv('MAPBOX_TOKEN' = "pk.eyJ1IjoibW9ubW81MzgiLCJhIjoiY2xtbnZ3MDRsMHkwNjJrcG5jaW1raXVybyJ9.HxbeuV14U8LSJL_nG5fGiw")

p <- plot_mapbox(mean_X_Y)%>%add_trace(type="scattermapbox",                                                       lat=~mean_X_Y$mean_Y,
                                       lon=~mean_X_Y$mean_X,
                                       mode = "markers",
                                       text=~paste("Mean_X =", mean_X_Y$mean_X,
                                                   "Mean_Y = ", mean_X_Y$mean_Y,
                                                   "N = ", mean_X_Y$N),
                                       hoverinfo = "text",
                                       marker=list(size = mean_X_Y$N))

p <- p %>% layout(
  title = "mean X,Y and N",
  mapbox=list(
    style="open-street-map")
)
p


# p <- plot_mapbox(x=mean_X_Y$mean_X, Y= mean_X_Y$mean_Y, color=~mean_X_Y$N)
# p