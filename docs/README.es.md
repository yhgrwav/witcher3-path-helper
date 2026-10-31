# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · **Español** · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Comandos de consola que te ayudan a completarlo todo en The Witcher 3: tablones de anuncios, cartas de Gwent y lugares «?» o misiones que un mod rompió (también cuentan en Progress on the Path).

## Instalación

1. Copia `modZPathHelper` en `The Witcher 3\Mods`.
2. ¿Actualizas desde una versión antigua? Borra `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws` si lo copiaste.
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

## Gwent

| Comando | Qué hace |
|---|---|
| `glist(page)` | Cartas que faltan y dónde conseguirlas, primero la región actual (`*` = se puede teletransportar) |
| `gnext()` | Teletransporta al jugador o mercader más cercano con una carta que falta. Gánala o cómprala y vuelve a usar `gnext()` |
| `gcheat()` | Truco: añade todas las cartas que faltan y completa las misiones secundarias de Gwent en el diario (no los torneos) |

`gcheat()` solo cambia el inventario y el diario. Los PNJ pueden seguir ofreciendo partidas y algunas comprobaciones de la historia pueden no contar las victorias. Guarda antes.

## Mapa: lugares «?» y misiones rotas

Para lugares que rompió un mod: el autoloot tomó el objeto que espera una misión, una pared ya no se puede destruir, un «?» nunca desaparece. Un lugar cuenta como completado en el juego y en Progress on the Path cuando su marcador está descubierto y en gris; estos comandos ponen justo ese estado. Funcionan en el mapa donde estás (Velen y Novigrado son un mismo mapa).

| Comando | Qué hace |
|---|---|
| `qfix()` | Arreglar los «?» con bug en todo el mapa: lugares que el juego ya cuenta como completados pero sigue mostrando como «?». No toca los lugares sin completar |
| `qdone(r)` | Ponte en un lugar roto: marca como completado todo lo pendiente en un radio de `r` metros (50 por defecto) |
| `qpins(r)` | Marcadores del mapa en un radio de `r` metros (30 por defecto) y su estado |
| `questdone()` | Completar la misión secundaria seguida en el diario (las principales se rechazan) |
| `qevent(r)` | Un evento aleatorio ya hecho sigue mostrando el «!» azul de Progress on the Path: ponte encima, ejecuta el comando y medita. Marca como completados los eventos de PotP en un radio de `r` metros (10 por defecto). Velen, Novigrado, Skellige, Kaer Morhen |
| `qdoneall()` | Contar los lugares pendientes de este mapa. `qdoneall("", 1)` marca TODOS como completados, lo estén o no. Guarda antes |
| `qreveal()` | Mostrar en el mapa todos los lugares «?» ocultos de la región (siguen sin descubrir hasta que los visites) |

## Licencia

MIT
