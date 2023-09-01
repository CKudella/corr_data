require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_correspondent/no_epp_per_cor_written_to_era.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# cut unnecessary label parts from name_in_edition column
data$name_in_edition <- gsub("\\b(\\W+COE+.*)", "", data$name_in_edition)
data$name_in_edition <- gsub("^(\\W+E)", "E", data$name_in_edition)
data$name_in_edition <- gsub("^\\[", "", data$name_in_edition)

#identify outliers
outliers_df <- data %>%
  mutate(
    Q1 = quantile(Number.of.letters.sent.to.Erasmus.from.this.correspondent, 0.25),
    Q3 = quantile(Number.of.letters.sent.to.Erasmus.from.this.correspondent, 0.75),
    IQR = Q3 - Q1,
    lower_bound = Q1 - 1.5 * IQR,
    upper_bound = Q3 + 1.5 * IQR,
    is_outlier = Number.of.letters.sent.to.Erasmus.from.this.correspondent < lower_bound | Number.of.letters.sent.to.Erasmus.from.this.correspondent > upper_bound
  ) %>%
  filter(is_outlier)

# create box plot
plot <- ggplot(data, aes(x = " ", y = Number.of.letters.sent.to.Erasmus.from.this.correspondent)) +
  geom_boxplot(width = 0.1, color = "black", outlier.alpha = 0.5) +
  geom_text_repel(data = outliers_df, aes(label = name_in_edition), hjust = 1.2, vjust = 0, box.padding = 3, max.overlaps = Inf, size = 3) +
  labs(x = "Correspondent", y = "Number of letters sent to Erasmus by this correspondent") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_cor_written_to_era_violinplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_era_violinplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_era_violinplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_cor_written_to_era_violinplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
