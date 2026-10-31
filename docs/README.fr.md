# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · **Français** · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Commandes de console pour tout terminer dans The Witcher 3 : panneaux d'affichage, cartes de Gwynt, ainsi que les lieux « ? » et les quêtes cassés par un mod (comptés aussi dans Progress on the Path).

## Installation

1. Copiez `modZPathHelper` dans `The Witcher 3\Mods`.
2. Mise à jour depuis une ancienne version ? Supprimez `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws` si vous l'aviez copié.
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

## Gwynt

| Commande | Effet |
|---|---|
| `glist(page)` | Cartes manquantes et où les obtenir, région actuelle d'abord (`*` = téléportation possible) |
| `gnext()` | Téléporte vers le joueur ou marchand le plus proche ayant une carte manquante. Gagnez-la ou achetez-la, puis relancez `gnext()` |
| `gcheat()` | Triche : ajoute toutes les cartes manquantes et termine les quêtes secondaires de Gwynt dans le journal (pas les tournois) |

`gcheat()` ne modifie que l'inventaire et le journal. Les PNJ peuvent encore proposer des parties et certaines vérifications de l'histoire peuvent ignorer les victoires. Sauvegardez avant.

## Carte : lieux « ? » et quêtes cassées

Pour les lieux cassés par un mod : l'autoloot a pris l'objet qu'une quête attend, un mur ne peut plus être détruit, un « ? » ne disparaît jamais. Un lieu compte comme terminé dans le jeu et dans Progress on the Path quand son marqueur est découvert et grisé ; ces commandes mettent exactement cet état. Elles agissent sur la carte où vous êtes (Velen et Novigrad sont une seule carte).

| Commande | Effet |
|---|---|
| `qfix()` | Réparer les « ? » bugués sur toute la carte : lieux que le jeu compte déjà comme terminés mais affiche encore en « ? ». Les lieux non terminés ne sont pas touchés |
| `qdone(r)` | Placez-vous à un lieu cassé : marque comme terminé tout ce qui ne l'est pas dans un rayon de `r` mètres (50 par défaut) |
| `qpins(r)` | Marqueurs de la carte dans un rayon de `r` mètres (30 par défaut) et leur état |
| `questdone()` | Terminer la quête secondaire suivie dans le journal (les quêtes principales sont refusées) |
| `qevent(r)` | Un événement aléatoire déjà fait affiche encore le « ! » bleu de Progress on the Path : placez-vous dessus, lancez la commande, puis méditez. Marque comme terminés les événements PotP dans un rayon de `r` mètres (10 par défaut). Velen, Novigrad, Skellige, Kaer Morhen |
| `qdoneall()` | Compter les lieux non terminés de cette carte. `qdoneall("", 1)` les marque TOUS comme terminés, qu'ils le soient ou non. Sauvegardez avant |
| `qreveal()` | Afficher sur la carte tous les lieux « ? » cachés de la région (non découverts tant que vous n'y allez pas) |

## Licence

MIT
