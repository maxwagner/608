library(ggplot2)
library(ggthemes)
library(bigvis)
library(knitr)

# read in pluto data
bk <- "nyc_pluto_16v1/BK.csv"
bk <- read.csv(bk)
bx <- "nyc_pluto_16v1/BX.csv"
bx <- read.csv(bx)
mn <- "nyc_pluto_16v1/MN.csv"
mn <- read.csv(mn)
qn <- "nyc_pluto_16v1/QN.csv"
qn <- read.csv(qn)
si <- "nyc_pluto_16v1/SI.csv"
si <- read.csv(si)

# combine it all
pluto <- rbind(bk,bx,mn,qn,si)
write.csv(pluto, "pluto.csv")

# read it in if restarting R
pluto <- read.csv("pluto.csv")


############# Q1. ############# 
# from the summary of the full data before subsetting, we can see that there is
# missing information. There are 43,388 properties that have a year built value of
# 0, which is roughly 5% of our total data. It is something to consider.
summary(pluto$YearBuilt)
dim(subset(pluto, YearBuilt == 0))

# from just the summary, we can see that the max value (2040) for year built is 
# further in the future than the current year (2016).
q1 <- subset(pluto, YearBuilt >= 1850)
summary(q1$YearBuilt)

# another subset to get rid of the bad info
q1 <- subset(q1, YearBuilt <= 2016)
summary(q1$YearBuilt)

# From the looks of the graph, build year peaked around 1925, with most being built
# after the 1900's. In general nearly no building were built from 1850 until 1890.
q1_cond <- condense(bin(q1$YearBuilt, 5))
kable(q1_cond)
autoplot(q1_cond) + xlab("Year Built") + ylab("Count") + ggtitle("Counts of Build Year in NYC") + theme_economist()
ggsave("q1.png", height = 5)


############# Q2. ############# 
# using the subsets from q1 to make q2
q2 <- subset(q1, NumFloors > 0)
q2_by_year <- condense(bin(q2$YearBuilt, 1), bin(q2$NumFloors, 10))
q2_by_year$.count <- log(q2_by_year$.count)

# As expected, the amount of short building is always the highest, with a clear trend
# of higher buildings being built in later years.
autoplot(q2_by_year) + xlab("Year Built") + ylab("Number of Floors") + ggtitle("Log Scaled Number of Floors by Build Year") + theme_economist()
ggsave("q2.png", height = 5)


############# Q3. ############# 
# using subsets from q2 to make q3
q3 <- subset(q2, AssessTot > 0)
q3_per_floor <- log(q3$AssessTot/q3$NumFloors)
q3_cond <- condense(bin(q3$YearBuilt, 1), z=q3_per_floor, summary = )

# this is a bit harder to see without looking at individual sections, but the overall picture
# can be seen below.
autoplot(q3_cond) + geom_smooth(se = FALSE)+ xlab("Year Built") + ylab("Assess Total") +
  ggtitle("Log Scaled Assess Value per floor by Build Year") + theme_economist()
ggsave("q3.png", height = 5)

# looking at average overall floor price near the dates in question
q3_3 <- subset(q3, YearBuilt >= 1936 & YearBuilt <= 1950)
mean(q3_3$AssessTot/q3_3$NumFloors)

# and now at the specific dates in question
q3_2 <- subset(q3, YearBuilt >= 1941 & YearBuilt <= 1945)
mean(q3_2$AssessTot/q3_2$NumFloors)

# from the means, it seems like the average assess value per floor in that time frame
# is lower than surrounding years.





