---
type: note
status: active
source: shadow/SOTA-DECISIONS.md
aliases:
  - SOTA Gate
tags:
  - prometeus/system
  - prometeus/sota
---

# SOTA Research Gate

O SOTA Research Gate impede mudanca estrutural por entusiasmo.

Antes de mudar arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao:

1. Auditar o estado local.
2. Pesquisar fontes primarias atuais.
3. Registrar decisao curta.
4. Explicitar trigger, nao-trigger, risco, custo e rollback.
5. Definir criterio negativo: quando nao aplicar.
6. Editar apenas se a pesquisa justificar.
7. Rodar [[Foundation Harness]] antes de commit.

## Criterio negativo

Se a pratica externa exige escala, equipe, CI, produto, permissao ou runtime que o Prometeus nao tem, nao copiar. Reduzir para procedimento pequeno ou rejeitar.

## Onde registrar

- Decisao SOTA: `shadow/SOTA-DECISIONS.md`.
- Contrato de modulo: `shadow/AGENT-MODULES.md`.
- Gate de migracao: `shadow/INCORPORATION-LOG.md`.
- Nota duravel: `Prometeus/wiki/Notes/`.

## Links

- [[Agent Module Encapsulation]]
- [[SOTA Dev Solo]]
- [[Promotion Gate]]
- [[Workspace Boundary]]
- [[Project Log]]

