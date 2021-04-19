require(readr)
require(ggplot2)
require(ggrepel)
require(patchwork)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_sent_from.csv", fileEncoding = "UTF-8")

# caculate quartiles
quartiles <- as.numeric(quantile(data$Number.of.letters.sent.from.this.location, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(data$Number.of.letters.sent.from.this.location[data$Number.of.letters.sent.from.this.location > (quartiles[3] + 1.5*IQR)])

# create pointplot (with sqrt trans)
plot1 <- ggplot(data = data, aes(x = reorder(Location.Name, -Number.of.letters.sent.from.this.location), y = Number.of.letters.sent.from.this.location, label = Location.Name)) +
  geom_point(stat = "identity") +
  scale_y_continuous(trans = "sqrt") +
  labs(x = "Locations", y = "Number of letters sent from this location") +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot1

# create boxplot (with log10 trans)
plot2 <- ggplot(data, aes(x = " ", y = Number.of.letters.sent.from.this.location)) +
  geom_boxplot(outlier.size = 2, notch = FALSE) +
  coord_trans(y = "sqrt") +
  geom_text_repel(label = ifelse(data$Number.of.letters.sent.from.this.location >= upper_dots, as.character(data$Location.Name), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Number of letters sent from this location")
plot2

# create combined plot via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_from_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
