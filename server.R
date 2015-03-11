library(shiny)

library(forecast)
library(dplyr)
load("d.Rda")
library(lubridate)

shinyServer(
  function(input, output){
    output$dates = renderUI({
      mydata = input$publisher
      dates = ymd_hm(select(data[[mydata]], Time..hour.)[[1]])
      min.date = min(dates) + days(7) # Use min of 7 days of data for predictions.
      max.date = max(dates) - days(1) # So we can predict the final date.
      dateInput("selected.date", label="2. Select start date for prediction.", min = min.date, value = max.date, max = max.date)
    })
       
    # Using only this series.
    activity1 <- reactive({
      data <- data[data$Series==input$publisher,]$Values;
      activity <- head(data,-input$hours)
    })

    output$forecastPlot <- renderPlot(
        plot.forecast(forecast.HoltWinters(HoltWinters(ts(activity1(), 
                                                frequency=24)),h=input$hours),
                      xaxt='n',ylab="Requests")
    )
    output$plot <- renderPlot(
      function(x) {
        plot(data[data$Series==input$publisher,]$Values,type="n",ylab="Requests",
             main="Actual numbers");
        lines(data[data$Series==input$publisher,]$Values)
      }
    )
})
