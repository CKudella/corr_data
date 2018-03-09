library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_epp_per_modern_state_sent_from_era_to_ms.csv")

# Dataframe nach Spalte 'Number.of.Letters.Erasmus.sent.to.this.Modern.State'sortieren
daten[order(daten$Number.of.Letters.sent.from.this.Modern.State.to.Erasmus)]


# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Modern.State, -Number.of.Letters.Erasmus.sent.to.this.Modern.State), y=Number.of.Letters.Erasmus.sent.to.this.Modern.State)) + geom_bar(stat = "identity") + geom_text(aes(label=Number.of.Letters.Erasmus.sent.to.this.Modern.State), vjust=-0.5, color='black') + labs(x="Modern State",y="Number of letters sent by Erasmus to this Modern State") 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35))