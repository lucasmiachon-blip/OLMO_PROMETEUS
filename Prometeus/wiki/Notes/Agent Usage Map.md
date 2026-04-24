---
type: note
status: active
source: shadow/AGENT-USAGE.md
tags:
  - prometeus/system
  - prometeus/agents
---

# Agent Usage Map

`shadow/AGENT-USAGE.md` mapeia como este projeto usa agents/skills/subagents globais do Claude Code sem criar scaffold local.

Substitui a tentacao de criar `.claude/agents/` local: toda necessidade de agente e coberta por recurso global (`Explore`, `Plan`, `/dream`, `/schedule`, `/code-review`) + procedimento em `shadow/`.

Contem tambem o SOTA agent contract para este projeto: orquestrador-worker, parallelization, evaluator-optimizer, context discipline, memory policy, tool minimalism.

Desde 2026-04-23, o arquivo tambem define o Local skills contract: regras para quando um procedimento `operational` pode virar skill em `.claude/skills/<name>/SKILL.md`.

Relacao com [[Agent Module Encapsulation]]: Agent Module e o eixo tecnico (procedimento -> modulo -> runner -> agente); Agent Usage Map e a operacionalizacao local (como usar recursos globais e como promover skills).

Links: [[Agent Module Encapsulation]], [[SOTA Research Gate]], [[Evidence Log]]
