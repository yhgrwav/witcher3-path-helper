# Board Taker — The Witcher 3 (next-gen)

[English](../README.md) · **Español**

Comandos de consola que recogen por ti todos los contratos y avisos de los tablones de anuncios, incluido un recorrido totalmente automático por todos los tablones de la región actual. Útil cuando tienes desbloqueados todos los puntos de viaje rápido y ya no recuerdas qué tablones has revisado.

Las misiones se toman mediante el propio código de los tablones del juego, así que aparecen en el diario igual que si hubieras arrancado el aviso tú mismo.

## Requisitos

- The Witcher 3: Wild Hunt next-gen (4.0 o posterior, usa anotaciones de script)
- Consola activada (`DBGConsoleOn=true` en `bin\config\base\general.ini`, o cualquier mod de consola)

## Instalación

Copia la carpeta `modZBoardTaker` en `The Witcher 3\Mods`. No hace falta fusionar, los archivos originales no se modifican.

## Comandos

| Comando | Qué hace |
|---|---|
| `bauto()` | Recorrido automático: teletransporta a cada tablón marcado como NEW en la región (~4 s cada uno) y toma todas las misiones |
| `bauto(true)` | Lo mismo, pero visita todos los tablones |
| `bstop()` | Detiene el recorrido |
| `btake()` | Toma las misiones de todos los tablones cargados a tu alrededor (~2 km) |
| `blist()` | Tablones de la región, los más cercanos primero. `blist(1)` para la página siguiente |
| `bgo(N)` | Teletransporte al tablón N de `blist()` |
| `btour()` | Teletransporte al tablón más cercano que aún tiene misiones |

## Notas

- Solo funciona en el mundo actual (Velen/Novigrad, Skellige, Toussaint, etc. son mundos separados). Ejecuta `bauto()` una vez en cada región.
- Si un tablón no cargó en 4 segundos, vuelve a ejecutar `bauto()`: solo visitará los tablones con misiones pendientes.
- Un tablón puede seguir como NEW si algunos avisos aún no se han desbloqueado por la historia.
- El recorrido se pausa durante los combates.

## Licencia

MIT
