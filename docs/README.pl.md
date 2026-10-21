# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · **Polski** · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Komendy konsoli, które pomagają ukończyć wszystko w Wiedźminie 3: tablice ogłoszeń, karty gwinta i opcjonalnie statystyki Progress on the Path.

## Instalacja

1. Skopiuj `modZPathHelper` do `The Witcher 3\Mods`.
2. Opcjonalnie: jeśli używasz **Progress on the Path**, skopiuj też `modZPathHelper_PotP`. Bez PotP ten folder zepsuje kompilację skryptów.
3. Włącz konsolę debugowania.
4. Aktualizujesz z Board Taker? Usuń stary folder `modZBoardTaker`.

## Tablice ogłoszeń

| Komenda | Działanie |
|---|---|
| `btake()` | Weź wszystkie zadania z tablic w promieniu 2 km |
| `blist(page)` | Lista tablic w regionie |
| `bgo(i)` | Teleport do tablicy `i` |
| `btour()` | Teleport do następnej tablicy z nowymi ogłoszeniami |
| `bauto()` / `bauto(true)` | Automatyczny objazd: teleport od tablicy do tablicy i branie zadań (pauza w walce; `true` = wszystkie tablice) |
| `bstop()` | Zatrzymaj objazd |

## Gwint

| Komenda | Działanie |
|---|---|
| `glist(page)` | Brakujące karty i skąd je wziąć, najpierw bieżący region (`*` = można się teleportować) |
| `gnext()` | Teleport do najbliższego gracza lub kupca z brakującą kartą. Wygraj lub kup ją, potem znów `gnext()` |
| `gcheat()` | Cheat: dodaje wszystkie brakujące karty i kończy poboczne zadania gwinta w dzienniku (bez turniejów) |

`gcheat()` zmienia tylko ekwipunek i dziennik. NPC mogą nadal proponować grę, a niektóre sprawdzenia fabularne mogą nie zaliczyć wygranych. Najpierw zapisz grę.

## Dodatek do Progress on the Path

| Komenda | Działanie |
|---|---|
| `pp()` | Co zostało w bieżącym regionie, według typu |
| `pp("contract", page)` | Lista według typu: `main`, `side`, `contract`, `hunt`, `scavenger`, `event`, `gwent` |

## Licencja

MIT
