library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_epp_sent_from_locations.csv")

# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Location.Name.Modern, -Number.of.letters.sent.FROM.this.location), y=log10(Number.of.letters.sent.FROM.this.location), label=Location.Name.Modern)) + geom_point(stat = "identity") + labs(x="Modern Location",y="Number of letters sent") + geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.letters.sent.FROM.this.location>80,as.character(Location.Name.Modern),'')),hjust=-0.35,vjust=0) + scale_y_continuous(breaks = c(1, 3), labels = c(10, 1000)) 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
