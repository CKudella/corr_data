require(readr)
require(ggplot2)
require(ggrepel)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_pirck_to.csv", fileEncoding = "UTF-8")

# calculate quartiles
quartiles <- as.numeric(quantile(data$Number.of.letters.sent.to.this.location.from.Pirckheimer, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate upper whisker
upper_whisker <- max(data$Number.of.letters.sent.to.this.location.from.Pirckheimer[data$Number.of.letters.sent.to.this.location.from.Pirckheimer < (quartiles[3] + 1.5 * IQR)])

# create boxplot
plot <- ggplot(data, aes(x = " ", y = Number.of.letters.sent.to.this.location.from.Pirckheimer)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(label = ifelse(data$Number.of.letters.sent.to.this.location.from.Pirckheimer > upper_whisker, as.character(data$Location.Name), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Number of letters sent from Pirckheimer to this location")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_by_pirck_to_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_pirck_to_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_pirck_to_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_pirck_to_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
