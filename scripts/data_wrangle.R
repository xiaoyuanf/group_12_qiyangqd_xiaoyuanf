# author: Margot Chen
# date: 2020-03-08

"This script leletes the first column and NAs of the `raw_data.csv`.

Usage: data_wrangle.R --path=<path> --filename=<filename>
" -> doc

library(tidyverse)
library(docopt)
library(here)
library(glue)

# THIS IS NEW
opt <- docopt(doc)

main <- function(path, filename) {
  
  df<-read_data(path)
  
  df<-df %>% drop_na() %>% 
    select(2:14) # the raw data duplicates the first column which is row number
  
  save_data(df, filename)
  
  print(glue("The file ", filename, " is saved in the data folder."))
}



#' @param path indicates where the raw data is. 
#' @example read_data('data/raw_data.csv')
#' 
#' @param filename indicates where the wrangled data should be saved
#' @example save_data("data_cleaned.csv")
#' 
#' 

read_data <- function(path) {
  read.csv(here(path))
}

save_data <- function(df, filename) {
  write.csv(df, here("data", filename), row.names=FALSE)
}

main(opt$path, opt$filename)