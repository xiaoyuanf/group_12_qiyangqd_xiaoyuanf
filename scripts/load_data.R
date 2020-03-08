# author: Group 12(Margot Chen, Qi Yang)
# date: 2020-03-05

"This script load in the data - Beijing PM2.5

Usage: load_data.R --data_url=<load_data_url>
"-> doc

# Load packages
library(docopt)
library(tidyverse)

opt <- docopt(doc)

# Load raw dataset from its URL and write to the "scripts" folder
main <- function(data_url){
  df<-read.csv(url(data_url))
  write.csv(df, data/raw_data.csv))  
  print("The dataset has been loaded")
}

#' @df df is the dataset read in
#' @data_url data_url is the URL to the dataset. 
#' For Beijing PM2.5, the URL is "https://archive.ics.uci.edu/ml/machine-learning-databases/00381/PRSA_data_2010.1.1-2014.12.31.csv"

main(opt$data_url)