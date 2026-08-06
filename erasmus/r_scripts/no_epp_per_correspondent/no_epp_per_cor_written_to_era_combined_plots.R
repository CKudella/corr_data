library(tidyverse)
library(ggrepel)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_correspondent/no_epp_per_cor_written_to_era.csv"
output_path <- "../r_plots/no_epp_per_correspondent/no_epp_per_cor_written_to_era_combined_plots"

id_col      <- "sender_id"
name_col    <- "name_in_edition"
measure_col <- str_glue("Number of letters sent to {subject_name} from this correspondent")

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    correspondent_id = all_of(id_col),
    name             = all_of(name_col),
    n_letters        = all_of(measure_col)
  ) |>
  filter(!is.na(n_letters)) |>
  mutate(
    # shorten name to coe form only, convert all-caps surnames to title case while preserving latin numerals
    name = str_split(name, "//") |> map_chr(1),
    name = str_remove(name, "\\[COE\\]"),
    name = str_trim(name),
    name = str_replace_all(name, "\\b\\p{Lu}{2,}\\b", function(m) {
      if_else(str_detect(m, "^[IVXLCDM]+$"), m, str_to_title(m))
    })
  )

quartiles   <- quantile(data$n_letters, probs = c(0.25, 0.5, 0.75))
iqr_val     <- IQR(data$n_letters)
upper_fence <- quartiles[3] + 1.5 * iqr_val

data <- data |>
  mutate(is_outlier = n_letters > upper_fence)

outliers <- data |> filter(is_outlier) |> arrange(desc(n_letters))

# statistics

n_correspondents <- nrow(data)
n_outliers       <- nrow(outliers)

mean_letters   <- mean(data$n_letters)
median_letters <- median(data$n_letters)

cat(str_glue("correspondents: {n_correspondents}"), "\n")
cat(str_glue("mean letters: {round(mean_letters, 1)} \u00b7 median: {median_letters}"), "\n")
cat(str_glue("upper fence: {round(upper_fence, 1)} \u00b7 outliers: {n_outliers}"), "\n")

# plot

plot_histogram <- data |>
  ggplot(aes(x = n_letters)) +
  geom_histogram(bins = 30, fill = "grey60", color = "white") +
  geom_vline(aes(xintercept = mean_letters, linetype = "Mean"), color = "black", linewidth = 0.6) +
  geom_vline(aes(xintercept = median_letters, linetype = "Median"), color = "black", linewidth = 0.6) +
  scale_linetype_manual(name = NULL, values = c("Mean" = "dashed", "Median" = "dotted")) +
  scale_x_log10(labels = comma) +
  labs(
    title = str_glue("Distribution of letters sent to {subject_name}, per correspondent"),
    subtitle = str_glue("Mean = {round(mean_letters, 1)} \u00b7 Median = {median_letters}"),
    x = "Number of letters (log-scale)",
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 12) +
  theme(panel.grid.minor = element_blank(), legend.position = "bottom")

plot_boxplot <- data |>
  ggplot(aes(x = "", y = n_letters)) +
  geom_boxplot(outlier.shape = NA, width = 0.3, fill = "grey90") +
  geom_point(aes(color = is_outlier, shape = is_outlier), alpha = 0.6, size = 1.8) +
  geom_text_repel(
    data = outliers,
    aes(label = name),
    size = 3, max.overlaps = Inf, box.padding = 0.6, seed = 42
  ) +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "black"), guide = "none") +
  scale_shape_manual(values = c("FALSE" = 16, "TRUE" = 17), guide = "none") +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Correspondents writing an outlying number of letters",
    x = NULL,
    y = "Number of letters"
  ) +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

plot_barchart <- outliers |>
  ggplot(aes(x = reorder(name, -n_letters), y = n_letters)) +
  geom_col(fill = "grey40") +
  geom_text(aes(label = n_letters), vjust = -0.4, size = 3.2) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = str_glue("All {n_outliers} outlier correspondents (> {round(upper_fence, 1)} letters)"),
    x = "Correspondent",
    y = "Number of letters"
  ) +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), panel.grid.major.x = element_blank())

final_plot <- (plot_histogram / plot_barchart | plot_boxplot) +
  plot_layout(widths = c(2, 2))

final_plot

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = final_plot, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })