require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# read data
data<-read.csv("no_corr_per_loc/no_corr_per_loc_writing_to_era_with_geocoordinates.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x= reorder(Location.Name.Modern, -Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus), y=Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus, label=Location.Name.Modern)) + 
  geom_point(stat = "identity") + 
  labs(x="Locations",y="Number of correspondents Erasmus writes letters to") + 
  geom_text(check_overlap = TRUE, aes(label=ifelse(Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus>15,as.character(Location.Name.Modern),'')),hjust=-0.1,vjust=0) +
  theme_bw() +
  theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot
