library(reshape2)
library(ggplot2)
library(readr)

# Test R Script für die Facet Grid Darstellung der Briefe an Erasmus aus den modern states pro Jahr

# Create Dataframe
daten<-read.csv("data/no_epp_to_era_from_modern_state_per_year.csv")

# Plot Facet Grid
plot <- ggplot(data=daten, aes(x=send_date_year1,y=Number.of.Letters.sent.from.this.Modern.State.to.Erasmus)) + geom_bar(stat = "identity") + labs(x="Year",y="Number of letters") + scale_x_continuous(breaks = c(1484:1536)) + facet_grid(Modern.State ~ ., space = "free" )
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(strip.text.y = element_text(angle = 0, hjust = 1)) + theme(legend.position="bottom")
