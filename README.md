# Path Helper — The Witcher 3 (next-gen)

**English** · [Русский](docs/README.ru.md) · [Polski](docs/README.pl.md) · [Українська](docs/README.uk.md) · [Deutsch](docs/README.de.md) · [Français](docs/README.fr.md) · [Español](docs/README.es.md) · [Português (BR)](docs/README.pt-BR.md) · [Čeština](docs/README.cs.md) · [简体中文](docs/README.zh-CN.md)

Console commands that help you finish everything in The Witcher 3: notice boards, Gwent cards, and "?" places or quests a mod broke (they count in Progress on the Path too).

## Install

1. Copy `modZPathHelper` into `The Witcher 3\Mods`.
2. Updating from an older version? Delete `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws` if you copied it.
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

## Map: "?" places and broken quests

For places a mod broke: autoloot took the item a quest waits for, a wall can no longer be destroyed, a "?" never goes away. A place counts as done in the game and in Progress on the Path when its map pin is discovered and greyed out, and these commands set that state. They work on the map you are on (Velen and Novigrad are one map).

| Command | What it does |
|---|---|
| `qfix()` | Fix bugged "?" on the whole map: places the game already counts as done but still shows as "?". Unfinished places are not touched |
| `qdone(r)` | Stand at a broken place: mark every unfinished place within `r` metres as done (default 50) |
| `qpins(r)` | Map pins within `r` metres (default 30) and their state |
| `questdone()` | Complete the side quest tracked in the journal (main quests are refused) |
| `qevent(r)` | A random event you already went through still shows a blue "!" from Progress on the Path: stand at it and run this, then meditate. Marks PotP events within `r` metres as done (default 10). Velen, Novigrad, Skellige, Kaer Morhen |
| `qdoneall()` | Count unfinished places on this map. `qdoneall("", 1)` marks ALL of them as done, finished or not. Make a save first |
| `qreveal()` | Show every hidden "?" place in the region on the map (stays undiscovered until you visit it) |

## License

MIT
