library(reshape2)
library(ggplot2)
library(readr)

# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_letters_to_era_per_year_per_correspondent.csv", fileEncoding = "UTF-8", colClasses=c("send_date_year1"="integer", "NoLettersSentToEra"="integer", "sender_id"="factor"))

# Linechart
plot <- ggplot(data=daten, aes(send_date_year1,NoLettersSentToEra)) + geom_point(shape=1) + facet_grid(sender_id ~ .) + labs(x="Year",y="Number of letters sent to Erasmus") + scale_x_continuous(breaks = c(1484:1536))
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1))

# X-Achsen Labels um 90 Grad rotieren, Legende unter die Chart, Greyscale Fills festlegen, Labels für die Legende setzen
plot + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + theme(strip.text.y = element_text(angle = 0, hjust = 1))