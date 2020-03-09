# author: Group 12(Margot Chen, Qi Yang)
# date: 2020-03-05

"This script carries out the exploration data analysis (EDA) for the project Beijing PM2.5. 
It produces five plots: 1) 2) 3) 4) Season VS. [PM2.5] and 5)Year VS. [PM2.5].

Usage: load_data.R --file_path<file_path> --image_path<image_path>
"-> doc

# Load packages
suppressMessages(library(tidyverse))
suppressMessages(library(docopt))
suppressMessages(library(here))
suppressMessages(library(ggplot2))

opt <- docopt(doc)

# Main function
main <- function(){
  
  # read in the dataset
  # these two lines will be replaced by one line: df_clean <- read.csv(here("scripts", "clean_data"))
  df <- read.csv(file_path)
  df_clean<- na.omit(df)
  
  # histogram: season VS. PM2.5
  ## add "season" to df_clean
  df_hist <- df_clean %>% 
    mutate(season = case_when(month == 12 ~ 'Winter', month >= 9 ~ 'Autumn', month >= 6 ~ 'Summer', month >= 3 ~ 'Spring',TRUE ~ 'Winter'))  # Group dates to seasons
  ## calculate the mean [PM2.5] for each season
  df_hist = aggregate(df_hist$pm2.5,
                      by = list(df_hist$season),
                      FUN = mean) 
  ## rename the new df_hist
  df_hist = rename(df_hist, c("season" = "Group.1", "PM2.5" = "x")) 
  ## plotting
  ggplot(data = df_hist, aes(x=season, y = PM2.5)) +
      geom_bar(stat="identity")+
      coord_cartesian(ylim=c(80,120))+
      labs(x = "Season", 
           y = "[PM2.5]",
           title = "PM2.5 VS Season") +
      theme_classic()+
    ggsave(here("images","season_vs_PM2.5.png"))
  
  # message for users
  print("The script has been run successfully!")
}


#' @param file_path is the full path name to the clean data file


# Tests
main(opt$file_path, opt$)