# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · **Deutsch** · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Konsolenbefehle, die dir helfen, in The Witcher 3 alles abzuschließen: Anschlagtafeln, Gwint-Karten sowie „?“-Orte und Quests, die ein Mod kaputt gemacht hat (zählen auch in Progress on the Path).

## Installation

1. Kopiere `modZPathHelper` nach `The Witcher 3\Mods`.
2. Update von einer älteren Version? Lösche `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws`, falls du es kopiert hast.
3. Aktiviere die Debug-Konsole.
4. Update von Board Taker? Lösche den alten Ordner `modZBoardTaker`.

## Anschlagtafeln

| Befehl | Funktion |
|---|---|
| `btake()` | Alle Aufträge von Tafeln im Umkreis von 2 km annehmen |
| `blist(page)` | Tafeln der Region auflisten |
| `bgo(i)` | Zu Tafel `i` teleportieren |
| `btour()` | Zur nächsten Tafel mit neuen Aushängen teleportieren |
| `bauto()` / `bauto(true)` | Auto-Tour: teleportiert von Tafel zu Tafel und nimmt Aufträge (Pause im Kampf; `true` = alle Tafeln) |
| `bstop()` | Auto-Tour stoppen |

## Gwint

| Befehl | Funktion |
|---|---|
| `glist(page)` | Fehlende Karten und wo man sie bekommt, aktuelle Region zuerst (`*` = Teleport möglich) |
| `gnext()` | Teleport zum nächsten Spieler oder Händler mit einer fehlenden Karte. Gewinnen oder kaufen, dann wieder `gnext()` |
| `gcheat()` | Cheat: fügt alle fehlenden Karten hinzu und schließt die Gwint-Nebenquests im Tagebuch ab (keine Turniere) |

`gcheat()` ändert nur Inventar und Tagebuch. NPCs bieten eventuell weiter Partien an, und manche Story-Prüfungen zählen die Siege nicht. Vorher speichern.

## Karte: „?“-Orte und kaputte Quests

Für Orte, die ein Mod kaputt gemacht hat: Autoloot hat den Gegenstand genommen, auf den eine Quest wartet, eine Wand lässt sich nicht mehr zerstören, ein „?“ verschwindet nie. Ein Ort gilt im Spiel und in Progress on the Path als erledigt, wenn seine Kartenmarkierung entdeckt und ausgegraut ist; diese Befehle setzen genau diesen Zustand. Sie wirken auf der Karte, auf der du bist (Velen und Novigrad sind eine Karte).

| Befehl | Funktion |
|---|---|
| `qfix()` | Verbuggte „?“ auf der ganzen Karte reparieren: Orte, die das Spiel schon als erledigt zählt, aber noch als „?“ zeigt. Unerledigte Orte bleiben unberührt |
| `qdone(r)` | An einem kaputten Ort stehen: alles Unerledigte im Umkreis von `r` Metern als erledigt markieren (Standard 50) |
| `qpins(r)` | Kartenmarkierungen im Umkreis von `r` Metern (Standard 30) und ihr Zustand |
| `questdone()` | Die im Tagebuch verfolgte Nebenquest abschließen (Hauptquests werden abgelehnt) |
| `qdoneall()` | Unerledigte Orte auf dieser Karte zählen. `qdoneall("", 1)` markiert ALLE als erledigt, egal ob erledigt oder nicht. Vorher speichern |
| `qreveal()` | Alle versteckten „?“-Orte der Region auf der Karte zeigen (bleiben unentdeckt, bis du sie besuchst) |

## Lizenz

MIT
