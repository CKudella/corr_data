require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/comp_no_corr_per_year_to_from_pirck.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create data frame for years 1484-1536
data2 <- tibble(Year = 1484:1536)

# merge data frames
data3 <- left_join(data2, data, by = "Year")

# pivot data from wide to long format
data_long <- data %>% pivot_longer(cols = c("Number.of.correspondents.Pirckheimer.writes.to.this.year", "Number.of.correspondents.writing.letters.to.Pirckheimer.this.year"), names_to = "variable", values_to = "value")

# create linechart
plot <- ggplot(data = data_long, aes(x = Year, y = value, colour = variable)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  labs(x = "Year", y = "Number of correspondents") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0, 170, 10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  scale_color_grey(labels = c("Number of correspondents Pirckheimer writes to", "Number of correspondents writing to Pirckheimer"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_corr_per_year_to_from_pirck_linechart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_year_to_from_pirck_linechart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_year_to_from_pirck_linechart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_year_to_from_pirck_linechart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
