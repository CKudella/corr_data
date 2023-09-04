require(tidyverse)
require(ggrepel)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
duration_of_correspondence_reciproc_corr <- read.csv("duration_of_correspondence/duration_corr_reciproc.csv", fileEncoding = "UTF-8", colClasses = c("Beginning.of.the.correspondence" = "Date", "End.of.the.correspondence" = "Date"))

# remove the generic "unknown / unnamed" correspondent from the dataframe
duration_of_correspondence_reciproc_corr <- duration_of_correspondence_reciproc_corr %>%  filter(Correspondent != "be1dcbc4-3987-472a-b4a0-c3305ead139f")

# set Beginning[...] and End[...] as.Date
duration_of_correspondence_reciproc_corr[, 3] <- as.Date(duration_of_correspondence_reciproc_corr[, 3], format = "%Y-%m-%d")
duration_of_correspondence_reciproc_corr[, 4] <- as.Date(duration_of_correspondence_reciproc_corr[, 4], format = "%Y-%m-%d")

# remove rows with the specified pattern in name_in_edition column using gsub
duration_of_correspondence_reciproc_corr$name_in_edition <- gsub("\\s*//\\s*.*", "", duration_of_correspondence_reciproc_corr$name_in_edition)

# calculate duration using lubridate
duration_of_correspondence_reciproc_corr$duration_in_years <- interval(duration_of_correspondence_reciproc_corr[, 3], duration_of_correspondence_reciproc_corr[, 4]) / years(1)

# drop NA rows
duration_of_correspondence_reciproc_corr <- drop_na(duration_of_correspondence_reciproc_corr)

# calculate quartiles
quartiles <- as.numeric(quantile(duration_of_correspondence_reciproc_corr$duration_in_years, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(duration_of_correspondence_reciproc_corr$duration_in_years[duration_of_correspondence_reciproc_corr$duration_in_years > (quartiles[3] + 1.5*IQR)])

# create box plot
plot <- ggplot(duration_of_correspondence_reciproc_corr, aes(x = " ", y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  geom_text_repel(label = ifelse(duration_of_correspondence_reciproc_corr$duration_in_years >= upper_dots, as.character(duration_of_correspondence_reciproc_corr$name_in_edition), ""), box.padding = 1, max.overlaps = Inf) +
  labs(x = "Correspondent", y = "Duration of the correspondence with Pirckheimer in years") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_reciproc_corr_boxplot.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_boxplot.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_boxplot.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_boxplot.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
