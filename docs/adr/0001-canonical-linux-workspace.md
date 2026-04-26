# 0001 — Canonical Linux workspace with Windows UI fallback

- Status: accepted
- Date: 2026-04-26
- Coauthor: Lucas + Claude Opus 4.7 (1M context)
- Supersedes: (none — extracted from `shadow/SOTA-DECISIONS.md` consolidation 2026-04-26)

## Context

Working tree vivia em `C:\Dev\Projetos\OLMO_PROMETEUS` (NTFS). WSL via `/mnt/c/...` adicionava ate 5x slowdown via 9P bridge (Microsoft WSL docs + vxlabs benchmarks). Triadic SOTA debate (Claude Opus 4.7 + Gemini base + Gemini 3.1 Pro Deep Think) convergiu em mover canonical para Linux ext4 nativo. Realidade ja estava em `/home/lucasmiachon/projects/OLMO_PROMETEUS` (clone Linux).

## Decision

Canonical unico: `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4 com `bash`, `rg`, `jq`, `uv`. Caminhos `C:\Dev\Projetos\*` e `/mnt/c/*` ficam como referencia historica, archive ou UI humana (Obsidian via `\\wsl.localhost\Ubuntu\...`); nao sao fonte operacional.

## Consequences

- I/O ~5x mais rapido vs `/mnt/c` para CLI Linux (Microsoft WSL docs).
- Obsidian no Windows acessa vault via UNC `\\wsl.localhost\` — pode ter friction com `inotify` em vault grande (criterio negativo abaixo).
- Hooks/scripts com path Windows hard-coded quebram silenciosamente — Stage 2 ja revelou um caso (PreToolUse hook `.ps1` removido em commit `4bd302e`).
- Memoria do Claude Code muda de path key (`-home-lucasmiachon-projects-OLMO-PROMETEUS`).

## Rollback

`git revert` dos commits de drift correction (`f24644d`, `c274a81`, `ed1a4ee`) e mover canonical de volta para `_archive/OLMO_PROMETEUS-archived-20260426-142912/` no Windows. Custo: rebuild memoria Claude + re-validar hooks.

## Negative criterion

Se Obsidian gerar >50 warnings/24h de "file moved/missing" via UNC OU `inotify` limit hit OU workflow remoto falhar por path sem correcao simples, voltar canonical para `/mnt/c`.

## Sources

- Microsoft WSL docs: https://learn.microsoft.com/en-us/windows/wsl/filesystems
- vxlabs WSL2 IO benchmarks: https://vxlabs.com/2019/12/06/wsl2-io-measurements/
- WSL filesystem performance issue: https://github.com/microsoft/WSL/issues/4197
- `shadow/SOTA-DECISIONS.md > Canonical Linux workspace with Windows UI fallback (2026-04-26)`
- `shadow/SOTA-DECISIONS.md > Triadic stack debate consolidation (2026-04-26)`
