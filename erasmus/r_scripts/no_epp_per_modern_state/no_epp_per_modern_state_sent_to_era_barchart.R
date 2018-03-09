library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_epp_per_modern_state_sent_to_era.csv")

# Dataframe nach Spalte 'Number.of.Letters.sent.from.this.Modern.State.to.Erasmus'sortieren
daten[order(daten$Number.of.Letters.sent.from.this.Modern.State.to.Erasmus)]


# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Modern.State, -Number.of.Letters.sent.from.this.Modern.State.to.Erasmus), y=Number.of.Letters.sent.from.this.Modern.State.to.Erasmus)) + geom_bar(stat = "identity") + geom_text(aes(label=Number.of.Letters.sent.from.this.Modern.State.to.Erasmus), vjust=-0.5, color='black') + labs(x="Modern State",y="Number of letters sent to Erasmus") 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35))