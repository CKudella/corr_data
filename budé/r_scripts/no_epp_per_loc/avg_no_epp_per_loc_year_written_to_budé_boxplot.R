require(tidyverse)
require(ggrepel)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/avg_no_epp_per_loc_year_written_to_budé.csv", fileEncoding = "UTF-8")

# caculate quartiles
quartiles <- as.numeric(quantile(data$Average.number.of.letters.written.from.this.location.to.Budé.per.year, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate upper outlier treshold
upper_dots <- min(data$Average.number.of.letters.written.from.this.location.to.Budé.per.year[data$Average.number.of.letters.written.from.this.location.to.Budé.per.year > (quartiles[3] + 1.5*IQR)])

# calculate lower whisker
lower_dots <- max(data$Average.number.of.letters.written.from.this.location.to.Budé.per.year[data$Average.number.of.letters.written.from.this.location.to.Budé.per.year < (quartiles[1] - 1.5 * IQR)])

# create boxplot
plot <- ggplot(data, aes(x = " ", y = Average.number.of.letters.written.from.this.location.to.Budé.per.year)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(label = ifelse(data$Average.number.of.letters.written.from.this.location.to.Budé.per.year >= upper_dots, as.character(data$Location.Name), "")) +
  geom_text_repel(label = ifelse(data$Average.number.of.letters.written.from.this.location.to.Budé.per.year <= lower_dots, as.character(data$Location.Name), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Average number of letters sent to Budé from this location per year")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_loc_year_written_to_budé_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_to_budé_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_to_budé_to_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_to_budé_to_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
