require(readr)
require(reshape2)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_year/avg_no_epp_per_corr_year_to_era.csv", fileEncoding = "UTF-8")

# create data frame for years 1484-1536
data2 <- data.frame(matrix(ncol = 1, nrow = 53))
x <- c("Year")
colnames(data2) <- x
data2$Year <- c(1484:1536)

# merge dataframes
data3 <- merge(x = data2, y = data, by = "Year", all.x = TRUE)

# create barchart
plot <- ggplot(data3, aes(x = Year, y = Average.number.of.letters.sent.per.correspondent.to.Erasmus.this.year)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom") +
  labs(y = "Average number of letters to Erasmus per correspondent", x = "Year")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_to_era_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
