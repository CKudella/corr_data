library(reshape2)
library(ggplot2)
library(readr)
library(dplyr)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/comp_no_corr_per_loc2.csv")

#DPLYR Filter
daten<-filter(daten, Difference>=5)

#Difference-Spalte entfernen
daten<-subset(daten, select = -Difference)

# Melt für Umwandlung von Wide zu Long
daten2 <- melt(daten, id.vars= c("Location.Name.Modern"))

# Linechart
plot <- ggplot(daten2,aes(x= reorder(Location.Name.Modern, -value),y=value, fill=variable)) + geom_bar(stat = "identity", position = "dodge") + labs(x="Location",y="Number of correspondents")

# X-Achsen Labels um 90 Grad rotieren, Legende unter die Chart, Greyscale Fills festlegen, Labels für die Legende setzen
plot + theme_bw() + theme_classic() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(legend.position="bottom") + scale_fill_grey(labels = c("Number of correspondents writing to Erasmus", "Number of correspondents Erasmus writes to"))