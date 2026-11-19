## -------------------------------
##
## Load eGRID subregion shapefile
##
## Purpose:
##
## This function loads an eGRID subregion shapefile, downloading it
## from the EPA website if it does not already exist locally.
##
## -------------------------------

load_egrid_subregion_shapefile <- function(shp_type) {

  #' load_egrid_subregion_shapefile
  #'
  #' Function to load an eGRID2022 subregion shapefile and download it
  #' if it doesn't exist
  #'
  #' @param shp_type Shapefile layer to load, either "Subregions" or "Multiple_Subregions"
  #' @return sf object with a "subregion" column, in EPSG:4326
  #'
  #' @examples
  #' sbrgn_shp <- load_egrid_subregion_shapefile("Subregions")

  ### Note: check for updates or changes each data year ###
  shp_dir <- "data/1_production_model/shapefiles"
  shp_path <- glue::glue("{shp_dir}/eGRID2022_{shp_type}.shp")

  if (!file.exists(shp_path)) {
    print(glue::glue("eGRID {shp_type} shapefile does not exist. Downloading..."))
    options(timeout = max(180, getOption("timeout")))
    temp_file <- tempfile()
    download.file(glue::glue("https://www.epa.gov/system/files/other-files/2024-05/egrid2022_{tolower(shp_type)}_shapefile.zip"),
                  temp_file, mode = "wb")
    unzip(temp_file, exdir = shp_dir)
    unlink(temp_file)
  }

  shp <-
    sf::st_read(shp_path, quiet = TRUE) %>%
    tidyr::drop_na() %>%
    dplyr::rename("subregion" = "ZipSubregi") %>%
    sf::st_transform(crs = "EPSG:4326")

  return(shp)
}
