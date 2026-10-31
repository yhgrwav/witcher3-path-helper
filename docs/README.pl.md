# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · **Polski** · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Komendy konsoli, które pomagają ukończyć wszystko w Wiedźminie 3: tablice ogłoszeń, karty gwinta oraz „?” i zadania zepsute przez mody (liczą się też w Progress on the Path).

## Instalacja

1. Skopiuj `modZPathHelper` do `The Witcher 3\Mods`.
2. Aktualizujesz ze starszej wersji? Usuń `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws`, jeśli go kopiowałeś.
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

## Mapa: „?” i zepsute zadania

Dla miejsc zepsutych przez mod: autoloot zabrał przedmiot, na który czeka zadanie, ściany nie da się już zniszczyć, „?” nie znika. Miejsce liczy się jako ukończone w grze i w Progress on the Path, gdy jego znacznik jest odkryty i wyszarzony; te komendy ustawiają właśnie ten stan. Działają na mapie, na której jesteś (Velen i Novigrad to jedna mapa).

| Komenda | Działanie |
|---|---|
| `qfix()` | Naprawia zbugowane „?” na całej mapie: miejsca, które gra już uznaje za ukończone, ale pokazuje jako „?”. Nieukończonych nie rusza |
| `qdone(r)` | Stań przy zepsutym miejscu: oznacza jako ukończone wszystko nieukończone w promieniu `r` metrów (domyślnie 50) |
| `qpins(r)` | Znaczniki mapy w promieniu `r` metrów (domyślnie 30) i ich stan |
| `questdone()` | Kończy zadanie poboczne śledzone w dzienniku (główne są pomijane) |
| `qevent(r)` | Losowe zdarzenie jest już zaliczone, a niebieski „!” z Progress on the Path wciąż wisi: stań na nim, wpisz komendę i medytuj. Oznacza zdarzenia PotP w promieniu `r` metrów jako ukończone (domyślnie 10). Velen, Novigrad, Skellige, Kaer Morhen |
| `qdoneall()` | Ile nieukończonych miejsc jest na tej mapie. `qdoneall("", 1)` oznacza WSZYSTKIE jako ukończone, czy są ukończone, czy nie. Najpierw zapisz grę |
| `qreveal()` | Pokazuje na mapie wszystkie ukryte „?” regionu (pozostają nieodkryte, dopóki ich nie odwiedzisz) |

## Licencja

MIT
