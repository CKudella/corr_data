require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_modern_state/no_corr_per_modern_state_writing_epp_to_pirck.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create bar chart
plot <- ggplot(data, aes(x = reorder(Modern.State, -Number.of.correspondents.who.wrote.letters.to.Pirckheimer), y = Number.of.correspondents.who.wrote.letters.to.Pirckheimer)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Number.of.correspondents.who.wrote.letters.to.Pirckheimer), vjust = -0.5, color = "black") +
  labs(x = "Modern State", y = "Number of correspondents who wrote letters to Pirckheimer") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_corr_per_modern_state_writing_epp_to_pirck_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_modern_state_writing_epp_to_pirck_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_modern_state_writing_epp_to_pirck_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_modern_state_writing_epp_to_pirck_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
