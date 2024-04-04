### SPECTRAL INDICES ### ----
### Juan Andrade Rivera
### linkedin: linkedin.com/in/juan-andriv
### 02.04.2024

### On data ----
### Developed for Sentinel 2 Level-2A satellite imagery
### Download desired image at https://dataspace.copernicus.eu/
### Sentinel-2 L2A Bands and Descriptions
### | Band | Description                | Wavelength (nm)          | Resolution |
### |------|----------------------------|--------------------------|------|
### | B01  | Coastal aerosol            | 442.7 (S2A), 442.3 (S2B) | 60m  |
### | B02  | Blue                       | 492.4 (S2A), 492.1 (S2B) | 10m  |
### | B03  | Green                      | 559.8 (S2A), 559.0 (S2B) | 10m  |
### | B04  | Red                        | 664.6 (S2A), 665.0 (S2B) | 10m  |
### | B05  | Vegetation red edge 1      | 704.1 (S2A), 703.8 (S2B) | 20m  |
### | B06  | Vegetation red edge 2      | 740.5 (S2A), 739.1 (S2B) | 20m  |
### | B07  | Vegetation red edge 3      | 782.8 (S2A), 779.7 (S2B) | 20m  |
### | B08  | NIR                        | 832.8 (S2A), 833.0 (S2B) | 10m  |
### | B8A  | Narrow NIR                 | 864.7 (S2A), 864.0 (S2B) | 20m  |
### | B09  | Water vapour               | 945.1 (S2A), 943.2 (S2B) | 60m  |
### | B11  | SWIR                       | 1613.7 (S2A), 1610.4 (S2B)| 20m |
### | B12  | SWIR                       | 2202.4 (S2A), 2185.7 (S2B)| 20m |
### Note: The cirrus band B10 is excluded as it does not contain any "bottom of the atmosphere" information


## set wd ----
setwd("C:/Users/Juan/Documents/0_RStudio/Spectral_Indices")

## load packages ---- 
library(sp) # necessary to work with spatial data
library(gdalUtilities) # to transform the GDAL files (jp2 from Sentinel 2)
library(rgdal) # to read spatial data
library(raster) # working with raster data
library(ggplot2) # easy plots
library(rasterVis) # for plotting maps using ggplot2 syntax

## load Sentinel 2 L2A data ----

# For this exercise I only need bands 02, 03, 04, 08 and 11
# so those are the ones I put inside the source folder
# b08 is replaced with b8A, as is the one available at 20m resolution

jp2_list <- list.files("source", pattern = ".jp2", full.names = TRUE) # pull jp2 files
raster_list <- lapply(jp2_list, raster) # transform to raster

# Crop the rasters to desired extension, I used a shapefile
shapefile <- shapefile("source/shp/AMM.shp") # if necessary change CRS to match the image
c_raster_list <- lapply(raster_list, function(r) crop(r, shapefile))

# Rename objects
print(c_raster_list) # check the order!!
raster_names <- c("b02", "b03", "b04", "b11", "b08") # name the bands in the order they are listed
c_raster_list <- setNames(c_raster_list, raster_names)
print(c_raster_list) # check all names are assigned correctly

# Separate list as individual raster objects
list2env(c_raster_list, envir = .GlobalEnv) # global environment is the general workspace

# creating an RGB image ----
rgb <- stack(list(b04,b03,b02))
plotRGB(rgb, axes = TRUE, stretch = "lin", main = "Monterrey Metropolitan Area (AMM)") +
  plot(shapefile, add = TRUE, border = "red", lwd = 2) # add shapefile with outline for AMM area

### INDICES ### ----
## NDVI Normalized Difference Vegetation Index ----
# -1 unhealthy vegetation, extreme negative value for water bodies
# 0 sparse vegetation or bare soil
# +1 for healthy vegetation
ndvi <- (b08 - b04) / (b08 + b04)
plot(ndvi, main = "NDVI", col = colorRampPalette(c("brown", "khaki", "darkgreen"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)


## NDBI Normalized Difference Builtup Index ----
# -1 water bodies
# 0 bare soil or water 
# +1 for urban areas
ndbi <- (b11 - b08) / (b11 + b08)
plot(ndbi, main = "NDBI", col = colorRampPalette(c("midnightblue", "lightblue", "ivory", "indianred1", "red4"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

## NDMI Normalized Difference Moisture Index ----
# -1 water stressed vegetation
# 0 typical moisture content in vegetation
# +1 well watered vegetation
ndmi <- (b08 - b11) / (b08 + b11)
plot(ndmi, main = "NDMI", col = colorRampPalette(c("chocolate4", "orange", "white", "lightblue", "midnightblue"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

## NDWI Normalized Difference Water Index ----
# -1 urban areas or bare soil
# 0 dry land 
# +1 water bodies
ndwi <- (b03 - b08) / (b03 + b08)
plot(ndwi, main = "NDWI", col = colorRampPalette(c("black", "gray","white", "lightblue", "darkblue"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

## SBI Soil Brightness Index ----
# -1 soils with high organic matter, moist, clay
# +1 soils with low organic matter, dry, sandy
sbi <- (b11 - b04) / (b11 + b04)
plot(sbi, main = "SBI", col = colorRampPalette(c("saddlebrown", "ivory", "yellow3"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

## Print in a facet view ----
pdf("Spectral_Indices.pdf", width = 11.7, height = 16.5) # set pdf parameters
png("Spectral_Indices.png", width = 11.7*100, height = 16.5*100, res = 100) # Set png parameters

par(mfrow = c(3, 2)) # Organize plots in 3 rows and 2 columns

# Plots
plotRGB(rgb, axes = TRUE, stretch = "lin", main = "Satellite view") +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

plot(ndvi, main = "NDVI - Normalized Difference Vegetation Index", col = colorRampPalette(c("brown", "khaki", "darkgreen"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

plot(ndbi, main = "NDBI - Normalized Difference Built-up Index", col = colorRampPalette(c("midnightblue", "lightblue", "ivory", "indianred1", "red4"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

plot(ndmi, main = "NDMI - Normalized Difference Moisture Index", col = colorRampPalette(c("chocolate4", "orange", "white", "lightblue", "midnightblue"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

plot(ndwi, main = "NDWI - Normalized Difference Water Index", col = colorRampPalette(c("black", "gray","white", "lightblue", "darkblue"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

plot(sbi, main = "SBI - Soil Brightness Index", col = colorRampPalette(c("saddlebrown", "ivory", "yellow3"))(256)) +
  theme_minimal() +
  plot(shapefile, add = TRUE, border = "red", lwd = 2)

par(mfrow = c(1, 1)) # Reset the plotting layout to default
dev.off() # close pdf device and save plot

