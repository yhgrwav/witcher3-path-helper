# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · **Čeština** · [简体中文](README.zh-CN.md)

Konzolové příkazy, které pomáhají dokončit vše v Zaklínači 3: nástěnky, karty gwintu a místa „?“ či úkoly rozbité modem (počítají se i v Progress on the Path).

## Instalace

1. Zkopírujte `modZPathHelper` do `The Witcher 3\Mods`.
2. Aktualizujete ze starší verze? Smažte `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws`, pokud jste ho kopírovali.
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

## Mapa: místa „?“ a rozbité úkoly

Pro místa, která rozbil mod: autoloot sebral předmět, na který úkol čeká, zeď už nejde zničit, „?“ nikdy nezmizí. Místo se ve hře i v Progress on the Path počítá jako hotové, když je jeho značka objevená a zašedlá; tyto příkazy nastavují právě tento stav. Fungují na mapě, kde se nacházíte (Velen a Novigrad jsou jedna mapa).

| Příkaz | Co dělá |
|---|---|
| `qfix()` | Opravit zabugovaná „?“ na celé mapě: místa, která hra už počítá jako hotová, ale stále ukazuje jako „?“. Nedokončených míst se nedotkne |
| `qdone(r)` | Postavte se k rozbitému místu: označí jako hotové vše nedokončené v okruhu `r` metrů (výchozí 50) |
| `qpins(r)` | Značky mapy v okruhu `r` metrů (výchozí 30) a jejich stav |
| `questdone()` | Dokončit vedlejší úkol sledovaný v deníku (hlavní úkoly odmítne) |
| `qdoneall()` | Spočítat nedokončená místa na této mapě. `qdoneall("", 1)` označí jako hotová VŠECHNA, ať jsou hotová, nebo ne. Nejdřív uložte hru |
| `qreveal()` | Ukázat na mapě všechna skrytá místa „?“ v regionu (zůstanou neobjevená, dokud je nenavštívíte) |

## Licence

MIT
