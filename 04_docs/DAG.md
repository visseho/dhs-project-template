# Diagramme causal (DAG)

> **À dessiner avant toute analyse.** Le DAG détermine votre adjustment set et distingue les confondants (à ajuster) des médiateurs (à ne PAS ajuster dans le modèle principal).

## Nœuds

- **X** — Exposition : *[à nommer]*
- **Y** — Issue : *[à nommer]*
- *[autres variables]*

## Arcs assumés

```
X -> Y    (effet d'intérêt)
C1 -> X, Y   (confondant)
X -> M -> Y  (médiateur)
U -> X, Y    (confondant non mesuré)
```

## Implications

- **Adjustment set minimal** pour l'effet total X → Y : *[à déterminer]*
- **Médiateurs** (ne jamais inclure dans le modèle principal) : *[liste]*
- **Confondants non mesurés** (à discuter en limites) : *[liste]*

## Outil

Tester le DAG avec [DAGitty](https://www.dagitty.net) ou le paquet R `dagitty`. Un exemple est fourni dans `notebooks/dag.R`.
