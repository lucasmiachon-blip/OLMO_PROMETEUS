# 0003 — Privacy guard minimum

- Status: accepted
- Date: 2026-04-26
- Coauthor: Lucas + GPT-5.x-Codex (xhigh)
- Supersedes: (none — extracted from `shadow/SOTA-DECISIONS.md`)

## Context

Prometeus is a solo doctor-dev lab. Even without patient workflows, the repo needed explicit controls before any health, personal data, email, PDF, audio or image flow could enter the workspace.

## Decision

Keep four small privacy controls in `shadow/`: `DATA-CLASSIFICATION.md`, `PHI-CHECKLIST.md`, `THREAT-MODEL.md` and `INCIDENT-LOG.md`. They are guardrails, not a clinical data store. No PHI or sensitive personal data is versioned by default.

## Consequences

The lab can discuss privacy and health workflows without storing sensitive content. The cost is a small checklist burden. Any real patient-data workflow remains `blocked` until a private approved process exists.

## Rollback

Remove the four files and their harness requirements if Prometeus permanently stops touching health or personal-data workflows.

## Negative criterion

If the controls are not consulted before the first real health/personal-data request, treat them as decorative and simplify to a hard block in `AGENTS.md`.

## Sources

- HHS HIPAA Minimum Necessary Requirement: https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/minimum-necessary-requirement/index.html
- NIST SP 800-61 Rev. 3: https://csrc.nist.gov/pubs/sp/800/61/r3/final
- NIST AI RMF: https://www.nist.gov/itl/ai-risk-management-framework
- `shadow/SOTA-DECISIONS.md > Privacy guard minimum (2026-04-26)`
