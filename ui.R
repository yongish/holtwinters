library(shiny)
load('d.Rda')
shinyUI(fluidPage(
  titlePanel("Holwinters trial"),
  
  # 1. Select a series from the drop-down menu.
  # The user will be shown a valid date range for this series.
  # 2. User will select a date.
  # The program runs exp or ARIMA on the data before this date, then displays
  # 90% confidence prediction vs. actual.
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    helpText("This is a app for demonstrating time-series analysis."),
    
    selectInput("publisher", label="1. Select desired series.",
                choices=as.character(unique(data$Series))),
    
    helpText("Increase the no. of hours to observe the prediction, and compare prediction vs. actual."),
    
    numericInput("hours",value=1,label="No. of hours to predict",min=1,max=400)
  ),
  
  mainPanel(
    plotOutput("plot")
    ,plotOutput("forecastPlot")
  )
))
