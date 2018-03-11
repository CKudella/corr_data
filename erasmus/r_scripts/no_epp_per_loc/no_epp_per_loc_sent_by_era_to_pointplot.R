require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# read data
data<-read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_era_to_with_geocoordinates.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x= reorder(Location, -Number.of.Letters.per.Location.to.which.Erasmus.has.sent.Letters), y=Number.of.Letters.per.Location.to.which.Erasmus.has.sent.Letters, label=Location)) + 
  geom_point(stat = "identity") + 
  labs(x="Locations",y="Number of letters sent to this location from Erasmus") + 
  geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.Letters.per.Location.to.which.Erasmus.has.sent.Letters>50,as.character(Location),'')),hjust=-0.1,vjust=0) +
  theme_bw() +
  theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot
