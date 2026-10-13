# Pour la direction de recherche

> Note interne au SSAPOPLAB — à destination des directeurs et directrices qui utilisent ce gabarit avec leurs étudiant·e·s.

## Comment utiliser ce gabarit avec un nouvel étudiant

### Étape 1 — Création du dépôt (10 min)

Sur GitHub, dans l'organisation `ssapoplab` :

1. Allez sur https://github.com/ssapoplab/dhs-project-template
2. Cliquez le bouton vert **"Use this template"** → **"Create a new repository"**
3. **Owner** : `ssapoplab` (pas le compte perso de l'étudiant·e)
4. **Repository name** : convention `these-nomfamille-sujet` ou `ma-nomfamille-sujet`
5. **Private** (toujours, tant que le projet n'est pas publié)
6. Ajoutez l'étudiant·e comme collaborateur avec droits **Write**
7. Ajoutez vous-même comme **Admin**

### Étape 2 — Rencontre d'initiation (1h)

Un seul objectif : faire tourner le pipeline de bout en bout sur **un pays** avec l'étudiant·e, en direct. Partage d'écran, main sur le clavier à tour de rôle. Les 10 règles du labo (`checklist.md`) sont présentées à ce moment.

### Étape 3 — Première semaine

- Jour 1 : Installation (R, RStudio, Git, GitHub Desktop, Quarto). Cloner le dépôt.
- Jours 2-3 : Demande DHS, téléchargement des premières données.
- Jours 4-5 : Lire R4DS chapitres 1-5, faire tourner `01_import_dhs.R` et explorer les données en console.
- **Fin de semaine 1** : premier commit "Setup complete + Benin data importing".

### Étape 4 — Les 3 premiers mois

- Rendez-vous bihebdomadaire de 30 min, agenda standard :
  - État du dépôt (branches ouvertes, PR en cours)
  - Démonstration de ce qui marche
  - Un bloquant
  - Prochains jalons
- L'étudiant·e remplit `04_docs/analysis_plan.md` au cours de ces semaines.
- Vous validez le plan **avant** qu'il/elle fasse tourner le modèle principal.

## Supervision par Pull Request

Quand l'étudiant·e a terminé une analyse, demandez une **Pull Request** vers `main` :

- Vous recevez une notification GitHub.
- Vous consultez le diff en ligne — chaque ligne modifiée est visible.
- Vous commentez directement sur les lignes problématiques.
- Approbation ou demande de modifications.
- Merge dans `main`.

Cette discipline remplace les échanges de scripts par courriel. Elle a trois vertus : traçabilité, enseignement par le commentaire ciblé, et préparation à la vie professionnelle (c'est le flux standard de toute équipe de recherche sérieuse).

## Signalement des mauvaises pratiques

Si vous voyez dans un commit :

- un `setwd()`
- un fichier `.DTA` ou `.sav`
- un chemin absolu
- un seuil statistique codé en dur dans un script
- un commit intitulé "mise à jour" ou "fix"

→ Demandez une correction **avant** le merge. L'étudiant·e intériorisera les règles en trois semaines.

## Évolution du gabarit

Ce gabarit est lui-même versionné. Pour proposer une amélioration (fonction utile, correction, documentation) : ouvrez une Pull Request sur le dépôt-mère. Les contributions sont bienvenues.

## Références à partager systématiquement

À donner à chaque nouvel·le étudiant·e lors de la rencontre d'initiation :

1. Jenny Bryan — **Happy Git with R** : https://happygitwithr.com
2. Hadley Wickham — **R for Data Science (2e)** : https://r4ds.hadley.nz
3. Gentzkow & Shapiro — **Code and Data for the Social Sciences** : https://web.stanford.edu/~gentzkow/research/CodeAndData.pdf
4. Nick Huntington-Klein — **The Effect** : https://theeffectbook.net
5. Croft et al. — **Guide to DHS Statistics** : https://dhsprogram.com/publications/publication-DHSG1-DHS-Questionnaires-and-Manuals.cfm
