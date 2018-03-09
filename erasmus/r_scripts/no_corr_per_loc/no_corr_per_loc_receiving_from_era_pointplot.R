library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_corr_per_loc_era_as_sender.csv")

# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Location.Name.Modern, -Number.of.Correspondents.who.received.at.this.Location.letters.BY.Erasmus), y=Number.of.Correspondents.who.received.at.this.Location.letters.BY.Erasmus, label=Location.Name.Modern)) + geom_point(stat = "identity") + labs(x="Modern Location",y="Number of correspondents Erasmus writes to") + geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.Correspondents.who.received.at.this.Location.letters.BY.Erasmus>15,as.character(Location.Name.Modern),'')),hjust=-0.1,vjust=0) 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
