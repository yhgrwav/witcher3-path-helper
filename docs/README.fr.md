# Board Taker — The Witcher 3 (next-gen)

[English](../README.md) · **Français**

Des commandes console qui prennent pour vous tous les contrats et annonces des panneaux d'affichage, dont une tournée entièrement automatique de tous les panneaux de la région actuelle. Pratique quand tous les points de voyage rapide sont débloqués et que vous ne savez plus quels panneaux vous avez consultés.

Les quêtes passent par le code des panneaux du jeu lui-même : elles apparaissent dans le journal comme si vous aviez arraché l'annonce à la main.

## Prérequis

- The Witcher 3: Wild Hunt next-gen (4.0 ou plus récent, utilise les annotations de script)
- Console activée (`DBGConsoleOn=true` dans `bin\config\base\general.ini`, ou un mod de console)

## Installation

Copiez le dossier `modZBoardTaker` dans `The Witcher 3\Mods`. Aucune fusion nécessaire, les fichiers du jeu ne sont pas modifiés.

## Commandes

| Commande | Effet |
|---|---|
| `bauto()` | Tournée automatique : téléporte à chaque panneau marqué NEW de la région (~4 s chacun) et prend toutes les quêtes |
| `bauto(true)` | Idem, mais visite tous les panneaux |
| `bstop()` | Arrête la tournée |
| `btake()` | Prend les quêtes de tous les panneaux chargés autour de vous (~2 km) |
| `blist()` | Panneaux de la région, du plus proche au plus loin. `blist(1)` pour la page suivante |
| `bgo(N)` | Téléporte au panneau N de `blist()` |
| `btour()` | Téléporte au panneau le plus proche qui a encore des quêtes |

## Remarques

- Fonctionne uniquement dans le monde actuel (Velen/Novigrad, Skellige, Toussaint, etc. sont des mondes séparés). Lancez `bauto()` une fois par région.
- Si un panneau n'a pas chargé en 4 secondes, relancez `bauto()` : il ne visite que les panneaux qui ont encore des quêtes.
- Un panneau peut rester NEW si certaines annonces ne sont pas encore débloquées par l'histoire.
- La tournée se met en pause pendant les combats.

## Licence

MIT
