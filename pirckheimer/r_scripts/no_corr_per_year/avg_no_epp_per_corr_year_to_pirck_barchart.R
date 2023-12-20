require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/avg_no_epp_per_corr_year_to_pirck.csv", fileEncoding = "UTF-8")

# create bar chart
plot <- ggplot(data, aes(x = Year, y = Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year)) +
  geom_bar(position = "dodge", stat = "identity") +
  geom_text(aes(label =  sprintf("%.2f", Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year)), vjust = -0.5, color = "black", size = 2.5) +
  geom_hline(aes(yintercept = mean(Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year), linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(Average.number.of.letters.sent.per.correspondent.to.Pirckheimer.this.year), linetype = "median"), size = 0.3) +
  labs(x = "Year", y = "Average number of letters sent to Pirckeimer per year and correspondent") +
  scale_x_continuous(breaks = c(1484:1536)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_to_pirck_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_pirck_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_pirck_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_pirck_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
