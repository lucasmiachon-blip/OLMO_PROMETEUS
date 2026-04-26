@AGENTS.md

## Codex

Regra fundamental: nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.

### Commands

```bash
./scripts/check.sh
./scripts/check.sh --strict
./scripts/evolve.sh next
```

### What this is

Codex e o executor/auditor local principal deste repo. `AGENTS.md` e a fonte de verdade; este arquivo e um adaptador fino.

Codex pode ser executor de uma rodada, mas nunca junto com Claude Code no mesmo escopo de edicao.

Be terse.

### Things that will bite you

- Use o maior reasoning effort disponivel; `xhigh` quando suportado.
- Write externo e bloqueado. Read externo de sibling/legado exige autorizacao humana explicita com caminho e motivo.
- Se o cwd nao for `/home/lucasmiachon/projects/OLMO_PROMETEUS`, corrija antes de editar.
- Nao criar `.codex/`, agents, hooks, MCP, skills ou runtime local sem gate em `shadow/SOTA-DECISIONS.md` e evidencia em `shadow/EVIDENCE-LOG.md`.
- Duplicar politica e drift: regra nova vai para `AGENTS.md`, `PROJECT_CONTRACT.md`, `TREE.md`, `shadow/` ou `Prometeus/wiki/`, nao aqui.

Coautoria: Lucas + GPT-5.x-Codex (xhigh)
