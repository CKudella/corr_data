require(readr)
require(reshape2)
require(lubridate)
require(ggplot2)
library(readr)
library(reshape2)
library(lubridate)
library(ggplot2)

# read data
data<-read.csv("no_epp_per_year/no_epp_per_day_sent_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# Set send_date_computable1 asDate
data$send_date_computable1 <- as.Date(data$send_date_computable1, format="%Y-%m-%d")

# Compute yearday, monthday, month, year
data$yday <- yday(data$send_date_computable1)
data$mday <- mday(data$send_date_computable1)
data$month <-month(data$send_date_computable1)
data$year <- year(data$send_date_computable1)

# Plot Facet Grid
plot <- ggplot(data=data, aes(x=mday,y=NoEppSentToEra)) +
  geom_bar(stat = "identity") +
  labs(x="Day",y="Number of letters sent to Erasmus") +
  scale_y_continuous(breaks = seq(0,14,2)) +
  facet_grid(year ~ month) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
  theme(legend.position="bottom")
plot
