---
type: note
status: experiment
source: legacy/2026-04-26/devmentor/vault/wiki/vault-anti-poluicao.md
incorporated: 2026-04-26
tags:
  - prometeus/concept
  - prometeus/principle
---

# Vault Anti-Pollution

Principio fundamental do [[Karpathy Wiki Pattern]]: o vault contem pensamento autentico do humano.

## Enunciado

> Your vault should contain your authentic thinking. Claude reads it for context but shouldn't pollute it with generated content. Keep Claude's outputs (plans, memory) in `~/.claude/`, and your knowledge in the vault proper.

(Isenberg + InternetVin, 2026 — regra numero 1 do workflow viral de second brain.)

## Implicacao no Prometeus

- **`private-learning/`** (gitignored): LLM pode ingerir/baixar fontes brutas aqui.
- **`Prometeus/wiki/Clippings`/`Daily`/`Attachments`**: LLM pode preencher templates; conteudo conceitual fica fora.
- **`Prometeus/wiki/Notes/`** (`status: experiment`): LLM escreve com `source` declarado e attribution; humano valida antes de virar `active`.
- **`Prometeus/wiki/Notes/`** (`status: active`): so humano escreve corpo conceitual proprio. LLM pode estruturar, sugerir links, mas nao redigir o pensamento.
- **`~/.claude/`** (fora do repo): outputs transient do LLM (plans, memoria de sessao, checkpoints).

## Por que importa

Um vault poluido por LLM-generated content perde a caracteristica que o torna util: ser o seu segundo cerebro, nao o cerebro do LLM. Se a nota vira compilacao, voce nao esta pensando, esta delegando.

O LLM e alavanca pra voce pensar mais rapido — nao substituto do pensamento.

## Aplicacao em "graduate"

Quando uma nota `experiment` vira `active`, a transicao e humana: o LLM pode propor estrutura, sugerir links, buscar conexoes — mas o corpo final e do humano. Se o humano pede "escreve a nota pra mim", a resposta correta e: "este e seu pensamento. Posso estruturar, nao escrever."

## Conexoes

- [[Karpathy Wiki Pattern]] — arquitetura 3 camadas
- [[Workspace Boundary]] — boundary canonico
- [[SOTA Dev Solo]] — humano no loop como regra
- [[Kepano and Karpathy Principles]] — sintese ja incorporada

## Fontes

Greg Isenberg + InternetVin, workflow viral 2026; Karpathy Gist abril 2026.
