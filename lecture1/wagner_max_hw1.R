# libs
library(ggplot2)
library(plyr)


# 1.

# get companies by state, flip the coords
dat <- read.csv("https://raw.githubusercontent.com/maxwagner/608/master/lecture1/inc5000_data.csv")
dat <- dat[complete.cases(dat),]
states <- data.frame(table(dat$State))
states <- states[order(states$Freq, decreasing = TRUE),]
colnames(states) <- c("state", "freq")
ggplot(states, aes(x=state, y=freq)) + geom_bar(stat='identity') + coord_flip() + labs(title="Companies by State")
ggsave("Q1.png")


# 2.

# find employees per industry without any filtering
head(states, 3)
dat_3 <- subset(dat, State == "NY")
ggplot(dat_3, aes(x=Industry, y=Employees)) + geom_bar(stat='identity') + coord_flip()

# find the outliers
dat_bps <- subset(dat_3, Industry == "Business Products & Services")
dat_bps <- dat_bps[order(dat_bps$Employees, decreasing = TRUE),]
head(dat_bps,3)

# remove the outlier, plot again
dat_3 <- subset(dat_3, Name != "Sutherland Global Services")
ggplot(dat_3, aes(x=Industry, y=Employees)) + geom_bar(stat='identity') + coord_flip()

# find the outliers rd2
dat_cps <- subset(dat_3, Industry == "Consumer Products & Services")
dat_cps <- dat_cps[order(dat_cps$Employees, decreasing = TRUE),]
head(dat_cps,3)

# remove the outlier, plot again
dat_3 <- subset(dat_3, Name != "Coty")
ggplot(dat_3, aes(x=Industry, y=Employees)) + geom_bar(stat='identity') + coord_flip()

# there are still some more, let's try the plot with businesses that have 500 employees or less
dat_3 <- subset(dat_3, Employees <= 500)
ggplot(dat_3, aes(x=Industry, y=Employees)) + geom_bar(stat='identity') + coord_flip() + labs(title="Employees by Industry in NY")
ggsave("Q2.png")


# 3.

# find revenue per employee, show top 10
sums <- ddply(dat, "Industry", summarize, revenue_tot = sum(Revenue), employee_tot = sum(Employees))
sums$avg <- sums$revenue_tot / sums$employee_tot
sums <- sums[order(sums$avg, decreasing = TRUE),]
head(sums, 10)

# graph the top 10
g <- ggplot(head(sums, 10), aes(x=Industry, y=avg)) + geom_bar(stat='identity')
g <- g + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + labs(title="Industries by Revenue") + coord_flip()
g
ggsave("Q3.png")














