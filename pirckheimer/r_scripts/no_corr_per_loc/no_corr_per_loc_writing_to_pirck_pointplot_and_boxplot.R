require(tidyverse)
require(ggrepel)
require(patchwork)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_loc/no_corr_per_loc_writing_to_pirck_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# calculate quartiles
quartiles <- as.numeric(quantile(data$Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer[data$Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer > (quartiles[3] + 1.5*IQR)])

# create pointplot
plot1 <- ggplot(data = data, aes(x = reorder(Location.Name.Modern, -Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer), y = Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer, label = Location.Name.Modern)) +
  geom_point(stat = "identity") +
  geom_hline(aes(yintercept = mean(Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer), linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer), linetype = "median"), size = 0.3) +
  labs(x = "Location", y = "Number of correspondents who wrote from this location to Pirckheimer") +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create box plot
plot2 <- ggplot(data, aes(x = " ", y = Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(label = ifelse(data$Number.of.correspondents.who.wrote.from.this.location.letters.to.Pirckheimer >= upper_dots, as.character(data$Location.Name.Modern), ""), box.padding = 1.5, max.overlaps = Inf) +
  labs(x = "Location", y = "Number of correspondents who wrote from this location to Pirckheimer") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
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
