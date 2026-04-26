# Repository Tree

Mapa operacional do `OLMO_PROMETEUS`.

Este arquivo existe para deixar claro o que mora na raiz, o que e fonte de verdade e o que nao deve virar infraestrutura ativa sem gate.

## Regra fundamental

Nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

`C:\Dev\Projetos\OLMO` pode ser lido para auditoria e inspiracao, mas nao pode receber edicoes, arquivos, hooks, configs, caches ou automacoes a partir deste repo.

## Raiz

```text
AGENTS.md             # contrato operacional para agentes neste repo
CLAUDE.md             # adaptador fino Boris-style para Claude Code, importa AGENTS.md
GEMINI.md             # adaptador fino para Gemini CLI, importa AGENTS.md
PROJECT_CONTRACT.md   # limites, lanes e criterio de promocao
README.md             # entrada humana rapida
TREE.md               # mapa profissional da arvore do repo
scripts/check.sh      # harness local Bash-first, sem writes externos
scripts/evolve.sh     # executor self-evolving Bash-first read-only
scripts/guard-olmo-write-hook.sh # guard Bash para boundary OLMO
internal/evolution/   # backlog, risk register e review cadence do loop interno
shadow/               # decisoes, gates, memoria operacional, evidencia e agent usage
Prometeus/            # vault Obsidian versionado
lab/                  # companions visuais e prototipos locais que leem o vault sem virar runtime
private-learning/     # area local ignorada; nao entra no contexto versionado
.github/workflows/    # watchdog read-only do GitHub Actions
.claude/              # state local do Claude Code (settings.local.json); ignorado por Git
```

## Adaptadores de Ferramenta

`CLAUDE.md` e `GEMINI.md` existem porque Claude Code e Gemini CLI procuram arquivos de contexto proprios.

Regra: eles importam `AGENTS.md`, nao duplicam politica e nao autorizam criar `.claude/`, `.gemini/`, hooks, MCP, agents ou skills ativos.

## Areas Vivas

### `lab/`
Companions visuais reversiveis.

- `lab/wiki-graph-lab/`: grafo HTML/JS que consome `Prometeus/wiki/` e abre notas no Obsidian.


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
- `DATA-CLASSIFICATION.md`, `PHI-CHECKLIST.md`, `THREAT-MODEL.md`, `INCIDENT-LOG.md`: controles minimos de privacidade e incidente; nao guardam dado sensivel.
- `AGENT-MODULES.md`: contrato experimental para agentes como modulos; eixo tecnico ortogonal a WORK-LANES.
- `AGENT-USAGE.md`: mapa de agentes/skills globais usados sem scaffold local + SOTA agent contract.
- `HYGIENE.md`: checklist anti-sprawl.
- `PLAN-*.md`: plans operacionais por rodada estrutural (um por mudanca grande, ex: `PLAN-2026-04-23.md`).
- `EMAIL-DIGEST-4P.md`, `STUDY-TRACK-DONE.md`: procedures com trigger, contrato, workflow, rubric e mini-evals.

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

`.claude/` nao e totalmente proibido: Claude Code cria `.claude/settings.local.json` automaticamente como state local do harness. O diretorio fica em `.gitignore` e `.claudeignore`, nunca versionado.

Subdirs proibidos sem gate individual (harness falha):

- `.claude/agents/`
- `.claude/hooks/`
- `.claude/commands/`

Subdirs com gate aberto (harness valida):

- `.claude/skills/`: aberto em 2026-04-23. Cada subdir `.claude/skills/<name>/` precisa de `SKILL.md` com frontmatter valido. Contrato em `shadow/AGENT-USAGE.md > Local skills contract`. Gate de promocao em `shadow/SOTA-DECISIONS.md > Local skills gate`.

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

Copiar/adaptar somente quando houver:

- casa clara neste repo;
- trigger real;
- risco explicito;
- rollback simples;
- harness passando.

## Gate Antes de Commit

```bash
./scripts/check.sh --strict
```

Se o working tree ja tiver mudanca do Obsidian ou do usuario, nao esconder isso. Separar commits pequenos e nao misturar alteracoes geradas com edicoes manuais sem motivo.

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
