require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_year/comp_no_epp_per_year_inferred_noninferred_sent_to_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create data frame for years 1484-1536
data2 <- tibble(Year = 1484:1536)

# merge data frames
data3 <- left_join(data2, data, by = "Year")

# pivot data from wide to long format
data_long <- data3 %>%  pivot_longer(cols = c("Number.of.letters.with.inferred.send.date", "Number.of.letters.with.non.inferred.send.date"), names_to = "variable", values_to = "value")

# create stacked barchart
plot <- ggplot(data_long, aes(x = Year, y = value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity") +
  scale_y_continuous(labels = function(x) sprintf("%.0f%%", x * 100)) +
  labs(x = "Year", y = "Number of letters") +
  scale_x_continuous(breaks = c(1484:1540)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  scale_fill_grey(labels = c("Letters sent to Budé with inferred send date", "Letters sent to Budé with non-inferred send date"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_to_budé_barchart_percentage.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_to_budé_barchart_percentage.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_to_budé_barchart_percentage.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_to_budé_barchart_percentage.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
