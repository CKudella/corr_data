library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_epp_sent_from_locations_by_era.csv")

# Pointplot aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Location.Name, -Number.of.Letters.sent.from.this.location.BY.Erasmus), y=Number.of.Letters.sent.from.this.location.BY.Erasmus, label=Location.Name)) + geom_point(stat = "identity") + labs(x="Modern Location",y="Number of letters sent") + geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.Letters.sent.from.this.location.BY.Erasmus>70,as.character(Location.Name),'')),hjust= -0.1,vjust=0) 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
