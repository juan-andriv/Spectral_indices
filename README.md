# Spectral_indices
A selection of spectral indices for Sentinel-2 Level-2A imagery

Juan Andrade Rivera
linkedin: linkedin.com/in/juan-andriv
02.04.2024

Developed for Sentinel 2 Level-2A satellite imagery

Download desired image at https://dataspace.copernicus.eu/

Sentinel-2 L2A Bands and Descriptions

| Band | Description                | Wavelength (nm)          | Resolution |
|---|------------|-----------|------|
| B01  | Coastal aerosol            | 442.7 (S2A), 442.3 (S2B) | 60m  |
| B02  | Blue                       | 492.4 (S2A), 492.1 (S2B) | 10m  |
| B03  | Green                      | 559.8 (S2A), 559.0 (S2B) | 10m  |
| B04  | Red                        | 664.6 (S2A), 665.0 (S2B) | 10m  |
| B05  | Vegetation red edge 1      | 704.1 (S2A), 703.8 (S2B) | 20m  |
| B06  | Vegetation red edge 2      | 740.5 (S2A), 739.1 (S2B) | 20m  |
| B07  | Vegetation red edge 3      | 782.8 (S2A), 779.7 (S2B) | 20m  |
| B08  | NIR                        | 832.8 (S2A), 833.0 (S2B) | 10m  |
| B8A  | Narrow NIR                 | 864.7 (S2A), 864.0 (S2B) | 20m  |
| B09  | Water vapour               | 945.1 (S2A), 943.2 (S2B) | 60m  |
| B11  | SWIR                       | 1613.7 (S2A), 1610.4 (S2B)| 20m |
| B12  | SWIR                       | 2202.4 (S2A), 2185.7 (S2B)| 20m |

Note: The cirrus band B10 is excluded as it does not contain any "bottom of the atmosphere" information

The indices calculated in this project are descsribed below.

| Index | Formula                        | Description                                                                               | Use                                                     |
|-------|--------------------------------|-------------------------------------------------------------------------------------------|---------------------------------------------------------|
| NDVI  | (NIR - Red) / (NIR + Red)      | -1: Unhealthy vegetation <br> 0: Sparse vegetation or bare soil <br> +1: Healthy vegetation | Assessing vegetation health and density                  |
| NDBI  | (SWIR - NIR) / (SWIR + NIR)    | -1: Water bodies <br> 0: Bare soil or water <br> +1: Urban areas                           | Identifying urban areas and built-up surfaces            |
| NDMI  | (NIR - SWIR) / (NIR + SWIR)    | -1: Water stressed vegetation <br> 0: Typical moisture in vegetation <br> +1: Well watered vegetation | Estimating vegetation moisture content               |
| NDWI  | (Green - NIR) / (Green + NIR)  | -1: Urban areas or bare soil <br> 0: Dry land <br> +1: Water bodies                         | Mapping water bodies and monitoring changes in water content |
| SBI   | (SWIR - Red) / (SWIR + Red)    | -1: High organic matter, moist, clay <br> +1: Low organic matter, dry, sand                 | Distinguishing soil types and soil moisture content      |


The final output is an array of maps showcasing each index.

![Spectral_Indices](https://github.com/juan-andriv/Spectral_indices/assets/163057641/fc4eb314-266c-46f6-bcb3-8ac89398c714)






