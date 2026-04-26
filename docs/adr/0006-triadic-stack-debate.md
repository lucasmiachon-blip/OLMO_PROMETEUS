# 0006 — Triadic SOTA stack debate (2026-04-26)

- Status: accepted
- Date: 2026-04-26
- Coauthor: Lucas + Claude Opus 4.7 (1M context)
- Supersedes: (none — extracts from `shadow/SOTA-DECISIONS.md > Triadic stack debate consolidation`)

## Context

Pos-migracao Windows->Linux ext4, foi necessario validar a stack ferramental do laboratorio com pesquisa SOTA externa. Foi rodado um exercicio triadico: prompt comum distribuido para Claude Opus 4.7, Gemini base e Gemini 3.1 Pro Deep Think. Cada um produziu diagnostico independente; um terceiro passe (sintese final pelo Gemini) consolidou. Os 10 raws e 2 matrizes legacy somaram 1845L em `shadow/`.

## Decision

A sintese essencial entra no historico operacional como entry curta em `shadow/SOTA-DECISIONS.md > Triadic stack debate consolidation (2026-04-26)` e como este ADR. Os 12 raws originais sao deletados; ficam preservados em git history (commit `9e32ebe` track inicial; `a908770` consolidacao em SOTA-DECISIONS; este commit deleta) — git e a fonte de evidencia, nao `shadow/`.

Convergencia da sintese (sem dissensao significativa entre os 3):

- **D01** Canonical workspace: `/home/lucasmiachon/projects/OLMO_PROMETEUS` (Linux ext4 nativo); `/mnt/c` so como referencia/UI. Ja registrado em `0001-canonical-linux-workspace.md`.
- **D04** Renormalize line endings (CRLF->LF) + `core.filemode false` local: aplicado em commit `50979f9` antes de qualquer edit semantico.
- **D09** Gemini 3.1 Pro Preview: 1M input / 64k output (fonte: `ai.google.dev/gemini-api/docs/models/gemini-3.1-pro-preview`, atualizado 2026-04-23). Substitui referencias historicas a 2M.
- **C01-C13** Stack confirmado (status quo, nao gera nova decisao): bash + Ubuntu 24.04 LTS; `uv`+`ruff` quando houver Python; `pnpm`+`biome` quando houver TS; `bun` apenas experimento; sem runtime agentico, sem MCP proprio, sem hooks alem do guard.

Rejeitados/deferidos:

- **D02** Skills locais agora: rejeitado. Mantem bloqueio existente via `shadow/AGENT-USAGE.md > Local skills contract`.
- **D06** GPT-5.5 como 4o adversario: rejeitado. Tres ja excedem ROI para lab solo.
- **D05/D07/D08/D10**: deferidos para sessao dedicada com escopo claro.

## Consequences

- `shadow/` reduzido em ~1845L; sinal por linha sobe.
- Argumentacao detalhada de cada raw fica acessivel via `git show <commit>:<path>` se necessario.
- Reposicionamento futuro do tema exige novo ADR ou decisao curta em `shadow/SOTA-DECISIONS.md`, nao restaurar raws.

## Rollback

`git revert <commit-deste-ADR>` restaura os 12 raws + remove este ADR. Custo: nenhum dado perdido (git preserva tudo).

## Negative criterion

Se em 60 dias um topico essencial dos raws deletados for citado e nao houver registro suficiente neste ADR + git history + SOTA-DECISIONS entry, reintroduzir aquele topico especifico como nota curta separada — uma por topico, sem PLAN longo retroativo.

## Sources

- Fonte primaria: Google Gemini docs `ai.google.dev/gemini-api/docs/models/gemini-3.1-pro-preview` (capacidade 1M/64k).
- Fonte primaria: Microsoft WSL filesystem perf docs (slowdown `/mnt/c` vs ext4) — `learn.microsoft.com/en-us/windows/wsl/filesystems`.
- Fonte primaria: git docs / GitHub / Edward Thomson sobre renormalize line endings.
- Evidencia interna: `shadow/SOTA-DECISIONS.md > Triadic stack debate consolidation (2026-04-26)`.
- Evidencia interna: commit `9e32ebe` (track inicial dos raws); commit `a908770` (consolidacao da entry); commit `50979f9` (D04 aplicado).
- Raws deletados (recuperaveis via `git show <commit>:<path>` em commits anteriores a este ADR): `shadow/SOTA-STACK-{2026-04-26,ARMS-PROMPT,CLAUDE-RESPONSE,CLI-PROMPTS-2026-04-27,CODEX-PROPOSAL,COMPARISON,CONSOLIDATED-DIAGNOSIS,GEMINI-3.1-PRO-DIAGNOSIS,GEMINI-PROMPT,GEMINI-RESPONSE}-2026-04-26.md`; `shadow/LEGACY-{INCORPORATION,ROOTS}-2026-04-26.md`.
