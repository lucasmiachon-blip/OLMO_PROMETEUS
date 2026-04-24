# Evidence Log

Objetivo: transformar frases como "3 usos reais" em dado auditavel.

Toda vez que um procedimento em `shadow/` rodar em uso real, registrar uma linha. Vale sintese, nao transcricao. A entrada deve caber em 30 segundos de escrita.

## Regra

- uma linha por uso real;
- `Input` e `Output` referenciam artefato persistente (thread id, arquivo, commit, nota wiki), nao descricao livre;
- `Observacao` registra o que surpreendeu ou quebrou;
- `Proximo` e uma acao concreta, nao intencao.

## Schema

| Data | Procedure | Input | Output | Observacao | Proximo |
| --- | --- | --- | --- | --- | --- |

## Entradas

| Data | Procedure | Input | Output | Observacao | Proximo |
| --- | --- | --- | --- | --- | --- |

## Gatilhos automaticos

- harness warn se este arquivo nao muda em >21 dias e ha procedure em `candidate` ou `candidate procedure`;
- higiene: se uma procedure acumula >=3 entradas + rubrica passando + >=14 dias sem edicao do procedure, considerar transicao para `operational`.

## Criterio negativo

Em 4 semanas, se este arquivo tiver <3 entradas por procedure ativo, considerar que o procedimento nao esta em uso real. Acao: reclassificar o procedimento para `experiment` e simplificar/deletar rubrica associada.

Coautoria: Lucas + Claude Opus 4.7 (1M)

