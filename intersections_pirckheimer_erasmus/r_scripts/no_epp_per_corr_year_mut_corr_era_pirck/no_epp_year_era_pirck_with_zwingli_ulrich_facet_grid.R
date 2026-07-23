require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_corr_year_mut_corr_era_pirck/no_epp_year_era_pirck_with_zwingli_ulrich.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# pivot data to longer format and set labels
data_long <- data %>%
  pivot_longer(cols = starts_with("EPP"), names_to = "variable", values_to = "value") %>%
  mutate(value = replace_na(value, 0)) %>%
  mutate(
    correspondent = case_when(
      variable %in% c("EPPEtX", "EPPXtE") ~ "Erasmus",
      variable %in% c("EPPPtX", "EPPXtP") ~ "Pirckheimer"
    ),
    direction = case_when(
      variable %in% c("EPPEtX", "EPPPtX") ~ "sent to Zwingli",
      variable %in% c("EPPXtE", "EPPXtP") ~ "received from Zwingli"
    )
  )

# make the year sequence complete (turn absence into zeros)

full_years <- full_seq(range(data_long$Year, na.rm = TRUE), 1)

data_complete <- data_long %>%
  complete(Year = full_years, nesting(correspondent, direction), fill = list(value = 0)) %>%
  mutate(signed_value = if_else(direction == "sent to Zwingli", value, -value))

# identify years of overlap between the two correspondences
overlap_years <- data_complete %>%
  group_by(Year, correspondent) %>%
  summarise(total = sum(value), .groups = "drop") %>%
  pivot_wider(names_from = correspondent, values_from = total) %>%
  filter(Erasmus > 0 & Pirckheimer > 0) %>%
  pull(Year)

shade_df <- tibble(
  xmin = overlap_years - 0.5,
  xmax = overlap_years + 0.5,
  ymin = -Inf, ymax = Inf
)

# create faceted bar chart plot
max_val <- max(abs(data_complete$signed_value))

plot <- ggplot(data_complete, aes(x = Year, y = signed_value, fill = direction)) +
  geom_rect(data = shade_df, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
            inherit.aes = FALSE, fill = "grey90", alpha = 0.4) +
  geom_col(width = 0.8, colour = "white", linewidth = 0.1) +
  geom_hline(yintercept = 0, colour = "grey30", linewidth = 0.3) +
  facet_grid(correspondent ~ .) +
  scale_fill_manual(values = c("sent to Zwingli" = "grey20",
                               "received from Zwingli" = "grey65"),
                    name = NULL) +
  scale_x_continuous(breaks = full_years, expand = expansion(add = 0.6)) +
  scale_y_continuous(limits = c(-max_val, max_val),
                     breaks = seq(-max_val, max_val, by = 1),
                     labels = abs) +
  labs(
    x = "Year",
    y = "Number of letters (sent above / received below zero line)",
    title = "Correspondence with Huldrych Zwingli",
    subtitle = "Grey bands mark years in which Erasmus and Pirckheimer were both corresponding with Zwingli"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5),
    strip.text.y = element_text(angle = 0, hjust = 0.5),
    legend.position = "bottom",
    panel.grid.minor.x = element_line(colour = "grey92")
  )

plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_year_era_pirck_with_zwingli_ulrich_facet_grid.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_year_era_pirck_with_zwingli_ulrich_facet_grid.png", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_year_era_pirck_with_zwingli_ulrich_facet_grid.eps", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_year_era_pirck_with_zwingli_ulrich_facet_grid.svg", plot = last_plot(), scale = 1, width = 11.7, height = 4.15, units = "in", dpi = 600, limitsize = TRUE)
