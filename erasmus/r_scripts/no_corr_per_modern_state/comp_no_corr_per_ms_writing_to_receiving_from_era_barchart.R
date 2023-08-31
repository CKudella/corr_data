require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_modern_state/comp_no_corr_per_ms_writing_to_receiving_from_era.csv", fileEncoding = "UTF-8", na.strings = c("NULL"), colClasses = c("Number.of.correspondents.who.received.letters.from.Erasmus" = "character", "Number.of.correspondents.who.wrote.letters.to.Erasmus" = "character"))

# set number columns to numeric
data$Number.of.correspondents.who.received.letters.from.Erasmus <- as.numeric(as.character(data$Number.of.correspondents.who.received.letters.from.Erasmus))
data$Number.of.correspondents.who.wrote.letters.to.Erasmus <- as.numeric(as.character(data$Number.of.correspondents.who.wrote.letters.to.Erasmus))

# pivot data from wide to long format
data_long <- data %>% pivot_longer(cols = c("Number.of.correspondents.who.received.letters.from.Erasmus", "Number.of.correspondents.who.wrote.letters.to.Erasmus"), names_to = "variable", values_to = "value")

# create bar chart
plot <- ggplot(data_long, aes(x = reorder(Modern.State, -value), y = value, fill = variable)) +
  geom_bar(position = "dodge", stat = "identity") +
  labs(x = "Modern State", y = "Number of correspondents") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  scale_fill_grey(labels = c("Number of correspondents Erasmus wrote letters to", "Number of correspondents who wrote letters to Erasmus"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_era_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_era_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_era_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_era_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
