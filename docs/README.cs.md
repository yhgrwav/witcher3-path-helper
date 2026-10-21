# Board Taker — Zaklínač 3 (next-gen)

[English](../README.md) · **Čeština**

Příkazy konzole, které za vás vezmou všechny zakázky a oznámení z nástěnek, včetně plně automatické cesty po všech nástěnkách aktuálního regionu. Hodí se, když máte odemčené všechny body rychlého cestování a už nevíte, které nástěnky jste prošli.

Úkoly se přijímají přes vlastní kód nástěnek hry, takže se v deníku objeví stejně, jako byste oznámení strhli sami.

## Požadavky

- Zaklínač 3: Divoký hon next-gen (4.0 nebo novější, používá anotace skriptů)
- Zapnutá konzole (`DBGConsoleOn=true` v `bin\config\base\general.ini` nebo libovolný mod konzole)

## Instalace

Zkopírujte složku `modZBoardTaker` do `The Witcher 3\Mods`. Slučování není potřeba, původní soubory se nemění.

## Příkazy

| Příkaz | Co dělá |
|---|---|
| `bauto()` | Automatická cesta: teleport ke každé nástěnce označené NEW v regionu (~4 s na každou) a převzetí všech úkolů |
| `bauto(true)` | Totéž, ale navštíví všechny nástěnky |
| `bstop()` | Zastaví cestu |
| `btake()` | Vezme úkoly ze všech načtených nástěnek v okolí (~2 km) |
| `blist()` | Nástěnky v regionu, nejbližší první. `blist(1)` pro další stránku |
| `bgo(N)` | Teleport k nástěnce N z `blist()` |
| `btour()` | Teleport k nejbližší nástěnce, kde ještě jsou úkoly |

## Poznámky

- Funguje jen v aktuálním světě (Velen/Novigrad, Skellige, Toussaint atd. jsou samostatné světy). Spusťte `bauto()` jednou v každém regionu.
- Pokud se nástěnka nenačetla do 4 sekund, spusťte `bauto()` znovu — navštíví jen nástěnky se zbývajícími úkoly.
- Nástěnka může zůstat NEW, pokud některá oznámení ještě nebyla odemčena příběhem.
- Během boje se cesta pozastaví.

## Licence

MIT
