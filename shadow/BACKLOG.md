# Backlog

> Markdown view derivado de `internal/evolution/backlog.json` (canonical machine-readable). Sincronizar manualmente; CI futuro pode validar drift.

Status: experiment. Promove a candidate apos 3 ciclos reais usando este formato (priorizar P0, fechar item, dormancy detection).

Source canonical: [`internal/evolution/backlog.json`](../internal/evolution/backlog.json) — schema `prometeus.evolution.backlog.v1`. Este markdown e a view humana priorizada por tier+effort.

## Tiers

| Tier | Significado |
|---|---|
| P0 | alto valor, risco baixo, blocker para proxima fase |
| P1 | medio valor / medio risco |
| P2 | defer ate trigger explicito |
| Frozen | bloqueado por dependencia externa |
| Resolved | concluido; mantido para audit trail |
| Deferred | descartado por SOTA gate |

## Effort (rough estimate)

`XS <30min` | `S 30-90min` | `M 90-180min` | `L 180-360min` | `XL multi-PR ou >360min`

## Dormancy rule

Item sem update em >10 sessoes -> auto-rebaixar a Frozen no proximo PR de hygiene. Resgate exige novo trigger.

## Items ativos (sincronizado 2026-04-27)

### P0 — high value, low risk

| ID | Titulo | Effort | Risk | Cross-ref |
|---|---|---|---|---|
| `PR-2` | Privacy + governance consolidation: mesclar shadow/{DATA-CLASSIFICATION,PHI-CHECKLIST,THREAT-MODEL,INCIDENT-LOG} em docs/threat-model.md; quebrar SOTA-DECISIONS em ADRs 0002-0005; mover email-digest-4p+study-track-done para procedures/ | M | med | HANDOFF §8 P0 #1 |
| `EV-DIGEST` | Promover ou aposentar email-digest-4p+study-track-done — 0 entries em EVIDENCE-LOG ha 14+d | S | low | HANDOFF §8 P0 #2 |
| `EV-B2` | CI verde no remoto — gh run list confirma workflow; sem branch protection ate verde | S | med | HANDOFF §8 P2 #11; backlog.json EV-B2 |
| `LEGACY-MINE` | Inventarios legacy bloqueados (snapshot Linux + zips) — autorizar caso-a-caso | M | low | HANDOFF §8 P0 #3 |

### P1 — medium

| ID | Titulo | Effort | Risk | Cross-ref |
|---|---|---|---|---|
| `WIKI-PROMO` | Promocao das 4 wiki notes incorporadas: experiment -> active em 30d se citadas em decisao; senao HYGIENE delete | XS | low | HANDOFF §8 P1 #5 |
| `DEVMENTOR-3` | Material devmentor restante (4 skills + 1 setup-script + 2 raw articles) — bloqueado pelo local skills gate | L | med | HANDOFF §8 P1 #6 |
| `PR-3` | AGENTS.md SOTA + retire scaffolds: ~80li Toolchain First; mesclar FOUNDATION/PROJECT_CONTRACT/AGENT-USAGE em docs/runbook.md; retire shadow/ folder | XL | high | HANDOFF §8 P1 #7 |
| `EV-B4` | SOTA-DECISIONS split em ADR index | M | med | backlog.json EV-B4 |
| `EV-B5` | Comparar OLMO e OLMO_GENESIS como ramos paralelos; adaptar gates maduros/convergentes sem copiar runtime, hooks, skills ou dados clinicos | M | med | backlog.json EV-B5; SOTA-DECISIONS 2026-04-27 |

EV-B5 tarefas: T1 gate read-only de integridade/maturidade local; T2 wiring no `scripts/check.sh`; T3 producer-consumer para hook/gate novo; T4 sync leve backlog JSON/Markdown; T5 erro observado vira detector/teste antes de claim antifragile; T6 revisao em 30 dias para manter, simplificar ou remover.

### P2 — defer ate trigger explicito

| ID | Titulo | Trigger | Effort |
|---|---|---|---|
| `SHARED-V2` | OLMO design system | primeiro projeto aula real | XL |
| `GH-403` | gh run view --log-failed HTTP 403 | admin do repo ou simulacao local | XS |
| `BRANCH-PROT` | Branch protection em main | workflow verde | XS |
| `PHI-FLOW` | Aplicar PHI-CHECKLIST em fluxo real | primeiro caso clinico/dado pessoal | M |
| `PNPM-VITE` | pnpm+vite wired | primeiro projeto JS-heavy real (>=1 .tsx ou >=3 .ts) | S |
| `INSIGHTS` | Insights skill (auto-improvement 7d) | >=3 ciclos retrabalho mesmo padrao | M |
| `HOOK-L2` | Model-fallback advisory hook | >=2 incidentes Claude/Codex em 5min | S |
| `TRIANGULATION` | Triangulation engine + Truth Critic | >=3 sessoes onde Explore+Plan+manual paralelo falhou | XL |

### Frozen / Resolved

| ID | Status | Resolvido em |
|---|---|---|
| `EV-B1` | Resolved | 2026-04-25 (backlog/risk/review) |
| `EV-B3` | Resolved | 2026-04-25 (privacy minimum) |

## Governance

- 1 item por linha; ID entre backticks; titulo livre.
- `effort` + `risk` + cross-ref obrigatorios em P0/P1.
- Mover entre tiers via PR; registrar transicao em `shadow/INCORPORATION-LOG.md` se afeta evidencia.
- Cap: 30 items max em P0+P1 combinados; >30 obriga consolidacao em PR de hygiene.
- Reabrir Resolved/Deferred exige novo trigger documentado.

## Cross-refs

- Source canonical: `internal/evolution/backlog.json`
- Risk register: `internal/evolution/risk-register.json`
- Review cadence: `internal/evolution/review.json`
- Plans archive: `shadow/PLAN-ARCHIVE/`
- ADRs: `docs/adr/`
- KBP: `shadow/KBP.md`
- Handoff (estado/contexto): `shadow/HANDOFF.md`

Coautoria: Lucas + Claude Opus 4.7 (1M)
