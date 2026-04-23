---
type: note
status: active
source: shadow/FOUNDATION.md
tags:
  - prometeus/system
---

# Foundation Harness

O harness e a camada minima de regressao local.

Comando:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1
```

Ele valida:

- boundary fundamental;
- arquivos essenciais;
- Obsidian vault basico com a raiz nomeada `OLMO_PROMETEUS`;
- evals JSON;
- ausencia de referencias antigas;
- ausencia de segredos obvios;
- ignores privados;
- `max_depth = 1`;
- estado Git.

Nao substitui julgamento. Evita regressao boba.

Links:

- [[Workspace Boundary]]
- [[Artifact]]
