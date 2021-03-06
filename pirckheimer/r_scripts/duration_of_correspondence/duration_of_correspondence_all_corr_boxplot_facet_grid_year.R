require(readr)
require(lubridate)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/duration_corr_all_corr.csv", fileEncoding="UTF-8", colClasses=c("Beginning.of.correspondence.with.Pirckheimer"="Date","End.of.the.correspondence.with.Pirckheimer"="Date"))

# calculate duration using lubridate
data$duration_in_years <- interval(data$Beginning.of.correspondence.with.Pirckheimer, data$End.of.the.correspondence.with.Pirckheimer) / years(1)

# extract start_year
data$start_year <- year(data$Beginning.of.correspondence.with.Pirckheimer)

# set start_year as factor
data$start_year <-as.factor(data$start_year)

# create boxplot with facet grid for years
plot <- ggplot(data, aes(x= ' ', y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Duration of correspondence in years") +
  facet_grid (. ~ start_year)
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
