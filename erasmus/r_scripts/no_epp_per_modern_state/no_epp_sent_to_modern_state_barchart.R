library(ggplot2)
library(readr)
# Daten aus CSV laden und als Dataframe 'daten' zur Verfügung stellen
daten<-read.csv("data/no_epp_per_modern_state_sent_to.csv")

# Dataframe nach Spalte 'Number.of.Correspondents.who.received.letters.BY.Erasmus'sortieren
daten[order(daten$Number.of.Letters)]


# Barchart aus dem Datenframe erstellen und x-Achse nach den Werten aus y.Achse sortieren, Barlabels hinzufügen, Achsenlabels umbenenenen
plot <- ggplot(data=daten, aes(x= reorder(Modern.State, -Number.of.Letters), y=Number.of.Letters)) + geom_bar(stat = "identity") + geom_text(aes(label=Number.of.Letters), vjust=-0.5, color='black') + labs(x="Modern State",y="Number of letters") 

# X-Achsen Labels rotieren
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35))