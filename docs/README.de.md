# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · **Deutsch** · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Konsolenbefehle, die dir helfen, in The Witcher 3 alles abzuschließen: Anschlagtafeln, Gwint-Karten und optional die Statistik von Progress on the Path.

## Installation

1. Kopiere `modZPathHelper` nach `The Witcher 3\Mods`.
2. Optional: Wenn du **Progress on the Path** nutzt, kopiere auch `modZPathHelper_PotP`. Ohne PotP bricht dieser Ordner die Skriptkompilierung.
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

## Add-on für Progress on the Path

| Befehl | Funktion |
|---|---|
| `pp()` | Was in der aktuellen Region übrig ist, nach Typ |
| `pp("contract", page)` | Liste nach Typ: `main`, `side`, `contract`, `hunt`, `scavenger`, `event`, `gwent` |

## Lizenz

MIT
