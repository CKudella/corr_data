require(readr)
require(ggplot2)
require(ggrepel)
require(patchwork)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_loc/no_corr_per_loc_receiving_from_budé_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# caculate quartiles
quartiles <- as.numeric(quantile(data$Number.of.correspondents.who.received.at.this.location.letters.from.Budé, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Number.of.correspondents.who.received.at.this.location.letters.from.Budé[data$Number.of.correspondents.who.received.at.this.location.letters.from.Budé > (quartiles[3] + 1.5*IQR)])

# create pointplot
plot1 <- ggplot(data = data, aes(x = reorder(Location.Name.Modern, -Number.of.correspondents.who.received.at.this.location.letters.from.Budé), y = Number.of.correspondents.who.received.at.this.location.letters.from.Budé, label = Location.Name.Modern)) +
  geom_point(stat = "identity") +
  labs(x = "Locations", y = "Number of correspondents receiving letters from Budé") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create boxplot
plot2 <- ggplot(data, aes(x = " ", y = Number.of.correspondents.who.received.at.this.location.letters.from.Budé)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  geom_text_repel(label = ifelse(data$Number.of.correspondents.who.received.at.this.location.letters.from.Budé >= upper_dots, as.character(data$Location.Name.Modern), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Number of correspondents receiving letters from Budé")
plot2

# create combined plot via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_corr_per_loc_receiving_from_budé_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_budé_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_budé_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_budé_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
