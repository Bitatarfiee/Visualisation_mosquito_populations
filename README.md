# Visualisation_mosquito_populations

## Description
MapBox is used for interface in Plotly to create two dot maps (for years 2004 and 2013)\
That show the distribution of the two types of mosquitos in the world (use color to distinguish between mosquitos).\
Analyze which countries and which regions in these countries had high density of each mosquito type and how the situation changed between these time points.

Compute Z as the numbers of mosquitos per country detected during all study period. Use plot_geo() function to create a choropleth map that shows Z values. This map should have an Equirectangular projection.

- Equirectangular projection with choropleth color log (𝑍𝑍)
- Conic equal area projection with choropleth color log (𝑍𝑍)

Use data from 2013 only for Brazil and
- Create variable X1 by cutting X into 100 piecies (use cut_interval() )
- Create variable Y1 by cutting Y into 100 piecies (use cut_interval() )
- Compute mean values of X and Y per group (X1,Y1) and the amount of observations N per group (X1,Y1)
- Visualize mean X,Y and N by using MapBox, Identify regions in Brazil that are most infected by mosquitoes.


# Data:
aegypti_albopictus.csv
File aegypti_albopictus.csv shows information about the location and detection time of two types of mosquitoes. Both Aedes aegypti and Aedes albopictus mosquitoes may spread viruses like Zika, dengue, chikungunya and other viruses but Aedes aegypti are more likely to spread these viruses (and therefore are more dangerous). The data file contain the following variables:
VECTOR: Identifying the species; Ae. aegypti or Ae. albopictus
- LOCATION_TYPE: Whether the record represents a point or a polygon location.\
- POLYGON_ADMIN: Admin level or polygon size which the record represents when the location type is a polygon. -999 when the location type is a point (5 km x 5 km).
- X: The longitudinal coordinate of the point or polygon centroid (WGS1984 Datum).
- Y: The latitudinal coordinate of the point or polygon centroid (WGS1984 Datum).
- YEAR: The year of the occurrence.
- COUNTRY: The name of the country within which the occurrence lies.
- COUNTRY_ID: ISO alpha-3 country codes. .
- GAUL_AD0: The country-level global administrative unit layer (GAUL) code (see http://www.fao.org/geonetwork) which identifies the Admin-0 polygon within which any smaller polygons and points lie.
- STATUS: Established vs. transient populations.
