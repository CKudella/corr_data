require(tidyverse)
require(ggrepel)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/duration_corr_all_corr.csv", fileEncoding="UTF-8", colClasses=c("Beginning.of.correspondence.with.Pirckheimer"="Date","End.of.the.correspondence.with.Pirckheimer"="Date"))

# calculate duration using lubridate
data$duration_in_years <- interval(data$Beginning.of.correspondence.with.Pirckheimer, data$End.of.the.correspondence.with.Pirckheimer) / years(1)

# extract start_year
data$start_year <- year(data$Beginning.of.correspondence.with.Pirckheimer)

# remove star_year rows with NA
data <- data %>% filter(!is.na(start_year))

# set start_year as factor
data$start_year <-as.factor(data$start_year)

# identify outliers for each start_year
outliers_df <- data %>%
  group_by(start_year) %>%
  mutate(
    Q1 = quantile(duration_in_years, 0.25),
    Q3 = quantile(duration_in_years, 0.75),
    IQR = Q3 - Q1,
    lower_bound = Q1 - 1.5 * IQR,
    upper_bound = Q3 + 1.5 * IQR,
    is_outlier = duration_in_years < lower_bound | duration_in_years > upper_bound,
    outlier_years = ifelse(is_outlier, as.character(name_in_edition), "")
  ) %>%
  filter(is_outlier) %>%
  ungroup()

# create facet wrap with box plots
plot <- ggplot(data, aes(x= ' ', y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(x = "Beginning of the correspondence with Pirckheimer", y = "Duration of correspondence in years") +
  facet_wrap (. ~ start_year, ncol =5 , nrow = 10) +
  geom_text_repel(data = outliers_df, aes(label = name_in_edition), box.padding = 0.5, max.overlaps = Inf, size = 2.3) +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.pdf", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.png", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.eps", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspondence_all_corr_boxplot_facet_grid_year.svg", plot = last_plot(), scale = 1, width = 33.1, height = 23.4, units = "in", dpi = 600, limitsize = TRUE)
