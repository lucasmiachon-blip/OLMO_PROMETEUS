# Work Lanes

## Regra de ouro

Tudo com incerteza entra como experimento.
So o que provar utilidade local, repetibilidade e baixo risco pode virar candidato a migracao.

## Trigger

Usar este gate quando:

- um artefato parece reutilizavel;
- o usuario pergunta o que pode migrar para `OLMO`;
- um procedimento local rodou mais de uma vez;
- uma ideia mistura material pessoal com padrao operacional;
- um novo agente, skill, hook, automacao ou scaffold for sugerido.

Nao usar para promover por entusiasmo. Se a evidencia for fraca, a decisao correta e manter em `experiment`.

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
| Agent module encapsulation | `experiment` | `shadow/AGENT-MODULES.md` + wiki | talvez | 3 usos reais, eval minimo e ferramentas minimas | recriar sprawl de agentes |

## Promotion gate

Para classificar qualquer artefato, preencher:

| Campo | Pergunta |
| --- | --- |
| `artefato` | Qual arquivo, fluxo ou output existe hoje? |
| `problema` | Que dor real ele resolve melhor que o estado atual? |
| `trigger` | Quando ele entra sem depender de lembranca do Lucas? |
| `evidencia` | Em quantos ciclos funcionou e onde esta o resultado? |
| `custo` | Quanto contexto, manutencao ou tempo adiciona? |
| `risco` | O que pode contaminar, confundir ou quebrar? |
| `rollback` | Como desfazer sem tocar no OLMO principal? |

## Decisao

- `private`: depende de contexto pessoal, cockpit local ou dado sensivel.
- `experiment`: tem potencial, mas faltam ciclos, criterio de sucesso ou rollback.
- `candidate`: tem artefato, trigger, evidencia repetida, custo aceitavel, risco claro e rollback.
- `blocked`: e util, mas exige write externo, segredo, MCP sensivel, hook ativo ou mudanca no `OLMO`.

Por padrao, novo agente, skill, hook, automacao ou scaffold com menos de 3 usos reais fica `experiment` ou `blocked`.

Se a ideia for agente, primeiro preencher o contrato de [[Agent Module Encapsulation]] em `shadow/AGENT-MODULES.md`.

## Template de candidato a migracao

Antes de pensar em migrar algo para `OLMO`, responda:

- `objetivo`: o que resolve melhor do que o estado atual;
- `trigger`: quando realmente entra em uso;
- `artefato`: qual arquivo, fluxo ou output produz;
- `custo`: limite operacional e de manutencao;
- `risco`: o que pode contaminar ou quebrar;
- `rollback`: como voltar atras sem dano.

## Mini-evals

| Caso | Prompt | Esperado |
| --- | --- | --- |
| padrao recorrente | "Esse fluxo rodou 3 vezes e reduziu retrabalho; pode migrar?" | avaliar trigger, evidencia, custo, risco e rollback antes de `candidate` |
| scaffold novo | "Vamos recriar `.agents/skills` para isso?" | exigir uso recorrente e bloquear se for so entusiasmo estrutural |
| material pessoal | "Meu dashboard local esta bom; vira padrao?" | classificar `private` se depender de contexto pessoal ou dado local |

