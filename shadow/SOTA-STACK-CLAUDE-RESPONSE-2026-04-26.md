# SOTA Stack Claude Response 2026-04-26

Generated at: 2026-04-26T18:20:23Z (local 2026-04-26 15:20:23 -03)
Model: claude-opus-4-7[1m]
Surface: Claude Code CLI (Anthropic)
Reasoning effort: max (extended thinking enabled this session)
Source prompt: `shadow/SOTA-STACK-ARMS-PROMPT-2026-04-26.md`

---

## 1. Identidade da avaliacao

```yaml
avaliador: "Claude"
superficie: "Claude Code (CLI, sessao Anthropic)"
modelo: "claude-opus-4-7[1m]"
nivel_raciocinio: "max (effort=max nesta sessao; thinking estendido habilitado)"
versao_cli: "Claude Code 2.1.119 (verificada localmente em shadow/HANDOFF.md:67; runtime em si nao expoe a versao)"
data_referencia: "2026-04-26"
browsing_pesquisa: "sim"
fontes_externas_usadas: "sim"
limitacoes: "Knowledge cutoff jan/2026 mitigado por WebSearch hoje; nao executei scripts/check.sh nem invoquei Codex/Gemini CLI; nao tenho acesso a billing real, latencia medida ou outputs de Obsidian indexer; juizo sobre Codex CLI sandbox e baseado no README do repo openai/codex citado em SOTA-STACK-2026-04-26.md, nao em teste atual."
```

Limitacao mais relevante em uma frase: nao consigo medir o I/O delta entre `/mnt/c` e ext4 nativo dentro desta sessao, entao toda recomendacao de migracao de filesystem aqui e contingente a experimento empirico, nao a numero observado por mim.

---

## 2. Tese principal

Se eu fosse responsavel tecnico do laboratorio Prometeus em 2026-04-26, **nao mexeria no stack agentico nem no toolchain por reflexo de SOTA**. O risco real desse repo nao e estar atras do estado da arte; e inflar runtime agentico antes de ter tres usos reais documentados em `EVIDENCE-LOG.md`.

A tese executiva tem cinco pontos:

1. **Manter Codex CLI como orquestrador-integrador, Claude Code (Opus 4.7) como juiz/arquiteto, Gemini como adversario de pesquisa longa.** A triade ja esta correta em `AGENTS.md` e `SOTA-DECISIONS.md > Time minimo`. Nao ha evidencia para subir multi-agent runtime.
2. **Bloquear adocao de Ubuntu 26.04 LTS por >=8 semanas** (ate 26.04.1 ou ate haver postmortem de zero-day em LTS recem-lancado). Foi liberado ha 3 dias.
3. **Reconciliar a divergencia entre AGENTS.md (canonico Windows `C:\Dev\Projetos\OLMO_PROMETEUS`) e o estado real do repo (`/home/lucasmiachon/projects/OLMO_PROMETEUS`, ja em ext4).** Esta e a unica decisao estrutural urgente: docs e realidade nao batem.
4. **Promover `uv`+`ruff` (Python) e `pnpm`+`vite`+`biome` (TS) como toolchain default *quando houver projeto que use*, nao como instalacao global especulativa.** Bun fica em experimento por projeto.
5. **Recusar a recomendacao Gemini de criar Agent Skills locais agora.** Conflita com o gate de `shadow/AGENT-USAGE.md > Local skills contract` (procedure operational + 30 dias + rubric >=0.8). Nao ha skill que satisfaca isso hoje.

Tudo o mais e iteracao sobre uma fundacao que ja esta certa.

---

## 3. Fatos verificados

### Modelos e CLIs (verificados em fontes oficiais)

| Item | Fato | Fonte |
|---|---|---|
| Claude Opus 4.7 | Modelo mais capaz da Anthropic, alias `claude-opus-4-7`, variante `[1m]` para contexto 1M | Local: `shadow/SOTA-STACK-2026-04-26.md` linhas 73-86; runtime atual: system prompt declara `claude-opus-4-7[1m]` |
| Claude Code 2.1 | Suporte a hot-reload de skills, structured status signals em subagents, parallel reconfig de MCP | Web: GitHub releases anthropics/claude-code; medium.com/@richardhightower (fev 2026) |
| Gemini 3.1 Pro Preview | Existe oficialmente, contexto 1.048.576 tokens (1M), 64k output, novo parametro `thinking_level` (incluindo MEDIUM) | Web: `ai.google.dev/gemini-api/docs/models/gemini-3.1-pro-preview`; `deepmind.google/models/model-cards/gemini-3-1-pro/` |
| GPT-5.5 ("Spud") | Lancado 2026-04-23 pela OpenAI; API disponivel desde 2026-04-24; contexto 1M; pricing $5/$30 input/output por 1M tokens (Pro: $30/$180) | Web: `openai.com/index/introducing-gpt-5-5/`; CNBC 2026-04-23 |
| Codex CLI | Versao local 0.125.0 (verificada em `shadow/HANDOFF.md`); modos `Suggest`/`Auto Edit`/`Full Auto`; sandbox `read-only`/`workspace-write`/`danger-full-access` | Local: `shadow/SOTA-STACK-2026-04-26.md` linhas 19-37; openai/codex repo |
| Gemini CLI | Versao local 0.39.1; tier free 60 req/min, 1.000 req/dia; Apache 2.0; suporta MCP, Google Search grounding, file ops, shell | Local: `shadow/SOTA-STACK-2026-04-26.md` linhas 41-66 |

### Sistema operacional

| Item | Fato | Fonte |
|---|---|---|
| Ubuntu 26.04 LTS "Resolute Raccoon" | Lancado 2026-04-23; kernel Linux 7.0; GNOME 50 Wayland-only; TPM full-disk encryption; Rust core utilities; suporte ate abril/2031 (10 anos com Pro/ESM) | Web: `documentation.ubuntu.com/release-notes/26.04/`; CNX-Software 2026-04-24 |
| Ubuntu 24.04.4 LTS | Linha LTS atual em uso no WSL local; dentro do ciclo padrao | Local: `shadow/HANDOFF.md` linha 70 |
| WSL2 vs `/mnt/c` | Microsoft documenta penalidade de I/O em cross-filesystem (9p protocol + tradicao NTFS); recomendacao oficial: arquivos no mesmo OS das ferramentas usadas | Local: `shadow/SOTA-STACK-2026-04-26.md` linhas 104-122 (links Microsoft Learn) |

### Toolchain

| Item | Fato | Fonte |
|---|---|---|
| `uv` (Astral) | Substitui pip/poetry/pyenv/virtualenv com lockfile, gerencia versoes Python | Local: `shadow/SOTA-STACK-2026-04-26.md` linhas 147-167 (docs.astral.sh/uv) |
| `ruff` | Linter+formatter Python em Rust, 10-100x mais rapido que ferramentas tradicionais | Local: idem (docs.astral.sh/ruff) |
| `bun` | Runtime+package manager+test runner+bundler all-in-one para JS/TS | Local: idem (bun.com/docs/runtime) |
| `pnpm` | Package manager focado em economia de disco/monorepos | Local: idem (pnpm.io) |
| `biome` | Formatter/linter para JS/TS/JSON/HTML/CSS/GraphQL | Local: idem (biomejs.dev) |

### Estado do repo

| Fato | Evidencia local |
|---|---|
| O repo ativo na sessao esta em `/home/lucasmiachon/projects/OLMO_PROMETEUS` (ext4 nativo Linux) | Variavel de ambiente do harness; CLAUDE.md (sessao 2026-04-26) |
| Os docs (`AGENTS.md`, `README.md`, `shadow/HANDOFF.md`, `shadow/FOUNDATION.md`, `shadow/SOTA-STACK-2026-04-26.md`) afirmam canonico `C:\Dev\Projetos\OLMO_PROMETEUS` acessado via `/mnt/c` | `AGENTS.md` linha 12; `shadow/HANDOFF.md` linha 11; `shadow/FOUNDATION.md` linha 35 |
| Nao ha registro em `INCORPORATION-LOG.md`/`SOTA-DECISIONS.md` de decisao formal de mover canonico para `/home` | Verificado por leitura de `shadow/SOTA-DECISIONS.md > Applied when` (linhas 168-183) |

**Esta divergencia e o fato mais importante deste documento.** Ou (a) o canonico mudou e a decisao precisa ser registrada via SOTA gate, ou (b) o canonico ainda e Windows e a sessao atual esta em workspace nao-canonico, o que viola a regra do proprio CLAUDE.md ("Se a sessao apontar para... cwd diferente, corrija para `C:\Dev\Projetos\OLMO_PROMETEUS` antes de editar").

---

## 4. Claims incertos ou incorretos

### Incorretos / nao verificados em fonte oficial

1. **"Janela de 2M tokens no Gemini 3.1 Pro"** - INCORRETO. Doc oficial (`ai.google.dev/gemini-api/docs/models/gemini-3.1-pro-preview`) confirma 1.048.576 input tokens (1M), 64k output. A confusao vem de Gemini 1.5 Pro ter tido 2M experimentalmente. Tanto o relatorio de Opus na pasta quanto a resposta Gemini ja flagaram isso; reafirmo.
2. **"Codex CLI aplica sandboxing a nivel de kernel via Landlock+Seccomp no Linux"** (Gemini response, secao 1) - PARCIALMENTE VERIFICADO. O README do `openai/codex` cita os modos de sandbox mas nao tive acesso direto a fonte primaria nesta verificacao para confirmar que Landlock+Seccomp sao a implementacao Linux atual. Marcar como `[NAO VERIFICADO POR MIM, hoje]`. Recomendo `gh api repos/openai/codex/contents/codex-rs/README.md` antes de citar como fato em decisao.
3. **"GPT-5.5 e ate 8x mais barato em tokens que Claude Opus para coding"** (Gemini response, secao 3) - NAO VERIFICADO. Pricing oficial GPT-5.5: $5/$30 input/output por 1M tokens. Claude Opus 4.7: nao verifiquei pricing atual nesta busca. O claim "8x mais barato" depende de comparacao apples-to-apples (mesmo nivel de raciocinio, mesmo workload), o que Gemini nao fez. Marcar `[NAO VERIFICADO]`.
4. **"Driver 9p do WSL2 causa degradacao de I/O em ate 80%"** (Gemini response, secao 2) - PROVAVELMENTE VERDADEIRO em ordem de grandeza para workloads tipo `node_modules`, mas o numero "80%" especifico nao e citado em fonte primaria oficial. Microsoft Learn fala em "performance is exception" e recomenda nao cruzar filesystems, sem dar numero. Marcar `[INFERENCIA FORTE; NUMERO NAO VERIFICADO]`.
5. **"Ubuntu 26.04.1 sai em meados de julho de 2026"** (Gemini response, secao 4) - NAO VERIFICADO. O ciclo Ubuntu LTS tipicamente entrega `.1` em ~3 meses, o que cairia em julho/2026, mas e cronograma, nao fato. Marcar `[INFERENCIA HISTORICA]`.

### Conflitos com boundary/anti-sprawl do Prometeus

1. **Recomendacao Gemini "criar Agent Skills locais imediatamente"** (resposta Gemini, secao 4) - CONFLITO direto com `shadow/AGENT-USAGE.md > Local skills contract` linhas 87-122: skill local exige procedure em lane `operational` + >=3 evidencias + rubric >=0.8 + 30 dias estavel + aprovacao humana por skill. Nao ha procedure que satisfaca isso hoje. **REJEITAR.**
2. **"Adocao do `uv`+`ruff`+`bun`+`biome` amanha"** (resposta Gemini, secao 4) - CONFLITO PARCIAL com regra do AGENTS.md "Do Not > inflar o repo com agentes, skills ou scaffolds sem uso recorrente". `uv`/`ruff` nao inflam o repo (sao instalados na maquina, nao versionados), mas instalar tudo sem projeto que use e desperdicio. Manter como **candidato por projeto**.
3. **"Migracao para ext4 amanha"** - PARCIALMENTE OK. Microsoft recomenda. Mas amanha o Lucas tem reuniao triadica para decidir; nao deve agir antes da decisao. E como ja apontei na secao 3, o estado atual sugere que essa migracao **ja aconteceu de fato sem registro formal** - precisa ser regularizada.

### Claims do dossie local que merecem releitura

1. `shadow/SOTA-STACK-2026-04-26.md` linha 113: "Decisao operacional atual: Prometeus fica em `C:\Dev\Projetos\OLMO_PROMETEUS`". Conflita com a CWD da sessao atual (`/home/lucasmiachon/projects/OLMO_PROMETEUS`). Nao reflete realidade.
2. `shadow/FOUNDATION.md` linha 35: "Workspace canonico aprovado: `C:\Dev\Projetos\OLMO_PROMETEUS`. No WSL, usar o mesmo workspace em `/mnt/c/Dev/Projetos/OLMO_PROMETEUS`". Idem.

---

## 5. Stack recomendado

Cada item justificado com: evidencia local | evidencia externa | custo | risco | rollback | criterio negativo.

### 5.1 Agente principal (orquestrador / decisao)

**Recomendacao:** Codex CLI 0.125.0 com `reasoning_effort=xhigh` como integrador-orquestrador e Claude Code (Opus 4.7) como juiz/arquiteto.

- Evidencia local: `AGENTS.md > Coauthorship` linha 149-150 (Codex xhigh default); `shadow/SOTA-DECISIONS.md > Codex xhigh default (2026-04-26)` linhas 112-128; `shadow/SOTA-DECISIONS.md > Time minimo` linhas 196-200.
- Evidencia externa: OpenAI models docs confirma `xhigh` como reasoning_effort em GPT-5.x-Codex; runtime atual confirma Opus 4.7 como mais capaz Anthropic.
- Custo: ja em uso, sem custo adicional alem do ja praticado.
- Risco: nenhum incremental.
- Rollback: nao aplicavel (status quo).
- Criterio negativo: se Codex xhigh causar atrito recorrente injustificado, rebaixar para `high` (ja registrado em SOTA-DECISIONS.md linha 126).

### 5.2 Agentes auxiliares

**Recomendacao:** Gemini CLI 0.39.1 (modelo `gemini-3.1-pro-preview`) e ChatGPT 5.5 web/API como adversarios independentes para SOTA gate, sem persistencia de runtime local.

- Evidencia local: `shadow/AGENT-USAGE.md > SOTA agent contract`; `shadow/SOTA-STACK-2026-04-26.md > Perna Gemini API`.
- Evidencia externa: Gemini 3.1 Pro Preview confirmado em ai.google.dev; GPT-5.5 confirmado em openai.com/index/introducing-gpt-5-5.
- Custo: API keys ja existem; chamadas pontuais, nao continuas.
- Risco: PHI/dado sensivel em prompt externo - mitigado por `shadow/PHI-CHECKLIST.md`.
- Rollback: parar de chamar; remover keys do ambiente.
- Criterio negativo: se a triade gerar mais ruido que sinal por 2 ciclos, descontinuar Gemini ou GPT-5.5 e ficar com adversario unico.

### 5.3 Shell

**Recomendacao:** Bash como contrato de scripts versionados, harness e shell entregue a agentes. Zsh permitido como conforto humano (nao versionado). Fish/Nushell **nao** entram como dependencia do projeto.

- Evidencia local: `shadow/SOTA-STACK-2026-04-26.md > Shells` linhas 126-141.
- Evidencia externa: Bash continua POSIX default; Fish 4.0 Rust nao e POSIX (phoronix.com); Nushell nao substitui Bash em CI (nushell.sh/book).
- Custo: zero, ja e o atual.
- Risco: nenhum incremental.
- Rollback: nao aplicavel.
- Criterio negativo: se um agente especifico tiver bug grave em Bash que outro shell resolva sem custo, reavaliar pontualmente.

### 5.4 Filesystem / workspace

**Recomendacao:** Reconciliar a divergencia: ou (a) registrar formalmente que canonico migrou para `~/projects/OLMO_PROMETEUS` (ext4 nativo Linux) e atualizar `AGENTS.md`, `README.md`, `shadow/HANDOFF.md`, `shadow/FOUNDATION.md`, `shadow/SOTA-DECISIONS.md` em UM commit pequeno com decisao + rollback; ou (b) verificar fisicamente se `C:\Dev\Projetos\OLMO_PROMETEUS` ainda existe em paralelo e decidir qual e canonico antes de continuar.

- Evidencia local: CWD atual `/home/lucasmiachon/projects/OLMO_PROMETEUS` vs docs apontando `C:\Dev\Projetos\...` (multiplas linhas).
- Evidencia externa: Microsoft Learn WSL filesystems doc recomenda ext4 nativo para Linux CLI.
- Custo: 1-2 commits de doc (nao envolve mover dados).
- Risco: se Obsidian usa o vault em `/home/...`, abrir do Windows precisa de `\\wsl.localhost\Ubuntu\...` ou symlink; ja podem ter sido testados.
- Rollback: revert dos commits de doc.
- Criterio negativo: se Obsidian indexer falhar persistentemente em `\\wsl.localhost\`, voltar canonico para `/mnt/c`.

**Esta e a decisao mais urgente da lista.**

### 5.5 Python

**Recomendacao:** `uv` + `ruff` quando houver projeto Python real. Nao instalar globalmente sem projeto.

- Evidencia local: `shadow/SOTA-STACK-2026-04-26.md` linhas 156-159; nao ha projeto Python ativo no repo hoje.
- Evidencia externa: docs.astral.sh/uv, docs.astral.sh/ruff.
- Custo: instalacao na maquina (~50MB), zero no repo.
- Risco: nenhum se nao for instalado por reflexo.
- Rollback: `uv self uninstall`.
- Criterio negativo: se um projeto Python ficar bloqueado por incompatibilidade do `uv`, voltar a pip+venv pontualmente.

### 5.6 TypeScript

**Recomendacao:** Default conservador `pnpm` + `vite` + `biome` por projeto. `bun` como experimento por projeto, nao default.

- Evidencia local: `shadow/SOTA-STACK-2026-04-26.md` linhas 156-160.
- Evidencia externa: pnpm.io, vitejs.dev, biomejs.dev, bun.com.
- Custo: zero ate ter projeto TS.
- Risco: nenhum.
- Rollback: trivial.
- Criterio negativo: se Biome quebrar em config existente do projeto que use ESLint/Prettier, manter ESLint/Prettier nesse projeto especifico.

### 5.7 Harness

**Recomendacao:** Manter `scripts/check.sh` e `scripts/evolve.sh` Bash-first como gate operacional. Nao adicionar `pytest`, `vitest` ou framework de teste externo sem projeto que precise.

- Evidencia local: `shadow/FOUNDATION.md > Harness` linhas 82-104; `shadow/SOTA-DECISIONS.md > Bash-first WSL2 harness (2026-04-26)`.
- Evidencia externa: nao aplicavel (e politica interna).
- Custo: zero, ja em producao.
- Risco: zero.
- Rollback: nao aplicavel.
- Criterio negativo: se o repo virar host de pacote real (npm/pypi), entao adicionar test runner especifico do pacote, NAO no harness raiz.

### 5.8 Wiki / Obsidian

**Recomendacao:** Manter vault em `Prometeus/`, regra de >=2 wikilinks por nota em `Notes/`, `Clippings/Daily/Attachments` ignorados. Nao adicionar plugins de Obsidian que escrevam fora do vault.

- Evidencia local: `AGENTS.md > Layout` linha 91; `README.md > Obsidian` linhas 95-112.
- Evidencia externa: nao aplicavel (workflow interno).
- Custo: zero.
- Risco: se canonico migrou para ext4, abrir vault de Windows-Obsidian usa `\\wsl.localhost\` que pode ter file-watching limit.
- Rollback: copiar vault de volta para `/mnt/c` ou usar symlink.
- Criterio negativo: se inotify limit + Obsidian indexer falhar, fall-back para Windows-side vault.

### 5.9 Pesquisa externa

**Recomendacao:** WebSearch/WebFetch via CLI quando houver claim factual instavel; preferir fontes primarias (docs oficiais) sobre blogposts. Registrar fonte no artefato em `shadow/`. Nao usar Consensus/SCite/PubMed neste tipo de avaliacao tecnica (sao para literatura cientifica, nao stack agentico).

- Evidencia local: `AGENTS.md > SOTA Research Gate` linhas 34-44.
- Evidencia externa: nao aplicavel.
- Custo: token de busca por chamada.
- Risco: aceitar blogspam como verdade - mitigado por preferir fontes `.dev/.io/.ai` oficiais.
- Rollback: ignorar resultado se nao for primario.
- Criterio negativo: nao aplicavel.

---

## 6. Decisoes para tomar agora (baixo risco / alto valor)

| # | Decisao | Risco | Valor |
|---|---|---|---|
| 1 | **Reconciliar divergencia de canonical workspace** em `AGENTS.md`/`README.md`/`shadow/*` em um commit pequeno apos decisao humana sobre qual e o canonico real (`/home/...` vs `C:\Dev\...`). Esta e a unica decisao urgente. | Baixo (so docs) | Alto (a regra fundamental do projeto fica mentirosa enquanto isso nao for resolvido) |
| 2 | **Registrar GPT-5.5 e Gemini 3.1 Pro Preview como modelos verificados em 2026-04-26** em `shadow/SOTA-STACK-2026-04-26.md` (atualizacao incremental, nao novo doc). | Baixissimo | Medio (evita pesquisa duplicada amanha) |
| 3 | **Bloquear formalmente upgrade para Ubuntu 26.04 LTS** ate 26.04.1 ou agosto/2026, o que vier primeiro. Registrar em `shadow/SOTA-DECISIONS.md` como decisao curta com criterio negativo (zero-day bug em LTS recem-lancado). | Baixissimo | Medio (evita decisao por reflexo amanha) |
| 4 | **Confirmar workflow remoto** (`gh run list` para o ultimo push em `main`) - ja era item P0 em `shadow/HANDOFF.md > Top Gaps`. | Baixo | Alto (destrava promocao para `candidate`) |
| 5 | **Manter triade Codex/Claude/Gemini sem mudanca**. Nao adotar GPT-5.5 como adversario novo ate haver 2 ciclos de comparacao com o que ja esta funcionando. | Zero | Medio (evita expansao por moda) |

---

## 7. Decisoes bloqueadas (e o que destravaria)

| Bloqueio | Por que esta bloqueada | Evidencia que destravaria |
|---|---|---|
| Criar `.claude/skills/<nome>/SKILL.md` agora | `shadow/AGENT-USAGE.md > Local skills contract` exige procedure operational + 30 dias + rubric >=0.8 + 3 evidencias + aprovacao humana por skill. Nao ha procedure nesse estado. | Promover `email-digest-4p`, `study-track-done` ou `sota-research-gate` a `operational` em `WORK-LANES.md` com 3+ entradas em `EVIDENCE-LOG.md` e rubric estavel por 30 dias. |
| Adotar runtime agentico (LangGraph/CrewAI/OpenAI Agents SDK como dependencia) | `shadow/SOTA-DECISIONS.md > Solo medico agent/orchestration refresh` exige 3 evidencias reais de retrabalho que procedimento manual nao resolva. Zero hoje. | 3 entradas em `EVIDENCE-LOG.md` mostrando re-trabalho atribuivel a falta de estado/HITL/tracing/coordenacao multi-agente. |
| Migrar de Ubuntu 24.04 para 26.04 | LTS lancado ha 3 dias; risco zero-day em base de medico solo dev. | 26.04.1 lancado, OU agosto/2026 sem CVE LTS-blocking, OU bug critico no 24.04 que so 26.04 resolva. |
| Mover canonico para Fedora ou Ubuntu nativo (sem WSL) | Obsidian + Windows ainda parte do fluxo; sem ganho medido. | Benchmark local mostrando >40% melhoria em build/agent loop, ou mudanca de plataforma humana (Lucas migrar de Windows). |
| Hooks Claude Code beyond `guard-olmo-write-hook.sh` | `shadow/FOUNDATION.md` linhas 36-40: hooks como arquitetura sao perigosos; so o guard atual tem teste positivo/negativo. | Cenario novo onde write/read externo apareca de forma nao coberta pelo guard atual, com teste de regressao. |
| MCP server proprio neste repo | `shadow/SOTA-DECISIONS.md > Decisao central` linha 24: nao incorporar MCP proprio por reflexo. | Necessidade especifica que nao seja resolvida por procedure + WebFetch/WebSearch. |
| Adotar bun como default global | `shadow/SOTA-STACK-2026-04-26.md` linha 158: bun e experimento por projeto. | Projeto TS no Prometeus rodando 30 dias com bun e mostrando ganho medido vs Node+pnpm. |

---

## 8. Plano experimental de 7 dias

Escopo: validar **uma** decisao - reconciliar canonical workspace - sem tocar em nada que nao precise tocar. Outras decisoes (ext4 migration, toolchain) ficam para janelas futuras com seus proprios experimentos.

### Hipotese

> O canonical workspace deve ser registrado como `/home/<user>/projects/OLMO_PROMETEUS` (ext4 nativo Linux) com Obsidian acessando via `\\wsl.localhost\Ubuntu\home\<user>\...` quando precisar de UI Windows. A migracao opera melhor que `/mnt/c` para CLI agentico e nao quebra Obsidian.

### Variaveis controladas

- A: cwd da sessao Claude Code/Codex CLI (medido via `pwd`).
- B: latencia de operacoes I/O-pesadas: `git status`, `rg` em `Prometeus/wiki/`, `./scripts/check.sh` end-to-end.
- C: estabilidade do Obsidian: contagem de "missing file" warnings em 24h, file-watcher CPU.
- D: tempo de resposta de subagent `Explore` em busca ampla (3 queries de baseline).

### Metricas (baseline + alvo)

| Metrica | Baseline (`/mnt/c`) | Alvo (`/home/...`) |
|---|---|---|
| `./scripts/check.sh` end-to-end (3 runs, mediana) | TBD | -30% ou melhor |
| `rg -l "OLMO" .` (sem hit no `.git`) | TBD | -20% ou melhor |
| Obsidian indexer warnings em 24h | <10 (atual) | <=10 |
| Obsidian save -> graph update visivel | <2s (atual) | <=3s (aceitavel via `\\wsl.localhost\`) |

### Cronograma

- **D1 (2026-04-27, sequenciamento triadico):** decidir, com Lucas + Codex + ChatGPT 5.5 ou Gemini, qual e o canonico real. Nao mover dados.
- **D2:** se decidido manter `/home/...`, atualizar `AGENTS.md`, `README.md`, `shadow/HANDOFF.md`, `shadow/FOUNDATION.md`, `shadow/SOTA-STACK-2026-04-26.md` em UM commit. Rodar `./scripts/check.sh`. Registrar em `shadow/INCORPORATION-LOG.md` e `shadow/SOTA-DECISIONS.md > Applied when`.
- **D3:** medir baseline atual de I/O (3 runs) e abrir vault no Obsidian via `\\wsl.localhost\`. Anotar.
- **D4-D5:** uso normal do laboratorio. 1-2 ciclos digest/study/wiki em uso real registrados em `EVIDENCE-LOG.md` (item P1 do Top Gaps).
- **D6:** medicao final. Comparar com baseline.
- **D7:** veredito. Se metricas atingiram alvo e Obsidian estavel, fechar como `operational`. Se nao, rollback.

### Rollback (sem destruicao)

- Reverter os commits de doc (`git revert <hash>`).
- Se vault foi copiado para `/home/...` e original ainda existe em `/mnt/c`, simplesmente reabrir Obsidian no caminho antigo. Manter ambos por 14 dias antes de deletar o nao-canonico.
- Sem `rm -rf` antes do D14 sob qualquer circunstancia.

### Criterios negativos para abortar

- Obsidian gerar >50 warnings de "file moved/missing" em 24h.
- `inotify` limit hit que exija `sudo sysctl` recorrente.
- Plugin do Obsidian quebrar em escrita de metadado.
- `./scripts/check.sh` falhar por path issue nao resolvivel em 30 minutos.
- Discordancia adversarial entre Codex/Gemini/ChatGPT na decisao do D1 sem caminho convergente: nao decidir por voto, manter status quo e levantar nova evidencia.

---

## 9. Riscos

### Privacidade / PHI

- **Vetor:** sessao Claude Code com Opus 4.7 + WebSearch chamando ai.google.dev/openai.com. Se um prompt incluir PHI, vaza para Anthropic + provedor do search.
- **Mitigacao atual:** `shadow/PHI-CHECKLIST.md`, `shadow/DATA-CLASSIFICATION.md`, regra explicita em AGENTS.md > Solo Doctor Dev Standard.
- **Severidade:** alta se mitigacao falhar; baixa em uso atual (sem PHI no repo).
- **Acao:** rodar PHI-CHECKLIST formalmente na proxima sessao que envolver email/agenda/PDF clinico real (item P1 em HANDOFF).

### Perda de dados

- **Vetor:** migracao de `/mnt/c` -> `/home/...` ou vice-versa sem backup.
- **Mitigacao:** experimento de 7 dias mantem ambos os paths por 14 dias; rollback explicito sem `rm -rf`.
- **Severidade:** media (vault e o ativo de maior dor para perder).
- **Acao:** antes de qualquer migracao real de dados, `git push origin main` + `tar -czf ~/prometeus-backup-$(date +%F).tar.gz Prometeus/`.

### Drift de docs

- **Vetor:** AGENTS.md/README.md/SOTA-DECISIONS.md afirmando coisas diferentes do estado real (ja acontece - canonical workspace).
- **Mitigacao:** `scripts/check.sh` valida cross-references mas nao valida claims geo-factual de path.
- **Severidade:** media (degrada confiabilidade do contrato).
- **Acao:** decisao #1 da lista de "tomar agora".

### Custo

- **Vetor:** Codex `xhigh` + Claude Opus 4.7 + GPT-5.5 + Gemini 3.1 Pro = 4 modelos premium queimando tokens em paralelo.
- **Mitigacao atual:** triade so e usada em SOTA gate, nao em dia-a-dia. Codex `xhigh` so para tarefas que justificam.
- **Severidade:** baixa-media; depende do uso, nao do stack.
- **Acao:** nao adicionar GPT-5.5 como quarto adversario padrao. Manter triade.

### Complexidade agentica

- **Vetor:** tentacao de criar `.claude/skills/`, hooks, MCP servers, multi-agent runtime - exatamente o que `AGENTS.md > Do Not` proibe.
- **Mitigacao:** SOTA gate + lane gate + evidencia.
- **Severidade:** alta se ceder; e a falha modal de projetos solo neste espaco.
- **Acao:** rejeitar **todas** as recomendacoes Gemini/Opus/ChatGPT que pedem "criar skill agora", "criar hook agora", "adotar runtime agora" sem trigger registrado.

---

## 10. Veredito final

Se eu fosse responsavel tecnico do laboratorio Prometeus em 2026-04-26, faria o seguinte, em ordem, na proxima sessao: primeiro, decidiria com Lucas qual e o canonical workspace real e atualizaria os docs em UM commit pequeno. Segundo, confirmaria o workflow remoto pendente (`gh run list`). Terceiro, manteria a triade Codex+Claude+Gemini sem mexer e rejeitaria todas as recomendacoes adversariais que pedem novo runtime, skill local ou hook expandido sem evidencia em `EVIDENCE-LOG.md`. Quarto, registraria GPT-5.5/Gemini 3.1 Pro Preview/Ubuntu 26.04 como verificados na linha do `SOTA-STACK-2026-04-26.md`, sem adotar nenhum deles em producao. Nada mais. O projeto nao precisa de stack novo; precisa de uso real e disciplina de gate. A regra Solo Doctor Dev (auditavel, reversivel, sem dados sensiveis, humano-no-loop, proporcional) ja e o veredito profissional - aplica-la nesta sessao significa **nao decidir nada estrutural** e usar a triade de amanha para fechar a unica divergencia urgente: docs vs realidade no path canonico.

---

## Sources

Verificacao externa em 2026-04-26:

- [Ubuntu 26.04 LTS release notes (oficial)](https://documentation.ubuntu.com/release-notes/26.04/)
- [Ubuntu 26.04 LTS Resolute Raccoon (CNX Software, 2026-04-24)](https://www.cnx-software.com/2026/04/24/ubuntu-26-04-lts-resolute-raccoon-released-with-linux-7-0/)
- [Gemini 3.1 Pro Preview - Google AI for Developers](https://ai.google.dev/gemini-api/docs/models/gemini-3.1-pro-preview)
- [Gemini 3.1 Pro Model Card - Google DeepMind](https://deepmind.google/models/model-cards/gemini-3-1-pro/)
- [Gemini 3.1 Pro - Vertex AI docs](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/3-1-pro)
- [Introducing GPT-5.5 - OpenAI](https://openai.com/index/introducing-gpt-5-5/)
- [GPT-5.5 System Card - OpenAI](https://openai.com/index/gpt-5-5-system-card/)
- [OpenAI announces GPT-5.5 - CNBC, 2026-04-23](https://www.cnbc.com/2026/04/23/openai-announces-latest-artificial-intelligence-model.html)
- [Anthropic Claude Code Releases](https://github.com/anthropics/claude-code/releases)
- [Claude Code Changelog - Anthropic](https://code.claude.com/docs/en/changelog)

Fontes locais ja citadas inline (caminhos relativos a `/home/lucasmiachon/projects/OLMO_PROMETEUS`).

Coautoria: Lucas + Claude Opus 4.7 (1M context).
