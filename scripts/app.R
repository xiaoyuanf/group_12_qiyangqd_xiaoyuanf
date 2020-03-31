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

# source
source(here("scripts/dash_functions.R"))
source(here("scripts/dash_components.R"))






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
