# 0004 — Procedure before agent runtime

- Status: accepted
- Date: 2026-04-25
- Coauthor: Lucas + GPT-5.x-Codex (xhigh)
- Supersedes: (none — extracted from `shadow/AGENT-MODULES.md` and `shadow/SOTA-DECISIONS.md`)

## Context

Agent frameworks, skills, hooks and MCPs are useful at scale, but Prometeus is a small low-risk lab. Runtime before evidence would add state, privacy surface and debugging cost before proving a local problem.

## Decision

Use the ladder `prompt -> procedure -> module contract -> runner manual -> agent real`. A real agent/runtime requires an operational procedure, at least three real evidence entries, eval/guardrails, rollback and explicit human approval.

## Consequences

Most improvements stay as Markdown, Bash or harness checks. This preserves reversibility and privacy. The trade-off is slower adoption of new agent tooling, by design.

## Rollback

Create a superseding ADR with a specific runtime, state model, tools, guardrails, eval dataset, rollback and privacy plan.

## Negative criterion

If three real failures show a manual procedure cannot handle durable state, HITL, tracing or coordination, evaluate runtime in a new ADR.

## Sources

- Anthropic, Building Effective Agents: https://www.anthropic.com/research/building-effective-agents/
- OpenAI Agents SDK guardrails: https://openai.github.io/openai-agents-python/guardrails/
- Google ADK multi-agent systems: https://google.github.io/adk-docs/agents/multi-agents/
- `shadow/AGENT-MODULES.md`
- `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`
