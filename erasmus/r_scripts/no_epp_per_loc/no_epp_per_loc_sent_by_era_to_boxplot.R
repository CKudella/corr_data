require(tidyverse)
require(ggrepel)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_era_to.csv", fileEncoding = "UTF-8")

# calculate quartiles
quartiles <- as.numeric(quantile(data$Number.of.letters.sent.to.this.location.from.Erasmus, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Number.of.letters.sent.to.this.location.from.Erasmus[data$Number.of.letters.sent.to.this.location.from.Erasmus > (quartiles[3] + 1.5*IQR)])

# create box plot
plot <- ggplot(data, aes(x = " ", y = Number.of.letters.sent.to.this.location.from.Erasmus)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(box.padding = 2, max.overlaps = Inf, label = ifelse(data$Number.of.letters.sent.to.this.location.from.Erasmus >= upper_dots, as.character(data$Location.Name), "")) +
  labs(x = "Location", y = "Number of letters sent by Erasmus to this location") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_by_era_to_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_era_to_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_era_to_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_era_to_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
