require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_modern_state_year_mut_corr_era_budé/no_epp_to_era_from_modern_state_per_year_mut_corr_era_budé_excl_budé.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create facet grid with bar charts
plot <- ggplot(data=data, aes(x=send_date_year1,y=Number.of.letters.sent.from.this.modern.state.to.Erasmus.this.year.from.mutual.correspondents.of.his.and.Budé..excl..Budé.)) +
  geom_bar(stat = "identity") +
  labs(x="Year",y="Number of letters sent from this modern state to Erasmus by mutual correspondents (excl. Budé)") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0,10,2)) +
  facet_grid(Modern.State ~ ., space = "free" )+
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
  theme(legend.position="bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_to_era_from_modern_state_per_year_mut_corr_era_budé_excl_budé_facet_grid.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_to_era_from_modern_state_per_year_mut_corr_era_budé_excl_budé_facet_grid.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_to_era_from_modern_state_per_year_mut_corr_era_budé_excl_budé_facet_grid.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_to_era_from_modern_state_per_year_mut_corr_era_budé_excl_budé_facet_grid.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
