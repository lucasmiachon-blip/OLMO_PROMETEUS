---
type: reference
status: active
tags:
  - prometeus/reference
  - prometeus/sota
---

# Kepano and Karpathy Principles

Esta nota resume o que foi incorporado dos repos lidos para ajustar o vault.

## Kepano / Obsidian

Fontes:

- `kepano/kepano-obsidian`: https://github.com/kepano/kepano-obsidian
- `kepano/obsidian-skills`: https://github.com/kepano/obsidian-skills
- `kepano/defuddle`: https://github.com/kepano/defuddle

Principios aplicados:

- Bottom-up primeiro, taxonomia depois.
- Vault como arquivos Markdown locais.
- Pastas simples: `Notes`, `References`, `Daily`, `Templates`, `Attachments`, `Clippings`, `Categories`.
- Usar Obsidian Markdown: wikilinks, properties e templates.
- Clippings devem virar Markdown limpo antes de entrar na wiki.

## Karpathy

Fontes:

- `karpathy/nanoGPT`: https://github.com/karpathy/nanoGPT
- `karpathy/build-nanogpt`: https://github.com/karpathy/build-nanogpt
- `karpathy/nanochat`: https://github.com/karpathy/nanochat
- `karpathy/micrograd`: https://github.com/karpathy/micrograd
- `karpathy/llm.c`: https://github.com/karpathy/llm.c

Principios aplicados:

- Simples, legivel, hackable.
- Escopo explicitamente limitado.
- Evolucao em passos pequenos e commits limpos.
- Harness cobre o fluxo minimo.
- Separar referencia educacional de uso operacional.

## Decisao local

O vault deve ser pequeno. Se crescer, a primeira acao e consolidar notas duplicadas, nao criar plugins ou pastas.
