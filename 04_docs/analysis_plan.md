# Plan pré-analyse

> **À remplir avant de regarder les résultats.** Datez et signez (nom du directeur ou directrice + étudiant·e). Idéalement : déposez-le sur l'OSF (https://osf.io) pour obtenir un horodatage indépendant.

**Projet :** *[titre]*
**Version :** 0.1 — [date]
**Auteur·rice·s :** *[étudiant·e, directeur·rice]*

---

## 1. Question(s) de recherche

Listez vos questions, numérotées. Soyez précis·e sur la population, l'exposition et l'issue.

| # | Question | Hypothèse pré-spécifiée |
|---|---|---|
| Q1 | *[Est-ce que X est associé à Y dans la population Z ?]* | *[Hypothèse directionnelle ou nulle, avec rationale théorique.]* |
| Q2 | ... | ... |

## 2. Population et échantillon

- **Source des données :** *[enquêtes DHS, pays, années]*
- **Population cible :** *[ex. femmes 15-49 actuellement en union]*
- **Critères d'inclusion :** *[liste]*
- **Critères d'exclusion :** *[liste]*
- **Taille d'échantillon attendue :** *[estimée à partir des documentations DHS]*

## 3. Variables

### 3.1 Issue(s) (variable dépendante)

| Nom | Définition opérationnelle | Variables DHS sources |
|---|---|---|
| *[y]* | *[seuils, codage, référence]* | *[v...]* |

### 3.2 Exposition principale

| Nom | Codage | Catégorie de référence |
|---|---|---|
| *[x]* | *[binaire/continu/catégoriel]* | *[réf.]* |

### 3.3 Confondants (adjustment set)

Issu du DAG dans `04_docs/DAG.md`. Listez-les :

- *[c1]*
- *[c2]*

### 3.4 Médiateurs potentiels

À ne **pas** inclure dans le modèle principal ; traités dans des analyses de médiation séparées.

- *[m1]*
- *[m2]*

## 4. Stratégie d'analyse

### 4.1 Modèle principal

*[Ex. régression logistique pondérée avec effets fixes pays et plan de sondage complexe (PSU + strates).]*

### 4.2 Modèles secondaires

- *[multiniveau]*
- *[stratification]*
- *[méta-analyse par pays]*

### 4.3 Analyses de sensibilité

- *[seuil alternatif]*
- *[sous-échantillon]*
- *[méthode d'ajustement alternative]*

### 4.4 Analyses de médiation (si applicable)

*[Cadre Imai/Keele/Tingley ou autre. Préciser les hypothèses d'identification.]*

## 5. Tests multiples

Nombre de tests pré-spécifiés : *[N]*. Correction prévue : *[Bonferroni / FDR / aucune, avec justification]*.

## 6. Déviations

Toute déviation à ce plan sera documentée dans `04_docs/deviations.md` avec date, raison, impact.

## 7. Reproductibilité

Code versionné sur GitHub : *[URL]*
Paquets R versionnés avec `renv` : voir `renv.lock`.
Commande pour reproduire : `make all`.

---

**Signatures (manuscrites, scannées, ou mention explicite datée) :**

- Étudiant·e : _______________________ Date : __________
- Directeur·rice : ___________________ Date : __________
