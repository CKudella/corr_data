require(readr)
require(reshape2)
require(ggplot2)
require(ggrepel)
require(patchwork)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/avg_no_epp_per_corr_year_from_budé.csv", fileEncoding = "UTF-8")

# caculate quartiles
quartiles <- as.numeric(quantile(data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year, probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate upper whisker
upper_whisker <- max(data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year[data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year < (quartiles[3] + 1.5 * IQR)])

# create data frame for years 1484-1536
data2 <- data.frame(matrix(ncol = 1, nrow = 53))
x <- c("Year")
colnames(data2) <- x
data2$Year <- c(1484:1536)

# merge dataframes
data3 <- merge(x = data2, y = data, by = "Year", all.x = TRUE)

# create linechart plot
plot1 <- ggplot(data3, aes(x = Year, y = Average.number.of.letters.sent.from.Budé.per.correspondent.this.year)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = rel(0.5))) +
  theme(legend.position = "bottom") +
  labs(y = "Average number of letters from Budé per correspondent", x = "Year")
plot1

# create boxplot
plot2 <- ggplot(data, aes(x = " ", y = Average.number.of.letters.sent.from.Budé.per.correspondent.this.year)) +
  geom_boxplot(notch = FALSE) +
  geom_text_repel(label = ifelse(data$Average.number.of.letters.sent.from.Budé.per.correspondent.this.year > upper_whisker, as.character(data$Year), "")) +
  theme_bw() +
  theme(axis.title.x = element_blank()) +
  labs(y = "Average number of letters from Budé per correspondent")
plot2

# create combined plot via patchwork
plot1 + plot2 + plot_layout(widths = c(2, 1))

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_from_budé_plots_combined.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
