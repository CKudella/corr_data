require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_year/no_epp_per_day_sent_by_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# Set send_date_computable1 asDate
data$send_date_computable1 <- as.Date(data$send_date_computable1, format = "%Y-%m-%d")

# Compute yearday, monthday, month, year
data$yday <- yday(data$send_date_computable1)
data$mday <- mday(data$send_date_computable1)
data$month <- month(data$send_date_computable1)
data$year <- year(data$send_date_computable1)

# create facet grid with bar charts
plot <- ggplot(data = data, aes(x = mday, y = NoEppSentFromBudé)) +
  geom_bar(stat = "identity") +
  labs(x = "Day", y = "Number of letters sent by Budé") +
  scale_y_continuous(breaks = seq(0, 5, 1)) +
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
ggsave("no_epp_per_day_sent_by_budé.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_day_sent_by_budé.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_day_sent_by_budé.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_day_sent_by_budé.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
