require(tidyverse)
require(ggrepel)
require(patchwork)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/comp_no_corr_no_epp_per_year_from_era.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create data frame for years 1484-1536
data2 <- tibble(Year = 1484:1536)

# merge data frames
data3 <- left_join(data2, data, by = "Year")

# create line chart for number of correspondents
plot1 <- ggplot(data = data3, aes(x = Year, y = Number.of.correspondents.to.whom.Erasmus.wrote.this.year)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  labs(x = "Year", y = "Number of correspondents to whom Erasmus wrote letters") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0, 90, 5)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 6)) +
  theme(legend.position = "bottom")
plot1

# create line chart for number of letters
plot2 <- ggplot(data = data3, aes(x = Year, y = Number.of.letters.sent.by.Erasmus.this.year)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  labs(x = "Year", y = "Number of letters sent by Erasmus") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0, 150, 10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 6)) +
  theme(legend.position = "bottom")
plot2

# create scatter plot with a regression line
plot3 <- ggplot(data = data3, aes(x = Number.of.correspondents.to.whom.Erasmus.wrote.this.year, y = Number.of.letters.sent.by.Erasmus.this.year)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  geom_text_repel(aes(label = Year), hjust = 0.5, vjust = -0.5,box.padding = 0.75, max.overlaps = Inf) +
  labs(x = "Number of correspondents to whom Erasmus wrote letters", y = "Number of letters sent by Erasmus") +
  theme_bw()
plot3

# create combined plot via patchwork
(plot1 / plot2 | plot3)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_corr_no_epp_per_year_from_era_plots_combined.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_no_epp_per_year_from_era_plots_combined.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_no_epp_per_year_from_era_plots_combined.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_no_epp_per_year_from_era_plots_combined.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
