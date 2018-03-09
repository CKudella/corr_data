library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/comp_correspondents_per_modern_state.csv")

# Dataframe nach Spalte 'Number.of.Correspondents.who.received.letters.BY.Erasmus'sortieren
daten[order(daten$Number.of.Correspondents.who.received.letters.BY.Erasmus)]


# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Modern.State, -Number.of.Correspondents.who.received.letters.BY.Erasmus),y=Number.of.Correspondents.who.received.letters.BY.Erasmus)) + geom_bar(stat = "identity") + geom_text(aes(label=Number.of.Correspondents.who.received.letters.BY.Erasmus), vjust=-0.5, color='black') + labs(x="Modern State",y="Number of correspondents receiving letters from Erasmus") 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35))