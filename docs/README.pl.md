# Board Taker — Wiedźmin 3 (next-gen)

[English](../README.md) · **Polski**

Komendy konsoli, które zbierają wszystkie zlecenia i ogłoszenia z tablic, w tym w pełni automatyczny objazd wszystkich tablic w bieżącym regionie. Przydatne, gdy masz odblokowane wszystkie punkty szybkiej podróży i nie pamiętasz już, które tablice sprawdziłeś.

Zadania są pobierane przez kod tablic samej gry, więc trafiają do dziennika tak, jakbyś zerwał ogłoszenie ręcznie.

## Wymagania

- Wiedźmin 3: Dziki Gon next-gen (4.0 lub nowszy, używa adnotacji skryptów)
- Włączona konsola (`DBGConsoleOn=true` w `bin\config\base\general.ini` lub dowolny mod konsoli)

## Instalacja

Skopiuj folder `modZBoardTaker` do `The Witcher 3\Mods`. Scalanie nie jest potrzebne, pliki gry nie są zmieniane.

## Komendy

| Komenda | Działanie |
|---|---|
| `bauto()` | Automatyczny objazd: teleport do każdej tablicy oznaczonej NEW w regionie (~4 s każda) i zebranie zadań |
| `bauto(true)` | To samo, ale odwiedza wszystkie tablice |
| `bstop()` | Zatrzymuje objazd |
| `btake()` | Zbiera zadania ze wszystkich wczytanych tablic wokół (~2 km) |
| `blist()` | Tablice w regionie, najbliższe najpierw. `blist(1)` — następna strona |
| `bgo(N)` | Teleport do tablicy N z `blist()` |
| `btour()` | Teleport do najbliższej tablicy, na której są jeszcze zadania |

## Uwagi

- Działa tylko w bieżącym świecie (Velen/Novigrad, Skellige, Toussaint itd. to osobne światy). Uruchom `bauto()` raz w każdym regionie.
- Jeśli tablica nie wczytała się w 4 sekundy, uruchom `bauto()` ponownie — odwiedzi tylko tablice z pozostałymi zadaniami.
- Tablica może pozostać NEW, jeśli część ogłoszeń nie została jeszcze odblokowana przez fabułę.
- Podczas walki objazd jest wstrzymywany.

## Licencja

MIT
