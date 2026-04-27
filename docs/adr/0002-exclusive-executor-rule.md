# 0002 — Exclusive executor rule

- Status: accepted
- Date: 2026-04-26
- Coauthor: Lucas + GPT-5.x-Codex (xhigh)
- Supersedes: (none — extracted from `shadow/SOTA-DECISIONS.md`)

## Context

Codex, Claude Code and Gemini can all contribute to Prometeus, but simultaneous editing by multiple executors creates authorship drift, hidden assumptions and merge risk. This repo is a small solo lab; clarity beats parallel write throughput.

## Decision

Choose one executor per edit/orchestration round: Codex or Claude Code. Gemini is research/contrapoint only and does not write. A second model can review in a separate round, after the current executor's diff is auditable.

## Consequences

Edits have clearer ownership and rollback. The cost is less parallel implementation. Research fanout remains allowed when read-only and scoped. If two tools touch the same scope, stop, audit the diff and choose one source of truth before continuing.

## Rollback

Remove the rule from `AGENTS.md`, `PROJECT_CONTRACT.md` and `shadow/FOUNDATION.md`; record a replacement ADR before allowing co-editing again.

## Negative criterion

If exclusive execution blocks real work repeatedly and review catches no authorship/merge problems for 30 days, replace with a narrower conflict rule.

## Sources

- Anthropic, Building Effective Agents: https://www.anthropic.com/research/building-effective-agents/
- OpenAI Codex: https://openai.com/codex
- `shadow/SOTA-DECISIONS.md > Exclusive executor rule (2026-04-26)`
