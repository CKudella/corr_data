library(reshape2)
library(ggplot2)
library(readr)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/comp_date_inferred_noninferred_per_year.csv")
head(daten)

# Linechart
plot <- ggplot(data=daten, aes(x= Year,y=No.of.Letters.with.inferred.Date.of.Dispatch)) + geom_line(stat = "identity", size=0.9) + geom_point(shape=1) + labs(x="Year",y="Number of letters") + scale_x_continuous(breaks = c(1484:1536)) + scale_y_continuous(breaks = seq(0,160,10))

# X-Achsen Labels um 90 Grad rotieren, Legende unter die Chart, Greyscale Fills festlegen, Labels für die Legende setzen
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(legend.position="bottom") + scale_color_grey(labels = c("Letters with inferred dating", "Letters with non-inferred dating"))