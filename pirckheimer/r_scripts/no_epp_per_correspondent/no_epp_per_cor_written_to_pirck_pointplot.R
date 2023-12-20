require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_correspondent/no_epp_per_cor_written_to_pirck.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create pointplot
plot <- ggplot(data = data, aes(x = reorder(sender_id, -Number.of.letters.sent.to.Pirckheimer.from.this.correspondent), y = Number.of.letters.sent.to.Pirckheimer.from.this.correspondent, label = sender_id)) +
  geom_point(stat = "identity") +
  geom_hline(aes(yintercept = mean(Number.of.letters.sent.to.Pirckheimer.from.this.correspondent), linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(Number.of.letters.sent.to.Pirckheimer.from.this.correspondent), linetype = "median"), size = 0.3) +
  labs(x = "Correspondent", y = "Number of letters sent by this correspondent to Pirckheimer") +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_cor_written_to_pirck_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_pirck_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_pirck_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_pirck_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
