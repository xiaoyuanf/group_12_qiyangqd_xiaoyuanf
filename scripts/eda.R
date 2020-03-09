# author: Group 12(Margot Chen, Qi Yang)
# date: 2020-03-05

"This script carries out the exploration data analysis (EDA) for the project Beijing PM2.5. 
It produces five plots: 1) 2) 3) 4) Season VS. [PM2.5] and 5)Year VS. [PM2.5].

Usage: load_data.R --image_path=<image_path>
"-> doc

# Load packages
suppressMessages(library(tidyverse))
suppressMessages(library(docopt))
suppressMessages(library(here))
suppressMessages(library(ggplot2))

opt <- docopt(doc)

# Main function
main <- function(image_path){
  
  # read in the dataset
  df_clean <- na.omit(read.csv(here("data", "raw_data.csv"))) # should be replaced by "clean_data"
  
  # 1.Correllogram: `DEWP`, `TEMP`, `PRES`, and `PM2.5`.
  
  
  
  # 2.Faceted histogram: distribution of [PM2.5] in different wind directions.
  
  
  
  # 3.Heat map: hourly [PM2.5] from 2013 to 2014. 
  
  
  
  # 4.Bar chart: season VS. PM2.5
  ## add "season" to df_clean
  df_bar <- df_clean %>% 
    mutate(season = case_when(month == 12 ~ 'Winter', month >= 9 ~ 'Autumn', month >= 6 ~ 'Summer', month >= 3 ~ 'Spring',TRUE ~ 'Winter'))  # Group dates to seasons
  ## calculate the mean [PM2.5] for each season
  df_bar = aggregate(df_bar$pm2.5,
                      by = list(df_bar$season),
                      FUN = mean) 
  ## rename season and PM2.5 column
  df_bar = rename(df_bar, c("season" = "Group.1", "PM2.5" = "x")) 
  ## reorder the season
  df_bar$season = factor(df_bar$season, levels = c("Spring", "Summer", "Autumn", "Winter"))
  ## plotting
  season_PM2.5 <- ggplot(data = df_bar, aes(x=season, y = PM2.5)) +
      geom_bar(stat="identity")+
      coord_cartesian(ylim=c(80,120))+ # limite the range of [PM2.5]
      labs(x = "Season", 
           y = "[PM2.5]",
           title = "PM2.5 VS Season")+
      theme_classic()
    ggsave(plot = season_PM2.5, filename = "season_PM2.5.png", path = image_path)

  # 5.Line chart: year VS. PM2.5
  ## add "date" column
    df_year_change <- df_clean
    df_year_change$date = as.Date(with(df_year_change, paste(year, month, day,sep="-")), "%Y-%m-%d") # Combine day, month and year to date
  ## calculate the mean for each date
    df_year_change = aggregate(df_year_change$pm2.5,
                               by = list(df_year_change$date),
                               FUN = mean) # Mean [PM2.5] of each date
  ## rename date and PM2.5 column
    df_year_change = rename(df_year_change, c("date" = "Group.1", "PM2.5"="x"))
  ## plotting
    year_PM2.5 = ggplot(data = df_year_change) +
        geom_line(aes(x=date, y=PM2.5), 
                  alpha = 0.6,
                  size = 0.6) +
      geom_vline(xintercept = as.numeric(as.Date("2013-09-01")), linetype=4, color = "blue", size = 1) +
    # add a vertical line showing the time when Chinese overnment launched the plan to control PM2.5
        labs(x = "Time", 
             y = "[PM2.5]",
             title = "[PM2.5] VS Time") +
        theme_classic()
    ggsave(plot = year_PM2.5, filename = "year_PM2.5.png", width=12, height=4, path = image_path)
    
    
    
  # message for users
  print("EDA has run successfully!")
}


#' @param image_path is the full path name to the folder where users would like to save the images. 
#' "images" would be a good choice.
#' 


# Tests
main(opt$image_path)