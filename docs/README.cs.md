# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · **Čeština** · [简体中文](README.zh-CN.md)

Konzolové příkazy, které pomáhají dokončit vše v Zaklínači 3: nástěnky, karty gwintu a volitelně statistiky Progress on the Path.

## Instalace

1. Zkopírujte `modZPathHelper` do `The Witcher 3\Mods`.
2. Volitelně: pokud používáte **Progress on the Path**, zkopírujte i `modZPathHelper_PotP`. Bez PotP tato složka rozbije kompilaci skriptů.
3. Zapněte ladicí konzoli.
4. Aktualizujete z Board Taker? Smažte starou složku `modZBoardTaker`.

## Nástěnky

| Příkaz | Co dělá |
|---|---|
| `btake()` | Vzít všechny úkoly z nástěnek v okruhu 2 km |
| `blist(page)` | Seznam nástěnek v regionu |
| `bgo(i)` | Teleport k nástěnce `i` |
| `btour()` | Teleport k další nástěnce s novými oznámeními |
| `bauto()` / `bauto(true)` | Automatická trasa: teleportuje od nástěnky k nástěnce a bere úkoly (pauza v boji; `true` = všechny) |
| `bstop()` | Zastavit trasu |

## Gwint

| Příkaz | Co dělá |
|---|---|
| `glist(page)` | Chybějící karty a kde je získat, nejdřív aktuální region (`*` = lze se teleportovat) |
| `gnext()` | Teleport k nejbližšímu hráči nebo obchodníkovi s chybějící kartou. Vyhrajte ji nebo kupte, pak znovu `gnext()` |
| `gcheat()` | Cheat: přidá všechny chybějící karty a dokončí vedlejší úkoly gwintu v deníku (turnaje ne) |

`gcheat()` mění jen inventář a deník. NPC mohou dál nabízet hru a některé příběhové kontroly nemusí výhry započítat. Nejdřív uložte hru.

## Doplněk pro Progress on the Path

| Příkaz | Co dělá |
|---|---|
| `pp()` | Co zbývá v aktuálním regionu podle typu |
| `pp("contract", page)` | Seznam podle typu: `main`, `side`, `contract`, `hunt`, `scavenger`, `event`, `gwent` |

## Licence

MIT
