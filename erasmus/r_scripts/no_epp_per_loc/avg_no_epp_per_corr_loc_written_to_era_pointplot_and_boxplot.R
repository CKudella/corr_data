require(tidyverse)
require(ggrepel)
require(patchwork)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/avg_no_epp_per_corr_loc_written_to_era.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# calculate quartiles
quartiles <- as.numeric(quantile(data$Average.Number.of.Letters, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Average.Number.of.Letters[data$Average.Number.of.Letters > (quartiles[3] + 1.5*IQR)])

# create pointplot
plot1 <- ggplot(data = data, aes(x = reorder(Location.Name, -Average.Number.of.Letters), y = Average.Number.of.Letters, label = Location.Name)) +
  geom_point(stat = "identity") +
  labs(x = "Location", y = "Average number of letters sent to Erasmus from this location per correspondent") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create box plot
plot2 <- ggplot(data, aes(x = " ", y = Average.Number.of.Letters)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(box.padding = 2, max.overlaps = Inf, label = ifelse(data$Average.Number.of.Letters >= upper_dots, as.character(data$Location.Name), "")) +
  labs(x = "Location", y = "Average number of letters sent to Erasmus from this location per correspondent") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot2

# create combined plot via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_loc_written_to_era_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_to_era_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_to_era_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_to_era_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
