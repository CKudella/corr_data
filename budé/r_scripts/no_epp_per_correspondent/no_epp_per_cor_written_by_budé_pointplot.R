require(readr)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_correspondent/no_epp_per_cor_written_by_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create pointplot
plot <- ggplot(data = data, aes(x = reorder(recipient_id, -Number.of.letters.sent.from.Budé.to.this.correspondent), y = Number.of.letters.sent.from.Budé.to.this.correspondent, label = recipient_id)) +
  geom_point(stat = "identity") +
  labs(x = "Correspondents", y = "Number of letters received from from Budé") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_cor_written_by_budé_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_by_budé_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_by_budé_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_by_budé_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
