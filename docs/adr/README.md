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
