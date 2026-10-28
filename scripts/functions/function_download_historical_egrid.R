## -------------------------------
##
## Download eGRID Historical Data
## 
## Purpose: 
## 
## This function downloads historical eGRID for the use in all 
## eGRID processes. 
##
## Authors:
##      Emma Russell, Abt Global
##
## -------------------------------

download_historical_egrid <- function(year) {
  
  #' @name download_historical_egrid
  #' 
  #' Function to check for presence of historical eGRID data and download if 
  #' it doesn't exist
  #' 
  #' @param year eGRID data year to download
  #' @return Downloaded eGRID data file path to be temporarily stored in repository and
  #'         is available to load in scripts
  #'         
  #' @examples 
  #' # Download 2022 eGRID historical data
  #' egrid_historical_path <- download_historical_egrid(2022)
  
  source("scripts/functions/function_check_valid_url.R")
  
  ### Note: check for updates or changes each data year ###
  # add previous eGRID data year every year
  urls <- c("2018" = "https://www.epa.gov/sites/default/files/2020-03/egrid2018_data_v2.xlsx",
            "2019" = "https://www.epa.gov/sites/default/files/2021-02/egrid2019_data.xlsx",
            "2020" = "https://www.epa.gov/system/files/documents/2022-09/eGRID2020_Data_v2.xlsx",
            "2021" = "https://www.epa.gov/system/files/documents/2023-01/eGRID2021_data.xlsx",
            "2022" = "https://www.epa.gov/system/files/documents/2024-01/egrid2022_data.xlsx",
            "2023" = "https://www.epa.gov/system/files/documents/2025-06/egrid2023_data_rev2.xlsx",
            # EPA did not publish eGRID2024; use Cornerstone eGRID 2024 (https://doi.org/10.5281/zenodo.18968658),
            # which is only published in metric units. The plant and CHP flag fields are unit-independent.
            "2024" = "https://zenodo.org/records/18968658/files/egrid2024_data_metric.xlsx")
  
  # save URLs as a callable variable
  assign("egrid_urls", urls, envir = .GlobalEnv)
  
  # set file path
  egrid_dir <- "data/1_production_model/static_tables/historical_egrid/"
  
  # set name of previous year's file
  # metric-only releases keep their file name so they are not mistaken for US-unit data
  file_name <- if (as.character(year) == "2024") "egrid2024_data_metric.xlsx" else glue::glue("egrid{year}_data.xlsx")
  file_path <- glue::glue("{egrid_dir}{file_name}")
  
  # check if historical data file does not exist
  if(!file.exists(file_path)) {
    print(glue::glue("eGRID {year} historical data does not exist. Downloading..."))
    
    # check for presence of output directory and create if doesn't exist
    if (!dir.exists(egrid_dir)) {
      dir.create(egrid_dir, recursive = TRUE)
    }
    
    # check if year is in URLs
    if (any(grepl(year, names(urls), ignore.case = TRUE))) {
      
      # index URL based on year
      egrid_url <- urls[as.character(year)]
      
      # check if URL is valid 
      if (check_valid_url(egrid_url)) {
        
        # download file
        download.file(url = egrid_url, 
                      destfile = file_path, 
                      mode = "wb")
        
        print(glue::glue("eGRID {year} historical data downloaded and stored in {file_path}"))
      } else {
        # if not, stop to check script or manually add previous data
        stop(glue::glue("Check script or add data for {year} historical eGRID data."))
      }
      
    } else {
      # if not, stop to check script or manually add previous data
      stop(glue::glue("Check script or add data for {year} historical eGRID data."))
    }
    
  } else {
    # skip download if file exists already
    print(glue::glue("eGRID {year} historical data already exists in {file_path}"))
  }
 
  return(file_path)
}
  


 
