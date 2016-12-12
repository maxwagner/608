library(tidyr)
library(ggplot2)

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

