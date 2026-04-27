# KBP — Known Bad Patterns

> Catalogo pointer-only de antipatterns que ja morderam neste lab. Cada KBP aponta para a regra/contrato canonico, nao duplica prosa.

Status: experiment. Promove a candidate apos uso real >=3x (PR cita KBP-N para justificar veto).

## Regra de catalogo

- 1 linha por pattern; formato: `KBP-NN | titulo curto | -> link`.
- Sem prosa inline. O link aponta para o doc canonico (`AGENTS.md`, `CLAUDE.md`, `shadow/SOTA-DECISIONS.md`, `docs/adr/`, ou outro KBP).
- Adicionar pattern apenas apos 1+ ocorrencia real no lab (sem aspiracional).
- Cap: 30 entries; >30 obriga consolidacao em PR.

## Catalogo

| ID | Titulo | Pointer |
|---|---|---|
| KBP-01 | Workspace stale — typo `OLMO_COWOR` ou cwd em sibling legado | `CLAUDE.md > Things that will bite you`; `AGENTS.md > Fundamental Boundary` |
| KBP-02 | Write fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS` | `AGENTS.md > Fundamental Boundary`; `scripts/guard-olmo-write-hook.sh` |
| KBP-03 | Bulk-import de `Aulas_core` (estado virgem com erros conhecidos) | `shadow/HANDOFF.md > Boundaries duras #3` |
| KBP-04 | Runtime scaffold sem gate (`.claude/agents/`, `agents/`, `subagents/`, `hooks/`, `playground/`) | `TREE.md > Diretorios Proibidos`; `AGENTS.md > Do Not` |
| KBP-05 | Commit com `--no-verify` / `--no-gpg-sign` / skip de hook | `shadow/HANDOFF.md > Boundaries duras #7`; `AGENTS.md > Do Not` |
| KBP-06 | Push autonomo em `origin/main` sem confirmacao humana por rodada | `shadow/HANDOFF.md > Boundaries duras #6` |
| KBP-07 | Promover artefato sem 3 entradas em `shadow/EVIDENCE-LOG.md` | `shadow/WORK-LANES.md > Transicao candidate -> operational` |
| KBP-08 | Decisao curta virou relatorio longo (ceremony bloat) | `AGENTS.md > Operating Principles`; `shadow/INCORPORATION-LOG.md` 2026-04-26 PR 1 |
| KBP-09 | Hook bloqueia Write canonical por content do arquivo (scan full payload em vez de campos path-only) | `scripts/guard-olmo-write-hook.sh`; INCORPORATION-LOG 2026-04-26 |
| KBP-10 | Stack declarada sem manifest (drift "saiu do papel?") — referencia condicional vira aspiracional | `shadow/INCORPORATION-LOG.md` 2026-04-26 stack manifests; `scripts/install-stack.sh` |
| KBP-11 | Antifragile narrativo sem detector/regra/teste | `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md > Antifragile Lite`; `VALUES.md > V5` |

Coautoria: Lucas + Claude Opus 4.7 (1M)
