require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc/no_epp_per_loc_written_by_era_at_with_geocoordiantes.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x= reorder(Location.Name, -Number.of.letters.sent.from.this.location.from.Erasmus), y=Number.of.letters.sent.from.this.location.from.Erasmus, label=Location.Name)) + 
  geom_point(stat = "identity") + 
  labs(x="Locations",y="Number of letters sent from this location from Erasmus") + 
  geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.letters.sent.from.this.location.from.Erasmus>400,as.character(Location.Name),'')),hjust=-0.1,vjust=0) +
  theme_bw() +
  theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_written_by_era_at_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
