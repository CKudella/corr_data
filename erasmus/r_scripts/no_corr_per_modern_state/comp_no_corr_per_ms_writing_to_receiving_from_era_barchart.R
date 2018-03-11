require(readr)
require(reshape2)
require(ggplot2)
library(readr)
library(reshape2)
library(ggplot2)

# read data
data<-read.csv("no_corr_per_modern_state/comp_no_corr_per_ms_writing_to_receiving_from_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"), colClasses=c("Number.of.correspondents.who.received.letters.from.Erasmus"="character","Number.of.correspondents.who.wrote.letters.to.Erasmus"="character"))

# set number columns to numeric
data$Number.of.correspondents.who.received.letters.from.Erasmus <- as.numeric(as.character(data$Number.of.correspondents.who.received.letters.from.Erasmus))
data$Number.of.correspondents.who.wrote.letters.to.Erasmus <- as.numeric(as.character(data$Number.of.correspondents.who.wrote.letters.to.Erasmus))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("Modern.State"))

# create linechart
plot <- ggplot(data_long,aes(x= reorder(Modern.State,-value),y=value, fill=variable)) + 
  geom_bar(position = "dodge", stat = "identity") + 
  labs(x="Modern State",y="Number of correspondents") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + 
  theme(legend.position="bottom")
plot