require(readr)
require(ggplot2)
require(ggrepel)
require(ggpubr)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_sent_from.csv", fileEncoding = "UTF-8")

# create pointplot (with sqrt trans)
plot <- ggplot(data = data, aes(x = reorder(Location.Name, -Number.of.letters.sent.from.this.location), y = Number.of.letters.sent.from.this.location, label = Location.Name)) +
  geom_point(stat = "identity") +
  labs(x = "Locations", y = "Number of letters sent from this location") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# create boxplot (with log10 trans)
plot2 <- ggplot(data, aes(x = " ", y = Number.of.letters.sent.from.this.location)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(label = ifelse(data$Number.of.letters.sent.from.this.location > 11, as.character(data$Location.Name), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Number of letters sent from this location")
plot2

# arrange plots
ggarrange(plot, plot2,
  ncol = 2, nrow = 1
)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
