library(reshape2)
library(ggplot2)
library(readr)
library(scales)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/comp_no_epp_per_modern_state_from_ms_to_era_by_era_to_ms.csv")

# Melt für Umwandlung von Wide zu Long
daten2 <- melt(daten, id.vars= c("Modern.State"))

# Stacked Barchart Percentage
plot <- ggplot(daten2,aes(x= reorder(Modern.State, -value),y=value, fill=variable)) + geom_bar(position = "fill", stat = "identity") + scale_y_continuous(labels = percent_format()) + labs(x="Modern State",y="Number of letters")

# X-Achsen Labels um 90 Grad rotieren, Legende unter die Chart, Greyscale Fills festlegen, Labels für die Legende setzen
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(legend.position="bottom") + scale_fill_grey(labels = c("Letters sent by Erasmus to this modern state", "Letters sent to Erasmus from this modern state"))