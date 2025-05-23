require(tidyverse)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_reciproc_corr <- read.csv("duration_of_correspondence/duration_corr_reciproc.csv", fileEncoding = "UTF-8", colClasses = c("Beginning.of.the.correspondence" = "Date", "End.of.the.correspondence" = "Date"))

# remove the generic "unknown / unnamed" correspondent and "a friend" from the dataframe
duration_of_correspondence_reciproc_corr <- duration_of_correspondence_reciproc_corr %>%  filter(Correspondent != "be1dcbc4-3987-472a-b4a0-c3305ead139f")
duration_of_correspondence_reciproc_corr <- duration_of_correspondence_reciproc_corr %>%  filter(Correspondent != "cbd92b4f-8d61-4497-bace-f223843a7970")

# set Beginning[...] and End[...] as.Date
duration_of_correspondence_reciproc_corr[, 3] <- as.Date(duration_of_correspondence_reciproc_corr[, 3], format = "%Y-%m-%d")
duration_of_correspondence_reciproc_corr[, 4] <- as.Date(duration_of_correspondence_reciproc_corr[, 4], format = "%Y-%m-%d")

# calculate duration using lubridate
duration_of_correspondence_reciproc_corr$duration_in_years <- interval(duration_of_correspondence_reciproc_corr[, 3], duration_of_correspondence_reciproc_corr[, 4]) / years(1)

# drop NA rows
duration_of_correspondence_reciproc_corr <- drop_na(duration_of_correspondence_reciproc_corr)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_reciproc_corr$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_reciproc_corr$duration_in_years)

# create histogram plot
plot <- ggplot(duration_of_correspondence_reciproc_corr, aes(x = duration_in_years)) +
  geom_histogram(fill = "black", alpha = 0.5, binwidth = 1) +
  geom_vline(aes(xintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_vline(aes(xintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  labs(x = "Duration of the correspondence with Erasmus in years", y = "Number of correspondents") +
  theme_bw() +
  theme(legend.position = "bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_reciproc_corr_histogram.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_histogram.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_histogram.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_histogram.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
