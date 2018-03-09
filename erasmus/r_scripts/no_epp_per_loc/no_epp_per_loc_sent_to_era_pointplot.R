library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_epp_sent_to_era_from_locations.csv")

# Pointplot aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Location.Name, -Number.of.Letters.sent.from.this.location.TO.Erasmus), y=Number.of.Letters.sent.from.this.location.TO.Erasmus, label=Location.Name)) + geom_point(stat = "identity") + labs(x="Modern Location",y="Number of letters sent") + geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.Letters.sent.from.this.location.TO.Erasmus>30,as.character(Location.Name),'')),hjust= -0.1,vjust=0) 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
