require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_year/comp_no_epp_per_year_sent_by_to_pirck.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# rename a column
colnames(data)[colnames(data) == "send_date_year1"] <- "Year"

# create data frame for years 1484-1536
data2 <- tibble(Year = 1491:1530)

# merge data frames
data3 <- left_join(data2, data, by = "Year")

# pivot data from wide to long format
data_long <- data3 %>%  pivot_longer(cols = c("NoEppSentFromPirck", "NoEppSentToPirck"), names_to = "variable", values_to = "value")

# create line chart
plot <- ggplot(data = data_long, aes(x = Year, y = value, colour = variable)) +
  geom_line(stat = "identity", size = 0.9) +
  geom_point(shape = 1, fill = "white", stroke = 1.25) +
  labs(x = "Year", y = "Number of letters") +
  scale_x_continuous(breaks = c(1491:1530)) +
  scale_y_continuous(breaks = seq(0, 100, 10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  scale_color_grey(labels = c("Letters sent by Pirckheimer", "Letters sent to Pirckheimer"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_year_sent_by_to_pirck_linechart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_sent_by_to_pirck_linechart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_sent_by_to_pirck_linechart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_sent_by_to_pirck_linechart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
