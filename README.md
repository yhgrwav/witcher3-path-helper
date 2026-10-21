# Path Helper — The Witcher 3 (next-gen)

**English** · [Русский](docs/README.ru.md) · [Polski](docs/README.pl.md) · [Українська](docs/README.uk.md) · [Deutsch](docs/README.de.md) · [Français](docs/README.fr.md) · [Español](docs/README.es.md) · [Português (BR)](docs/README.pt-BR.md) · [Čeština](docs/README.cs.md) · [简体中文](docs/README.zh-CN.md)

Console commands that help you finish everything in The Witcher 3: notice boards, Gwent cards and, optionally, Progress on the Path statistics.

## Install

1. Copy `modZPathHelper` into `The Witcher 3\Mods`.
2. Optional: if you use **Progress on the Path**, also copy `modZPathHelper_PotP`. Without PotP this folder will break script compilation.
3. Enable the debug console.
4. Updating from Board Taker? Delete the old `modZBoardTaker` folder.

## Notice boards

| Command | What it does |
|---|---|
| `btake()` | Take all quests from boards within 2 km |
| `blist(page)` | List boards in the region |
| `bgo(i)` | Teleport to board `i` |
| `btour()` | Teleport to the next board with new notices |
| `bauto()` / `bauto(true)` | Auto tour: teleports from board to board and takes quests (pauses in combat; `true` = all boards) |
| `bstop()` | Stop the auto tour |

## Gwent

| Command | What it does |
|---|---|
| `glist(page)` | Missing cards and where to get them, current region first (`*` = teleport available) |
| `gnext()` | Teleport to the nearest player or merchant with a missing card. Win or buy it, then run `gnext()` again |
| `gcheat()` | Cheat: adds every missing card and completes the Gwent side quests in the journal (tournaments are not touched) |

`gcheat()` only changes the inventory and the journal. NPCs may still offer games, and some story checks may not count the wins. Make a save first.

## Progress on the Path add-on

| Command | What it does |
|---|---|
| `pp()` | What is left in the current region, by type |
| `pp("contract", page)` | List by type: `main`, `side`, `contract`, `hunt`, `scavenger`, `event`, `gwent` |

## License

MIT
