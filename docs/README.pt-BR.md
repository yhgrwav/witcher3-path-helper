# Path Helper — The Witcher 3 (next-gen)

[English](../README.md) · [Русский](README.ru.md) · [Polski](README.pl.md) · [Українська](README.uk.md) · [Deutsch](README.de.md) · [Français](README.fr.md) · [Español](README.es.md) · **Português (BR)** · [Čeština](README.cs.md) · [简体中文](README.zh-CN.md)

Comandos de console que ajudam a concluir tudo em The Witcher 3: quadros de avisos, cartas de Gwent e locais "?" ou missões que um mod quebrou (contam também no Progress on the Path).

## Instalação

1. Copie `modZPathHelper` para `The Witcher 3\Mods`.
2. Atualizando de uma versão antiga? Apague `modProgressOnThePathNG\content\scripts\local\pathhelper_potp.ws` se você o copiou.
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

## Gwent

| Comando | O que faz |
|---|---|
| `glist(page)` | Cartas que faltam e onde obtê-las, região atual primeiro (`*` = teleporte disponível) |
| `gnext()` | Teleporta para o jogador ou mercador mais próximo com uma carta que falta. Vença ou compre e use `gnext()` de novo |
| `gcheat()` | Trapaça: adiciona todas as cartas que faltam e conclui as missões secundárias de Gwent no diário (não os torneios) |

`gcheat()` muda só o inventário e o diário. NPCs ainda podem oferecer partidas e algumas verificações da história podem não contar as vitórias. Salve antes.

## Mapa: locais "?" e missões quebradas

Para locais que um mod quebrou: o autoloot pegou o item que uma missão espera, uma parede não pode mais ser destruída, um "?" nunca some. Um local conta como concluído no jogo e no Progress on the Path quando seu marcador está descoberto e acinzentado; estes comandos definem exatamente esse estado. Funcionam no mapa em que você está (Velen e Novigrad são um mapa só).

| Comando | O que faz |
|---|---|
| `qfix()` | Corrigir os "?" bugados no mapa inteiro: locais que o jogo já conta como concluídos mas ainda mostra como "?". Locais não concluídos não são tocados |
| `qdone(r)` | Fique em um local quebrado: marca como concluído tudo o que falta num raio de `r` metros (padrão 50) |
| `qpins(r)` | Marcadores do mapa num raio de `r` metros (padrão 30) e seu estado |
| `questdone()` | Concluir a missão secundária acompanhada no diário (missões principais são recusadas) |
| `qevent(r)` | Um evento aleatório já feito ainda mostra o "!" azul do Progress on the Path: fique sobre ele, rode o comando e medite. Marca como concluídos os eventos do PotP num raio de `r` metros (padrão 10). Velen, Novigrad, Skellige, Kaer Morhen |
| `qdoneall()` | Contar os locais não concluídos deste mapa. `qdoneall("", 1)` marca TODOS como concluídos, estejam ou não. Salve antes |
| `qreveal()` | Mostrar no mapa todos os locais "?" ocultos da região (continuam não descobertos até você visitá-los) |

## Licença

MIT
