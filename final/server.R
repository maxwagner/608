library(tidyr)
library(ggplot2)
library(shiny)
library(stringi)

# load the cleaned data frame
records <- read.csv("data/records.csv", stringsAsFactors = FALSE)

# fix dates from the csv load in
records$Date <- as.Date(records$Date, "%d-%b-%Y")

# each type of data is different, load them separate
########## sprints ##########
# measured in seconds
records_sprints <- subset(records, 
                          records$Event == "100m" |
                            records$Event == "100mh" |
                            records$Event == "110mh" |
                            records$Event == "200m" |
                            records$Event == "400m" |
                            records$Event == "400mh" |
                            records$Event == "4x100m"
)

records_sprints$Mark <- as.numeric(records_sprints$Mark)
#############################


##########  mid and long distance ##########
# measured in minutes:seconds
# convert to minutes
records_mid <- subset(records, 
                      records$Event == "800m" |
                        records$Event == "1500m" |
                        records$Event == "5000m" |
                        records$Event == "10000m" |
                        records$Event == "4x400m"
)
records_mid <- separate(records_mid, Mark, c("minutes", "seconds"), sep = ":")
records_mid$seconds <- (as.numeric(records_mid$seconds)/60)
records_mid$Mark <- as.numeric(records_mid$minutes) + as.numeric(records_mid$seconds)
records_mid <- subset(records_mid, select = -c(minutes, seconds))
records_mid$Mark <- as.numeric(records_mid$Mark)
############################################


########## marathon ##########
# measured in hours:minutes:seconds
# converted to hours
records_marathon <- subset(records, records$Event == "marathon")
records_marathon <- separate(records_marathon, Mark, c("hours", "minutes", "seconds"), sep = ":")
records_marathon$minutes <- as.numeric(records_marathon$minutes)/60
records_marathon$seconds <- as.numeric(records_marathon$seconds)/60/60
records_marathon$Mark <- 
  as.numeric(records_marathon$hours) +
  as.numeric(records_marathon$minutes) +
  as.numeric(records_marathon$seconds)
records_marathon <- subset(records_marathon, select = -c(hours, minutes, seconds))
records_marathon$Mark <- as.numeric(records_marathon$Mark)
##############################


########## field  ##########
# measured in meters
records_field <- subset(records, 
                        records$Event == "discus" |
                          records$Event == "hammer" |
                          records$Event == "high-jump" |
                          records$Event == "javelin" |
                          records$Event == "long-jump" |
                          records$Event == "pole-vault" |
                          records$Event == "shot-put" |
                          records$Event == "triple-jump"
)
records_field$Mark <- as.numeric(records_field$Mark)
############################

# s1
s1 <- subset(records_marathon, records_marathon$Event == "marathon")
s1 <- subset(s1, s1$Sex == "male")
#

# s2
s2 <- subset(records_sprints, records_sprints$Event == "400mh")
s2 <- subset(s2, s2$Sex == "male")
#

# s2
s3 <- subset(records_field, records_field$Event == "discus")
s3 <- subset(s3, s3$Sex == "female")
#

function(input, output, session) {
  
  output$s3tab <- renderTable(colnames = FALSE,{
    t(data.frame(table(s3$Nation)))
  })
  
  output$s1 <- renderPlot({
    ggplot(data = s1) + 
      theme_minimal() +
      geom_point(aes(x = Date, y = Mark, colour = Mark),
                 size = 4,
                 alpha = .4) +
      ggtitle(paste0("Event: ", stri_trans_totitle(s1$Event))) +
      scale_y_reverse()
  })
  
  output$s2 <- renderPlot({
    ggplot(data = s2) + 
      theme_minimal() +
      geom_point(aes(x = Date, y = Mark, colour = Mark),
                 size = 4,
                 alpha = .4) +
      ggtitle(paste0("Event: ", stri_trans_totitle(s2$Event))) +
      scale_y_reverse()
  })
  
  output$s3 <- renderPlot({
    ggplot(data = s3) + 
      theme_minimal() +
      geom_point(aes(x = Date, y = Mark, colour = Mark),
                 size = 4,
                 alpha = .4) +
      ggtitle(paste0("Event: ", stri_trans_totitle(s3$Event)))
  })
  
  
  output$plot2 <- renderPlot({
    
    if (input$event == "100m" |
        input$event == "100mh" |
        input$event == "110mh" |
        input$event == "200m" |
        input$event == "400m" |
        input$event == "400mh" |
        input$event == "4x100m") {
      dataset_flex <- records_sprints
      scale_y = TRUE
      
    } else if (input$event == "800m" |
               input$event == "1500m" |
               input$event == "5000m" |
               input$event == "10000m" |
               input$event == "4x400m") {
      dataset_flex <- records_mid
      scale_y = TRUE
      
    } else if (input$event == "discus" |
               input$event == "hammer" |
               input$event == "high-jump" |
               input$event == "javelin" |
               input$event == "long-jump" |
               input$event == "pole-vault" |
               input$event == "shot-put" |
               input$event == "triple-jump") {
      dataset_flex <- records_field
      scale_y = FALSE
      
    } else {
      dataset_flex <- records_marathon
      scale_y = TRUE
    }

    dataset_flex <- subset(dataset_flex, dataset_flex$Event == input$event)
    dataset_flex <- subset(dataset_flex, dataset_flex$Sex == input$plot2gender)
    
    ggplot(data = dataset_flex) + 
      theme_minimal() +
      geom_point(aes(x = Date, y = Mark, colour = Mark),
                 size = 4,
                 alpha = .4) +
      ggtitle(paste0("Event: ", stri_trans_totitle(input$event))) +
      if (scale_y == TRUE) {
        scale_y_reverse()
      }
  })
  
  output$tablei1 <- renderTable(colnames = FALSE,{
    
    if (input$event == "100m" |
        input$event == "100mh" |
        input$event == "110mh" |
        input$event == "200m" |
        input$event == "400m" |
        input$event == "400mh" |
        input$event == "4x100m") {
      dataset_flex <- records_sprints
      
    } else if (input$event == "800m" |
               input$event == "1500m" |
               input$event == "5000m" |
               input$event == "10000m" |
               input$event == "4x400m") {
      dataset_flex <- records_mid
      
    } else if (input$event == "discus" |
               input$event == "hammer" |
               input$event == "high-jump" |
               input$event == "javelin" |
               input$event == "long-jump" |
               input$event == "pole-vault" |
               input$event == "shot-put" |
               input$event == "triple-jump") {
      dataset_flex <- records_field
      
    } else {
      dataset_flex <- records_marathon
    }
    
    dataset_flex <- subset(dataset_flex, dataset_flex$Event == input$event)
    dataset_flex <- subset(dataset_flex, dataset_flex$Sex == input$plot2gender)
    
    t(data.frame(table(dataset_flex$Nation)))
  })
  
  
  
  
}