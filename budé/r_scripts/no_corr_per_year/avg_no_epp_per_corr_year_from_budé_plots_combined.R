require(tidyverse)
require(ggrepel)
require(patchwork)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/avg_no_epp_per_corr_year_from_budé.csv", fileEncoding = "UTF-8")

# calculate quartiles
quartiles <- as.numeric(quantile(data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year[data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year > (quartiles[3] + 1.5*IQR)])

# create data frame for years 1484-1536
data2 <- tibble(Year = 1503:1540)

# merge data frames
data3 <- left_join(data2, data, by = "Year")

# filter out NAs from the data
filtered_data <- data3[!is.na(data3$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year), ]

# calculate mean and median from the filtered data
mean_value <- mean(filtered_data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year)
median_value <- median(filtered_data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year)

# create line chart plot
plot1 <- ggplot(data3, aes(x = Year, y = Average.number.of.letters.sent.from.Budé.per.correspondent.this.year)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  geom_hline(aes(yintercept = mean_value, linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median_value, linetype = "median"), size = 0.3) +
  labs(x = "Year", y = "Average number of letters sent by Budé per year and correspondent") +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot1

# create box plot
plot2 <- ggplot(data3, aes(x = " ", y = Average.number.of.letters.sent.from.Budé.per.correspondent.this.year)) +
  geom_boxplot(notch = FALSE) +
  geom_text_repel(label = ifelse(data3$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year >= upper_dots, as.character(data3$Year), "")) +
  labs(x = "Year", y = "Average number of letters sent by Budé per year and correspondent") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot2

# create combined plot via patchwork
plot1 + plot2 + plot_layout(widths = c(2, 1))

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
