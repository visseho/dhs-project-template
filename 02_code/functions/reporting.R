## ============================================================
## functions/reporting.R
## Petites fonctions pour sauvegarder tableaux et figures,
## et pour appliquer un thème ggplot cohérent au projet.
## ============================================================

#' Sauvegarder un ggplot en PNG et PDF
save_figure <- function(plot, name, width = 7, height = 5, dpi = 300,
                        out_dir = here::here("03_output", "figures")) {
  if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
  ggplot2::ggsave(file.path(out_dir, paste0(name, ".png")), plot,
                  width = width, height = height, dpi = dpi)
  ggplot2::ggsave(file.path(out_dir, paste0(name, ".pdf")), plot,
                  width = width, height = height)
  invisible(file.path(out_dir, name))
}

#' Sauvegarder un tibble en .csv
save_table <- function(tbl, name,
                       out_dir = here::here("03_output", "tables")) {
  if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
  readr::write_csv(tbl, file.path(out_dir, paste0(name, ".csv")))
  invisible(file.path(out_dir, paste0(name, ".csv")))
}

#' Thème ggplot du laboratoire
theme_lab <- function(base_size = 11) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      panel.grid.minor   = ggplot2::element_blank(),
      plot.title.position = "plot",
      strip.text         = ggplot2::element_text(face = "bold")
    )
}
