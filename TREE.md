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
private-learning/     # area local ignorada; nao entra no contexto versionado
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
- `agents/`
- `subagents/`
- `skills/`
- `hooks/`
- `playground/`

Motivo: esses nomes sugerem runtime ativo, aumentam contexto e recriam sprawl legado.

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

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1 -Strict
```

Se o working tree ja tiver mudanca do Obsidian ou do usuario, nao esconder isso. Separar commits pequenos e nao misturar alteracoes geradas com edicoes manuais sem motivo.

Coautoria: Lucas + GPT-5.4 (Codex)
