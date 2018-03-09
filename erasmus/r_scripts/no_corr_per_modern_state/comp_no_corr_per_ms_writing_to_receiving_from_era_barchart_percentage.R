library(reshape2)
library(ggplot2)
library(readr)
library(scales)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/comp_no_corr_per_modern_state.csv")

# Summe bilden
daten$Summe<-daten$Number.of.Correspondents.who.received.letters.BY.Erasmus + daten$Number.of.Correspondents.who.wrote.letters.TO.Erasmus

# Nach Summe sortieren
daten[order(-daten$Summe),]

#Summen Spalte entfernen
daten<-subset(daten, select = -Summe)

# Melt für Umwandlung von Wide zu Long
daten2 <- melt(daten, id.vars= c("Modern.State"))

# Linechart
plot <- ggplot(daten2,aes(x= reorder(Modern.State,-value),y=value, fill=variable)) + geom_bar(position = "fill", stat = "identity") + scale_y_continuous(labels = percent_format()) + labs(x="Modern State",y="Number of correspondents")

# X-Achsen Labels um 90 Grad rotieren, Legende unter die Chart, Greyscale Fills festlegen, Labels für die Legende setzen
plot + theme_bw() + theme_classic() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(legend.position="bottom") + scale_fill_grey(labels = c("Correspondents Erasmus writes to", "Correspondents writing to Erasmus")) 