# author: Margot Chen
# date: 2020-03-08

"This script cleans the raw dataset by deleting the first column and NAs of the `raw_data.csv`.
Please save the cleaned dataset in the 'data' folder when using command line.

Usage: data_wrangle.R --raw_path=<raw_data_path> --clean_path=<clean_data_path>
" -> doc

library(tidyverse)
library(docopt)
library(here)
library(glue)

opt <- docopt(doc)

main <- function(raw_path, clean_path) {
  
  # Read in the raw data
  df<-read_data(raw_path)
  
  # Clean out NAs
  df<-df %>% drop_na() %>% 
    select(2:14)  # the raw data duplicates the first column which is row number
    
  # Change the names of the wind direction
  levels(df$cbwd) <- c("Calm and variable", "Northeast", "Northwest", "Southeast") 
  
  # Save the cleaned data  
  save_data(df, clean_path)
  
  print(glue("The cleaned dataset is saved as ", clean_path, "."))

}


#' @param raw_path indicates where the raw data is. 
#' @example read_data('data/raw_data.csv')
#' 
#' @param clean_path indicates where the wrangled data should be saved.
#' @example save_data("data/data_cleaned.csv")

# Read in the raw dataset
read_data <- function(raw_path) {
  read.csv(here(raw_path))
}

# Save the cleaned dataset
save_data <- function(df, clean_path) {
  write.csv(df, here(clean_path), row.names=FALSE)
}

# Tests
main(opt$raw_path, opt$clean_path)

