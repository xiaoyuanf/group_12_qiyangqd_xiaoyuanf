# author: Margot Chen, Qi Yang
# date: 2020-03-23

"This script is the main file that creates a Dash app.

Usage: app.R
"

# Libraries

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(ggplot2)
library(plotly)
library(tidyverse)

app <- Dash$new()

# Load the data here
# TO DO




# layout

app$layout(
  htmlDiv(
      htmlH1(
          "Beijing PM2.5 Data"
            )
          )
)


app$run_server(debug=TRUE)