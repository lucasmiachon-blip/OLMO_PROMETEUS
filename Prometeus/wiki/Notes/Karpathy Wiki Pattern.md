---
type: note
status: experiment
source: legacy/2026-04-26/devmentor/vault/wiki/karpathy-wiki-pattern.md
incorporated: 2026-04-26
aliases:
  - LLM Wiki Pattern
tags:
  - prometeus/concept
  - prometeus/knowledge-management
---

# Karpathy Wiki Pattern

Pattern para second brain onde o LLM faz o trabalho bracal (compilacao, cross-reference, bookkeeping) e o humano cura fontes e escreve permanent notes autorais.

## Arquitetura em 3 camadas

1. **Raw** — fontes brutas imutaveis. No Prometeus: `private-learning/` (gitignored) ou `Prometeus/wiki/Clippings/`, `Prometeus/wiki/Daily/`, `Prometeus/wiki/Attachments/` (gitignored excepto README).
2. **Wiki** — LLM-maintained, com `confidence: low|medium|high`. No Prometeus: `Prometeus/wiki/Notes/` quando o conteudo e referencia/conceito; harness exige >=2 wikilinks para nao virar espelho de `shadow/`.
3. **Zettel** — pensamento autentico do humano, graduado do wiki. No Prometeus: notas em `Prometeus/wiki/Notes/` com `status: active` e prose autoral; LLM nao escreve corpo (ver [[Vault Anti-Pollution]]).

## Por que funciona

O maior custo de um Zettelkasten classico nao e pensar — e manter. Cross-references desatualizados, resumos stale, links quebrados. LLM nao cansa de fazer bookkeeping. Humano fica livre pra curadoria e insight.

Regra critica: o vault contem pensamento autentico, nao output bruto de LLM. Wiki layer e excecao (marcada com confidence); zettel nunca e.

## Por que nao RAG

Karpathy mantem 100+ articles, 400K palavras, sem vector DB. Context window moderno (200K-1M) + grep + filesystem resolve ate essa escala. RAG entra quando corpus > 100 artigos e queries precisam precision retrieval — nao discovery (discovery e o graph view do Obsidian).

## Tres operacoes core

- **ingest** — raw -> wiki article (ou atualiza existente)
- **query** — busca + sintese
- **lint** — health check (links quebrados, orfaos, contradicoes, stale)

No Prometeus, ingest/lint ainda nao sao skills (bloqueado pelo local skills gate ate procedure operational; ver `shadow/SOTA-DECISIONS.md > Local skills gate`).

## Conexoes

- [[Vault Anti-Pollution]] — regra do pensamento autentico
- [[Foundation Harness]] — harness valida wiki health
- [[SOTA Dev Solo]] — principios solo
- [[Kepano and Karpathy Principles]] — sintese alta-nivel ja incorporada

## Fontes

Andrej Karpathy, GitHub Gist abril 2026.
