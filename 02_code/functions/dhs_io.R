## ============================================================
## functions/dhs_io.R
## Fonctions utilitaires pour localiser et lire les recodes DHS.
##
## Convention de nommage DHS : <CC><RC><PH>FL.DTA
##   CC = code pays à 2 lettres (BJ pour Bénin, CM Cameroun, etc.)
##   RC = recode (IR femmes, MR hommes, CR couples, HR ménage, PR personne)
##   PH = numéro de phase (61 = DHS-VI, 71 = DHS-VII, 81 = DHS-VIII)
##   FL = Flat file (format Stata, celui qu'on utilise)
## ============================================================

#' Localiser un fichier DHS .DTA
#'
#' @param country_code Code pays ISO3 (ex. "BEN", "KEN")
#' @param survey_id    Identifiant de l'enquête (ex. "DHS-VII-2017-18")
#' @param recode       Un parmi "IR", "MR", "CR", "HR", "PR", "BR", "KR"
#' @param data_root    Typiquement `paths$data_raw`
#'
#' @return Chemin du fichier ou NA_character_ si non trouvé.
find_dhs_file <- function(country_code, survey_id, recode, data_root) {
  dir <- file.path(data_root, country_code, survey_id)
  if (!dir.exists(dir)) {
    cli::cli_warn("Dossier introuvable : {dir}")
    return(NA_character_)
  }
  pattern <- paste0("^[A-Z]{2}", recode, "[0-9]+FL\\.DTA$")
  hits <- list.files(dir, pattern = pattern,
                     ignore.case = TRUE, full.names = TRUE)
  if (length(hits) == 0) {
    cli::cli_warn("Aucun recode {recode} dans {dir}")
    return(NA_character_)
  }
  if (length(hits) > 1) {
    cli::cli_warn("Plusieurs fichiers {recode} dans {dir}, utilisation du premier : {basename(hits[1])}")
  }
  hits[1]
}

#' Lire un recode DHS en préservant les étiquettes
#'
#' @param path Chemin vers un fichier .DTA
#' @param vars Optionnel : vecteur de noms de variables à garder.
#'             NULL (défaut) lit toutes les colonnes.
read_dhs <- function(path, vars = NULL) {
  if (is.na(path) || !file.exists(path)) return(NULL)
  d <- if (is.null(vars)) {
    haven::read_dta(path)
  } else {
    haven::read_dta(path, col_select = dplyr::all_of(vars))
  }
  attr(d, "dhs_path") <- path
  d
}

#' Construit un tibble pays × enquête à partir de la config
country_survey_grid <- function(config) {
  purrr::map_dfr(config$countries, function(c) {
    tibble::tibble(country = c$code, survey = unlist(c$surveys))
  })
}

#' Récupère le numéro de phase DHS depuis le nom de fichier
#' (ex. BJIR71FL.DTA → 71)
dhs_phase_from_filename <- function(path) {
  m <- regmatches(basename(path), regexpr("[0-9]+", basename(path)))
  as.integer(m)
}
