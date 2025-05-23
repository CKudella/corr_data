require(tidyverse)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_year/no_epp_per_day_sent_by_era.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# set send_date_computable1 asDate
data$send_date_computable1 <- as.Date(data$send_date_computable1, format = "%Y-%m-%d")

# compute yearday, monthday, month, year
data$yday <- yday(data$send_date_computable1)
data$mday <- mday(data$send_date_computable1)
data$month <- month(data$send_date_computable1)
data$year <- year(data$send_date_computable1)

# create facet grid with bar charts
plot <- ggplot(data = data, aes(x = mday, y = NoEppSentFromEra)) +
  geom_bar(stat = "identity") +
  labs(x = "Day", y = "Number of letters sent by Erasmus") +
  scale_y_continuous(breaks = seq(0, 14, 2)) +
  facet_grid(year ~ month) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
  theme(legend.position = "bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_day_sent_by_era_facet_grid.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_day_sent_by_era_facet_grid.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_day_sent_by_era_facet_grid.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_day_sent_by_era_facet_grid.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
