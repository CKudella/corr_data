require(tidyverse)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_only_epp_to_budé <- read.csv("duration_of_correspondence/duration_corr_only_epp_to_budé.csv", fileEncoding = "UTF-8", colClasses = c("FLTE" = "Date", "LLTE" = "Date"))

# calculate duration using lubridate
duration_of_correspondence_only_epp_to_budé$duration_in_years <- interval(duration_of_correspondence_only_epp_to_budé[, 2], duration_of_correspondence_only_epp_to_budé[, 3]) / years(1)

# drop NA rows
duration_of_correspondence_only_epp_to_budé <- drop_na(duration_of_correspondence_only_epp_to_budé)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_only_epp_to_budé$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_only_epp_to_budé$duration_in_years)

# create scatterplot plot
plot <- ggplot(duration_of_correspondence_only_epp_to_budé, aes(x = FLTE ,y = duration_in_years)) +
  geom_point(stat = "identity", fill = "black", alpha = 0.5) +
  geom_hline(aes(yintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  scale_y_continuous(breaks = seq(0,25, by = 5)) +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(y = "Duration of correspondence in years", x = "Beginning of correspondence with Budé")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_only_epp_to_budé_scatterplot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_to_budé_scatterplot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_to_budé_scatterplot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_to_budé_scatterplot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
