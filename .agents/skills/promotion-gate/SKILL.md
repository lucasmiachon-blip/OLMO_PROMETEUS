---
name: promotion-gate
description: Decide whether an artifact should stay private, remain an experiment, or become a migration candidate. Use whenever the user asks what can move toward OLMO, what should stay isolated, how risky a pattern is, or how to separate personal material from reusable project assets.
---

# Promotion Gate

Use this skill to classify artifacts without contaminating the main repo.

## Lanes

- `private`: personal, daily, contextual, not reusable enough
- `experiment`: promising, but still unstable or under-validated
- `candidate`: reusable pattern with clear artifact, trigger, and rollback

## Minimum review questions

For every artifact, answer:

1. What is the artifact?
2. What problem does it solve?
3. What is the trigger for using it?
4. What evidence shows it works?
5. What could contaminate or break the main repo?
6. What is the rollback if promotion is wrong?

## Decision rules

- If it depends heavily on personal context, keep it `private`.
- If it works once but not repeatedly, keep it `experiment`.
- If it has repeatable value, explicit trigger, and rollback, it may become `candidate`.
- Human approval is still required before anything touches `OLMO`.

## Output format

Return a compact review with:

- lane
- rationale
- blockers
- next validation step

## File-aware behavior

If persistence is requested, update `shadow/WORK-LANES.md`.
Do not suggest direct migration into `C:\Dev\Projetos\OLMO` unless the user explicitly asks for that conversation.
