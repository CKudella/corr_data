require(readr)
require(reshape2)
require(ggplot2)
library(readr)
library(reshape2)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_year/comp_no_epp_per_year_inferred_noninferred.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create data frame for years 1484-1536
data2 <- data.frame(matrix(ncol = 1, nrow = 53))
x <- c("Year")
colnames(data2) <- x
data2$Year <- c(1484:1536)

# merge dataframes
data3 <- merge(x = data2, y = data, by = "Year", all.x = TRUE)

# apply melt for wide to long
data_long <- melt(data3, id.vars= c("Year"))

# create linechart
plot <- ggplot(data=data_long, aes(x= Year, y=value, colour=variable)) +
  geom_line(stat = "identity", size=0.9) +
  geom_point(shape=1) + labs(x="Year",y="Number of letters") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0,160,10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position="bottom") +
  theme(legend.title=element_blank()) +
  scale_color_grey(labels = c("Number of letters with inferred send date", "Number of letters with non-inferred send date"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_year_inferred_noninferred_linechart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_linechart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_linechart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_linechart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)