---
name: study-track-done
description: Maintain or update a visual study track with honest `done` criteria. Use whenever the user asks for study planning, progress tracking, visual learning lanes, done definitions, or wants topics moved between captured, studying, applying, and done.
---

# Study Track Done

Use this skill to keep study progress visible without inflating completion.

## Status vocabulary

Use only these states unless the user asks otherwise:

- `capturado`
- `em-estudo`
- `aplicando`
- `done`

## Done rule

Only mark something as `done` when at least one of these is true:

- the user can explain it cleanly;
- the user applied it in a concrete artifact;
- the user repeated it enough that it is no longer fragile.

If evidence is weak, keep the item in `em-estudo` or `aplicando`.

## Workflow

1. Identify the topic, current state, evidence, and next step.
2. Move topics conservatively.
3. Preserve unfinished edges instead of hiding them.
4. Prefer a compact visual table when presenting progress.
5. Keep one next action per item when possible.

## File-aware behavior

If persistence is requested:

- update `shadow/STUDY-TRACK-DONE.md` for the reusable structure;
- update `private-learning/dashboard.html` when the visual cockpit should reflect the current state.

When writing prose, explain why an item is or is not `done`.
