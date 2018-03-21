library(reshape2)
library(ggplot2)
library(readr)

# Create Dataframe
daten<-read.csv("data/georgius_spalatinus_pirck_era.csv")

labels <- c(EPPEtX = "Erasmus to Georgius Spalatinus", EPPXtE = "Georgius Spalatinus to Erasmus", EPPPtX = "Pirckheimer to Georgius Spalatinus", EPPXtP = "Georgius Spalatinus to Pirckheimer")

# Melt (Wide to Long)
daten2 <- melt(daten, id.vars= c("years"))

# Plot Facet Grid
plot <- ggplot(data=daten2, aes(x= years,y=value, factor = variable)) + geom_point(stat = "identity", size = 3) + labs(x="Year",y="Number of letters") + scale_x_continuous(breaks = c(1484:1536)) + scale_y_continuous(breaks = seq(1,10,1)) + facet_grid(variable ~ ., labeller=labeller(variable = labels))
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(strip.text.y = element_text(angle = 0, hjust = 1)) + theme(legend.position="bottom")
