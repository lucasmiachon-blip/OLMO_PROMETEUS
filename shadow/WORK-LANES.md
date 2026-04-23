# Work Lanes

## Regra de ouro

Tudo com incerteza entra como experimento.
So o que provar utilidade local, repetibilidade e baixo risco pode virar candidato a migracao.

## Lanes

| Lane | Casa | Quando entra | Quando sai |
| --- | --- | --- | --- |
| `private` | `private-learning/` local ignorado | material pessoal, cockpit, digests, notas | fica local |
| `experiment` | `shadow/` ou `Prometeus/wiki/Notes` | pergunta aberta, prototipo conceitual, teste de fluxo | descartado ou promovido |
| `candidate` | `shadow/` | padrao que parece reutilizavel e ja gerou artefato | aguarda validacao humana |

## Mapa inicial das prioridades

| Item | Lane atual | Casa | Pode migrar | Trigger minimo | Risco principal |
| --- | --- | --- | --- | --- | --- |
| Digest de email em 4 paragrafos | `candidate` | `shadow/` + wiki | sim | funcionar por 3 ciclos uteis seguidos | virar ritual sem acao |
| Study track com `done` | `candidate` | `shadow/` + wiki | sim | reduzir retrabalho e dar visibilidade de progresso | marcar `done` cedo demais |
| Dashboard local simples | `private` | `private-learning/` local ignorado | nao, por enquanto | n/a | misturar camada pessoal com runtime |
| Novos fluxos multimodelo | `experiment` | `shadow/` ou wiki | talvez | declarar objetivo, trigger, artefato, custo e risco | contaminar o repo principal |
| Foundation + harness local | `experiment` | `shadow/` + `scripts/` | talvez | passar em 3 sessoes reais e reduzir regressao | virar burocracia sem ganho |
| Obsidian project wiki | `experiment` | `Prometeus/wiki/` | talvez | ser usado em 3 ciclos sem virar deposito | acumular notas sem decisao |

## Template de candidato a migracao

Antes de pensar em migrar algo para `OLMO`, responda:

- `objetivo`: o que resolve melhor do que o estado atual;
- `trigger`: quando realmente entra em uso;
- `artefato`: qual arquivo, fluxo ou output produz;
- `custo`: limite operacional e de manutencao;
- `risco`: o que pode contaminar ou quebrar;
- `rollback`: como voltar atras sem dano.

