# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · **Español** · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Comandos de consola que te ayudan a completarlo todo en The Witcher 3: tablones de anuncios, cartas de Gwent y, opcionalmente, las estadísticas de Progress on the Path.

## Instalación

1. Copia `modZPathHelper` en `The Witcher 3\Mods`.
2. Opcional: si usas **Progress on the Path**, copia también `modProgressOnThePathNG` (merge). Sin PotP esta carpeta rompe la compilación de scripts.
3. Activa la consola de depuración.
4. ¿Actualizas desde Board Taker? Borra la carpeta antigua `modZBoardTaker`.

## Tablones de anuncios

| Comando | Qué hace |
|---|---|
| `btake()` | Tomar todas las misiones de los tablones en 2 km |
| `blist(page)` | Listar los tablones de la región |
| `bgo(i)` | Teletransportarse al tablón `i` |
| `btour()` | Teletransportarse al siguiente tablón con anuncios nuevos |
| `bauto()` / `bauto(true)` | Ruta automática: teletransporta de tablón en tablón y toma misiones (pausa en combate; `true` = todos) |
| `bstop()` | Detener la ruta |
| `qreveal()` | Mostrar en el mapa todos los «?» ocultos de la región (siguen sin descubrir hasta que los visites) |

## Gwent

| Comando | Qué hace |
|---|---|
| `glist(page)` | Cartas que faltan y dónde conseguirlas, primero la región actual (`*` = se puede teletransportar) |
| `gnext()` | Teletransporta al jugador o mercader más cercano con una carta que falta. Gánala o cómprala y vuelve a usar `gnext()` |
| `gcheat()` | Truco: añade todas las cartas que faltan y completa las misiones secundarias de Gwent en el diario (no los torneos) |

`gcheat()` solo cambia el inventario y el diario. Los PNJ pueden seguir ofreciendo partidas y algunas comprobaciones de la historia pueden no contar las victorias. Guarda antes.

## Complemento para Progress on the Path

| Comando | Qué hace |
|---|---|
| `pp()` | Lo que queda en la región actual, por tipo |
| `pp("contract", page)` | Lista por tipo: `main`, `side`, `contract`, `hunt`, `scavenger`, `event`, `gwent` |

## Licencia

MIT
