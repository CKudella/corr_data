require(tidyverse)
require(patchwork)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_correspondent/no_epp_per_cor_written_by_era.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create pointplot
plot1 <- ggplot(data = data, aes(x = reorder(recipient_id, -Number.of.letters.sent.by.Erasmus.to.this.correspondent), y = Number.of.letters.sent.by.Erasmus.to.this.correspondent, label = recipient_id)) +
  geom_point(stat = "identity") +
  geom_hline(aes(yintercept = mean(Number.of.letters.sent.by.Erasmus.to.this.correspondent), linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(Number.of.letters.sent.by.Erasmus.to.this.correspondent), linetype = "median"), size = 0.3) +
  labs(x = "Correspondent", y = "Number of letters sent by Erasmus to this correspondent") +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create box plot and violin plot combined
plot2 <- ggplot(data, aes(x = " ", y = Number.of.letters.sent.by.Erasmus.to.this.correspondent)) +
  geom_violin() +
  geom_boxplot(width = 0.1, color = "black", outlier.alpha = 0.25) +
  labs(x = "Correspondent", y = "Number of letters sent by Erasmus to this correspondent") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot2

# create combined plot via patchwork
plot1 + plot2 + plot_layout(widths = c(2, 1))

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_cor_written_by_era_plots_combined.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_by_era_plots_combined.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_by_era_plots_combined.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_by_era_plots_combined.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
