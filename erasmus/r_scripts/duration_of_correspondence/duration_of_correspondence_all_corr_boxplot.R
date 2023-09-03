require(tidyverse)
require(ggrepel)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_all_corr <- read.csv("duration_of_correspondence/duration_corr_all_corr.csv", fileEncoding = "UTF-8", colClasses = c("Beginning.of.correspondence.with.Erasmus" = "Date", "End.of.the.correspondence.with.Erasmus" = "Date"))

# remove the generic "unknown / unnamed" correspondent and "a friend" from the dataframe
duration_of_correspondence_all_corr <- duration_of_correspondence_all_corr %>%  filter(correspondents_id != "be1dcbc4-3987-472a-b4a0-c3305ead139f")
duration_of_correspondence_all_corr <- duration_of_correspondence_all_corr %>%  filter(correspondents_id != "cbd92b4f-8d61-4497-bace-f223843a7970")

# cut unnecessary label parts from name_in_edition column
duration_of_correspondence_all_corr$name_in_edition <- gsub("\\b(\\W+COE+.*)", "", duration_of_correspondence_all_corr$name_in_edition)
duration_of_correspondence_all_corr$name_in_edition <- gsub("^(\\W+E)", "E", duration_of_correspondence_all_corr$name_in_edition)
duration_of_correspondence_all_corr$name_in_edition <- gsub("^\\[", "", duration_of_correspondence_all_corr$name_in_edition)

# set Beginning[...] and End[...] as.Date
duration_of_correspondence_all_corr[, 3] <- as.Date(duration_of_correspondence_all_corr[, 3], format = "%Y-%m-%d")
duration_of_correspondence_all_corr[, 4] <- as.Date(duration_of_correspondence_all_corr[, 4], format = "%Y-%m-%d")

# calculate duration using lubridate
duration_of_correspondence_all_corr$duration_in_years <- interval(duration_of_correspondence_all_corr[, 3], duration_of_correspondence_all_corr[, 4]) / years(1)

# drop NA rows
duration_of_correspondence_all_corr <- drop_na(duration_of_correspondence_all_corr)

# calculate quartiles
quartiles <- as.numeric(quantile(duration_of_correspondence_all_corr$duration_in_years, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(duration_of_correspondence_all_corr$duration_in_years[duration_of_correspondence_all_corr$duration_in_years > (quartiles[3] + 1.5*IQR)])

# create box plot
plot <- ggplot(duration_of_correspondence_all_corr, aes(x = " ", y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  geom_text_repel(label = ifelse(duration_of_correspondence_all_corr$duration_in_years >= upper_dots, as.character(duration_of_correspondence_all_corr$name_in_edition), ""), box.padding = 1.2, max.overlaps = Inf, size = 2.5) +
  labs(x = "Correspondent", y = "Duration of the correspondence with Erasmus in years") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_all_corr_boxplot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
