# select all files that are csv
files = list.files(path = "data", pattern = "*.csv")

# data frame for collecting the files at the end
recs = data.frame()

# read in the files
for (file in files) {
  temp <- read.csv(paste("data/", file, sep = ""), stringsAsFactors = FALSE)
  temp <- temp[c("MARK", "COMPETITOR", "NAT", "VENUE", "DATE")]
  
  # only keep the top 100 times for easier management
  if (nrow(temp) > 100) {
    temp <- temp[1:100,]
  }
  
  # trim whitespace from marks
  temp$MARK <- gsub("[[:space:]]", "", temp$MARK)
  
  # trim letters from marks
  temp$MARK <- gsub("[a-zA-Z]", "", temp$MARK)
  
  
  # give athletes capital names
  library(stringi)
  temp$COMPETITOR <- stri_trans_totitle(temp$COMPETITOR)
  
  # fix nationality
  temp$NAT <- substr(temp$NAT, 1, 3)
  
  # fix date
  temp$DATE <- as.Date(temp$DATE, "%d-%b-%y")
  
  # add a sex column
  if (grepl("_men", file)) {
    temp$Sex <- "male"
  } else if (grepl("_women", file)) {
    temp$Sex <- "female"
  } else {
    temp$Sex <- "unknown"
  }
  
  # add an event column
  event <- gsub("_.*$", "", file)
  temp$Event <- event
  
  # rename the columns
  colnames(temp) <- c("Mark", "Athlete", "Nation", "Venue", 
                      "Date", "Sex", "Event")
  
  # rbind to the recs data frame
  recs <- rbind(recs, temp)
}

write.csv(recs, "data/records.csv")