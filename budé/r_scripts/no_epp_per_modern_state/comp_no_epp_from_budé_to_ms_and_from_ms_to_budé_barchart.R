require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_modern_state/comp_no_epp_from_budé_to_ms_and_from_ms_to_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# pivot data from wide to long format
data_long <- data %>%  pivot_longer(cols = c("Number.of.letters.Budé.sent.to.this.modern.state", "Number.of.letters.sent.from.this.modern.state.to.Budé"), names_to = "variable", values_to = "value")

# create bar chart
plot <- ggplot(data_long, aes(x = reorder(ModernState, -value), y = value, fill = variable)) +
  geom_bar(position = "dodge", stat = "identity") +
  labs(x = "Modern State", y = "Number of letters") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position = "bottom") +
  theme(legend.title = element_blank()) +
  scale_fill_grey(labels = c("Number of letters sent by Budé to this modern state", "Number of letter sent from this modern state to Budé"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_from_budé_to_ms_and_from_ms_to_budé_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_budé_to_ms_and_from_ms_to_budé_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_budé_to_ms_and_from_ms_to_budé_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_budé_to_ms_and_from_ms_to_budé_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
