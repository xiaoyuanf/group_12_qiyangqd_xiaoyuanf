# author: Margot Chen, Qi Yang
# date: 2020-03-23

"This script is the main file that creates a Dash app.

Usage: app.R
"

### Load libraries

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(ggplot2)
library(plotly)
library(tidyverse)
library(here)

app <- Dash$new()

### Load the data
df_clean <- read.csv(here("data", "cleaned_data.csv"))
df <- read.csv(here("data", "raw_data.csv"))





### Line graph and slider: readers can change the range of time to see how [pm2.5] changes with time
### Slider
year_slider <- dccRangeSlider(
  id='year-slider',
  min=14611, # 2010-01-02
  max=16435, # 2014-12-31
  step=1, # each move is 1
  value=list(14611, 16435),
  marks = list(
    "14611" = list("label" = "2010"), # marks the start of each year
    "14976" = list("label" = "2011"),
    "15341" = list("label" = "2012"),
    "15706" = list("label" = "2013"),
    "16071" = list("label" = "2014"),
    "16435" = list("label" = "2015")
  )
)

### Line graph: change the time range 
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
    scale_x_date(limits = as.Date(c(date1,date2)))
    # add a vertical line showing the time when Chinese overnment launched the plan to control pm2.5

    # convert to ggplotly()
  ggplotly(plot_year_change)
}


# Graph
graph_time <- dccGraph(
  id = 'graph_time',
  figure = make_line_graph()
)


### layout
app$layout(
  htmlDiv(
    list(
      htmlH1("Beijing PM2.5 Data"),
      
      # Slider for changing time range
      year_slider,
      # Graph for time range
      graph_time,
      
      
      dccMarkdown("[Data Source](https://archive.ics.uci.edu/ml/datasets/Beijing+PM2.5+Data#)")
      )

          )
)

### app callback

# year_time callback
app$callback(
  output=list(id = 'graph_time', property='figure'),
  params=list(input(id='year-slider', property='value')),
  # Create a list of values
  function(value) {
    make_line_graph(value)
  })



### Run app
app$run_server(debug=TRUE)
