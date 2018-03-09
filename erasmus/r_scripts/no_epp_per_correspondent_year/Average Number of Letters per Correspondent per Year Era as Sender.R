library(reshape2)
library(ggplot2)
library(readr)

# this is meant as a replacement for figure 41 in the defended thesis version

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/avg_no_epp_per_corr_ era_as_sender.csv", sep =";", colClasses=c("Average.number.of.letters.written.by.Erasmus.per.correspondent"="numeric"))

# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= Year,y=Average.number.of.letters.written.by.Erasmus.per.correspondent)) + geom_bar(stat = "identity") + labs(x="Year",y="Average Number of letters written by Erasmus per correspondent") + scale_x_continuous(breaks = c(1484:1536)) + scale_y_continuous(breaks = c(1:4))
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
