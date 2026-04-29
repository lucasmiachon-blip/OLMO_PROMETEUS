# Repository Tree

Mapa operacional do `OLMO_PROMETEUS`.

Este arquivo existe para deixar claro o que mora na raiz, o que e fonte de verdade e o que nao deve virar infraestrutura ativa sem gate.

Regra de escrita: be terse. Politica vive uma vez; adaptadores nao duplicam.

## Regra fundamental

Nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.

`C:\Dev\Projetos\OLMO` pode ser lido para auditoria e inspiracao, mas nao pode receber edicoes, arquivos, hooks, configs, caches ou automacoes a partir deste repo.

## Raiz

```text
AGENTS.md             # contrato operacional para agentes neste repo
CLAUDE.md             # adaptador fino Boris-style para Claude Code, importa AGENTS.md
CODEX.md              # adaptador fino para Codex, importa AGENTS.md
GEMINI.md             # adaptador fino para Gemini CLI, importa AGENTS.md
PROJECT_CONTRACT.md   # limites, lanes e criterio de promocao
VALUES.md             # valores, objetivos, OLMO como piso e lente de gaps
README.md             # entrada humana rapida
TREE.md               # mapa profissional da arvore do repo
scripts/check.sh      # harness local Bash-first, sem writes externos
scripts/evolve.sh     # executor self-evolving Bash-first read-only
scripts/integrity.sh  # gate read-only de integridade/maturidade local
scripts/simulate-ci.sh # simulacao local read-only do workflow Self Evolution (Linux leg)
scripts/install-stack.sh # diagnostico idempotente do stack (sem sudo)
scripts/guard-olmo-write-hook.sh # guard Bash para boundary OLMO
biome.json            # config raiz biome (lint+format JSON `internal/` + JS `lab/`)
docs/adr/             # Architecture Decision Records curtos e aceitos
lab/wiki-graph-lab/pyproject.toml # primeiro projeto Python real; ruff wired
lab/wiki-graph-lab/uv.lock        # lockfile reproducible (uv pip compile)
internal/evolution/   # backlog, risk register, review cadence + failure-registry do loop interno
shadow/               # decisoes, gates, memoria operacional, evidencia, backlog view e KBP
Prometeus/            # vault Obsidian versionado
lab/                  # companions visuais e prototipos locais que leem o vault sem virar runtime
private-learning/     # area local ignorada; nao entra no contexto versionado
.github/workflows/    # watchdog read-only do GitHub Actions
.claude/              # state local do Claude Code (settings.local.json); ignorado por Git
```

## Adaptadores de Ferramenta

`CLAUDE.md`, `CODEX.md` e `GEMINI.md` existem porque ferramentas diferentes procuram arquivos de contexto proprios.

Regra: eles importam `AGENTS.md`, nao duplicam politica e nao autorizam criar `.claude/`, `.gemini/`, `.codex/`, hooks, MCP, agents ou skills ativos.

## Areas Vivas

### `lab/`
Companions visuais reversiveis.

- `lab/wiki-graph-lab/`: grafo HTML/JS que consome `Prometeus/wiki/` e abre notas no Obsidian.

### `docs/adr/`

Architecture Decision Records curtos para decisoes aceitas que outro agente precisa conhecer antes de repetir ou alterar infraestrutura.

- `README.md`: indice 0001-0007.
- `template.md`: formato MADR simplificado.
- Criar ADR para boundary, executor rule, privacy guard, runtime/agent gate, hook/gate, MCP, memoria e rollback nao-trivial.

### `.github/workflows/`

Automacao read-only. `self-evolution.yml` roda `scripts/check.sh` e `scripts/evolve.sh` em push, PR, schedule semanal e workflow manual. Nao pode escrever, commitar, fazer push, abrir issue ou tocar dado sensivel.

### `internal/evolution/`

Estado interno versionado do self-evolution loop: backlog, risk register e review cadence. Nao e memoria privada e nao guarda dados de paciente.


### `Prometeus/`

Vault Obsidian graph-first.

- `Prometeus/README.md`: entrada do vault.
- `Prometeus/.obsidian/`: configuracao versionada minima.
- `Prometeus/wiki/`: conhecimento duravel e linkavel.
- `Prometeus/wiki/Clippings/`, `Daily/` e `Attachments/`: captura crua ignorada, exceto README de cada pasta.

### `shadow/`

Memoria operacional, nao deposito de pesquisa longa.

- `FOUNDATION.md`: infra, hooks, memoria, harness e orquestracao.
- `HANDOFF.md`: entrada enxuta para hidratar nova janela com objetivo, gaps e cross refs.
- `WORK-LANES.md`: fonte unica dos estados (`private`, `experiment`, `candidate`, `operational`, `retired`, `blocked`) e promotion gate.
- `INCORPORATION-LOG.md`: log de transicoes de estado aplicadas (nao redefine estados).
- `EVIDENCE-LOG.md`: registro de uso real dos procedimentos; gate para `operational`.
- `SOTA-DECISIONS.md`: decisoes curtas apos SOTA research gate; secao `Applied when` e stubs `Blocked ate evidencia`.
- `LEGACY-INCORPORATION-*.md`: matriz profissional de legado; guarda decisao `incorporar/nao incorporar` e parking lot com trigger de reabertura.
- `DATA-CLASSIFICATION.md`, `PHI-CHECKLIST.md`, `THREAT-MODEL.md`, `INCIDENT-LOG.md`: controles minimos de privacidade e incidente; nao guardam dado sensivel.
- `AGENT-MODULES.md`: contrato experimental para agentes como modulos; eixo tecnico ortogonal a WORK-LANES.
- `AGENT-USAGE.md`: mapa de agentes/skills globais usados sem scaffold local + SOTA agent contract.
- `HYGIENE.md`: checklist anti-sprawl.
- `PLAN-*.md`: plans operacionais por rodada estrutural (um por mudanca grande, ex: `PLAN-2026-04-23.md`).
- `EMAIL-DIGEST-4P.md`, `STUDY-TRACK-DONE.md`: procedures com trigger, contrato, workflow, rubric e mini-evals.
- `BACKLOG.md`: view markdown derivada de `internal/evolution/backlog.json` (canonical), com tiers P0/P1/P2/Frozen/Resolved + effort + dormancy.
- `KBP.md`: catalogo pointer-only de Known Bad Patterns observados no lab; cross-ref para AGENTS/CLAUDE/SOTA-DECISIONS, sem prosa inline.
- `ORCHESTRATION-HARNESS-ANTIFRAGILE.md`: gate E2E, matriz producer-consumer e contrato antifragile verificavel.
- `PLAN-ARCHIVE/`: plans operacionais arquivados por mudanca estrutural (`YYYY-MM-DD.md`); imutavel apos arquivado.

### `private-learning/`

Area pessoal e local.

- fica em `.gitignore` e `.claudeignore`;
- pode conter cockpit, exports, checkpoints e rascunhos pessoais;
- nao e fonte de verdade do projeto;
- nao deve ser exigida pelo harness.

## Diretorios Proibidos Por Padrao

Estes nomes nao ficam na raiz sem necessidade repetida, gate humano explicito e atualizacao deste arquivo:

- `.agents/`
- `.codex/`
- `.gemini/`
- `agents/`
- `subagents/`
- `skills/`
- `hooks/`
- `playground/`

Motivo: esses nomes sugerem runtime ativo, aumentam contexto e recriam sprawl legado.

### `.claude/` tratamento especial

`.claude/` nao e totalmente proibido: Claude Code cria `.claude/settings.local.json` automaticamente como state local do harness (gitignored). Subdirs com cluster contract sao versionados.

Subdirs com cluster contract (versionados, harness valida):

- `.claude/agents/<cluster>/`: 4 clusters fixos (`harness`, `research`, `study`, `wiki`). Cap 2 subagents por cluster. Cada `.md` exige frontmatter com `cluster` batendo com a pasta. Contrato unico: `shadow/CLUSTER-CONTRACT.md`.
- `.claude/skills/<cluster>/<name>/`: 4 clusters fixos. Cap 2 skills por cluster. Cada `SKILL.md` exige 8 frontmatter fields (`name`, `description`, `trigger`, `non-trigger`, `source`, `status`, `owner`, `cluster`). Aberto desde 2026-04-23, com cluster doctrine adicionada em 2026-04-28. Detalhes em `shadow/AGENT-USAGE.md > Local skills contract` + `shadow/CLUSTER-CONTRACT.md`.

Subdirs proibidos sem gate individual (harness falha):

- `.claude/hooks/` (gitignored; usado apenas via `settings.local.json`)
- `.claude/commands/`
- Qualquer subdir em `.claude/agents/` ou `.claude/skills/` que nao seja um dos 4 clusters fixos (ex: `.claude/agents/foo/` falha em `integrity.sh`).

Para mapa de uso de agentes/skills globais, ver `shadow/AGENT-USAGE.md`.

## Politica de Incorporacao do OLMO

Padroes bons do `OLMO` podem ser copiados apenas como ideias ou adaptacoes pequenas.

Nao copiar:

- `.env`, tokens, chaves, caches, workspaces, settings locais;
- `config/mcp/` ou MCP sensivel;
- hooks ativos;
- scaffolds locais de agents, subagents ou skills;
- `node_modules`, `.venv`, `__pycache__`, zips e outputs;
- historico longo que nao muda comportamento.

`OLMO` e piso profissional, nao teto. Copiar/adaptar somente quando houver:

- casa clara neste repo;
- trigger real;
- producer-consumer quando for hook/gate;
- protecao extra Prometeus alem do piso OLMO;
- risco explicito;
- rollback simples;
- harness passando.

## Gate Antes de Commit

```bash
./scripts/check.sh --strict
```

Se o working tree ja tiver mudanca do Obsidian ou do usuario, nao esconder isso. Separar commits pequenos e nao misturar alteracoes geradas com edicoes manuais sem motivo.

Coautoria: Lucas + GPT-5.x-Codex (xhigh)
