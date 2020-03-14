# author: Margot Chen
# date: 2020-03-08

"This script leletes the first column and NAs of the `raw_data.csv`.

Usage: data_wrangle.R --raw_path=<raw_path> --clean_name=<clean_name>
" -> doc

library(tidyverse)
library(docopt)
library(here)
library(glue)

# THIS IS NEW
opt <- docopt(doc)

main <- function(raw_path, clean_name) {
  
  df<-read_data(raw_path)
  
  df<-df %>% drop_na() %>% 
    select(2:14) # the raw data duplicates the first column which is row number
  
  save_data(df, clean_name)
  
  print(glue("The file ", clean_name, " is saved in the data folder."))
}



#' @param raw_path indicates where the raw data is (better in the `data` folder). 
#' @example read_data('data/raw_data.csv')
#' @param clean_name indicates where the wrangled data should be saved (better in the `data` folder).
#' @example save_data('data/cleaned_data.csv')

read_data <- function(raw_path) {
  read.csv(here(raw_path))
}

save_data <- function(df, clean_name) {
  write.csv(df, here(clean_name), row.names=FALSE)
}

# Tests
main(opt$raw_path, opt$clean_name)