# Architecture Decision Records

> Cada decisao arquitetural significativa vira 1 ADR curto e numerado.
> Formato: MADR (Markdown ADR) simplificado.
> Status irrevogavel quando `accepted`: nao reabrir; criar novo ADR que `supersedes` o anterior.

## Padrao

- Naming: `NNNN-kebab-case-title.md` (NNNN sequencial 4-digitos).
- Status: `proposed` → `accepted` (default) → `superseded by NNNN` (se substituido).
- Tamanho alvo: <=80L. Se passar disso, falta foco.
- Decisao curta vence relatorio longo. Detalhes vao em links.

## Indice

| # | Titulo | Status | Data |
|---|---|---|---|
| 0001 | [Canonical Linux workspace](0001-canonical-linux-workspace.md) | accepted | 2026-04-26 |
| 0002 | [Exclusive executor rule](0002-exclusive-executor-rule.md) | accepted | 2026-04-26 |
| 0003 | [Privacy guard minimum](0003-privacy-guard-minimum.md) | accepted | 2026-04-26 |
| 0004 | [Procedure before agent runtime](0004-procedure-before-agent-runtime.md) | accepted | 2026-04-25 |
| 0005 | [Producer-consumer gates](0005-producer-consumer-gates.md) | accepted | 2026-04-27 |
| 0006 | [Triadic SOTA stack debate](0006-triadic-stack-debate.md) | accepted | 2026-04-26 |
| 0007 | [Multimodel SOTA efficacy](0007-multimodel-sota-efficacy.md) | accepted | 2026-04-27 |

## Template

Ver `template.md`. Copiar como ponto de partida.

## Quando criar ADR vs nota curta

**ADR sim** se:

- mudanca de boundary, executor rule, sampling, harness, hook, MCP, memoria;
- decisao com rollback nao-trivial;
- escolha entre alternativas com trade-offs declaraveis;
- decisao que outro agente/sessao precisa ler antes de acao similar.

**ADR nao** (use commit msg, runbook, ou inline) se:

- bug fix mecanico;
- typo, doc edit cosmetico;
- versao de dependencia;
- experimento que nao mexe contrato.
