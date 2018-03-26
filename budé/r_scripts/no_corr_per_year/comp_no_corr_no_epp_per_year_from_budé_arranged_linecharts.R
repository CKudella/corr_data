require(readr)
require(reshape2)
require(ggplot2)
require(ggpubr)
library(readr)
library(reshape2)
library(ggplot2)
library(ggpubr)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_year/comp_no_corr_no_epp_per_year_from_budé.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create data frame for years 1484-1536
data2 <- data.frame(matrix(ncol = 1, nrow = 57))
x <- c("Year")
colnames(data2) <- x
data2$Year <- c(1484:1540)

# merge dataframes
data3 <- merge(x = data2, y = data, by = "Year", all.x = TRUE)

# create linechart for number of correspondents
plot <- ggplot(data=data3, aes(x= Year, y=Number.of.correspondents.receiving.letters.from.Budé.this.year)) +
  geom_line(stat = "identity", size=0.9) +
  geom_point(shape=1) + labs(x="Year",y="Number of correspondents") +
  scale_x_continuous(breaks = c(1484:1540)) +
  scale_y_continuous(breaks = seq(0,30,5)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position="bottom")
plot

# create linechart for number of letters
plot2 <- ggplot(data=data3, aes(x= Year, y=Number.of.letters.sent.from.Budé.this.year)) +
  geom_line(stat = "identity", size=0.9) +
  geom_point(shape=1) + labs(x="Year",y="Number of letters") +
  scale_x_continuous(breaks = c(1484:1540)) +
  scale_y_continuous(breaks = seq(0,50,10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position="bottom")
plot2

# arrange plots
ggarrange(plot, plot2,
          ncol = 1, nrow = 2)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_corr_no_epp_per_year_from_budé_arranged_linecharts.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_no_epp_per_year_from_budé_arranged_linecharts.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_no_epp_per_year_from_budé_arranged_linecharts.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_no_epp_per_year_from_budé_arranged_linecharts.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
