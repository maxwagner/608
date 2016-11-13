library(shiny)
library(googleVis)
library(plyr)
library(dplyr)

# read in data
mortality <-  read.csv('https://raw.githubusercontent.com/maxwagner/608/master/lecture3/q1/cleaned-cdc-mortality-1999-2010.csv')

# rem some columns, rename remaining
mortality <- mortality[, c(3,5,7,10,11)]
colnames(mortality) <- c("Chapter", "State", "Year", "Population", "Rate")

# shiny server
shinyServer(function(input, output) {
  
  # sr = state rate, nr = national rate
  mortalityReactive <- reactive({
    srFilt <- filter(mortality, Chapter == input$chapter)
    srGroup <- group_by(srFilt, State)
    states <- data.frame(State = unique(srGroup$State))
    Change <- srGroup$Rate[srGroup$Year == 1999] - srGroup$Rate[srGroup$Year == 2010]
    stateChange <- cbind(states, Change)
    
    nrFilt <- filter(mortality, Chapter == input$chapter)
    nrDdply <- ddply(nrFilt, ~Year, summarise, Rate=mean(Rate))
    nrChange <- nrDdply$Rate[nrDdply$Year == 1999] - nrDdply$Rate[nrDdply$Year == 2010]
    
    stateChange$NationalChange <- nrChange
    stateChange$Delta <- stateChange$Change - stateChange$NationalChange
    
    forGraph <- select(stateChange, State, Delta)
    arrange(forGraph, desc(Delta))
  })
  
  
  
  
  output$gvisplot <- renderGvis({
    gvisBarChart(mortalityReactive(),
                 options = list(
                   title = "Mortality Rate Difference From National",
                   backgroundColor = "#CFD8DC",
                   backgroundColor.stroke = "black",
                   backgroundColor.strokeWidth = 10,
                   height = 1000, 
                   width = 1000,
                   chartArea = "{width: '60%', height: '95%'}"
                 ))
  })
})