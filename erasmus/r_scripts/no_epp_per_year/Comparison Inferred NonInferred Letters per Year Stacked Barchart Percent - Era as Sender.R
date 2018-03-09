library(reshape2)
library(ggplot2)
library(readr)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/comp_date_inferred_noninferred_per_year_era_as_sender.csv")

# Melt für Umwandlung von Wide zu Long
daten2 <- melt(daten, id.vars= c("Year"))

# Stacked Barchart
plot <- ggplot(daten2,aes(x=Year,y=value, fill=variable)) + geom_bar(position = "fill", stat = "identity") + scale_y_continuous(labels = percent_format()) + labs(x="Year",y="Number of letters") + scale_x_continuous(breaks = c(1484:1536))

# X-Achsen Labels um 90 Grad rotieren, Legende unter die Chart, Greyscale Fills festlegen, Labels für die Legende setzen
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(legend.position="bottom") + scale_fill_grey(labels = c("Letters written by Erasmus with inferred dating", "Letters written by Erasmus with non-inferred dating"))