# functions to create plots in beijing pm2.5 dashboard

# load libraries
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(plotly))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(here))
suppressPackageStartupMessages(library(viridis))

# overview heatmap
make_heatmap <- function(checklistValue=2013){
  ht <- df %>% 
    filter(year==checklistValue) %>% 
    ggplot(aes(day,hour,fill=pm2.5))+
    geom_tile(color= "white",size=0.1) +
    # Sets the order of colours in the scale reverse
    scale_fill_viridis(name="Hourly pm2.5", direction = -1)+ 
    facet_grid(year~month)+
    scale_y_continuous(trans = "reverse", breaks = unique(df$hour))+
    scale_x_continuous(breaks =c(1,10,20,31))+
    theme_minimal(base_size = 8)+
    labs(x="Day", y="Hour")+
    ggtitle(paste0('Hourly PM2.5 in year ', 
                   #checklistValue is a list. need to unlist and turn the vector in to string
                   paste(sort(unlist(checklistValue)), collapse = ' ')))
    
  ggplotly(ht)
}

# Line graph: change the time range 
make_line_graph <- function(value=list(14611, 16435)){
  
  ## Convert input values to integer then to date
  # `as.Date()` convert input (must be integer) to date format
  # `as.integer()` convert input to integer format
  date1 <- as.Date(as.integer(value[1]), origin = "1970-01-01")
  date2 <- as.Date(as.integer(value[2]), origin = "1970-01-01")
  
  ## Get a new dataframe
  df_year_change <- df_clean
  # add "date" column
  df_year_change$date = as.Date(with(df_year_change, paste(year, month, day,sep="-")), "%Y-%m-%d") # Combine day, month and year to date
  # calculate the mean for each date
  df_year_change = aggregate(df_year_change$pm2.5,
                             by = list(df_year_change$date),
                             FUN = mean) # Mean [pm2.5] of each date
  # rename date and pm2.5 column
  names(df_year_change) <- c("date", "pm2.5")
  
  ## plotting
  plot_year_change <- ggplot(df_year_change) +
    geom_line(aes(x=date, y=pm2.5),
              alpha = 0.6,
              size = 0.6) +
    geom_vline(xintercept = as.numeric(as.Date("2013-09-01")),
               linetype=4, color = "blue", size = 1) +
    labs(x = "Time",
         y = "[pm2.5]",
         title = "[pm2.5] VS Time") +
    theme_classic() +
    # change the range of date on x axis
    scale_x_date(date_labels = "%Y-%m-%d", limits = as.Date(c(date1,date2)))
  # add a vertical line showing the time when Chinese overnment launched the plan to control pm2.5
  
  # convert to ggplotly()
  ggplotly(plot_year_change)
}

