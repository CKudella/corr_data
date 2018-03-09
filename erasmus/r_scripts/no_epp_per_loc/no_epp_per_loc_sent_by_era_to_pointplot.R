library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_epp_sent_by_era_to_locations.csv")

# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Location, -Number.of.Letters.per.Location.to.which.Erasmus.has.sent.Letters), y=Number.of.Letters.per.Location.to.which.Erasmus.has.sent.Letters, label=Location)) + geom_point(stat = "identity") + labs(x="Modern Location",y="Number of letters sent by Erasmus") + geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.Letters.per.Location.to.which.Erasmus.has.sent.Letters>50,as.character(Location),'')),hjust=-0.1,vjust=0) 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
