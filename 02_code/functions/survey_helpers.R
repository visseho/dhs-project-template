## ============================================================
## functions/survey_helpers.R
## Construction d'objets survey/srvyr et remise à l'échelle
## des pondérations pour les analyses multi-pays.
## Référence : Croft et al. (2018), Guide to DHS Statistics.
## ============================================================

#' Remettre à l'échelle les pondérations DHS pour une analyse poolée
#'
#' Les pondérations individuelles DHS (v005, mv005) sont normalisées
#' pour sommer à la taille de l'échantillon de chaque pays. Pour une
#' analyse poolée, il faut les remettre à l'échelle.
#'
#' Deux méthodes :
#'   - "country_n" (défaut) : pondérations qui somment à n par pays.
#'                           Approprié si vous incluez des effets fixes pays.
#'   - "denormalized" : pondérations qui somment à la population cible
#'                      de chaque pays. Nécessite une table de population.
#'
#' @param data data.frame avec colonnes `weight` (= v005/1e6) et `country`
#' @param method "country_n" ou "denormalized"
rescale_weights <- function(data, method = "country_n") {
  if (!"weight" %in% names(data)) {
    stop("data doit avoir une colonne 'weight' (= v005/1e6)")
  }

  if (method == "country_n") {
    data |>
      dplyr::group_by(country) |>
      dplyr::mutate(weight_pooled = weight * dplyr::n() /
                                     sum(weight, na.rm = TRUE)) |>
      dplyr::ungroup()
  } else if (method == "denormalized") {
    stop("La méthode denormalized nécessite une table de populations ; voir 04_docs/codebook.md")
  } else {
    stop("Méthode inconnue : ", method)
  }
}

#' Construire un objet survey design pour un dataset poolé
#'
#' @param data data analytique avec colonnes psu, stratum, weight_pooled
#' @param weight_var nom de la colonne de pondération à utiliser
make_design <- function(data, weight_var = "weight_pooled") {
  srvyr::as_survey_design(
    .data   = data,
    ids     = psu,         # v021
    strata  = stratum,     # v022
    weights = !!rlang::sym(weight_var),
    nest    = TRUE
  )
}
