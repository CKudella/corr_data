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
data<-read.csv("no_corr_per_modern_state/comp_no_corr_per_ms_writing_to_receiving_from_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"), colClasses=c("Number.of.correspondents.who.received.letters.from.Pirckheimer"="character","Number.of.correspondents.who.wrote.letters.to.Pirckheimer"="character"))

# set number columns to numeric
data$Number.of.correspondents.who.received.letters.from.Pirckheimer <- as.numeric(as.character(data$Number.of.correspondents.who.received.letters.from.Pirckheimer))
data$Number.of.correspondents.who.wrote.letters.to.Pirckheimer <- as.numeric(as.character(data$Number.of.correspondents.who.wrote.letters.to.Pirckheimer))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("Modern.State"))

# create barchart
plot <- ggplot(data_long,aes(x= reorder(Modern.State,-value),y=value, fill=variable)) +
  geom_bar(position = "dodge", stat = "identity") +
  labs(x="Modern State",y="Number of correspondents") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position="bottom") +
  theme(legend.title=element_blank()) +
  scale_fill_grey(labels = c("Number of correspondents Pirckheimer wrote letters to", "Number of correspondents who wrote letters to Pirckheimer"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_pirck_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_pirck_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_pirck_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_corr_per_ms_writing_to_receiving_from_pirck_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
