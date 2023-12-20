require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/avg_no_epp_per_corr_year_to_pirck.csv", fileEncoding = "UTF-8")

# create data frame for years 1484-1536
data2 <- tibble(Year = 1491:1530)

# merge data frames
data3 <- left_join(data2, data, by = "Year")

# filter out NAs from the data
filtered_data <- data3[!is.na(data3$Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year), ]

# calculate mean and median from the filtered data
mean_value <- mean(filtered_data$Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year)
median_value <- median(filtered_data$Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year)

# create line chart plot
plot <- ggplot(data3, aes(x = Year, y = Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  geom_hline(aes(yintercept = mean_value, linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median_value, linetype = "median"), size = 0.3) +
  labs(x = "Year", y = "Average number of letters sent to Pirckeimer per year and correspondent") +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_to_pirck_linechart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_pirck_linechart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_pirck_linechart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_pirck_linechart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
