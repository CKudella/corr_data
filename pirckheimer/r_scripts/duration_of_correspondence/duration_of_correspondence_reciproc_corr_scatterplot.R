require(tidyverse)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_reciproc_corr <- read.csv("duration_of_correspondence/duration_corr_reciproc.csv", fileEncoding = "UTF-8", colClasses = c("Start.of.correspondence" = "Date", "End.of.correspondence" = "Date"))

# calculate duration using lubridate
duration_of_correspondence_reciproc_corr$duration_in_years <- interval(duration_of_correspondence_reciproc_corr[, 2], duration_of_correspondence_reciproc_corr[, 3]) / years(1)

# drop NA rows
duration_of_correspondence_reciproc_corr <- drop_na(duration_of_correspondence_reciproc_corr)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_reciproc_corr$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_reciproc_corr$duration_in_years)

# create scatter plot
plot <- ggplot(duration_of_correspondence_reciproc_corr, aes(x = Start.of.correspondence ,y = duration_in_years)) +
  geom_point(stat = "identity", fill = "black", alpha = 0.5) +
  geom_hline(aes(yintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  scale_y_continuous(breaks = seq(0,25, by = 5)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(y = "Duration of correspondence in years", x = "Beginning of correspondence with Pirckheimer")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_reciproc_corr_scatterplot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_scatterplot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_scatterplot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_scatterplot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
