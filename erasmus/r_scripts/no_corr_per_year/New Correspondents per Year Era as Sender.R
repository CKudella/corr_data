library(reshape2)
library(ggplot2)
library(readr)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/new_corr_per_year_era_as_sender.csv")

# Linechart
plot <- ggplot(data=daten, aes(x= Year,y=Number.of.new.correspondents.Erasmus.writes.to)) + geom_histogram(stat = "identity", size=0.9) + labs(x="Year",y="Number of new correspondents Erasmus writes to") + scale_x_continuous(breaks = c(1484:1536))
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35))