require(readr)
require(tidyverse)
require(lubridate)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_only_epp_from_budé <- read.csv("duration_of_correspondence/duration_corr_only_epp_from_budé.csv", fileEncoding = "UTF-8", colClasses = c("FLFE" = "Date", "LLFE" = "Date"))

# calculate duration using lubridate
duration_of_correspondence_only_epp_from_budé$duration_in_years <- interval(duration_of_correspondence_only_epp_from_budé[, 2], duration_of_correspondence_only_epp_from_budé[, 3]) / years(1)

# drop NA rows
duration_of_correspondence_only_epp_from_budé <- drop_na(duration_of_correspondence_only_epp_from_budé)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_only_epp_from_budé$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_only_epp_from_budé$duration_in_years)

# create density plot
plot <- ggplot(duration_of_correspondence_only_epp_from_budé, aes(x = duration_in_years)) +
  geom_density(fill = "black", alpha = 0.5) +
  geom_vline(aes(xintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_vline(aes(xintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  scale_x_continuous(breaks = seq(0,35, by = 5)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(y = "density", x = "Duration of correspondence in years")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_only_epp_from_budé_density_plot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_density_plot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_density_plot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_density_plot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
