# Board Taker — The Witcher 3 (Next-Gen)

[English](../README.md) · **Deutsch**

Konsolenbefehle, die alle Aufträge und Aushänge von den Anschlagtafeln für dich nehmen, inklusive einer vollautomatischen Tour über alle Tafeln der aktuellen Region. Praktisch, wenn alle Schnellreisepunkte freigeschaltet sind und du nicht mehr weißt, welche Tafeln du schon geprüft hast.

Die Quests werden über den spieleigenen Tafel-Code angenommen und erscheinen im Tagebuch genauso, als hättest du den Zettel selbst abgerissen.

## Voraussetzungen

- The Witcher 3: Wild Hunt Next-Gen (4.0 oder neuer, nutzt Skript-Annotationen)
- Aktivierte Debug-Konsole (`DBGConsoleOn=true` in `bin\config\base\general.ini` oder ein Konsolen-Mod)

## Installation

Den Ordner `modZBoardTaker` nach `The Witcher 3\Mods` kopieren. Kein Mergen nötig, Originaldateien bleiben unverändert.

## Befehle

| Befehl | Funktion |
|---|---|
| `bauto()` | Automatische Tour: teleportiert zu jeder mit NEW markierten Tafel der Region (~4 s pro Tafel) und nimmt alle Quests |
| `bauto(true)` | Ebenso, aber besucht alle Tafeln |
| `bstop()` | Stoppt die Tour |
| `btake()` | Nimmt Quests von allen geladenen Tafeln in der Nähe (~2 km) |
| `blist()` | Tafeln der Region, nächste zuerst. `blist(1)` für die nächste Seite |
| `bgo(N)` | Teleport zu Tafel N aus `blist()` |
| `btour()` | Teleport zur nächsten Tafel, die noch Quests hat |

## Hinweise

- Funktioniert nur in der aktuellen Welt (Velen/Novigrad, Skellige, Toussaint usw. sind getrennte Welten). `bauto()` einmal pro Region ausführen.
- Hat eine Tafel in 4 Sekunden nicht geladen, `bauto()` erneut starten — es besucht nur Tafeln mit verbliebenen Quests.
- Eine Tafel kann NEW bleiben, wenn einige Aushänge durch die Story noch nicht freigeschaltet sind.
- Im Kampf pausiert die Tour.

## Lizenz

MIT
