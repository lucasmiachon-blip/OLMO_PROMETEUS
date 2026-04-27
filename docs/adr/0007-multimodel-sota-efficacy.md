# 0007 - Multimodel SOTA efficacy

- Status: accepted
- Date: 2026-04-27
- Coauthor: Lucas + GPT-5.x-Codex (xhigh)
- Supersedes: `shadow/SOTA-DECISIONS.md > Frontier orchestration objective (2026-04-27)` wording

## Context

Prometeus now explicitly targets education, research, EBM and direct LLM-assisted work. The previous wording put cost beside eval and privacy, which could be read as optimizing for cheapness instead of frontier effectiveness. The user decision is stronger: multimodel orchestration is the likely path, while orchestration SOTA is still evolving.

## Decision

Treat multimodel orchestration as the preferred operating hypothesis for frontier tasks. Prioritize current SOTA and measured efficacy against a human, procedural or single-model baseline. Cost remains a viability constraint, alongside latency, maintenance, privacy and rollback; it is not the primary criterion.

## Consequences

Model choice can combine OpenAI, Anthropic, Google and local models when a task benefits from specialization, critique, fan-out, handoff or HITL. No runtime is unlocked by this ADR: every composition still needs a bounded task, eval, privacy posture, rollback and negative criterion.

## Rollback

Revert V9 wording in `VALUES.md` and this ADR if multimodel orchestration does not beat simpler single-model/procedural baselines in real Prometeus evaluations.

## Negative criterion

If multimodel adds coordination noise without better outputs, reliability or auditability for a specific task, use the simpler model/procedure.

## Sources

- OpenAI Agents SDK, Agent Orchestration: https://openai.github.io/openai-agents-js/guides/multi-agent/
- OpenAI Agents SDK, Guardrails: https://openai.github.io/openai-agents-js/guides/guardrails/
- Anthropic, Building Effective Agents: https://www.anthropic.com/engineering/building-effective-agents
- Google ADK, Multi-Agent Systems: https://google.github.io/adk-docs/agents/multi-agents/
