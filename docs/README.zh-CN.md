# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · **简体中文**

帮助你在《巫师 3》中完成一切的控制台命令：告示板、昆特牌，以及被模组弄坏的“?”地点和任务（也计入 Progress on the Path）。

## 安装

1. 将 `modZPathHelper` 复制到 `The Witcher 3\Mods`。
2. 从旧版本升级？如果你复制过 `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws`，请删除它。
3. 开启调试控制台。
4. 从 Board Taker 升级？请删除旧的 `modZBoardTaker` 文件夹。

## 告示板

| 命令 | 作用 |
|---|---|
| `btake()` | 接取 2 公里内所有告示板的任务 |
| `blist(page)` | 列出本区域的告示板 |
| `bgo(i)` | 传送到告示板 `i` |
| `btour()` | 传送到下一个有新告示的告示板 |
| `bauto()` / `bauto(true)` | 自动巡游：在告示板之间传送并接取任务（战斗中暂停；`true` = 全部告示板） |
| `bstop()` | 停止自动巡游 |

## 昆特牌

| 命令 | 作用 |
|---|---|
| `glist(page)` | 缺少的卡牌及获取地点，当前区域优先（`*` = 可传送） |
| `gnext()` | 传送到最近的持有缺失卡牌的玩家或商人。赢下或买下后再次执行 `gnext()` |
| `gcheat()` | 作弊：添加所有缺失卡牌，并在日志中完成昆特牌支线任务（不含锦标赛） |

`gcheat()` 只修改物品栏和日志。NPC 可能仍会邀请对局，部分剧情判定可能不计入胜利。请先存档。

## 地图：“?”地点和损坏的任务

用于被模组弄坏的地点：自动拾取拿走了任务需要的物品、墙再也无法摧毁、“?”永远不消失。当地图标记已发现并变灰时，该地点在游戏和 Progress on the Path 中都算完成；这些命令正是设置这种状态。它们只作用于你当前所在的地图（威伦和诺维格瑞是同一张地图）。

| 命令 | 作用 |
|---|---|
| `qfix()` | 修复整张地图上出错的“?”：游戏已算作完成却仍显示为“?”的地点。不会动未完成的地点 |
| `qdone(r)` | 站在损坏的地点旁：将 `r` 米内所有未完成的地点标记为完成（默认 50） |
| `qpins(r)` | `r` 米内（默认 30）的地图标记及其状态 |
| `questdone()` | 完成日志中正在追踪的支线任务（主线任务会被拒绝） |
| `qdoneall()` | 统计本地图未完成的地点。`qdoneall("", 1)` 会把全部地点标记为完成，无论是否完成。请先存档 |
| `qreveal()` | 在地图上显示本区域所有隐藏的“?”地点（在你到访前仍保持未发现） |

## 许可证

MIT
