require(tidyverse)
require(ggrepel)
require(patchwork)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/comp_no_corr_per_year_to_from_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create data frame for years 1503-1540
data2 <- tibble(Year = 1503:1540)

# merge data frames
data3 <- left_join(data2, data, by = "Year")

# pivot data from wide to long format
data_long <- data %>% pivot_longer(cols = c("Number.of.correspondents.Budé.writes.to.this.year", "Number.of.correspondents.writing.letters.to.Budé.this.year"), names_to = "variable", values_to = "value")

# create line chart
plot1 <- ggplot(data = data_long, aes(x = Year, y = value, colour = variable)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  labs(x = "Year", y = "Number of correspondents") +
  scale_x_continuous(breaks = c(1503:1540)) +
  scale_y_continuous(breaks = seq(0, 30, 5)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  scale_color_grey(labels = c("Number of correspondents to whom Budé wrote letters", "Number of correspondents who wrote letters to Budé"))
plot1

# create scatter plot with a regression line
plot2 <- ggplot(data = data3, aes(x = Number.of.correspondents.Budé.writes.to.this.year, y = Number.of.correspondents.writing.letters.to.Budé.this.year)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  geom_text_repel(aes(label = Year), hjust = 0.5, vjust = -0.5,box.padding = 0.75, max.overlaps = Inf) +
  labs(x = "Number of correspondents to whom Budé wrote letters", y = "Number of correspondents who wrote letters to Budé") +
  theme_bw()
plot2

# create combined plot via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_corr_per_year_to_from_budé_plots_combined.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_year_to_from_budé_plots_combined.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_year_to_from_budé_plots_combined.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_year_to_from_budé_plots_combined.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
