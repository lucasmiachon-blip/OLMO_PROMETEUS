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
- Obsidian vault basico nomeado `Prometeus`;
- adaptadores `CLAUDE.md` e `GEMINI.md`;
- ausencia de scaffolds fantasmas;
- contratos de procedimentos e SOTA gate;
- wikilinks e aliases do Obsidian;
- referencias de arquivos no Canvas;
- ausencia de referencias antigas;
- ausencia de segredos obvios;
- ignores privados;
- estado Git.

Nao substitui julgamento. Evita regressao boba.

Links:

- [[Workspace Boundary]]
- [[SOTA Research Gate]]
- [[Agent Module Encapsulation]]
- [[Artifact]]
