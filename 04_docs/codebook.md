# Codebook — variables dérivées

> **Documentez chaque nouvelle variable que vous créez, au moment où vous la créez.** Pas "plus tard".

Ce codebook décrit les variables construites par le pipeline (dans `01_data/processed/`). Les variables DHS d'origine sont référencées par leur code entre parenthèses.

---

## Identifiants et plan de sondage

| Variable | Type | Description | Source |
|---|---|---|---|
| `id` | chr | Identifiant unique | `caseid` / `mcaseid` |
| `country` | chr | Code ISO3 du pays | config |
| `survey` | chr | Identifiant de l'enquête | config |
| `psu` | int | Unité primaire de sondage | `v021` / `mv021` |
| `stratum` | int | Strate d'échantillonnage | `v022` / `mv022` |
| `weight` | num | Pondération individuelle | `v005`/1e6 |
| `weight_pooled` | num | Pondération remise à l'échelle pour analyse multi-pays | voir `functions/survey_helpers.R` |

## Issues

| Variable | Type | Description |
|---|---|---|
| *[y1]* | *[type]* | *[définition opérationnelle]* |

## Exposition principale

| Variable | Type | Description |
|---|---|---|
| *[x1]* | *[type]* | *[codage, catégorie de référence]* |

## Covariables

| Variable | Type | Description |
|---|---|---|
| `age` | int | Âge en années | `v012` / `mv012` |
| *[c1]* | ... | ... |

---

**Mise à jour :** Date de dernière modification : [YYYY-MM-DD], par [nom].
