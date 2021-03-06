require(readr)
require(ggplot2)
require(ggrepel)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/avg_no_epp_per_loc_year_written_to_era.csv", fileEncoding = "UTF-8")

# create boxplot
plot <- ggplot(data, aes(x = " ", y = Average.Number.of.Letters.written.from.this.location.to.Erasmus.per.year)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(box.padding = 1.25, label = ifelse(data$Average.Number.of.Letters.written.from.this.location.to.Erasmus.per.year > 2.5825, as.character(data$Location.Name), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Average number of letters sent to Erasmus from this location per year")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_loc_year_written_to_era_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_to_era_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_to_era_to_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_to_era_to_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
