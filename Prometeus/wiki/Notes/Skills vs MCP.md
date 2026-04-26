---
type: note
status: experiment
source: legacy/2026-04-26/devmentor/vault/wiki/skills-vs-mcp.md
incorporated: 2026-04-26
tags:
  - prometeus/concept
  - prometeus/llmops
---

# Skills vs MCP

Duas formas de dar capacidade a um agent LLM. Diferem em quando o schema e carregado e quem decide ativar.

## MCP (passivo, upfront)

Carrega schema de todas as tools no inicio da sessao. Agent decide chamar tool em runtime. Util quando se quer a mesma tool disponivel em multiplos clientes (Claude Desktop, Cursor, etc) com auth unificada.

Problema: consome context window antes de qualquer acao. Ver [[CLI vs MCP]].

## Agent Skills (ativo, on-demand)

Pasta com `SKILL.md` contendo SOP em markdown: quando ativar, como executar, exemplos. Agent escaneia nomes/descricoes no startup (barato), carrega `SKILL.md` completo so quando relevante.

Vantagens:

- Token cost amortizado — so a skill necessaria e carregada.
- Versionavel em git (skill e markdown, nao config).
- Compartilhavel (clone repo de skills de outro dev).
- Especifico do projeto (skills diferentes para projetos diferentes).

## Quando usar cada

- **Skill**: workflow complexo, multi-step, especifico do projeto.
- **MCP**: integracao com servico externo que ja tem server MCP maduro (Figma, Linear, Slack).
- **CLI**: tool unix madura, bem conhecida do modelo (git, docker, grep).

Setups de 2026 misturam os tres. Ver [[CLI vs MCP]].

## Decisao Prometeus

Skills locais (`. claude/skills/`) bloqueadas ate procedure atingir `operational` com >=3 entradas em `shadow/EVIDENCE-LOG.md` (ver `shadow/SOTA-DECISIONS.md > Local skills gate (2026-04-23)`). MCP proprio bloqueado por padrao.

A escada permitida e: procedimento -> modulo documentado -> runner manual -> agente real (ver [[Agent Module Encapsulation]]).

## Conexoes

- [[CLI vs MCP]] — comparacao tool surface
- [[Agent Module Encapsulation]] — escada de promocao
- [[Agent Usage Map]] — mapa de agentes/skills usados
- [[SOTA Research Gate]] — gate antes de mudar arquitetura

## Fontes

Padrao Agent Skills (Anthropic, 2025); kepano/obsidian-skills (CEO Obsidian, 2026).
