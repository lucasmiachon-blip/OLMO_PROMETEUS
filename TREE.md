# Repository Tree

Mapa operacional do `OLMO_PROMETEUS`.

Este arquivo existe para deixar claro o que mora na raiz, o que e fonte de verdade e o que nao deve virar infraestrutura ativa sem gate.

## Regra fundamental

Nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

`C:\Dev\Projetos\OLMO` pode ser lido para auditoria e inspiracao, mas nao pode receber edicoes, arquivos, hooks, configs, caches ou automacoes a partir deste repo.

## Raiz

```text
AGENTS.md             # contrato operacional para agentes neste repo
PROJECT_CONTRACT.md   # limites, lanes e criterio de promocao
README.md             # entrada humana rapida
TREE.md               # mapa profissional da arvore do repo
scripts/check.ps1     # harness local, sem writes externos
shadow/               # decisoes, gates, memoria operacional e higiene
Prometeus/            # vault Obsidian versionado
private-learning/     # cockpit e material pessoal local, gitignored
playground/           # prototipos descartaveis
.agents/skills/       # skills pequenas, com trigger claro
.codex/agents/        # agentes estreitos, preferencialmente read-only
hooks/                # docs e scripts manuais inativos; nenhum hook ativo por padrao
```

## Areas Vivas

### `Prometeus/`

Vault Obsidian graph-first.

- `Prometeus/README.md`: entrada do vault.
- `Prometeus/.obsidian/`: configuracao versionada minima.
- `Prometeus/wiki/`: conhecimento duravel e linkavel.
- `Prometeus/wiki/Clippings/`, `Daily/` e `Attachments/`: captura crua ignorada, exceto README de cada pasta.

### `shadow/`

Memoria operacional, nao deposito de pesquisa longa.

- `FOUNDATION.md`: infra, hooks, memoria, harness e orquestracao.
- `HYGIENE.md`: checklist anti-sprawl.
- `INCORPORATION-LOG.md`: registro de experimentos e candidatos.
- `WORK-LANES.md`: classificacao `private`, `experiment`, `candidate`.
- `SOTA-DECISIONS.md`: decisoes curtas, sem relatorios longos.

### `.agents/skills/`

Cada skill precisa ter:

- trigger de uso;
- output claro;
- risco limitado;
- comportamento de arquivo explicito quando persistir algo.

Nao criar skill para ideia avulsa. Se nao houver uso recorrente, documentar em `shadow/` ou descartar.

### `.codex/agents/`

Agentes devem ser estreitos e preferencialmente read-only.

Regras atuais:

- `max_depth = 1` em `.codex/config.toml`;
- sem fan-out automatico;
- sem agente que escreva fora de `OLMO_PROMETEUS`;
- sem copiar subagentes do `OLMO` por reflexo.

### `hooks/`

Hooks entram primeiro como documentacao ou script manual.

Nada em `hooks/` e registrado automaticamente. Antes de virar hook ativo, precisa de trigger, evidencia, rollback, custo e aprovacao humana explicita.

## Politica de Incorporacao do OLMO

Padroes bons do `OLMO` podem ser copiados apenas como ideias ou adaptacoes pequenas.

Nao copiar:

- `.env`, tokens, chaves, caches, workspaces, settings locais;
- `config/mcp/` ou MCP sensivel;
- hooks ativos;
- `node_modules`, `.venv`, `__pycache__`, zips e outputs;
- historico longo que nao muda comportamento.

Copiar/adaptar somente quando houver:

- casa clara neste repo;
- trigger real;
- risco explicito;
- rollback simples;
- harness passando.

## Gate Antes de Commit

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1 -Strict
```

Se o working tree ja tiver mudanca do Obsidian ou do usuario, nao esconder isso. Separar commits pequenos e nao misturar alteracoes geradas com edicoes manuais sem motivo.

Coautoria: Lucas + GPT-5.4 (Codex)
