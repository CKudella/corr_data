require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_modern_state/comp_no_epp_from_era_to_ms_and_from_ms_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=Number.of.letters.sent.from.this.modern.state.to.Erasmus, y=Number.of.letters.Erasmus.sent.to.this.modern.state, label=ModernState)) +
  geom_point(stat = "identity") +
  geom_smooth(method = lm) +
  labs(x="Number of letters sent from this modern state to Erasmus",y="Number of letters sent from Erasmus to this modern state") + 
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
