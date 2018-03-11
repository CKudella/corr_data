library(reshape2)
library(ggplot2)
library(readr)

# Facet Grid visualization of the number of letters Erasmus sent to the modern states compared to the number of letters he received from there der Briefe von Erasmus an die modern states pro Jahr

# Create Dataframe
daten<-read.csv("data/no_epp_from_to_era_per_modern_state_per_year.csv")

# Melt from Wide zu Long
daten2 <- melt(daten, id.vars= c("ModernState","send_date_year1"))

# Plot Facet Grid
plot <- ggplot(data=daten2, aes(x=send_date_year1,y=value, colour=variable)) + geom_line(stat = "identity") + labs(x="Year",y="Number of letters") + scale_x_continuous(breaks = c(1484:1536)) + facet_grid(ModernState ~ ., space = "free" )
plot + theme_minimal() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(strip.text.y = element_text(angle = 0, hjust = 1)) + theme(legend.position="bottom") + scale_color_grey(labels = c("Number of letters sent from Erasmus to the modern state", "Number of letters sent from mondern state to Erasmus"))
