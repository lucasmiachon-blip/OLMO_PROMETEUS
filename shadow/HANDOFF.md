# Handoff

Status: active
Updated: 2026-04-26 (PM noite, pos Round 1 do plan `cuddly-beaming-wind` — incorporacao seletiva OLMO+OLMO_GENESIS)
Scope: janela hidratada para retomar `OLMO_PROMETEUS` apos `/clear` ou nova sessao.

> Este arquivo e a fonte unica de hidratacao. `session-start.sh` cola top 60 li no inicio de cada sessao. Mantenha denso, sem secoes paralelas.

---

## 1. O que este projeto e

`open OLMO_PROMETEUS` e um laboratorio paralelo solo, baixo risco, para validar fluxo (digest, study, wiki, gates de promocao) antes de promover qualquer artefato para `OLMO` (repo principal, intocavel sem autorizacao explicita).

Workspace canonico unico: **`/home/lucasmiachon/projects/OLMO_PROMETEUS`** em Linux/WSL ext4 (ADR `0001-canonical-linux-workspace`). Caminhos em `/mnt/c/...` ou drive Windows sao referencia historica, archive ou UI humana (Obsidian via UNC `\\wsl.localhost\Ubuntu\...`); nao sao fonte operacional.

Perfil do operador: medico solo dev. Padrao de ouro: auditavel, reversivel, humano-no-loop, sem PHI versionada, proporcional ao tamanho real do projeto. Codex e Claude Code sao executores autorizados (nunca juntos no mesmo escopo); Gemini e pesquisa/contraponto sem write.

---

## 2. Boundaries duras (NAO violar)

1. **Nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.** Read externo de sibling/legado (sibling principal, Aulas_core, snapshots paralelos, etc) exige autorizacao humana explicita citando caminho e motivo na conversa.
2. **Sibling principal e read-only autorizado caso-a-caso.** Nunca write; copiar com melhoras para canonical, nunca direto.
3. **NAO bulk-import de `Aulas_core`.** Estado virgem com muitos erros conhecidos pelo user.
4. **NAO criar runtime scaffolds** (`.claude/agents/`, `.claude/hooks/`, `.claude/commands/`, `agents/`, `subagents/`, `skills/`, `hooks/`, `playground/`) sem gate. `.claude/skills/` so com procedure operational; `.claude/settings.local.json` e state local (gitignored).
5. **NAO promover artefato sem 3 entradas reais em `EVIDENCE-LOG.md`** + rubrica + 14 dias estabilidade.
6. **NAO push autonomo.** Push em `origin/main` e shared-state action — exige confirmacao humana explicita por rodada.
7. **NAO commit com `--no-verify`, `--no-gpg-sign`, ou skip de hook.** Investigar e consertar root cause.

---

## 3. Estado atual (2026-04-26 PM tarde)

### Branch & remoto
- `main` local sincronizado com `origin/main` (push OK em `04dad2f`).
- `gh` configurado via SSH WSL nativo (ver `shadow/GITHUB-REMOTE-WSL.md`).
- GitHub Actions `Self Evolution` existe; `gh run view --log-failed` retorna HTTP 403 por falta de admin (bloqueio documentado, nao contornar).

### Harness
- `./scripts/check.sh --strict` passa com 0 warnings.
- `scripts/test-olmo-boundary-guard.sh` passa 21/21 casos.
- Stack gates wired: `ruff check lab/wiki-graph-lab/` + `biome check .` rodam em `check.sh` se manifestos presentes.
- 7 scripts em `scripts/` (todos `bash -n` OK): `check.sh`, `evolve.sh`, `install-stack.sh`, `doctor-github-remote.sh`, `guard-olmo-write-hook.sh`, `test-olmo-boundary-guard.sh`, + 5 hooks abaixo.

### Tools instaladas (13/13 — stack saiu do papel em 2026-04-26)
| Ferramenta | Versao | Path | Wired-in |
|---|---|---|---|
| Claude Code | 2.1.119 | `~/.local/bin/claude` | autoria/arquitetura |
| Codex CLI | 0.125.0 | `~/.npm-global/bin/codex` | edicao/auditoria (`xhigh`) |
| Gemini CLI | 0.39.1 | `~/.npm-global/bin/gemini` | pesquisa/contraponto (READ-ONLY) |
| `uv` (Astral Python) | 0.11.7 | `~/.local/bin/uv` | `lab/wiki-graph-lab/pyproject.toml` + `uv.lock` |
| `ruff` | 0.15.12 | `~/.local/bin/ruff` | `pyproject.toml [tool.ruff]`; `check.sh` gate |
| `biome` | 2.4.13 | `~/.npm-global/bin/biome` | `biome.json` raiz; `check.sh` gate |
| `pnpm` | 10.33.2 | `~/.npm-global/bin/pnpm` | aguarda projeto JS-heavy real |
| `node` | 20.20.2 | `/usr/bin/node` | runtime npm globals |
| `bun` | 1.3.13 | `~/.local/bin/bun` | instalado via direct binary + python unzip (bypass `sudo apt install unzip`); experimento por projeto |
| `rg` (ripgrep) | 14.1.1 | `~/.local/bin/rg` | `check.sh` (secret scan, OLMO refs) |
| `jq` | 1.7 | `/usr/bin/jq` | `check.sh` (JSON validation) |
| `gh` | 2.45.0 | `/usr/bin/gh` | `shadow/GITHUB-REMOTE-WSL.md` |
| `git` | 2.43 | `/usr/bin/git` | system |
| Zellij | 0.44.1 | `~/.local/bin/zellij` | multi-pane terminal opcional |
| WSL | 2.6.3.0 | host | runtime |
| Ubuntu WSL | 24.04.4 LTS | bloqueado em 24.04 (upgrade exige novo trigger/metrica/rollback) | runtime |

Diagnostico: `./scripts/install-stack.sh` (idempotente, sem sudo, reporta versao+path+install hint).

---

## 4. Hooks ativos (`.claude/settings.local.json`, gitignored)

| Hook | Tipo | Matcher | O que faz |
|---|---|---|---|
| `guard-olmo-write-hook.sh` | PreToolUse | `Write\|Edit\|MultiEdit\|NotebookEdit\|Bash` | Boundary: bloqueia write para sibling fora do canonical; ask em read externo. Scaneia campos path-only de `tool_input` (file_path/command/workdir/cwd/directory). |
| `guard-read-secrets.sh` | PreToolUse | `Read\|Grep\|Glob` | Bloqueia `.env`/`.pem`/`.key`/`credentials.json`/`id_rsa` + Grep credential patterns + paths PHI (`paciente_*`, `patient_*`, `phi_*`, `clinical_*`). |
| `guard-secrets.sh` | PreToolUse | `Bash` | Bloqueia `git commit/add` com staged blob contendo OpenAI/Anthropic/AWS/GitHub/Notion/Google/Slack/Stripe/postgres keys ou symlink. |
| `ask-bash-write.sh` | PreToolUse | `Bash` | Pede confirmacao humana (permissionDecision=ask) antes de comandos com write-intent (mkdir/rm/mv/cp/git add/commit/push/etc; `>` redirecao; sudo). Reads (ls/cat/grep/git status) sao allow direto. NUNCA bloqueia. |
| `trace-edits.sh` | PostToolUse | `Edit\|Write\|MultiEdit` | Imprime header + diff/stat em **stderr (visivel ao user em tempo real)** e `additionalContext` (visivel ao modelo). 60 li max; trunca com aviso. |
| `pre-compact-checkpoint.sh` | PreCompact | `*` | Snapshot em `.claude/.last-checkpoint` com `git log -5` + `git status` + recently modified + HANDOFF top 30. |
| `session-start.sh` | SessionStart | `*` | Cola HANDOFF top 60 + `git log -5` + `git status` no inicio de cada sessao. |

Todos smoke-tested 2026-04-26 (`shadow/EVIDENCE-LOG.md > hook-smoke-test`).

Hooks **NAO** incorporados (avaliados, descartados):
- `guard-bash-write` (overlap com boundary atual);
- `lint-on-edit` (especifico aulas);
- `loop-guard` (tied a fluxo `/debug-team`);
- 24+ outros (chaos-inject, momentum-brake, ambient-pulse, apl-cache-refresh, etc — ceremony bloat solo).

---

## 5. ADRs aceitos (`docs/adr/`)

| # | Titulo | Status | Data |
|---|---|---|---|
| 0001 | Canonical Linux workspace | accepted | 2026-04-26 |
| 0006 | Triadic SOTA stack debate | accepted | 2026-04-26 |

ADRs intermediarios (0002-0005) reservados para PR 2 (privacy + governance consolidation).

---

## 6. Procedures e lanes ativos

| Procedure | Lane | Casa | Notas |
|---|---|---|---|
| `email-digest-4p` | experiment | `shadow/EMAIL-DIGEST-4P.md` | 0 entries em EVIDENCE-LOG; rebaixado de `candidate` em 2026-04-24. Antes de PR 2: provar uso real ou simplificar/aposentar. |
| `study-track-done` | experiment | `shadow/STUDY-TRACK-DONE.md` | Idem. |
| `obsidian-crossref-check` | candidate | (harness) | Roda mas sem rubrica/citacao em `AGENTS.md > Do`. |
| `decision-protocol` | experiment | `procedures/decision-protocol.md` | Adapted; formato DR-NNN para mudancas nao-triviais. |
| `sota-research-gate` | operational | `AGENTS.md > SOTA Research Gate` | Aplicado em 6+ entries de EVIDENCE-LOG. |
| `boundary-guard` | operational | `scripts/guard-olmo-write-hook.sh` + `test-olmo-boundary-guard.sh` | Validado por suite de regressao 21/21. |
| `privacy-guard` | operational | 4 docs em `shadow/` (DATA-CLASSIFICATION/PHI-CHECKLIST/THREAT-MODEL/INCIDENT-LOG) | Exigido pelo harness; sem uso clinico real ainda. |

Wiki notes novas (4, status `experiment`, source devmentor): `Prometeus/wiki/Notes/{CLI vs MCP, Karpathy Wiki Pattern, Vault Anti-Pollution, Skills vs MCP}.md`. Promocao a `active` requer uso real; em 30d sem citacao -> HYGIENE delete.

---

## 7. DONE nesta sessao (2026-04-26 PM noite — plan `valiant-dreaming-waffle`)

Trigger: user "saiu do papel?" → stack declarada mas zero manifestos no repo.

Commits (em ordem):

- `fe8d26d` — ops: add ask-bash-write hook + cross-refs (sessao anterior).
- (este commit) — `feat(stack): wire uv+ruff+biome manifests, README workflow with mermaid, install bun via direct binary` — stack saiu do papel: 13/13 tools OK; 3 manifestos novos (`biome.json`, `lab/wiki-graph-lab/pyproject.toml`, `lab/wiki-graph-lab/uv.lock`); `scripts/install-stack.sh` idempotente; `scripts/check.sh` agora roda `ruff` + `biome` gates; README reescrito com stack table + 3 Mermaid diagrams (lanes, SOTA gate, executor selection); cross-refs em AGENTS/PROJECT_CONTRACT/TREE/FOUNDATION/HANDOFF passaram de condicional ("quando houver projeto real") para afirmativo (manifestos vivos).

Bun instalado via direct binary download + python unzip (bypass `sudo apt install unzip`); `~/.local/bin/bun 1.3.13`.

Sessao anterior (commit `fe8d26d`) deixou: 7 hooks ativos smoke-tested 5/5; push `origin/main`; HANDOFF reescrito como fonte unica de hidratacao.

---

## 8. PENDING para proxima sessao (priorizado)

### P0 — High value, low risk

1. **PR 2 — Privacy + governance consolidation** (~45min, risco medio): mesclar `shadow/{DATA-CLASSIFICATION,PHI-CHECKLIST,THREAT-MODEL,INCIDENT-LOG}.md` em `docs/threat-model.md`. Quebrar `shadow/SOTA-DECISIONS.md` (354L) em ADRs numerados (0002-0005: executor rule, sampling, privacy guard, Codex xhigh). Mover `email-digest-4p` + `study-track-done` para `procedures/`. Atualizar `scripts/check.sh` para novos paths.

2. **Promover ou aposentar `email-digest-4p` + `study-track-done`**: 0 entries em EVIDENCE-LOG ha 14+ dias. Ou rodar 3x ciclos reais e registrar, ou simplificar/aposentar antes do PR 2.

3. **Inventarios bloqueados** (precisam Bash com `!` prefix do user OU regra `Bash(read:...)` em `.claude/settings.local.json`):
   - **OLMO + OLMO_GENESIS auditados via Explore read-only em 2026-04-26** (plan `cuddly-beaming-wind`). Round 1 incorporou 4 artefatos: `shadow/BACKLOG.md`, `shadow/KBP.md`, `shadow/PLAN-ARCHIVE/`, `internal/evolution/failure-registry.{jsonl,README.md}`. **Aulas_core ignorado por instrucao explicita do user.**
   - `legacy/2026-04-26/dev/olmo-migration/` (snapshot Linux, paths sob `/home/lucasmiachon/`)
   - `aulas-magnas-gemini-20260305.zip` (extrair em `/tmp`; path em `/mnt/c/Dev/Projetos/`)
   - Snapshots paralelos remanescentes: `OLMO_COWORK`, `Projeto_olmo_main` (path em `/mnt/c/Dev/Projetos/`)
   - Aux: `cowork-command-center-workspace`, `orquestrador-context`, `Conversores` (path em `/mnt/c/Dev/Projetos/`)

4. **Round 2 do plan `cuddly-beaming-wind`** (~120min, risco medio): adicionar `.pre-commit-config.yaml` (subset seguro: trailing-ws, eof-fixer, large-file 500KB, detect-private-key, merge-conflict, check-yaml), `.github/workflows/ci.yml` (ruff+ruff-format+bash -n+jq validate; matrix 3.11/3.12), estender `scripts/check.sh` com `--integrity` mode (cross-refs FOUNDATION<->AGENTS<->TREE<->HANDOFF, hooks->scripts, ADRs->SOTA-DECISIONS, lanes->INCORPORATION-LOG; output `shadow/INTEGRITY-REPORT.md`), promover `obsidian-crossref-check` a `operational` apos 3 entries em EVIDENCE-LOG. Cross-check com PR 2 antes (ambos editam `scripts/check.sh`).

### P1 — Medium

5. **Promocao das 4 wiki notes incorporadas**: `experiment` -> `active` em 30d se citadas em decisao ou expandidas com pensamento autoral; senao HYGIENE delete.

6. **Material devmentor restante** (3 grupos): 4 skills (`ingest`/`graduate`/`lint-wiki`/`session-log`) bloqueadas pelo local skills gate ate procedure operational; 1 `setup-second-brain.sh` avaliar adequacao; 2 raw articles (Scalekit + Karpathy) ja referenciados nas wiki notes — arquivar?

7. **PR 3 — AGENTS.md SOTA + retire scaffolds** (~60min, risco alto): AGENTS.md ~80L (Toolchain First); mesclar `FOUNDATION/PROJECT_CONTRACT/AGENT-USAGE/AGENT-MODULES/ORCHESTRATION-*` em `docs/runbook.md`; retire `shadow/` folder. Defer: mudanca grande, exige decisao humana sobre que partes morrem ou viram ADR.

8. **CI remoto verde**: `EV-B2` em backlog. Confirmar `gh run list` apos push; se falhar, `gh run view --log-failed` (atualmente HTTP 403). Nao aplicar branch protection ate workflow verde ou bloqueio documentado.

### P2 — Future (defer ate trigger real)

9. **`shared-v2/` design system de OLMO**: defer ate primeiro projeto aula real no Prometeus.
10. **`gh run view --log-failed` HTTP 403**: defer ate ter admin do repo ou simulacao local.
11. **Branch protection no `main`**: defer ate workflow verde.
12. **Aplicar `PHI-CHECKLIST.md` em fluxo real**: trigger = primeiro caso clinico/dado pessoal a entrar no fluxo. Nao tocar antes.
13. **`pnpm` + `vite` wired**: trigger = primeiro projeto JS-heavy real (>=1 `.tsx` ou >=3 `.ts`). Por enquanto `biome` standalone basta.

---

## Migration Readiness

Ainda nao migrar nada para `OLMO` como padrao operacional.

Pronto: repo canonico em Linux/WSL ext4; `main` sincronizado com origin; harness Bash passa; runtime antigo removido; ADRs 0001/0006 aceitos; executor rule + sampling + Codex xhigh registrados em SOTA-DECISIONS; controles minimos de privacidade/PHI exigidos pelo harness.

Falta antes de promocao de qualquer artefato: `EV-B2` CI verde no remoto; >=3 entradas em `EVIDENCE-LOG.md` por procedure; aplicacao real de `PHI-CHECKLIST.md` em fluxo clinico; trigger/risco/custo/rollback explicito por artefato migravel; rollback simples preservado (revert de commit, sem sync automatico).

---

## 10. Cross-references (paths vivos)

**Contrato e boundary**
- `../AGENTS.md` (fonte unica de verdade)
- `../CLAUDE.md`, `../CODEX.md`, `../GEMINI.md` (adaptadores finos)
- `../PROJECT_CONTRACT.md`
- `FOUNDATION.md`

**Estado e promocao**
- `WORK-LANES.md` (lanes + promotion gate; +4 entries de Round 1)
- `INCORPORATION-LOG.md` (transicoes aplicadas — 6 entries de 2026-04-26)
- `EVIDENCE-LOG.md` (uso real de procedures)
- `HYGIENE.md` (regras de poda)
- `BACKLOG.md` (view markdown derivada de `internal/evolution/backlog.json`; tiers + effort + dormancy)
- `KBP.md` (Known Bad Patterns pointer-only)
- `PLAN-ARCHIVE/` (plans estruturais arquivados; pattern `YYYY-MM-DD.md`)

**Decisoes**
- `SOTA-DECISIONS.md` (indice operacional + entry triadic 2026-04-26)
- `../docs/adr/0001-canonical-linux-workspace.md`
- `../docs/adr/0006-triadic-stack-debate.md` (raws originais deletados em commit `478bc1d`; recuperaveis via git history pre-este-commit)

**Privacidade / PHI**
- `DATA-CLASSIFICATION.md`, `PHI-CHECKLIST.md`, `THREAT-MODEL.md`, `INCIDENT-LOG.md`

**Orquestracao / harness**
- `ORCHESTRATION-HARNESS-ANTIFRAGILE.md` (gate E2E + fault injection)
- `AGENT-MODULES.md`, `AGENT-USAGE.md`
- `scripts/check.sh`, `scripts/evolve.sh`

**Backlog estruturado**
- `../internal/evolution/backlog.json` (proximo batch oficial)
- `../internal/evolution/risk-register.json` (riscos vivos)
- `../internal/evolution/review.json` (cadencia)

**Planos das ultimas sessoes** (read-only)
- `/home/lucasmiachon/.claude/plans/harmonic-waddling-spring.md` (esta sessao: hooks fix + doc cleanup; antes: Fase A+B+C)
- `/home/lucasmiachon/.claude/plans/fuzzy-hatching-harbor.md` (sessao anterior)

**Sources legacy autorizados** (read-only, citar ao tocar)
- `legacy/2026-04-26/devmentor/` (autorizado 2026-04-26; 7 wiki notes lidas, 4 incorporadas)
- Sibling principal (autorizado caso-a-caso para leitura citada; nunca write)
- Archive 20260426 (sem perda significativa vs canonical)

**Mapa**
- `../TREE.md`

---

## 10. Stop conditions

- Cada PR deve passar `./scripts/check.sh --strict` antes do commit.
- Se hook bloquear ou quebrar workflow, `git revert` + restaurar `.claude/settings.local.json` minimal (so `guard-olmo-write-hook.sh`).
- Se cwd nao for `/home/lucasmiachon/projects/OLMO_PROMETEUS`, parar antes de editar.
- Se task exigir write em sibling, parar e pedir autorizacao explicita.
- Se mudanca estrutural nao tiver trigger, aceite, risco e rollback, manter em `experiment`.
- Se correcao do CI exigir permissao admin, registrar bloqueio em vez de contornar com automacao insegura.
- Stop ao fim de cada PR; nao encadear PR 1+2+3 em um so commit.
- Sem dado de paciente/PHI versionado em qualquer fluxo.
