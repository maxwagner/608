library(shiny)
library(googleVis)
library(dplyr)

# read in data
mortality <-  read.csv('https://raw.githubusercontent.com/maxwagner/608/master/lecture3/q1/cleaned-cdc-mortality-1999-2010.csv')

# rem some columns, rename remaining
mortality <- mortality[, c(3,5,7,11)]
colnames(mortality) <- c("Chapter", "State", "Year", "Rate")

# only keep 2010 rates
mortality2010 <- filter(mortality, Year == 2010)

# shiny server
function(input, output) {
  mortalityReactive <- reactive({
    mortalityFilt <- filter(mortality2010, Year == 2010, Chapter == input$chapter)
    mortalitySel <- select(mortalityFilt, State, Rate)
    arrange(mortalitySel, desc(Rate))
  })
  
  
  output$gvisplot <- renderGvis({
    gvisBarChart(mortalityReactive(),
                 options = list(
                   title = "2010 Mortality Rate",
                   backgroundColor = "#CFD8DC",
                   backgroundColor.stroke = "black",
                   backgroundColor.strokeWidth = 10,
                   height = 1000, 
                   width = 500,
                   chartArea = "{width: '60%', height: '95%'}"
                 ))
  })
}