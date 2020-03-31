# to create div components for beijing pm2.5 dashboard

# title
title <- htmlDiv(
  #className = "pretty_container",
  list(htmlH1('BEIJING PM2.5')),
  style = list(
    'columnCount' = 1,
    'background-color' = '#8ECCD9',
    'text-align' = 'center',
    'height'=75
  )
)

# introduction
intro <- htmlDiv(
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
  #className = "pretty_container",
  list(htmlH2("Overview")),
  style = list('height'=40)
)

time_header <- htmlDiv(
  list(htmlH2("How did Beijing PM2.5 change over time?")),
  style = list('height'=40)
)

factors_header <- htmlDiv(
  list(htmlH2("How did weather factors relate to PM2.5?")),
  style = list('height'=40)
)

#overview checklist
yearChecklist <- dccChecklist(
  id='year_checklist',
  options=list(
    list("label" = "2011", "value" = "2011"),
    list("label" = "2012", "value" = "2012"),
    list("label" = "2013", "value" = "2013"),
    list("label" = "2014", "value" = "2014")
  ),
  value=list("2013")
)

div_checklist <- htmlDiv(
  list(
    htmlLabel('Select one or more years: '),
    yearChecklist
  ), style=list(
    'padding'=10
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



## Graph
graph_time <- dccGraph(
  id = 'graph_time',
  figure = make_line_graph()
)
