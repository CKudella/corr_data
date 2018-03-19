require(readr)
require(lubridate)
require(ggplot2)
library(readr)
library(lubridate)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/duration_reciproc_budé.csv", fileEncoding="UTF-8", colClasses=c("Start.of.Correspondence"="Date","End.of.Correspondence"="Date"))

# calculate duration using lubridate
data$duration_in_years <- interval(data$Start.of.Correspondence, data$End.of.Correspondence) / years(1)

# extract start_year
data$start_year <- year(data$Start.of.Correspondence)

# set start_year as factor
data$start_year <-as.factor(data$start_year)

# create boxplot with facet grid for years
plot <- ggplot(data, aes(x= ' ', y = duration_in_years)) +
  geom_boxplot(outlier.size=2, notch = FALSE) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Duration of correspondence in years") +
  facet_grid (. ~ start_year)
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_reciproc_budé_boxplot_facet_grid_year.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_budé_boxplot_facet_grid_year.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_budé_boxplot_facet_grid_year.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_budé_boxplot_facet_grid_year.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
