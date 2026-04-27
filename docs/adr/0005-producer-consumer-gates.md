# 0005 — Producer-consumer gates

- Status: accepted
- Date: 2026-04-27
- Coauthor: Lucas + GPT-5.x-Codex (xhigh)
- Supersedes: (none — extracted from EV-B5 T3)

## Context

Prometeus imported the useful part of OLMO maturity work: gates and hooks should prove who emits a signal, who consumes it and what happens on failure. Without that, a gate is easy to add and hard to justify.

## Decision

Every new hook, gate, check or detector must have a row in `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md > Producer-Consumer Matrix` before entering `scripts/check.sh`, `.claude/settings.local.json`, CI or an operational procedure.

## Consequences

The harness can reject theatrical controls and preserve a local consumer for each detector. The cost is one small matrix row per gate. Existing rows cover check, integrity, boundary guard, ask-write and self-evolution workflow.

## Rollback

Remove the matrix requirement from `scripts/integrity.sh` and keep only direct harness checks if it becomes noise.

## Negative criterion

If a producer-consumer row has no real failure/action for 30 days and never informs a decision, simplify or remove the gate.

## Sources

- Google SRE, Production Services Best Practices: https://sre.google/sre-book/service-best-practices/
- Anthropic, Building Effective Agents: https://www.anthropic.com/research/building-effective-agents/
- `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md > Producer-Consumer Matrix`
- `shadow/EVIDENCE-LOG.md > producer-consumer-gate`
