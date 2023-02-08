require(readr)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_correspondent_mut_corr_era_budé/no_epp_sent_to_era_from_mut_corr_era_budé.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# cut uncessary label parts from name_in_edition column
data$name_in_edition <- gsub("\\b(\\W+COE+.*)", "", data$name_in_edition)
data$name_in_edition <- gsub("^(\\W+E)", "E", data$name_in_edition)

# create barchart
plot <- ggplot(data, aes(x= reorder(name_in_edition, -Number.of.letters.sent.to.Erasmus.per.mutual.correspondent),y=Number.of.letters.sent.to.Erasmus.per.mutual.correspondent)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.sent.to.Erasmus.per.mutual.correspondent), vjust=-0.5, color='black') +
  labs(x="Mutual correspondents",y="Number of letter sent to Erasmus ") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_sent_to_era_from_mut_corr_era_budé_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_sent_to_era_from_mut_corr_era_budé_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_sent_to_era_from_mut_corr_era_budé_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_sent_to_era_from_mut_corr_era_budé_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
