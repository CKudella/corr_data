require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_year/no_epp_per_year_with_non_inferred_send_date_sent_to_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create barchart
plot <- ggplot(data=data, aes(x=Year,y=Number.of.letters.with.non.inferred.send.date.sent.to.Pirckheimer.this.year)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.with.non.inferred.send.date.sent.to.Pirckheimer.this.year), vjust=-0.5, color='black', size = 2.5) +
  labs(x="Year",y="Number of letters") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0,70,10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_year_with_non_inferred_send_date_to_pirck_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_with_non_inferred_send_date_to_pirck_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_with_non_inferred_send_date_to_pirck_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_with_non_inferred_send_date_to_pirck_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
