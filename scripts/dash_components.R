# to create div components for beijing pm2.5 dashboard

# title
title <- htmlDiv(
  className = "pretty_container",
  list(htmlH1('BEIJING PM2.5 (2011-2014)')),
  style = list(
    'columnCount' = 1,
    'background-color' = '#8ECCD9',
    'text-align' = 'center',
    'height'=75
  )
)

# introduction
intro <- htmlDiv(
  className = "pretty_container",
  list(
    htmlH2("Introduction"),
    dccMarkdown('
                Welcome to the BEIJING PM2.5 dashboard!
                
                This dashboard allows you to explore the [Beijing PM2.5 dataset](https://archive.ics.uci.edu/ml/datasets/Beijing+PM2.5+Data#).
                
                Below, you can find out how PM2.5 in Beijing from 2011-2014 changed over time, and how weather factors related the change.
                ')
  )
)

# headers
overview_header <- htmlDiv(
  className = "pretty_container",
  list(htmlH2("Overview of Hourly PM2.5 Concentration")),
  style = list('height'=40)
)

time_header <- htmlDiv(
  className = "pretty_container",
  list(htmlH2("How did Beijing PM2.5 change over time?")),
  style = list('height'=40)
)

factors_header <- htmlDiv(
  className = "pretty_container",
  list(htmlH2("How did weather factors relate to PM2.5?")),
  style = list('height'=40)
)

#overview checklist
yearChecklist <- dccChecklist(
  id='year_checklist',
  options=list(
    list("label" = "2011  ", "value" = "2011"),
    list("label" = "2012  ", "value" = "2012"),
    list("label" = "2013  ", "value" = "2013"),
    list("label" = "2014", "value" = "2014")
  ),
  value=list("2013")
)

div_checklist <- htmlDiv(
  list(
    htmlLabel('Please pick one or more years you are interested in to see the hourly PM2.5 concentration: '),
    yearChecklist
  ), style=list(
    'padding'=20
  )
)

# overview heatmap
overview_heatmap <- dccGraph(
  id='heat',
  figure=make_heatmap()
)


# Line graph and slider: readers can change the range of time to see how [pm2.5] changes with time
## Slider
year_slider <- dccRangeSlider(
  id='year-slider',
  min=14611, # 2010-01-02
  max=16435, # 2014-12-31
  step=1, # each move is 1
  value=list(14975, 16071),
  allowCross = FALSE,
  marks = list(
    "14611" = list("label" = "2010"), # marks the start of each year
    "14976" = list("label" = "2011"),
    "15341" = list("label" = "2012"),
    "15706" = list("label" = "2013"),
    "16071" = list("label" = "2014"),
    "16435" = list("label" = "2015")
  )
)

div_slider <- htmlDiv(
  list(
    htmlLabel('Please pick the time range you are interested in to see the changes in PM2.5 concentration across time: '),
    year_slider,
    htmlDiv(id='time_range_hint'),
    dccMarkdown("__Note__: The vertical blue line indicates the time when Chinese government started a PM2.5 reduction plan (September 2013).")
  ), style=list(
    'padding'=20
  )
)

## Graph
graph_time <- dccGraph(
  id = 'graph_time',
  figure = make_line_graph()
)

# relationship scatterplot
## weather factor radiobutton
factor_xaxis <-
  tibble(
    label = c("Temperature", "Pressure","Dew Point", "Cumulated wind speed"),
    value = c("TEMP", "PRES", "DEWP", "Iws")
  )

factorRadio <- dccRadioItems(
  id='factor_radio',
  options=map(1:nrow(factor_xaxis), function(i) {
    list(label=factor_xaxis$label[i], value=factor_xaxis$value[i])
  }),
  value = "TEMP",
  labelStyle = list("display" = "block")
)

div_radio <- htmlDiv(
  list(
    htmlLabel('Select one weather factor: '),
    factorRadio
  ), style=list(
    'padding'=20
  )
)

## scatterplot
factor_scatterplot <- dccGraph(
  id='scatter',
  figure=make_scatter()
)

