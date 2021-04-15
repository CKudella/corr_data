require(readr)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/avg_no_epp_per_loc_year_written_by_pirck_at.csv", fileEncoding = "UTF-8")

# create boxplot
plot <- ggplot(data, aes(x = " ", y = Average.number.of.letters.written.by.Pirckheimer.from.this.location.per.year)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text(check_overlap = TRUE, aes(label = ifelse(Average.number.of.letters.written.by.Pirckheimer.from.this.location.per.year >= 8.8125, as.character(Location.Name), "")), hjust = -0.1, vjust = 0) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Average number of letters sent from this location by Pirckheimer per year")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_loc_year_written_by_pirck_at_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_pirck_at_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_pirck_at_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_pirck_at_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
