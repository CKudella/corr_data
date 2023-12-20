require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_modern_state_year/comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# pivot data from wide to long format
data_long <- data %>% pivot_longer(cols = c(NoEppSentFromEra, NoEppSentToEra), names_to = "variable", values_to = "value")

# create facet grid with bar charts
plot <- ggplot(data = data_long, aes(x = Year, y = value, linetype = variable)) +
  geom_line(stat = "identity", size = 0.9) +
  labs(x = "Year", y = "Number of letters") +
  scale_x_continuous(breaks = c(1484:1536)) +
  facet_grid(ModernState ~ ., space = "free") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  scale_colour_discrete(labels = c("Number of letters sent by Erasmus to this modern state per year", "Number of letters sent to Erasmus from this modern state per year"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year_facet_grid.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year_facet_grid.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year_facet_grid.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year_facet_grid.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
