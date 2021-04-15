require(readr)
require(tidyverse)
require(lubridate)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_all_corr <- read.csv("duration_of_correspondence/duration_corr_all_corr.csv", fileEncoding = "UTF-8", colClasses = c("Beginning.of.correspondence.with.Budé" = "Date", "End.of.the.correspondence.with.Budé" = "Date"))

# set Beginning[...] and End[...] as.Date
duration_of_correspondence_all_corr[, 3] <- as.Date(duration_of_correspondence_all_corr[, 3], format = "%Y-%m-%d")
duration_of_correspondence_all_corr[, 4] <- as.Date(duration_of_correspondence_all_corr[, 4], format = "%Y-%m-%d")

# calculate duration using lubridate
duration_of_correspondence_all_corr$duration_in_years <- interval(duration_of_correspondence_all_corr[, 3], duration_of_correspondence_all_corr[, 4]) / years(1)

# round duration to 1 digit
duration_of_correspondence_all_corr$duration_in_years <- round(duration_of_correspondence_all_corr$duration_in_years, digits = 1)

# drop NA rows
duration_of_correspondence_all_corr <- drop_na(duration_of_correspondence_all_corr)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_all_corr$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_all_corr$duration_in_years)

# create scatterplot plot
plot <- ggplot(duration_of_correspondence_all_corr, aes(x = Beginning.of.correspondence.with.budé ,y = duration_in_years)) +
  geom_point(stat = "identity", fill = "black", alpha = 0.5) +
  geom_hline(aes(yintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  scale_y_continuous(breaks = seq(0,25, by = 5)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(y = "Duration of correspondence in years", x = "Beginning of the correspondence with Budé")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_all_corr_scatterplot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_scatterplot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_scatterplot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_scatterplot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
