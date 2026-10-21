# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · **Português (BR)** · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Comandos de console que ajudam a concluir tudo em The Witcher 3: quadros de avisos, cartas de Gwent e, opcionalmente, as estatísticas do Progress on the Path.

## Instalação

1. Copie `modZPathHelper` para `The Witcher 3\Mods`.
2. Opcional: se você usa **Progress on the Path**, copie também `modZPathHelper_PotP`. Sem o PotP essa pasta quebra a compilação dos scripts.
3. Ative o console de depuração.
4. Atualizando do Board Taker? Apague a pasta antiga `modZBoardTaker`.

## Quadros de avisos

| Comando | O que faz |
|---|---|
| `btake()` | Pegar todas as missões dos quadros num raio de 2 km |
| `blist(page)` | Listar os quadros da região |
| `bgo(i)` | Teleportar para o quadro `i` |
| `btour()` | Teleportar para o próximo quadro com avisos novos |
| `bauto()` / `bauto(true)` | Rota automática: teleporta de quadro em quadro pegando missões (pausa em combate; `true` = todos) |
| `bstop()` | Parar a rota |
| `qreveal()` | Mostrar no mapa todos os “?” ocultos da região (continuam não descobertos até você visitá-los) |

## Gwent

| Comando | O que faz |
|---|---|
| `glist(page)` | Cartas que faltam e onde obtê-las, região atual primeiro (`*` = teleporte disponível) |
| `gnext()` | Teleporta para o jogador ou mercador mais próximo com uma carta que falta. Vença ou compre e use `gnext()` de novo |
| `gcheat()` | Trapaça: adiciona todas as cartas que faltam e conclui as missões secundárias de Gwent no diário (não os torneios) |

`gcheat()` muda só o inventário e o diário. NPCs ainda podem oferecer partidas e algumas verificações da história podem não contar as vitórias. Salve antes.

## Complemento para o Progress on the Path

| Comando | O que faz |
|---|---|
| `pp()` | O que falta na região atual, por tipo |
| `pp("contract", page)` | Lista por tipo: `main`, `side`, `contract`, `hunt`, `scavenger`, `event`, `gwent` |

## Licença

MIT
