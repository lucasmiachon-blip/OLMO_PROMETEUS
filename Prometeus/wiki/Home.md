---
type: home
status: active
tags:
  - prometeus/home
  - prometeus/graph
---

# Prometeus Wiki

Este vault Obsidian se chama `Prometeus` e mora dentro do repo isolado `OLMO_PROMETEUS`. A wiki operacional mora em `wiki/` e usa uma abordagem bottom-up: notas pequenas primeiro, organizacao depois.

Direcao atual: second brain graph-first. O Graph View deve ser grande e vivo; Canvas e mapa curado opcional.

Comece por:

- [[Prometeus Vault]]
- [[Second Brain Atlas]]
- [[Graph Operating System]]
- [[Knowledge Lifecycle]]
- [[SOTA Research Gate]]
- [[Agent Module Encapsulation]]
- [[Prometeus.canvas|Mapa visual em Canvas]]
- [[Prometeus Wiki]]
- [[Foundation Harness]]
- [[Workspace Boundary]]
- [[Email Digest System]]
- [[Email Triage]]
- [[Study Track System]]
- [[Promotion Gate]]
- [[Kepano and Karpathy Principles]]

## Regra de uso

- Captura crua e pessoal fica em `private-learning/` no repo, fora da wiki versionada.
- `wiki/Clippings/` e `wiki/Daily/` sao buffers locais ignorados pelo Git.
- Uma nota so entra no wiki quando muda comportamento futuro.
- Qualquer coisa migravel passa por [[Promotion Gate]].
- Nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

## Abrir

No Obsidian, abra `C:\Dev\Projetos\OLMO_PROMETEUS\Prometeus`.

Nao abra a raiz `OLMO_PROMETEUS` como vault, senao o nome e a arvore ficam errados.

## Graph View

Use o Graph View como interface principal do second brain. O filtro padrao deve ser:

```text
path:wiki
```

- `Atlas`: dourado.
- `Home`: dourado.
- `Categories`: laranja.
- `Notes`: verde-azulado.
- `References`: azul.
- `Templates`: cinza.
- `Buffers`: amarelo.

## Canvas

Use [[Prometeus.canvas|Prometeus Canvas]] como vitrine curada. Ele e manual e bonito, mas nao substitui o grafo.

Se o Graph abrir cinza, confira `Groups`. O Obsidian pode regravar `graph.json` enquanto o Graph esta aberto; nesse caso, reabra o vault e aplique o preset de [[Graph Operating System]].

## Proximo ciclo

1. Capturar entrada.
2. Se for mudanca estrutural, passar por [[SOTA Research Gate]].
3. Sintetizar em artefato.
4. Linkar a um sistema ou conceito.
5. Rodar `scripts/check.ps1`.
6. Decidir se fica private, experiment ou candidate.

Coautoria: Lucas + GPT-5.4 (Codex)
