# Board Taker — The Witcher 3 (next-gen)

[English](../README.md) · **Português (BR)**

Comandos de console que pegam para você todos os contratos e avisos dos quadros de avisos, incluindo um tour totalmente automático por todos os quadros da região atual. Útil quando você já desbloqueou todos os pontos de viagem rápida e não lembra mais quais quadros já conferiu.

As missões são aceitas pelo próprio código dos quadros do jogo, então aparecem no diário como se você tivesse arrancado o aviso.

## Requisitos

- The Witcher 3: Wild Hunt next-gen (4.0 ou mais recente, usa anotações de script)
- Console ativado (`DBGConsoleOn=true` em `bin\config\base\general.ini`, ou qualquer mod de console)

## Instalação

Copie a pasta `modZBoardTaker` para `The Witcher 3\Mods`. Não precisa de merge, os arquivos originais não são alterados.

## Comandos

| Comando | O que faz |
|---|---|
| `bauto()` | Tour automático: teleporta para cada quadro marcado como NEW na região (~4 s cada) e pega todas as missões |
| `bauto(true)` | O mesmo, mas visita todos os quadros |
| `bstop()` | Para o tour |
| `btake()` | Pega as missões de todos os quadros carregados ao seu redor (~2 km) |
| `blist()` | Quadros da região, os mais próximos primeiro. `blist(1)` para a próxima página |
| `bgo(N)` | Teleporta para o quadro N de `blist()` |
| `btour()` | Teleporta para o quadro mais próximo que ainda tem missões |

## Observações

- Funciona apenas no mundo atual (Velen/Novigrad, Skellige, Toussaint etc. são mundos separados). Rode `bauto()` uma vez em cada região.
- Se um quadro não carregou em 4 segundos, rode `bauto()` de novo: ele só visita quadros com missões restantes.
- Um quadro pode continuar NEW se alguns avisos ainda não foram liberados pela história.
- O tour pausa durante combates.

## Licença

MIT
