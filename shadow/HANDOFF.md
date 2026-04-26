# Handoff

Status: active
Updated: 2026-04-26 (PM, pos legacy mining + 5 hooks wired)
Scope: janela hidratada para retomar `OLMO_PROMETEUS` apos `/clear`.

## Quick Hydration (cole no inicio da nova sessao)

Sessao 2026-04-26 PM trabalhou em paralelo: (a) higiene tecnica + consolidacao adversarial do stack debate; (b) inventario read-only de archives legacy (devmentor, archived OLMO_PROMETEUS, OLMO live); (c) inicio da estrutura profissional (docs/adr + procedures); (d) wire de 5 hooks selecionados de OLMO (excessivos no original; cherry-pick aqui).

OLMO e intocavel: leitura autorizada, sem write. Aulas_core era estado virgem (muitos erros), tomar cuidado.

## DONE neste turno (2026-04-26 PM)

Commits (em ordem):

1. `50979f9` — chore: untrack derived graph artifact and normalize line endings post NTFS->ext4 migration. Renormalize 12 arquivos (CRLF->LF) + `lab/wiki-graph-lab/graph-data.js` -> `.gitignore` + `core.filemode false` local. **D04 aplicado**.
2. `a908770` — docs: consolidate 2026-04-26 triadic debate into single SOTA entry. 727L (PLAN+MATRIX rascunhos) -> ~25L em `shadow/SOTA-DECISIONS.md > Triadic stack debate consolidation (2026-04-26)`. Frame adversarial: ceremony bloat anti-pattern.
3. `70d8dbb` — docs: add structural cleanup roadmap to HANDOFF.md. Roadmap inicial 3-PR (este arquivo).
4. `6fcc233` — docs: add docs/adr and procedures professional structure skeleton. **PR 1 partial**: `docs/adr/{README,template,0001-canonical-linux-workspace}.md` + `procedures/{README,decision-protocol}.md`.
5. (commit em progresso) — feat: incorporate 5 selected hooks from OLMO + update settings.local.json + this HANDOFF.

Tools instalados (user-space, sem sudo):

- `uv` 0.11.7 (Astral Python pkg manager) -> `~/.local/bin/uv`
- `ruff` 0.15.12 -> `~/.local/bin/ruff`
- `biome` 2.4.13 -> `~/.npm-global/bin/biome`
- `pnpm` 10.33.2 -> `~/.npm-global/bin/pnpm`
- `rg` (ripgrep) 14.1.1 -> `~/.local/bin/rg` (resolve harness gap; era shell-function CLAUDE_CODE_EXECPATH wrapper invisivel)
- **bun pendente**: precisa `sudo apt install unzip`. Defer (marcado como experimento, sem projeto TS hoje).

Hooks SAFE incorporados em `scripts/` + wired em `.claude/settings.local.json` (local, gitignored):

- `guard-olmo-write-hook.sh` (existente) — PreToolUse Write|Edit|MultiEdit|NotebookEdit|Bash: boundary OLMO sibling.
- `guard-read-secrets.sh` (NOVO, adapted from OLMO `.claude/hooks/`) — PreToolUse Read|Grep|Glob: bloqueia .env/.pem/.key/credentials.json/id_rsa + Grep credential patterns + paths PHI (paciente_*, patient_*, phi_*, clinical_*).
- `guard-secrets.sh` (NOVO, adapted) — PreToolUse Bash: bloqueia git commit/add com staged blobs contendo OpenAI/Anthropic/AWS/GitHub/Notion/Google/Slack/Stripe/postgres keys.
- `trace-edits.sh` (NOVO) — PostToolUse Edit|Write|MultiEdit: emite `additionalContext` com diff resumido (transparencia user-pedida).
- `pre-compact-checkpoint.sh` (NOVO, adapted) — PreCompact: snapshot em `.claude/.last-checkpoint` (gitignored) com git log + status + recently modified.
- `session-start.sh` (NOVO, adapted) — SessionStart: hidrata sessao com HANDOFF top 60 li + git log -5 + status.

Hooks **NAO** incorporados (avaliados, descartados):

- `guard-bash-write.sh` — overlap com boundary guard atual. Reavaliar PR3.
- `lint-on-edit.sh` — especifico OLMO `content/aulas/<aula>/slides/*.html`. Esperar projeto TS/aula real.
- `loop-guard.sh` — tied a `/debug-team` flow. Complexidade > valor solo.
- 24+ outros hooks OLMO (chaos-inject, momentum-brake, ambient-pulse, apl-cache-refresh, etc): ceremony bloat para solo (32 hook registrations no OLMO).

Inventarios read-only feitos:

- **devmentor** (`/home/lucasmiachon/legacy/2026-04-26/devmentor/`): 11 incorporar / 8 nao incorporar / 4 avaliar. Highlights: 4 wiki notes (cli-vs-mcp, karpathy-pattern, anti-pollution, skills-vs-mcp), 4 skills (ingest/graduate/lint-wiki/session-log), 1 setup-second-brain.sh, 2 raw articles (Scalekit + Karpathy).
- **archived OLMO_PROMETEUS** (`/mnt/c/Dev/Projetos/_archive/OLMO_PROMETEUS-archived-20260426-142912/`): SEM perda significativa. 91 arquivos archive vs 96 canonical: 73 identicos / 14 divergentes (todos GREW no canonical, sem shrinkage) / 4 ausentes (todos `private-learning/` UI .gitignored ou workspace.json) / 9 novos no canonical.
- **OLMO live Windows** (`/mnt/c/Dev/Projetos/OLMO/`): apenas via `/mnt/c` ls + Read de `docs/ARCHITECTURE.md`. **9 subagents + 18 skills + 30 scripts/32 hook registrations + L1-L7 antifragile + APL**. Read mais profundo do Bash bloqueado pelo hook de sibling OLMO em alguns paths.

Inventario consolidado em chat — **NAO comitado** (defer ate ter tempo de organizar em `shadow/RECOVERED-2026-04-26/` ou `docs/recovered/`).

## PENDING para proxima sessao (priorizado)

### P0 — High value, low risk

1. **Verificar funcionamento dos 5 novos hooks**: SessionStart deve surface HANDOFF; PostToolUse trace-edits deve mostrar diff; guard-read-secrets/secrets devem bloquear smoke tests. Se algum quebrar, `git revert` do commit + restaurar `.claude/settings.local.json` simples.

2. **Inventarios bloqueados** (precisam workaround do hook OLMO sibling — opcoes: Bash com `!` prefix do user, OU regra Bash read em `.claude/settings.local.json`):
   - `/home/lucasmiachon/legacy/2026-04-26/dev/olmo-migration/OLMO/` (snapshot Linux)
   - `/mnt/c/Dev/Projetos/Aulas_core/` (CUIDADO: estado virgem, muitos erros — NAO importar bulk)
   - `/mnt/c/Dev/Projetos/aulas-magnas-gemini-20260305.zip` (precisa extrair em /tmp)
   - `/mnt/c/Dev/Projetos/OLMO_GENESIS/`, `/OLMO_COWORK/`, `/Projeto_olmo_main/` (snapshots paralelos)
   - `/mnt/c/Dev/Projetos/cowork-command-center-workspace/`, `/orquestrador-context/`, `/Conversores/` (aux)

3. **PR 1 — Compress raws** (continuar): consolidar 10 `shadow/SOTA-STACK-*-2026-04-26.md` (1746L) em 1 ADR `docs/adr/0006-triadic-stack-debate.md` (~50L). Consolidar 2 `shadow/LEGACY-*-2026-04-26.md` (109L). Adicionar mais ADRs (executor rule, sampling, privacy, Codex xhigh, exclusivity).

### P1 — Medium

4. **PR 2 — Privacy + governance consolidation**: mesclar `shadow/DATA-CLASSIFICATION.md` + `PHI-CHECKLIST.md` + `THREAT-MODEL.md` + `INCIDENT-LOG.md` em `docs/threat-model.md`. Quebrar `shadow/SOTA-DECISIONS.md` em ADRs numerados. Mover procedures (email-digest-4p, study-track-done) para `procedures/`.

5. **Incorporar material devmentor**: 4 wiki notes (cli-vs-mcp, karpathy-pattern, anti-pollution, skills-vs-mcp) -> `Prometeus/wiki/References/` ou `docs/wiki/`. Skills devmentor: avaliar caso a caso (user disse skip skills/agents/subagents do OLMO; devmentor diferente).

### P2 — Future

6. **PR 3 — AGENTS.md SOTA + retire scaffolds**: AGENTS.md ~80L (Toolchain First); mesclar FOUNDATION/PROJECT_CONTRACT/AGENT-USAGE/AGENT-MODULES/ORCHESTRATION-* em `docs/runbook.md`; retire `shadow/` folder.

7. **`shared-v2/` design system de OLMO**: defer ate primeiro projeto aula real no Prometeus.

8. **`bun` install**: precisa `sudo apt install unzip`. Defer.

9. **`git push origin main`**: 10+ commits ahead. NAO push autonomamente; user decide.

## Cross-references

- **Plano original**: `/home/lucasmiachon/.claude/plans/fuzzy-hatching-harbor.md` (saida read-only do plan mode 2026-04-26 PM)
- **Decisoes consolidadas**: `shadow/SOTA-DECISIONS.md > Triadic stack debate consolidation (2026-04-26)`
- **ADRs novos**: `docs/adr/0001-canonical-linux-workspace.md` + `docs/adr/template.md` + `docs/adr/README.md`
- **Procedures novos**: `procedures/decision-protocol.md` (adapted de OLMO `content/aulas/shared/`)
- **Evidencia**: `shadow/EVIDENCE-LOG.md` ultima entry 2026-04-26 sota-research-gate
- **Transicoes lane**: `shadow/INCORPORATION-LOG.md` ultimas 3 entries 2026-04-26
- **Matriz legacy original**: deletada em PR 1 (compress raws); conteudo essencial em `shadow/INCORPORATION-LOG.md` + git history pre-ADR-0006
- **OLMO ARCHITECTURE source**: `/mnt/c/Dev/Projetos/OLMO/docs/ARCHITECTURE.md` (read-only, autorizado)
- **devmentor source**: `/home/lucasmiachon/legacy/2026-04-26/devmentor/` (autorizado)
- **archived OLMO_PROMETEUS**: `/mnt/c/Dev/Projetos/_archive/OLMO_PROMETEUS-archived-20260426-142912/`

## Stop conditions (proxima sessao)

- Cada PR deve passar `./scripts/check.sh --strict` antes do commit.
- Se hook novo (trace, guard-secrets, guard-read-secrets, pre-compact, session-start) bloquear ou quebrar workflow, `git revert` + restaurar `.claude/settings.local.json` minimal (so guard-olmo-write).
- NAO tocar `/mnt/c/Dev/Projetos/OLMO/` (read-only authorized — copiar com melhoras para canonical).
- NAO bulk-import de Aulas_core (estado virgem, muitos erros conhecidos pelo user).
- `Prometeus/wiki/` continua dominio separado (vault Obsidian).
- `private-learning/` continua gitignored.
- Stop ao fim de cada PR; nao encadear PR 1+2+3 num so commit.

---

## Read First (legado, sera retirado no PR 3)

## Read First

1. Este repo e `OLMO_PROMETEUS`, nao `OLMO`: ver `../PROJECT_CONTRACT.md`.
2. A regra fundamental e nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`: ver `../AGENTS.md` e `FOUNDATION.md`.
3. O workspace canonico unico e `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4.
4. O objetivo atual e validar laboratorio paralelo de baixo risco para vault, digest, study flow, wiki operacional e gates: ver `../README.md` e `WORK-LANES.md`.
5. O proximo batch oficial vem de `../internal/evolution/backlog.json`; nao inventar fila paralela.
6. Riscos vivos vem de `../internal/evolution/risk-register.json`; nao esconder warning critico.
7. Claude global state em `~/.claude/projects/-home-lucasmiachon-devmentor` e legado, nao fonte de hidratacao deste repo.

## Current Objective

Validar se a fatia Prometeus realmente merece promocao futura:

- Branch ativo: `main` local alinhado com `origin/main`.
- `Prometeus/` precisa funcionar como vault e wiki operacional, nao deposito.
- `shadow/EMAIL-DIGEST-4P.md` e `shadow/STUDY-TRACK-DONE.md` precisam de uso real registrado em `EVIDENCE-LOG.md`.
- `scripts/check.sh` e `scripts/evolve.sh` sao o gate operacional local.
- Qualquer conversa sobre `OLMO` exige evidencia, rollback e aprovacao humana explicita.

## Migration Readiness

Ainda nao migrar para `OLMO` como padrao operacional.

O que ja esta pronto:

- repo canonico consolidado em `/home/lucasmiachon/projects/OLMO_PROMETEUS`;
- `main` publicado no GitHub e alinhado com `origin/main`;
- harness local passa via Bash;
- runtime antigo removido do caminho operacional versionado;
- decisao SOTA registrada para `xhigh` e workspace Linux/WSL ext4 canonico;
- contrato de executores consolidado: Codex ou Claude Code por rodada, nunca ambos no mesmo escopo; Gemini e pesquisa/contraponto sem write;
- proposta/comparacao SOTA da rodada consolidada em `../docs/adr/0006-triadic-stack-debate.md`;
- legado lido e consolidado em `INCORPORATION-LOG.md`; raws originais deletados em PR 1, recuperaveis via git history pre-ADR-0006;
- controles minimos de privacidade/PHI criados e exigidos pelo harness: `DATA-CLASSIFICATION.md`, `PHI-CHECKLIST.md`, `THREAT-MODEL.md`, `INCIDENT-LOG.md`.

O que falta antes de promocao:

- confirmar workflow remoto apos o push em `main`;
- aplicar `PHI-CHECKLIST.md` no primeiro fluxo real com saude ou dado pessoal;
- registrar pelo menos 3 usos reais de digest/study/wiki/harness em `EVIDENCE-LOG.md` antes de promover procedimento para `candidate` ou `operational`;
- escolher explicitamente quais artefatos sao migraveis, com trigger, risco, custo e rollback;
- manter rollback simples: revert de commit, sem sync automatico, hook ativo, MCP sensivel ou write externo.

## Top Gaps

| Rank | Gap | Source | Next |
| --- | --- | --- | --- |
| P0 | Objetivo ainda nao tem metricas de valor para medico solo dev | `internal/evolution/backlog.json` e `scripts/evolve.sh` | definir 3 a 5 outcomes mensais antes de promover fluxo |
| P0 | CI remoto precisa ser confirmado depois do push em `main` | `../internal/evolution/backlog.json` id `EV-B2`; `INCIDENT-LOG.md` | rodar `gh run list`/`gh run view` e documentar resultado |
| P1 | PHI/dado sensivel tem controle minimo, mas precisa uso real | `../internal/evolution/risk-register.json` id `R-PHI`; `DATA-CLASSIFICATION.md` | aplicar checklist no primeiro fluxo com saude/dado pessoal |
| P1 | Digest e study ainda nao provaram 3 usos reais | `EVIDENCE-LOG.md` e `WORK-LANES.md` | rodar em ciclos reais e registrar output |
| P1 | Foundation, wiki e antifragile gate ainda estao em `experiment` | `WORK-LANES.md` | escolher 1 fluxo para virar `candidate`, nao varios |
| P1 | Arquitetura ainda depende de TREE + contexto humano | `../internal/evolution/backlog.json` id `EV-B4` | criar nota curta de arquitetura so depois de `EV-B2` |


## Local Runtime Verified

Verificado em 2026-04-26 no workspace `/home/lucasmiachon/projects/OLMO_PROMETEUS`:

| Ferramenta | Estado | Observacao |
|---|---|---|
| Claude Code | `2.1.119` | `claude` aponta para `~/.npm-global/bin/claude` via symlink em `~/.local/bin` |
| Codex CLI | `0.125.0` | versao publicada atual no npm no momento da verificacao |
| Gemini CLI | `0.39.1` | instalado globalmente via npm |
| Zellij | `0.44.1` | instalado em `~/.local/bin/zellij`; `/usr/local/bin/zellij` antigo estava em uso |
| WSL | `2.6.3.0` | `wsl.exe --update` informou que ja era a versao mais recente |
| Ubuntu WSL | `24.04.4 LTS` | linha LTS atual; upgrade para 26.04 e decisao estrutural, nao update comum |

Pendencia: existem pacotes `apt` atualizaveis, mas exigem senha humana: rodar `sudo apt update && sudo apt upgrade` no terminal.

## Next Session

Sequencia obrigatoria:

1. Confirmar `git status --short --branch` em `/home/lucasmiachon/projects/OLMO_PROMETEUS`.
2. Rodar `./scripts/check.sh`.
3. Rodar `./scripts/evolve.sh next`.
4. Abrir `../docs/adr/0006-triadic-stack-debate.md` como decisao consolidada da stack; nao reabrir debate sem claim novo.
5. Ler `INCORPORATION-LOG.md` antes de tocar qualquer legado; itens em parking lot so reabrem com trigger/evidencia.
6. (slot disponivel — sequencia renumerada apos PR 1).
7. Manter Ubuntu 24.04 e workspace Linux/WSL ext4; qualquer Fedora, Ubuntu 26.04 ou mudanca de OS exige novo trigger, metrica, rollback e criterio negativo.
8. Atacar `EV-B2`: confirmar workflow remoto do `main` com `gh run list` e, se falhar, `gh run view --log-failed`.
9. Se o log remoto continuar bloqueado, documentar bloqueio e reproduzir o mais perto possivel com Bash local.
10. Nao aplicar branch protection ate haver workflow verde ou bloqueio documentado.
11. `EV-B3` ja tem controle minimo aplicado; antes de qualquer fluxo clinico/dado pessoal, usar `PHI-CHECKLIST.md`.
12. Nao mover mais caminhos legados sem leitura previa e matriz `incorporar/nao incorporar`.

## Cross References

- Contrato e boundary: `../PROJECT_CONTRACT.md`, `../AGENTS.md`, `FOUNDATION.md`
- Estado e promocao: `WORK-LANES.md`, `INCORPORATION-LOG.md`, `EVIDENCE-LOG.md`
- Evolucao: `../internal/evolution/backlog.json`, `../internal/evolution/review.json`, `../internal/evolution/risk-register.json`
- Orquestracao, antifragile e `CASE_edges`: `ORCHESTRATION-HARNESS-ANTIFRAGILE.md`
- SOTA compacto: `SOTA-DECISIONS.md`, `AGENT-MODULES.md`, `AGENT-USAGE.md`
- GitHub remoto: `GITHUB-REMOTE-WSL.md`
- SOTA stack debate triadico 2026-04-26: `../docs/adr/0006-triadic-stack-debate.md` (raws originais deletados; recuperaveis via git history pre-commit ADR 0006)
- Mapa da arvore: `../TREE.md`

## Stop Conditions

- Se o cwd nao for `/home/lucasmiachon/projects/OLMO_PROMETEUS`, parar antes de editar.
- Se a tarefa exigir write em `C:\Dev\Projetos\OLMO`, parar e pedir autorizacao explicita.
- Se a mudanca estrutural nao tiver trigger, aceite, risco e rollback, manter em `experiment`.
- Se a correcao do CI exigir permissao admin, registrar bloqueio em vez de contornar com automacao insegura.
