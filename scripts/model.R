# author: Margot Chen
# date: 2020-03-16

"This script carries out a linear regression for the Beijing pm2.5 dataset and
exports the model and plots to user defined locations. 

Usage: model.R --clean_path=<clean_data_path> --model_path=<model_path> --image_path=<image_path>
"-> doc

# Load packages
suppressMessages(library(tidyverse))
suppressMessages(library(broom))
suppressMessages(library(here))
suppressMessages(library(ggplot2))
suppressMessages(library(corrplot))
suppressMessages(library(lmfit))
suppressMessages(library(glue))
suppressMessages(library(docopt))

opt <- docopt(doc)

# Main function
main <- function(clean_path, model_path, image_path) {
  # Load data
  df_clean <- read.csv(here(clean_path))
  
  # Linear regression
  model <- lm(pm2.5 ~ DEWP + TEMP + PRES + cbwd, data=df_clean)
  
  # message for users
  print("Linear regression has run successfully!")
}



#' @param clean_path is the path to the cleaned data file.
#' 
#' @param model_path is the location where the users would like to save the model.
#' 
#' @param image_path is the full path name to the folder where users would like to save the images. 


main(opt$clean_path, opt$model_path, opt$image_path)
