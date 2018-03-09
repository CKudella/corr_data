library(reshape2)
library(ggplot2)
library(readr)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/era_no_epp_per_year.csv")

# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= Year,y=Total.Number.of.letters.per.year)) + geom_bar(stat = "identity") + geom_text(aes(label=Total.Number.of.letters.per.year), vjust=-0.5, color='black', size = 2.5) + labs(x="Year",y="Number of letters") + scale_x_continuous(breaks = c(1484:1536)) + scale_y_continuous(breaks = seq(0,240,10))
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
