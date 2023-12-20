require(tidyverse)
require(ggrepel)
require(patchwork)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_loc/no_corr_per_loc_receiving_from_pirck_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# caculate quartiles
quartiles <- as.numeric(quantile(data$Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer[data$Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer > (quartiles[3] + 1.5*IQR)])

# create pointplot
plot1 <- ggplot(data = data, aes(x = reorder(Location.Name.Modern, -Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer), y = Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer, label = Location.Name.Modern)) +
  geom_point(stat = "identity") +
  geom_hline(aes(yintercept = mean(Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer), linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer), linetype = "median"), size = 0.3) +
  labs(x = "Location", y = "Number of correspondents at this location to whom Pirckheimer wrote") +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create box plot
plot2 <- ggplot(data, aes(x = " ", y = Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(label = ifelse(data$Number.of.correspondents.who.received.at.this.Location.letters.from.Pirckheimer >= upper_dots, as.character(data$Location.Name.Modern), "")) +
  labs(x = "Location", y = "Number of correspondents at this location to whom Pirckheimer wrote") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot2

# create combined plot via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_corr_per_loc_receiving_from_pirck_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_pirck_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_pirck_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_pirck_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
