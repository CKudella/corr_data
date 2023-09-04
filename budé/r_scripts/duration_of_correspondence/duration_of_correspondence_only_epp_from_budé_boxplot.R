require(tidyverse)
require(ggrepel)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_only_epp_from_budé <- read.csv("duration_of_correspondence/duration_corr_only_epp_from_budé.csv", fileEncoding = "UTF-8", colClasses = c("Beginning.of.the.correspondence" = "Date", "End.of.the.correspondence" = "Date"))

# set Beginning[...] and End[...] as.Date
duration_of_correspondence_only_epp_from_budé[, 3] <- as.Date(duration_of_correspondence_only_epp_from_budé[, 3], format = "%Y-%m-%d")
duration_of_correspondence_only_epp_from_budé[, 4] <- as.Date(duration_of_correspondence_only_epp_from_budé[, 4], format = "%Y-%m-%d")

# calculate duration using lubridate
duration_of_correspondence_only_epp_from_budé$duration_in_years <- interval(duration_of_correspondence_only_epp_from_budé[, 3], duration_of_correspondence_only_epp_from_budé[, 4]) / years(1)

# drop NA rows
duration_of_correspondence_only_epp_from_budé <- drop_na(duration_of_correspondence_only_epp_from_budé)

# calculate quartiles
quartiles <- as.numeric(quantile(duration_of_correspondence_only_epp_from_budé$duration_in_years, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(duration_of_correspondence_only_epp_from_budé$duration_in_years[duration_of_correspondence_only_epp_from_budé$duration_in_years > (quartiles[3] + 1.5*IQR)])

# create box plot
plot <- ggplot(duration_of_correspondence_only_epp_from_budé, aes(x = " ", y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  geom_text_repel(label = ifelse(duration_of_correspondence_only_epp_from_budé$duration_in_years >= upper_dots, as.character(duration_of_correspondence_only_epp_from_budé$name_in_edition), ""), box.padding = 0.5, max.overlaps = Inf) +
  labs(x = "Correspondent", y = "Duration of the correspondence with Budé in years") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_only_epp_from_budé_boxplot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_boxplot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_boxplot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_only_epp_from_budé_boxplot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
