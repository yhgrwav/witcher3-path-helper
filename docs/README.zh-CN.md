# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · [Português (BR)](README.pt-BR.md) · [Čeština](README.cs.md) · **简体中文**

帮助你在《巫师 3》中完成一切的控制台命令：告示板、昆特牌，以及可选的 Progress on the Path 统计。

## 安装

1. 将 `modZPathHelper` 复制到 `The Witcher 3\Mods`。
2. 可选：如果你使用 **Progress on the Path**，再复制 `modZPathHelper_PotP`。没有 PotP 时该文件夹会导致脚本编译失败。
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

## Progress on the Path 扩展

| 命令 | 作用 |
|---|---|
| `pp()` | 当前区域按类型列出剩余内容 |
| `pp("contract", page)` | 按类型列出：`main`、`side`、`contract`、`hunt`、`scavenger`、`event`、`gwent` |

## 许可证

MIT
