require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_modern_state/no_corr_per_modern_state_writing_epp_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create linechart
plot <- ggplot(data, aes(x= reorder(Modern.State, -Number.of.correspondents.who.wrote.letters.to.Erasmus),y=Number.of.correspondents.who.wrote.letters.to.Erasmus)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.correspondents.who.wrote.letters.to.Erasmus), vjust=-0.5, color='black') +
  labs(x="Modern State",y="Number of correspondents") +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot