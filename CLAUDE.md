@AGENTS.md

## Claude Code

Regra fundamental: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

### Commands

```
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1           # harness local
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1 -Strict   # harness + working tree limpo
```

### What this is

Laboratorio paralelo solo, baixo risco. Valida fluxo, digest, estudo, wiki e gates de promocao. `AGENTS.md` e a fonte de verdade; este arquivo e um adaptador fino.

### Things that will bite you

- Write externo nao autorizado: qualquer edit fora de `C:\Dev\Projetos\OLMO_PROMETEUS` e proibido. Se a tarefa exigir, pare e peca autorizacao citando caminho e acao exata.
- Runtime scaffolds proibidos sem gate: `.claude/agents/`, `.claude/hooks/`, `.claude/commands/`, `agents/`, `subagents/`, `skills/`, `hooks/`, `playground/`.
- `.claude/skills/` e aceito desde 2026-04-23 como casa de skills reais promovidas de procedures `operational` (ver `shadow/AGENT-USAGE.md > Local skills contract`). Cada subdir precisa de `SKILL.md` valido.
- `.claude/settings.local.json`: aceito como state local do harness; fica em `.gitignore` e `.claudeignore`, nunca versionado.
- Duplicar politica: se precisar de regra nova, va para `AGENTS.md`, `PROJECT_CONTRACT.md`, `TREE.md`, `shadow/` ou `Prometeus/wiki/` — nao aqui.
- Arvore grande no contexto principal: use `Agent` tool com Explore para pesquisa ampla. Mapa de agentes/skills globais usados vive em `shadow/AGENT-USAGE.md`.
- `candidate` sem gate: preencha o promotion gate em `shadow/WORK-LANES.md` e registre a transicao em `shadow/INCORPORATION-LOG.md`.
- Memoria: `C:\Users\lucas\.claude\projects\...\memory\` e intencionalmente vazia. Memoria do projeto vive em `shadow/`, `AGENTS.md` e `Prometeus/wiki/`.
- Uso real de procedimento sem log: toda vez que `email-digest-4p`, `study-track-done` ou `sota-research-gate` rodar em uso real, registre linha em `shadow/EVIDENCE-LOG.md`.

### Iteracao

Se Claude Code errar um padrao do repo, adicione o caso a `Things that will bite you` em vez de explicar dentro da conversa. Este arquivo melhora com erros observados, nao com especulacao.
