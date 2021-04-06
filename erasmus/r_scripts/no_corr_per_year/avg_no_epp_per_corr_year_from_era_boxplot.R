require(readr)
require(ggplot2)
require(ggrepel)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/avg_no_epp_per_corr_year_from_era.csv", fileEncoding = "UTF-8")

# caculate quartiles
quartiles <- as.numeric(quantile(data$Average.number.of.letters.sent.from.Erasmus.per.correspondent.this.year, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate upper whisker
upper_whisker <- max(data$Average.number.of.letters.sent.from.Erasmus.per.correspondent.this.year[data$Average.number.of.letters.sent.from.Erasmus.per.correspondent.this.year < (quartiles[3] + 1.5 * IQR)])

# create boxplot
plot <- ggplot(data, aes(x = " ", y = Average.number.of.letters.sent.from.Erasmus.per.correspondent.this.year)) +
  geom_boxplot(notch = FALSE) +
  geom_text_repel(label = ifelse(data$Average.number.of.letters.sent.from.Erasmus.per.correspondent.this.year > upper_whisker, as.character(data$Year), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Average number of letters from Erasmus per correspondent")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_from_era_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_era_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_era_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_era_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
