# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · **Français** · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Commandes de console pour tout terminer dans The Witcher 3 : panneaux d'affichage, cartes de Gwynt et, en option, les statistiques de Progress on the Path.

## Installation

1. Copiez `modZPathHelper` dans `The Witcher 3\Mods`.
2. Optionnel : si vous utilisez **Progress on the Path**, copiez aussi `modZPathHelper_PotP`. Sans PotP, ce dossier casse la compilation des scripts.
3. Activez la console de débogage.
4. Mise à jour depuis Board Taker ? Supprimez l'ancien dossier `modZBoardTaker`.

## Panneaux d'affichage

| Commande | Effet |
|---|---|
| `btake()` | Prendre toutes les quêtes des panneaux dans un rayon de 2 km |
| `blist(page)` | Lister les panneaux de la région |
| `bgo(i)` | Se téléporter au panneau `i` |
| `btour()` | Se téléporter au prochain panneau avec de nouvelles annonces |
| `bauto()` / `bauto(true)` | Tournée auto : téléporte de panneau en panneau et prend les quêtes (pause en combat ; `true` = tous les panneaux) |
| `bstop()` | Arrêter la tournée |
| `qreveal()` | Afficher sur la carte tous les « ? » cachés de la région (non découverts tant que vous n’y allez pas) |

## Gwynt

| Commande | Effet |
|---|---|
| `glist(page)` | Cartes manquantes et où les obtenir, région actuelle d'abord (`*` = téléportation possible) |
| `gnext()` | Téléporte vers le joueur ou marchand le plus proche ayant une carte manquante. Gagnez-la ou achetez-la, puis relancez `gnext()` |
| `gcheat()` | Triche : ajoute toutes les cartes manquantes et termine les quêtes secondaires de Gwynt dans le journal (pas les tournois) |

`gcheat()` ne modifie que l'inventaire et le journal. Les PNJ peuvent encore proposer des parties et certaines vérifications de l'histoire peuvent ignorer les victoires. Sauvegardez avant.

## Module pour Progress on the Path

| Commande | Effet |
|---|---|
| `pp()` | Ce qui reste dans la région actuelle, par type |
| `pp("contract", page)` | Liste par type : `main`, `side`, `contract`, `hunt`, `scavenger`, `event`, `gwent` |

## Licence

MIT
