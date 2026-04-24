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
| 2026-04-24 | sota-research-gate | HEAD pre-auditoria (98c6b64) | commits 1ea1dea, 0e6177d, b3bbdb4 + 4 linhas em `shadow/INCORPORATION-LOG.md` | EVIDENCE-LOG vazio validou o gate negativo: 4 labels em candidate/operational estavam aspiracionais. Auditor encontrou >=3 criticos e >=3 altos sem inflar escopo. | Rodar email-digest-4p e study-track-done em uso real >=3x ate 2026-05-22; se <3 entradas por procedure, rebaixar/simplificar rubrica |

## Gatilhos automaticos

- harness warn se este arquivo nao muda em >21 dias e ha procedure em `candidate` ou `candidate procedure`;
- higiene: se uma procedure acumula >=3 entradas + rubrica passando + >=14 dias sem edicao do procedure, considerar transicao para `operational`.

## Criterio negativo

Em 4 semanas, se este arquivo tiver <3 entradas por procedure ativo, considerar que o procedimento nao esta em uso real. Acao: reclassificar o procedimento para `experiment` e simplificar/deletar rubrica associada.

Coautoria: Lucas + Claude Opus 4.7 (1M)

