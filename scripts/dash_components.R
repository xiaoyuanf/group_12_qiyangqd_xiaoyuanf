# to create div components for beijing pm2.5 dashboard

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



# Graph
graph_time <- dccGraph(
  id = 'graph_time',
  figure = make_line_graph()
)
