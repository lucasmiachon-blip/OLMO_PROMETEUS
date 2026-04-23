---
name: digest-4p
description: Create or refresh a digest in exactly 4 paragraphs from inbox notes, copied emails, rough bullet dumps, or mixed updates. Use this whenever the user asks for a digest, morning brief, executive summary, inbox synthesis, or wants messy updates turned into a short operational readout.
---

# Digest 4P

Use this skill to turn noisy inputs into a stable 4-paragraph operational digest.

## Inputs

Accept any of these:

- pasted emails
- bullet lists
- meeting notes
- dashboard notes
- rough daily updates
- Gmail threads labelled `Prometeus/Processar` or `Prometeus/Alta`

If the input is fragmented, first cluster it by theme, decision, blocker, or next action.

## Gmail label contract

Gmail is only an intake queue. Do not use Gmail labels as the durable taxonomy.

- `Prometeus/Processar`: normal queue; worth digesting.
- `Prometeus/Alta`: priority flag; process before normal queue.
- `Prometeus/Ruido`: ignore except for noise/source pattern detection.
- `Prometeus/Digerido`: only after a persistent artifact exists.

Never mark or recommend marking an email as `Prometeus/Digerido` until a digest, note, or Vault artifact exists with date, source/thread reference, and the 4-paragraph synthesis.

## Output contract

Return exactly 4 paragraphs.

- Paragraph 1: context and what changed.
- Paragraph 2: the most important signals, decisions, or movements.
- Paragraph 3: risks, blockers, ambiguity, or opportunity.
- Paragraph 4: next actions, priorities, or what deserves attention tomorrow.

Keep each paragraph short and dense. Prefer 2 to 4 sentences per paragraph.
Default to Portuguese unless the user clearly asks for another language.

## Workflow

1. Remove noise and duplicates.
2. Group related items before writing.
3. Preserve concrete names, dates, and deadlines when they matter.
4. Avoid copying raw email tone unless the user asks for it.
5. If something is uncertain, state it as uncertainty instead of pretending confidence.
6. If working from Gmail, process `Prometeus/Alta` first, then `Prometeus/Processar`.
7. Treat `Prometeus/Digerido` as a post-persistence state, not as a reading status.

## File-aware behavior

If the user wants persistence:

- update or draft content for `private-learning/dashboard.html` when the digest is part of the daily cockpit;
- update `shadow/EMAIL-DIGEST-4P.md` when the task is about the reusable method, not the daily content.
- create or update a dated artifact before any email can be considered `Prometeus/Digerido`.

Do not create extra sections unless the user asks. The main deliverable is the 4-paragraph digest.
