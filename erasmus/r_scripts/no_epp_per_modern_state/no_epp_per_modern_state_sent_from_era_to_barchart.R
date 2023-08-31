require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_modern_state/no_epp_per_modern_state_sent_from_era_to.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create bar chart
plot <- ggplot(data, aes(x = reorder(Modern.State, -Number.of.letters.Erasmus.sent.to.this.modern.state), y = Number.of.letters.Erasmus.sent.to.this.modern.state)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Number.of.letters.Erasmus.sent.to.this.modern.state), vjust = -0.5, color = "black") +
  labs(x = "Modern State", y = "Number of letters sent by Erasmus to this modern state") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_modern_state_sent_from_era_to_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_modern_state_sent_from_era_to_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_modern_state_sent_from_era_to_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_modern_state_sent_from_era_to_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
