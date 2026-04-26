---
name: decision-protocol
description: Protocolo Lucas <-> Agente para mudancas nao-triviais. Agente propoe, Lucas decide, decisao registrada.
trigger: mudanca de boundary, executor rule, gate, harness, hook, MCP, memoria, ADR; mudanca de contrato em AGENTS.md; alteracao que afeta 3+ arquivos versionados em cascata
non-trigger: bug fix, typo, edit cosmetico, doc rename, lint/format, atualizacao de versao de dependencia
source: /mnt/c/Dev/Projetos/OLMO/content/aulas/shared/decision-protocol.md (read-only, autorizado 2026-04-26; OLMO intocavel)
status: experiment
owner: Lucas
---

# Decision Protocol — Lucas <-> Agente

Adaptado de OLMO com melhoras para perfil solo med dev: removido escopo "slides/aulas"; ampliado para mudancas estruturais; alinhado com `AGENTS.md > Operating Principles` ("decisao curta vence relatorio longo").

## Quando usar (trigger)

- Mudanca em boundary fundamental (`AGENTS.md > Fundamental Boundary`).
- Mudanca em executor rule, sampling, gate, harness, hook, MCP, memoria.
- Adicao de skill, agent, runtime, MCP server.
- Alteracao que afeta 3+ arquivos versionados em cascata.
- ADR novo (proposed -> accepted).

## Nao usar (non-trigger)

- Bug fix mecanico, typo, doc cosmetico.
- Lint, format, dependency bump.
- Single-file edit sem impacto contratual.

## Formato da proposta (agente -> Lucas)

```
## DR-NNN: <titulo curto>

**Escopo:** <arquivos/secoes afetados>
**Estado:** PROPOSTA | APROVADO | REJEITADO | ALTERNATIVA

### Proposta
<O que vai mudar, em <=4 frases>

### Justificativa
<Por que. Referencia a SOTA-DECISIONS, EVIDENCE-LOG, fonte primaria, ou principio de design>

### Trade-off
<O que piora se fizer. O que piora se NAO fizer>

### Rollback
<Comando concreto para reverter>

### Alternativa
<Opcao B, se houver>
```

## Resposta (Lucas -> agente)

| Estado | Significado | Acao do agente |
|---|---|---|
| AGREE | Prosseguir como proposto | Implementar e registrar no commit + ADR/EVIDENCE-LOG |
| DISAGREE | Nao fazer | Registrar razao em EVIDENCE-LOG como licao aprendida |
| RISK | Preocupacao especifica | Mitigar e re-propor |
| BETTER OPTION | Lucas propoe alternativa | Implementar a alternativa |

## Registro

- Decisoes APROVADAS: registrar no commit message + linha em `shadow/EVIDENCE-LOG.md` + (se ADR-worthy) novo arquivo em `docs/adr/NNNN-*.md`.
- Decisoes REJEITADAS: registrar em `shadow/EVIDENCE-LOG.md` como licao aprendida, com razao curta.

## Mini-evals

| Caso | Esperado |
|---|---|
| Agente propoe novo hook PreToolUse | DR-NNN com trigger, justificativa, rollback (revert do commit + restaurar `.claude/settings.local.json`), criterio negativo |
| Agente sugere uv como default global sem projeto Python | RISK ou DISAGREE: aguarda projeto real, conforme ADR de package adoption |
| Agente quer migrar shadow/ para docs/ inteiro num commit | RISK: split em PRs pequenos reversiveis |

## Criterio negativo

Se DR-NNN virar ritual aplicado a edits triviais, simplificar trigger ou descartar.
