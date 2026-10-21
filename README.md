# Board Taker — The Witcher 3 (next-gen)

**English** · [Русский](docs/README.ru.md) · [Polski](docs/README.pl.md) · [Українська](docs/README.uk.md) · [Deutsch](docs/README.de.md) · [Français](docs/README.fr.md) · [Español](docs/README.es.md) · [Português (BR)](docs/README.pt-BR.md) · [Čeština](docs/README.cs.md) · [简体中文](docs/README.zh-CN.md)

Console commands that take every contract and notice from notice boards for you, including a fully automatic tour of all boards in the current region. Handy when you have unlocked every fast travel point and no longer remember which boards you have checked.

Quests are taken through the game's own notice board code, so they appear in the journal exactly as if you had pulled the note yourself.

## Requirements

- The Witcher 3: Wild Hunt next-gen (4.0 or newer, uses script annotations)
- The debug console enabled (`DBGConsoleOn=true` in `bin\config\base\general.ini`, or any console mod)

## Installation

Copy the `modZBoardTaker` folder into `The Witcher 3\Mods`. No merging needed, vanilla files are not changed.

## Commands

| Command | What it does |
|---|---|
| `bauto()` | Automatic tour: teleports to every board marked NEW in the current region (~4 s each) and takes all quests |
| `bauto(true)` | Same, but visits every board |
| `bstop()` | Stops the tour |
| `btake()` | Takes quests from all loaded boards around you (~2 km) |
| `blist()` | Boards in the region, nearest first. `blist(1)` for the next page |
| `bgo(N)` | Teleport to board N from `blist()` |
| `btour()` | Teleport to the nearest board that still has quests |

## Notes

- Works only in the current world (Velen/Novigrad, Skellige, Toussaint, etc. are separate worlds). Run `bauto()` once in each region.
- If a board did not load in 4 seconds, run `bauto()` again — it only visits boards that still have quests.
- A board can stay NEW if some of its notes are not unlocked by the story yet.
- The tour pauses during combat.

## License

MIT
