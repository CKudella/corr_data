require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/avg_no_epp_per_loc_year_written_by_era_at.csv", fileEncoding = "UTF-8")

# calculate quartiles
quartiles <- as.numeric(quantile(data$Average.Number.of.Letters.written.by.Erasmus.from.this.location.per.year, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Average.Number.of.Letters.written.by.Erasmus.from.this.location.per.year[data$Average.Number.of.Letters.written.by.Erasmus.from.this.location.per.year > (quartiles[3] + 1.5*IQR)])

# create box plot
plot <- ggplot(data, aes(x = " ", y = Average.Number.of.Letters.written.by.Erasmus.from.this.location.per.year)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text(check_overlap = TRUE, aes(label = ifelse(Average.Number.of.Letters.written.by.Erasmus.from.this.location.per.year >= upper_dots, as.character(Location.Name), "")), hjust = -0.1, vjust = 0) +
  labs(x = "Location", y = "Average number of letters written by Erasmus at this location per year") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())  
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_loc_year_written_by_era_at_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_era_at_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_era_at_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_era_at_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
