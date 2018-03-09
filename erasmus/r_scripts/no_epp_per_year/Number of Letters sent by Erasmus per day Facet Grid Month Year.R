library(reshape2)
library(ggplot2)
library(readr)
library(lubridate)

# Facet Grid visualization of the number of letters sent by Erasmus per day

# Create Dataframe
daten<-read.csv("data/no_epp_sent_by_era_per_day.csv")

# Set send_date_computable1 asDate
daten$send_date_computable1 <- as.Date(daten$send_date_computable1, format="%Y-%m-%d")

# Compute yearday, monthday, month, year
daten$yday <- yday(daten$send_date_computable1)
daten$mday <- mday(daten$send_date_computable1)
daten$month <-month(daten$send_date_computable1)
daten$year <- year(daten$send_date_computable1)

# Plot Facet Grid
plot <- ggplot(data=daten, aes(x=mday,y=Number.of.Letters.sent.by.Erasmus)) + geom_bar(stat = "identity") + labs(x="Day",y="Number of letters sent by Erasmus") + scale_y_continuous(breaks = seq(0,14,2)) +facet_grid(year ~ month)
plot + theme_bw() + theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + theme(strip.text.y = element_text(angle = 0, hjust = 1)) + theme(legend.position="bottom") 
