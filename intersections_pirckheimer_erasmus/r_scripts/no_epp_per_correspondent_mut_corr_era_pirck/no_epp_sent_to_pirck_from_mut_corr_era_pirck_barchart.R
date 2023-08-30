require(tidyverse)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_correspondent_mut_corr_era_pirck/no_epp_sent_to_pirck_from_mut_corr_era_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# cut unnecessary label parts from name_in_edition column
data$name_in_edition <- gsub("\\b(\\W+COE+.*)", "", data$name_in_edition)
data$name_in_edition <- gsub("^(\\W+E)", "E", data$name_in_edition)

# modify the label for Erasmus
erasmus_index <- which(data$sender_id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf")
data$name_in_edition[erasmus_index] <- "Desiderius ERASMUS"

# create bar chart
plot <- ggplot(data, aes(x= reorder(name_in_edition, -Number.of.letters.sent.to.Pirckheimer.per.mutual.correspondent),y=Number.of.letters.sent.to.Pirckheimer.per.mutual.correspondent)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.sent.to.Pirckheimer.per.mutual.correspondent), vjust=-0.5, color='black') +
  labs(x="Mutual correspondents",y="Number of letter sent to Pirckheimer ") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_sent_to_pirck_from_mut_corr_era_pirck_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_sent_to_pirck_from_mut_corr_era_pirck_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_sent_to_pirck_from_mut_corr_era_pirck_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_sent_to_pirck_from_mut_corr_era_pirck_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
