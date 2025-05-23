require(tidyverse)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read duration_of_correspondence_reciproc_corr and define duration_of_correspondence_reciproc_corr type for date columns
duration_of_correspondence_reciproc_corr<-read.csv("duration_of_correspondence/duration_corr_reciproc.csv", fileEncoding="UTF-8", colClasses=c("Beginning.of.the.correspondence"="Date","End.of.the.correspondence"="Date"))

# calculate duration using lubridate
duration_of_correspondence_reciproc_corr$duration_in_years <- interval(duration_of_correspondence_reciproc_corr$Beginning.of.the.correspondence, duration_of_correspondence_reciproc_corr$End.of.the.correspondence) / years(1)

# extract start_year
duration_of_correspondence_reciproc_corr$start_year <- year(duration_of_correspondence_reciproc_corr$Beginning.of.the.correspondence)

# remove star_year rows with NA
duration_of_correspondence_reciproc_corr <- duration_of_correspondence_reciproc_corr %>% filter(!is.na(start_year))

# set start_year as factor
duration_of_correspondence_reciproc_corr$start_year <-as.factor(duration_of_correspondence_reciproc_corr$start_year)

# create facet wrap with box plots
plot <- ggplot(duration_of_correspondence_reciproc_corr, aes(x= ' ', y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(x = "Starting year of the correspondence with Budé", y = "Duration of the correspondence with Budé in years") +
  facet_wrap (. ~ start_year, ncol =5 , nrow = 10) +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_reciproc_corr_boxplot_facet_grid_year.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_boxplot_facet_grid_year.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_boxplot_facet_grid_year.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_reciproc_corr_boxplot_facet_grid_year.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
