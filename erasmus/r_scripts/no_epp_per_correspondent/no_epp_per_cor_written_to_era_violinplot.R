require(readr)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_correspondent/no_epp_per_cor_written_to_era.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create violin and boxplot combined
plot <- ggplot(data, aes(x = " ", y = Number.of.letters.sent.to.Erasmus.from.this.correspondent)) +
  geom_violin() +
  geom_boxplot(width = 0.1, color = "black", outlier.alpha = 0.25) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Number of letters written to Erasmus")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_cor_written_to_era_violinplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_era_violinplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_era_violinplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_era_violinplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
