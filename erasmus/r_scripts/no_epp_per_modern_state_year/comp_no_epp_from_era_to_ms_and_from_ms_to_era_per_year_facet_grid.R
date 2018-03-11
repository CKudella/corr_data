library(reshape2)
library(ggplot2)
library(readr)

# read data
data<-read.csv("no_epp_per_modern_state_year/comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("ModernState","Year"))


# Plot Facet Grid
plot <- ggplot(data=data_long, aes(x=Year,y=value, colour=variable)) + 
  geom_line(stat = "identity") + 
  labs(x="Year",y="Number of letters") + 
  scale_x_continuous(breaks = c(1484:1536)) + 
  facet_grid(ModernState ~ ., space = "free" ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
  theme(legend.position="bottom")
plot
