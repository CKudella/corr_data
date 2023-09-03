require(tidyverse)
require(patchwork)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_only_epp_from_budé <- read.csv("duration_of_correspondence/duration_corr_only_epp_from_budé.csv", fileEncoding = "UTF-8", colClasses = c("FLFE" = "Date", "LLFE" = "Date"))

# set Beginning[...] and End[...] as.Date
duration_of_correspondence_only_epp_from_budé[, 3] <- as.Date(duration_of_correspondence_only_epp_from_budé[, 3], format = "%Y-%m-%d")
duration_of_correspondence_only_epp_from_budé[, 4] <- as.Date(duration_of_correspondence_only_epp_from_budé[, 4], format = "%Y-%m-%d")

# calculate duration using lubridate
duration_of_correspondence_only_epp_from_budé$duration_in_years <- interval(duration_of_correspondence_only_epp_from_budé[, 3], duration_of_correspondence_only_epp_from_budé[, 4]) / years(1)

# drop NA rows
duration_of_correspondence_only_epp_from_budé <- drop_na(duration_of_correspondence_only_epp_from_budé)

# calculate mean of "duration of correspondence"
duration_of_correspondence_mean <- mean(duration_of_correspondence_only_epp_from_budé$duration_in_years)

# calculate median of "duration of correspondence"
duration_of_correspondence_median <- median(duration_of_correspondence_only_epp_from_budé$duration_in_years)

# create box plot
plot1 <- ggplot(duration_of_correspondence_only_epp_from_budé, aes(x = " ", y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  labs(x = "Correspondent", y = "Duration of the correspondence with Budé in years") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create density plot
plot2 <- ggplot(duration_of_correspondence_only_epp_from_budé, aes(x = duration_in_years)) +
  geom_density(fill = "black", alpha = 0.5) +
  geom_vline(aes(xintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_vline(aes(xintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  labs(x = "Duration of the correspondence with Budé in years", y = "Density") +
  theme_bw() +
  theme(legend.position = "bottom")
plot2

# create histogram plot
plot3 <- ggplot(duration_of_correspondence_only_epp_from_budé, aes(x = duration_in_years)) +
  geom_histogram(fill = "black", alpha = 0.5, binwidth = 1) +
  geom_vline(aes(xintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_vline(aes(xintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  labs(x = "Duration of the correspondence with Budé in years", y = "Number of correspondents") +
  theme_bw() +
  theme(legend.position = "bottom")
plot3

# create scatter plot
plot4 <- ggplot(duration_of_correspondence_only_epp_from_budé, aes(x = FLFE ,y = duration_in_years)) +
  geom_point(stat = "identity", fill = "black", alpha = 0.5) +
  geom_hline(aes(yintercept = mean(duration_in_years), linetype="mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(duration_in_years), linetype="median"), size = 0.3) +
  labs(x = "Starting year of the correspondence with Budé", y = "Duration of the correspondence with Budé in years") +
  theme_bw() +
  theme(legend.position = "bottom")
plot4

# combine plots via patchwork
plot1 + plot2 + plot3 + plot4 + plot_layout(ncol = 2)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_only_epp_from_budé_plots_combined.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_plots_combined.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_plots_combined.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_plots_combined.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
