require(tidyverse)
require(ggrepel)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/avg_no_epp_per_corr_year_to_era.csv", fileEncoding = "UTF-8")

# calculate quartiles
quartiles <- as.numeric(quantile(data$Average.number.of.letters.sent.per.correspondent.to.Erasmus.this.year, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Average.number.of.letters.sent.per.correspondent.to.Erasmus.this.year[data$Average.number.of.letters.sent.per.correspondent.to.Erasmus.this.year > (quartiles[3] + 1.5*IQR)])

# create box plot
plot <- ggplot(data, aes(x = " ", y = Average.number.of.letters.sent.per.correspondent.to.Erasmus.this.year)) +
  geom_boxplot(notch = FALSE) +
  geom_text_repel(label = ifelse(data$Average.number.of.letters.sent.per.correspondent.to.Erasmus.this.year >= upper_dots, as.character(data$Year), "")) +
  labs(x = "Year", y = "Average number of letters sent to Erasmus per year and correspondent") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_to_era_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
