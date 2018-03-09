library(reshape2)
library(ggplot2)
library(readr)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/comp_no_epp_written_to_era_to_no_corr_per_yeart.csv")

# Melt für Umwandlung von Wide zu Long
daten2 <- melt(daten, id.vars= c("Year"))

# Linechart
plot <- ggplot(data=daten2, aes(x= Year,y=value, colour=variable)) + geom_line(stat = "identity", size=0.9) + geom_point(shape=1) + labs(x="Year",y="Number of correspondents") + scale_x_continuous(breaks = c(1484:1536))
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1))

# X-Achsen Labels um 90 Grad rotieren, Legende unter die Chart, Greyscale Fills festlegen, Labels für die Legende setzen
plot + theme_classic() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(legend.position="bottom") + scale_color_grey(labels = c("Number of letters written to Erasmus", "Number of correspondents writing letters to Erasmus"))