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

## Karpathy 2026 LLM Wiki Pattern

Evolucao do pensamento Karpathy para second brain + AI:

- Raw e junk drawer. Clippings, daily, attachments entram sem organizar; a AI/LLM processa depois. O projeto ja implementa via `Prometeus/wiki/Clippings/`, `Prometeus/wiki/Daily/`, `Prometeus/wiki/Attachments/` ignorados.
- Prose > bullets para LLMs. LLMs preferem frases completas; bullets telegrapicos perdem sinal. Aplicacao local: `Prometeus/wiki/Notes` tende a prose para conceitos duraveis; `shadow/` mantem bullets porque e operacional e scanavel.
- First version small. Nao sobredesenhar schema; nao importar digital life em um fim de semana; nao overbuild search.
- Durabilidade. Markdown + folders + schemas explicitos; tool-agnostico; funciona com qualquer LLM hoje ou em dez anos.
- AI organiza cross-links. Deliberadamente NAO adotado por enquanto (viola anti-sprawl ate haver >=3 dores concretas onde curadoria manual falhou; revisar em `shadow/SOTA-DECISIONS.md > Blocked ate evidencia > C4`).

Links: [[Foundation Harness]], [[SOTA Research Gate]]

## Decisao local

O vault deve ser pequeno. Se crescer, a primeira acao e consolidar notas duplicadas, nao criar plugins ou pastas.

Notas conceituais em `wiki/Notes` devem ter >=2 wikilinks para outras notas (harness valida); senao viram espelhos de `shadow/` e sao candidatas a delete.
