require(readr)
require(tidyverse)
require(lubridate)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_only_epp_to_pirck <- read.csv("duration_of_correspondence/duration_corr_only_epp_to_pirck.csv", fileEncoding = "UTF-8", colClasses = c("FLTE" = "Date", "LLTE" = "Date"))

# calculate duration using lubridate
duration_of_correspondence_only_epp_to_pirck$duration_in_years <- interval(duration_of_correspondence_only_epp_to_pirck[, 2], duration_of_correspondence_only_epp_to_pirck[, 3]) / years(1)

# drop NA rows
duration_of_correspondence_only_epp_to_pirck <- drop_na(duration_of_correspondence_only_epp_to_pirck)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_only_epp_to_pirck$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_only_epp_to_pirck$duration_in_years)

# create boxplot
plot <- ggplot(duration_of_correspondence_only_epp_to_pirck, aes(x = " ", y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Duration of correspondence in years")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_only_epp_to_pirck_boxplot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_to_pirck_boxplot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_to_pirck_boxplot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_to_pirck_boxplot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
