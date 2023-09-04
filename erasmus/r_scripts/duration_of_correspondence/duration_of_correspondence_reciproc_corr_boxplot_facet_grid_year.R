require(tidyverse)
require(ggrepel)
require(svglite)
require(lubridate) # in case an older tidyverse package version is used

# set working directory
getwd()
setwd("../query_results/")

# read data and define date type for date columns
duration_of_correspondence_reciproc_corr<-read.csv("duration_of_correspondence/duration_corr_reciproc.csv", fileEncoding="UTF-8", colClasses=c("Beginning.of.the.correspondence"="Date","End.of.the.correspondence"="Date"))

# remove the generic "unknown / unnamed" correspondent and "a friend" from the duration_of_correspondence_reciproc_corrframe
duration_of_correspondence_reciproc_corr <- duration_of_correspondence_reciproc_corr %>%  filter(Correspondent != "be1dcbc4-3987-472a-b4a0-c3305ead139f")
duration_of_correspondence_reciproc_corr <- duration_of_correspondence_reciproc_corr %>%  filter(Correspondent != "cbd92b4f-8d61-4497-bace-f223843a7970")

# cut unnecessary label parts from name_in_edition column
duration_of_correspondence_reciproc_corr$name_in_edition <- gsub("\\b(\\W+COE+.*)", "", duration_of_correspondence_reciproc_corr$name_in_edition)
duration_of_correspondence_reciproc_corr$name_in_edition <- gsub("^(\\W+E)", "E", duration_of_correspondence_reciproc_corr$name_in_edition)
duration_of_correspondence_reciproc_corr$name_in_edition <- gsub("^\\[", "", duration_of_correspondence_reciproc_corr$name_in_edition)

# calculate duration using lubridate
duration_of_correspondence_reciproc_corr$duration_in_years <- interval(duration_of_correspondence_reciproc_corr$Beginning.of.the.correspondence, duration_of_correspondence_reciproc_corr$End.of.the.correspondence) / years(1)

# extract start_year
duration_of_correspondence_reciproc_corr$start_year <- year(duration_of_correspondence_reciproc_corr$Beginning.of.the.correspondence)

# remove star_year rows with NA
duration_of_correspondence_reciproc_corr <- duration_of_correspondence_reciproc_corr %>% filter(!is.na(start_year))

# set start_year as factor
duration_of_correspondence_reciproc_corr$start_year <-as.factor(duration_of_correspondence_reciproc_corr$start_year)

# identify outliers for each start_year
outliers_df <- duration_of_correspondence_reciproc_corr %>%
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
plot <- ggplot(duration_of_correspondence_reciproc_corr, aes(x= ' ', y = duration_in_years)) +
  geom_boxplot(notch = FALSE) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(x = "Starting year of the correspondence with Erasmus", y = "Duration of the correspondence with Erasmus in years") +
  facet_wrap (. ~ start_year, ncol =5 , nrow = 10) +
  geom_text_repel(data = outliers_df, aes(label = name_in_edition), box.padding = 0.5, max.overlaps = Inf, size = 2.3) +
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
