require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_corr_year_mut_corr_era_pirck/no_epp_year_era_pirck_with_leo_x_pope.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# set labels
labels <- c(EPPEtX = "Erasmus to Pope LEO X", EPPXtE = "Pope LEO X to Erasmus", EPPPtX = "Pirckheimer to Pope LEO X", EPPXtP = "Pope LEO X to Pirckheimer")

# pivot data to longer format
data_long <- data %>% pivot_longer(cols = starts_with("EPP"), names_to = "variable", values_to = "value")

# plot facet grid
plot <- ggplot(data=data_long, aes(x= Year,y=value, factor = variable)) +
    geom_point(stat = "identity", size = 1.75) +
    labs(x="Year",y="Number of letters") +
    scale_x_continuous(breaks = c(1484:1536)) +
    scale_y_continuous(limits = c(0,3)) +
    facet_grid(variable ~ ., labeller=labeller(variable = labels)) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
    theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
    theme(legend.position="bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_year_era_pirck_with_leo_x_pope_facet_grid.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_year_era_pirck_with_leo_x_pope_facet_grid.png", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_year_era_pirck_with_leo_x_pope_facet_grid.eps", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_year_era_pirck_with_leo_x_pope_facet_grid.svg", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
