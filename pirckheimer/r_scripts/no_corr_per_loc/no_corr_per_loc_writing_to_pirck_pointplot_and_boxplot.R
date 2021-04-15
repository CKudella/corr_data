require(readr)
require(ggplot2)
require(ggrepel)
require(patchwork)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_loc/no_corr_per_loc_writing_to_pirck_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create pointplot
plot1 <- ggplot(data = data, aes(x = reorder(Location.Name.Modern, -Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer), y = Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer, label = Location.Name.Modern)) +
  geom_point(stat = "identity") +
  labs(x = "Locations", y = "Number of correspondents writing letters to Pirckheimer") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create boxplot
plot2 <- ggplot(data, aes(x = " ", y = Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(label = ifelse(data$Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer > 3.5, as.character(data$Location.Name.Modern), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Number of correspondents writing letters to Pirckheimer")
plot2

# create combined plot via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_corr_per_loc_writing_to_pirck_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_writing_to_pirck_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_writing_to_pirck_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_writing_to_pirck_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
