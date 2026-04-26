# Procedures

> Procedimentos operacionais durables. Cada um tem trigger/non-trigger, contrato I/O, workflow curto, criterio negativo.
> Promovidos quando `operational` em `shadow/WORK-LANES.md` (legacy ate PR 3 do plano de cleanup) com >=3 entradas em `shadow/EVIDENCE-LOG.md`.

## Indice

| Nome | Status | Trigger | Source |
|---|---|---|---|
| [decision-protocol](decision-protocol.md) | experiment | mudanca nao-trivial em arquitetura, contrato, gate, hook ou orquestracao | adaptado de OLMO `content/aulas/shared/decision-protocol.md` |

## Convencao

- 1 procedure = 1 arquivo curto (~80L max).
- Frontmatter minimo: trigger, non-trigger, source, status, owner.
- Sem duplicacao com `AGENTS.md`. Procedure resolve um problema operacional especifico, nao recita politica.
