@AGENTS.md

## Claude Code

Regra fundamental: nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.

### Commands

```
./scripts/check.sh                 # Ubuntu/WSL harness local rapido
./scripts/check.sh --strict        # Ubuntu/WSL harness + working tree limpo
./scripts/evolve.sh next           # proximo batch
```

### What this is

Laboratorio paralelo solo, baixo risco. Valida fluxo, digest, estudo, wiki e gates de promocao. `AGENTS.md` e a fonte de verdade; este arquivo e um adaptador fino.

Claude Code pode ser executor de uma rodada, mas nunca junto com Codex no mesmo escopo de edicao.

Be terse.

### Things that will bite you

> Catalogo formal e pointer-only em `shadow/KBP.md`. Esta secao mantem os pitfalls com prosa explicativa para hidratacao rapida; o KBP catalogo e a fonte de verdade quando houver divergencia.

- Write externo nao autorizado: qualquer edit fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS` e proibido e deve ser bloqueado. Read externo de sibling/legado exige pergunta previa citando caminho e motivo exatos. (KBP-02)
- Workspace stale: se a sessao apontar para ROADMAP legado, `OLMO_COWORK`, typo `OLMO_COWOR`, `/mnt/c/Dev/Projetos/OLMO_PROMETEUS` ou cwd diferente, corrija para `/home/lucasmiachon/projects/OLMO_PROMETEUS` antes de editar; o hook deve aplicar write=block e read=ask para siblings `OLMO*` nao canonicos. (KBP-01)
- Runtime scaffolds proibidos sem gate: `.claude/agents/`, `.claude/hooks/`, `.claude/commands/`, `agents/`, `subagents/`, `skills/`, `hooks/`, `playground/`. (KBP-04)
- `.claude/skills/` e aceito desde 2026-04-23 como casa de skills reais promovidas de procedures `operational` (ver `shadow/AGENT-USAGE.md > Local skills contract`). Cada subdir precisa de `SKILL.md` valido.
- `.claude/settings.local.json`: aceito como state local do harness; fica em `.gitignore` e `.claudeignore`, nunca versionado.
- Duplicar politica: se precisar de regra nova, va para `AGENTS.md`, `PROJECT_CONTRACT.md`, `TREE.md`, `shadow/` ou `Prometeus/wiki/` — nao aqui.
- Arvore grande no contexto principal: use `Agent` tool com Explore para pesquisa ampla. Mapa de agentes/skills globais usados vive em `shadow/AGENT-USAGE.md`.
- `candidate` sem gate: preencha o promotion gate em `shadow/WORK-LANES.md` e registre a transicao em `shadow/INCORPORATION-LOG.md`.
- Memoria: memoria automatica/global de ferramenta fica fora do repo. Memoria do projeto vive em `shadow/`, `AGENTS.md` e `Prometeus/wiki/`.
- Uso real de procedimento sem log: toda vez que `email-digest-4p`, `study-track-done` ou `sota-research-gate` rodar em uso real, registre linha em `shadow/EVIDENCE-LOG.md`.

### Iteracao

Se Claude Code errar um padrao do repo, adicione o caso a `Things that will bite you` em vez de explicar dentro da conversa. Este arquivo melhora com erros observados, nao com especulacao.
