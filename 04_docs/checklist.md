# Les 10 règles du laboratoire

**À lire avant de commencer. À relire au moindre doute.**

Ces règles ne sont pas des conseils esthétiques. Ce sont les pratiques qui vous feront gagner des **mois** sur votre thèse et qui déterminent la crédibilité scientifique de vos résultats.

---

## 1. Un projet = un dépôt Git

Toute analyse quantitative — même "juste pour voir" — commence par la création d'un dépôt. Jamais de code qui vit uniquement dans un fichier Word, un courriel, ou un dossier `Downloads/`. **Pas d'exception.**

## 2. Jamais de données dans Git

Les fichiers `.DTA`, `.sav`, `.csv` contenant des données individuelles **ne sont jamais** poussés sur GitHub. Les termes d'utilisation DHS, MICS et consorts l'interdisent explicitement. Le `.gitignore` du gabarit les bloque — ne le modifiez pas sans en parler à votre directeur.

**Avant chaque commit**, vérifiez dans GitHub Desktop qu'aucun fichier de données n'apparaît dans la liste "Changes". Si vous en voyez un : **stop**, demandez de l'aide.

## 3. Jamais de `setwd()`

`setwd("/Users/mariedupont/Documents/these/")` est le symptôme d'un projet non reproductible. Toute référence à un chemin passe par :

```r
here::here("01_data", "raw")
```

qui fonctionne chez vous, chez votre directeur, chez votre jury, sur le cluster de calcul.

## 4. Les constantes vivent dans `_config.yml`

Seuil d'âge, liste de pays, variables à inclure, chemins — tout ce qui pourrait changer est dans le fichier de config. **Pas en dur dans les scripts.** Si vous écrivez `filter(age >= 15 & age <= 49)` dans un script, c'est un signal qu'il faut déplacer 15 et 49 dans `_config.yml`.

## 5. Un script = une responsabilité

Si vous ne pouvez pas résumer ce que fait un script en une phrase, découpez-le. Les scripts sont numérotés dans l'ordre d'exécution : `01_import`, `02_harmonize`, `03_outcomes`, etc. On ne saute pas d'étape, on n'inverse pas l'ordre.

## 6. Code dupliqué deux fois = fonction

La deuxième fois que vous copiez-collez un bloc de code, arrêtez-vous. Mettez-le dans `02_code/functions/`. La règle vaut même pour 5 lignes.

## 7. Jamais sur `main` directement

Toute nouvelle analyse, correction, ajout de pays se fait sur **une branche**. Nom explicite : `add-cameroon`, `fix-weight-rescaling`, `sensitivity-urban-rural`. Puis Pull Request, puis merge. Même si vous travaillez seul·e, cette discipline rendra le projet relisable.

## 8. Un commit = un changement logique

Mauvais message de commit :
> "mise à jour"

Bons messages :
> "Add Cameroon 2018 to country list and BP schema"
> "Fix weight rescaling for Lesotho (division by zero)"
> "Refactor outcome construction to use schema file"

Si vous ne pouvez pas écrire un message en une ligne, vous êtes en train de commiter deux changements. Séparez-les.

## 9. Documentez pendant que vous codez

Chaque script commence par un en-tête :

```r
## ============================================================
## 05_construct_covariates.R
## Recode les covariables (éducation, richesse, résidence)
## en catégories harmonisées entre pays.
## Entrées : 01_data/interim/*/harmonised/{ir,mr}.rds
## Sorties : mêmes fichiers, enrichis des variables recodées
## ============================================================
```

Chaque variable dérivée est documentée dans `04_docs/codebook.md` au moment où vous la créez — pas "plus tard".

## 10. Un plan pré-analyse avant de regarder les résultats

Remplissez `04_docs/analysis_plan.md` **avant** de faire tourner les modèles sur les vraies données. Hypothèses, échantillon, variables, modèles, analyses de sensibilité. Si vous changez quelque chose après avoir vu les résultats, documentez-le dans `04_docs/deviations.md` avec date et raison.

Ce n'est pas de la bureaucratie. C'est ce qui différencie une analyse d'un *data dredging* — et c'est de plus en plus exigé par les revues.

---

## En cas de doute

- Un camarade du labo a sûrement vu le problème avant. Demandez sur le Slack du labo.
- Les erreurs Git se règlent presque toujours sans tout casser. **Ne faites pas** `rm -rf .git/` dans la panique — demandez d'abord.
- Toute dérogation à ces règles doit être discutée avec le directeur de thèse. Les règles existent, mais aucune règle n'est absolue : c'est la discussion qui l'est.
