# Legacy Roots 2026-04-26

Status: active inventory

Purpose: registrar raizes antigas antes de arquivar fora do workspace canonico.

## Canonical

- Active root: `/home/lucasmiachon/projects/OLMO_PROMETEUS`
- Rule: only this repo is operational for Prometeus.

## To Archive

| Path | Observed state | Decision |
| --- | --- | --- |
| `/home/lucasmiachon/devmentor` | Git repo on `main`; untracked `populate-vault.sh`; contains vault/scripts and `.claude/` local state | Move whole directory to legacy; do not merge runtime. |
| `/home/lucasmiachon/dev` | Contains `olmo-migration/OLMO` repo on branch `codex/prometeus-incorporation-plan`; no short-status changes observed | Move whole directory to legacy; do not merge hooks/MCP/package runtime. |
| `/mnt/c/Dev/Projetos/OLMO_PROMETEUS` | Not found/mounted in this WSL session | If found later, treat as legacy/archive, not operational source. |

## Keep Global

| Path | Reason |
| --- | --- |
| `/home/lucasmiachon/.codex` | Global Codex state/cache/skills. |
| `/home/lucasmiachon/.claude` | Global Claude state/cache/projects. |
| `/home/lucasmiachon/.gemini` | Global Gemini state/history/tmp. |

## Incorporation Rule

Legacy roots are not sources of truth. If something is needed later, copy only a small, non-sensitive, reviewed artifact into the correct house in this repo.

Never bulk-copy hooks, MCP config, `.env`, secrets, caches, package runtime, or agent scaffolds from legacy.

Operational rule: always read before moving. For each legacy item, decide `incorporar` or `nao incorporar` with justification, destination, risk, and rollback. No sycophancy: useful artifacts enter; confusing, sensitive, duplicated, or overbuilt artifacts stay legacy.

Current incorporation matrix: `shadow/LEGACY-INCORPORATION-2026-04-26.md`.

Coautoria: Lucas + GPT-5.x-Codex (xhigh)
