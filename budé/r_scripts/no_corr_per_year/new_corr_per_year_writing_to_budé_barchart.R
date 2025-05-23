require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/new_corr_per_year_writing_to_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create bar chart
plot <- ggplot(data = data, aes(x = YEAR, y = NewCorrWritingToBudé)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = "Number of new correspondents who wrote letters to Budé") +
  geom_text(aes(label = NewCorrWritingToBudé), vjust = -0.5, color = "black") +
  scale_x_continuous(breaks = c(1503:1540)) +
  scale_y_continuous(breaks = seq(0, 5, 1)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("new_corr_per_year_writing_to_budé_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("new_corr_per_year_writing_to_budé_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("new_corr_per_year_writing_to_budé_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("new_corr_per_year_writing_to_budé_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
