# author: Qi Yang, Margot Chen
# date: 2020-03-05

"This script carries out the exploration data analysis (EDA) for the project Beijing pm2.5. 
It produces five plots: 1) 2) 3) 4) Season VS. [pm2.5] and 5)Year VS. [pm2.5].

Usage: eda.R --image_path=<image_path>
"-> doc

# Load packages
suppressMessages(library(tidyverse))
suppressMessages(library(docopt))
suppressMessages(library(here))
suppressMessages(library(ggplot2))
suppressMessages(library(corrplot))
suppressMessages(library(viridis))
suppressMessages(library(glue))

opt <- docopt(doc)

# Main function
main <- function(image_path){
  
  # read in the dataset
  df <- read.csv(here("data", "raw_data.csv")) # some plots need NAs
  df_clean <- read.csv(here("data", "cleaned_data.csv"))
  
  # 1.Correllogram: `DEWP`, `TEMP`, `PRES`, and `pm2.5`.
  df_corr<-cor(df_clean[6:9]) %>% # get the correlation of the four columns DEWP, TEMP, PRES, and pm2.5 against each other.
    round(2)
  # corrplot is in base R, can't use ggsave
  png(here(glue(image_path, "/corr.png")))
  
  corr<-corrplot(df_corr,
           type = "upper",
           method = "color",
           addCoef.col = "black",
           diag = FALSE)
  dev.off()

  # 2.Faceted histogram: distribution of [pm2.5] in different wind directions.
  facted_hist <- df_clean %>% ggplot(aes(pm2.5))+
    geom_histogram()+
    facet_wrap(~cbwd)+
    theme_bw()
  
  ggsave(plot = facted_hist, filename = "facted_hist.png", path = here(image_path))
  
  # 3.Heat map: hourly [pm2.5] from 2013 to 2014. 
  heat_map <- df %>% filter(year>=2013) %>% 
    ggplot(aes(day,hour,fill=pm2.5))+
    geom_tile(color= "white",size=0.1) +
    scale_fill_viridis(name="Hourly pm2.5", direction = -1)+ #Sets the order of colours in the scale reverse
    facet_grid(year~month)+
    scale_y_continuous(trans = "reverse", breaks = unique(df$hour))+
    scale_x_continuous(breaks =c(1,10,20,31))+
    theme_minimal(base_size = 8)+
    labs(title= "Hourly pm2.5", x="Day", y="Hour")+
    theme(legend.position = "bottom")
  
  ggsave(plot = heat_map, filename = "heatmap.png", path = here(image_path))
  
  # 4.Bar chart: season VS. pm2.5
  ## add "season" to df_clean
  df_bar <- df_clean %>%
    mutate(season = case_when(month == 12 ~ 'Winter', month >= 9 ~ 'Autumn', month >= 6 ~ 'Summer', month >= 3 ~ 'Spring',TRUE ~ 'Winter'))  # Group dates to seasons
  ## calculate the mean [pm2.5] for each season
  df_bar = aggregate(df_bar$pm2.5,
                      by = list(df_bar$season),
                      FUN = mean)
  ## rename season and pm2.5 column
  names(df_bar) <- c("season", "pm2.5")
  ## reorder the season
  df_bar$season = factor(df_bar$season, levels = c("Spring", "Summer", "Autumn", "Winter"))
  ## plotting
  season_pm2.5 <- ggplot(data = df_bar, aes(x=season, y = pm2.5)) +
      geom_bar(stat="identity")+
      coord_cartesian(ylim=c(80,120))+ # limite the range of [pm2.5]
      labs(x = "Season",
           y = "[pm2.5]",
           title = "pm2.5 VS Season")+
      theme_classic()
    ggsave(plot = season_pm2.5, filename = "season_pm2.5.png", path = here(image_path))

  # 5.Line chart: year VS. pm2.5
  ## add "date" column
    df_year_change <- df_clean
    df_year_change$date = as.Date(with(df_year_change, paste(year, month, day,sep="-")), "%Y-%m-%d") # Combine day, month and year to date
  ## calculate the mean for each date
    df_year_change = aggregate(df_year_change$pm2.5,
                               by = list(df_year_change$date),
                               FUN = mean) # Mean [pm2.5] of each date
  ## rename date and pm2.5 column
    names(df_year_change) <- c("date", "pm2.5")
  ## plotting
    year_pm2.5 = ggplot(data = df_year_change) +
        geom_line(aes(x=date, y=pm2.5),
                  alpha = 0.6,
                  size = 0.6) +
      geom_vline(xintercept = as.numeric(as.Date("2013-09-01")), linetype=4, color = "blue", size = 1) +
    # add a vertical line showing the time when Chinese overnment launched the plan to control pm2.5
        labs(x = "Time",
             y = "[pm2.5]",
             title = "[pm2.5] VS Time") +
        theme_classic()
    ggsave(plot = year_pm2.5, filename = "year_pm2.5.png", width=12, height=4, path = here(image_path))


    
  # message for users
  print("EDA has run successfully!")
}


#' @param image_path is the full path name to the folder where users would like to save the images. 
#' "images" would be a good choice.

# Tests
main(opt$image_path)