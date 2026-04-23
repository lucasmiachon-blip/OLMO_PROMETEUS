---
type: note
status: active
source: AGENTS.md
tags:
  - prometeus/system
  - prometeus/boundary
---

# Workspace Boundary

Regra fundamental: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

Proibido sem autorizacao explicita:

- criar arquivo fora daqui;
- editar arquivo fora daqui;
- deletar ou mover arquivo fora daqui;
- sincronizar com repositorios siblings;
- automatizar write externo;
- tocar `C:\Dev\Projetos\OLMO`.

Se uma tarefa exigir write externo, parar e pedir autorizacao citando caminho e acao exata.
