# Evidence Log

Objetivo: transformar frases como "3 usos reais" em dado auditavel.

Toda vez que um procedimento em `shadow/` rodar em uso real, registrar uma linha. Vale sintese, nao transcricao. A entrada deve caber em 30 segundos de escrita.

## Regra

- uma linha por uso real;
- `Input` e `Output` referenciam artefato persistente (thread id, arquivo, commit, nota wiki), nao descricao livre;
- `Observacao` registra o que surpreendeu ou quebrou;
- `Proximo` e uma acao concreta, nao intencao.

## Schema

| Data | Procedure | Input | Output | Observacao | Proximo |
| --- | --- | --- | --- | --- | --- |
| 2026-04-25 | project-hygiene | Consolidacao final do workspace Prometeus | vault `Prometeus`, lab `lab/wiki-graph-lab/`, diretorio legado ausente | Estado final confirmou survivor unico; remoto Git ainda nao configurado | Configurar remote antes do proximo pedido de push |

## Entradas

| Data | Procedure | Input | Output | Observacao | Proximo |
| --- | --- | --- | --- | --- | --- |
| 2026-04-24 | sota-research-gate | HEAD pre-auditoria (98c6b64) | commits 1ea1dea, 0e6177d, b3bbdb4 + 4 linhas em `shadow/INCORPORATION-LOG.md` | EVIDENCE-LOG vazio validou o gate negativo: 4 labels em candidate/operational estavam aspiracionais. Auditor encontrou >=3 criticos e >=3 altos sem inflar escopo. | Rodar email-digest-4p e study-track-done em uso real >=3x ate 2026-05-22; se <3 entradas por procedure, rebaixar/simplificar rubrica |
| 2026-04-24 | sota-research-gate | HEAD pos-rodada-I (6f0b85f) | commits 51d59a7 (gate wording), cf78eec (skill sprawl harness check), 9ee66dd (coauthorship) | Rodada II fechou findings A3, pre-mortem #2 e B1. M3 (wiki <2 wikilinks) confirmado como falso positivo: auditor contou linhas via grep, harness conta matches e ja passava. | Primeiro uso real de digest/study deve virar entry 3 em EVIDENCE-LOG |
| 2026-04-25 | sota-research-gate | Pedido do usuario: erro deve virar reporte com acao profissional e decisao fazer/nao fazer | `AGENTS.md`, `shadow/FOUNDATION.md`, `shadow/SOTA-DECISIONS.md` | O workspace inicial informado estava stale; localizar `OLMO_PROMETEUS` antes de escrever evitou memoria no repo errado. | Rodar harness e usar o protocolo no proximo erro material |
| 2026-04-25 | sota-research-gate | Pesquisa SOTA: Claude memory/skills/subagents, OpenAI Agents, LangGraph, CrewAI, Paperclip, privacidade medico solo | `AGENTS.md`, `shadow/AGENT-USAGE.md`, `shadow/FOUNDATION.md`, `shadow/SOTA-DECISIONS.md` | Pesquisa sustentou padroes operacionais, mas nao justificou dependencia/runtime novo no estado atual do Prometeus. | Rodar harness; usar overlay para decidir qualquer pedido futuro de agentes/skills/orquestracao |
| 2026-04-25 | maturity-check | Pedido do usuario: maturidade deve ser executavel, nao Markdown | `scripts/maturity.ps1`, `scripts/check.ps1`, `AGENTS.md`, `README.md`, `TREE.md`, `shadow/FOUNDATION.md` | Baseline mostrou maturidade forte em fronteira/anti-sprawl, mas fraca em backlog, CI, privacidade operacional, metricas, release e incidentes; agora o harness executa o maturity check. | Aplicar Batch 1: backlog minimo, risk register, DoR/DoD e weekly review |
| 2026-04-25 | self-evolution-loop | Pedido do usuario: projeto deve evoluir sem pedido manual e ter estrutura interna | `scripts/evolve.ps1`, `internal/evolution/`, `.github/workflows/self-evolution.yml`, `scripts/check.ps1` | Loop ficou read-only: checa, falha e mostra proximo batch sem auto-write/commit/push; estrutura interna guarda backlog, riscos e cadencia. | Validar primeira execucao do workflow no GitHub e decidir branch protection |
| 2026-04-25 | sota-research-gate | Pedido do usuario: ler OLMO read-only, pesquisar SOTA independente e aplicar aqui orquestracao/harness/antifragile | `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`, `shadow/AGENT-MODULES.md`, `scripts/check.ps1` | SOTA externo convergiu em simplicidade, eval, tracing, guardrails e postmortem; OLMO trouxe bons padroes, mas nao deve ser copiado como runtime. | Usar o gate E2E na proxima mudanca estrutural antes de criar qualquer runtime multi-agent |
| 2026-04-25 | boundary-guard | Pedido do usuario: erro de workspace stale ja ocorreu dezenas de vezes | `scripts/guard-olmo-write-hook.ps1`, `scripts/test-olmo-boundary-guard.ps1`, `scripts/check.ps1` | Guard agora bloqueia workspace legado ROADMAP e harness falha se ele reaparecer. | Manter qualquer leitura externa explicitamente read-only; se warning reaparecer, corrigir ambiente antes de editar |
| 2026-04-25 | antifragile-learning | Pedido do usuario: provar que erro injetado e detectado e vira melhoria | `scripts/test-antifragile-learning.ps1`, `scripts/check.ps1`, `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md` | Aprendizado foi definido como cadeia verificavel: injecao -> deteccao -> evidencia -> teste/regra futura; fault injection agora usa catalogo seguro com `-Scenario`, `CASE_edges` e `-Seed`. | Rodar o learning-loop em toda mudanca de guard, harness ou protocolo de erro |
| 2026-04-25 | handoff-hydration | Pedido do usuario: tudo documentado para janela hidratada com cross refs, sem MD avulso | `shadow/HANDOFF.md`, `README.md`, `TREE.md`, `shadow/FOUNDATION.md`, `shadow/HYGIENE.md`, `scripts/check.ps1` | Handoff virou entrada enxuta e versionada; gaps ficam linkados para backlog, risk register, lanes e gates em vez de duplicar docs longos. | Usar `shadow/HANDOFF.md` no inicio da proxima janela e resolver `EV-B2` antes de branch protection |

## Gatilhos automaticos

- harness warn se este arquivo nao muda em >21 dias e ha procedure em `candidate` ou `candidate procedure`;
- higiene: se uma procedure acumula >=3 entradas + rubrica passando + >=14 dias sem edicao do procedure, considerar transicao para `operational`.

## Criterio negativo

Em 4 semanas, se este arquivo tiver <3 entradas por procedure ativo, considerar que o procedimento nao esta em uso real. Acao: reclassificar o procedimento para `experiment` e simplificar/deletar rubrica associada.

Coautoria: Lucas + Claude Opus 4.7 (1M)

