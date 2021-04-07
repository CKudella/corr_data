require(readr)
require(tidyverse)
require(lubridate)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_only_epp_from_erasmus <- read.csv("duration_of_correspondence/duration_corr_only_epp_from_erasmus.csv", fileEncoding = "UTF-8", colClasses = c("FLFE" = "Date", "LLFE" = "Date"))

# calculate duration using lubridate
duration_of_correspondence_only_epp_from_erasmus$duration_in_years <- interval(duration_of_correspondence_only_epp_from_erasmus[, 2], duration_of_correspondence_only_epp_from_erasmus[, 3]) / years(1)

# drop NA rows
duration_of_correspondence_only_epp_from_erasmus <- drop_na(duration_of_correspondence_only_epp_from_erasmus)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_only_epp_from_erasmus$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_only_epp_from_erasmus$duration_in_years)

# create histogram plot
plot <- ggplot(duration_of_correspondence_only_epp_from_erasmus, aes(x = duration_in_years)) +
  geom_histogram(fill = "black", alpha = 0.5, binwidth = 1) +
  geom_vline(aes(xintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_vline(aes(xintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  scale_x_continuous(breaks = seq(0,35, by = 5)) +
  scale_y_continuous(breaks = seq(0,400, by = 50)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(y = "Number of correspondents", x = "Duration of correspondence in years")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_only_epp_from_era_histogram.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_era_histogram.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_era_histogram.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_era_histogram.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
