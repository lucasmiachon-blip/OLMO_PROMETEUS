# SOTA Decisions

Data: 2026-04-25
Escopo: open OLMO_PROMETEUS
Status: indice operacional de decisoes; detalhes longos ficam em docs especializados.

## Decisao central

Prometeus deve continuar pequeno, verificavel e reversivel.

Manter:

- `AGENTS.md` como contrato central.
- `CLAUDE.md` e `GEMINI.md` como adaptadores finos.
- `shadow/` para decisoes, procedures e gates.
- `Prometeus/wiki/` para conhecimento navegavel.
- `scripts/check.ps1` como harness antes de commit.
- Boundary absoluta: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

Nao incorporar por reflexo:

- runtime agentico;
- hooks como arquitetura;
- MCP proprio;
- registry local de agentes/skills;
- relatorios SOTA longos.

## Regras praticas

1. Procedimento primeiro; skill/agente apenas com uso recorrente e aprovacao humana.
2. Pesquisa externa vira decisao curta e teste, nao museu documental.
3. Qualquer coisa migravel passa por `private -> experiment -> candidate`.
4. Nada toca `C:\Dev\Projetos\OLMO` sem autorizacao humana explicita.
5. Toda mudanca estrutural precisa de trigger, risco, custo, rollback e criterio negativo.

## SOTA research gate

Mudancas de arquitetura, agente, skill, hook, MCP, memoria ou orquestracao exigem:

- auditoria local antes de buscar fora;
- fontes primarias atuais;
- decisao curta;
- criterio negativo explicito;
- harness passando.

Rubrica minima: auditoria local, fonte primaria, decisao curta, criterio negativo e artefato registrado. Se a pesquisa nao sustenta a mudanca para este repo pequeno, rejeitar ou adiar.

## Agent module frontier

Agentes sao modulos encapsulados, nao personas ou pastas. O contrato vive em `shadow/AGENT-MODULES.md`.

Escada permitida:

1. prompt/procedure;
2. modulo documentado;
3. runner manual;
4. agente real com eval, estado, tools minimas e rollback.

Runtime agentico continua bloqueado ate haver 3 evidencias reais de retrabalho que um procedimento simples nao resolva.

## Padrao SOTA para procedimentos

Todo procedimento duravel precisa de:

- trigger e nao-trigger;
- contrato de entrada;
- output esperado;
- workflow curto;
- criterios negativos;
- mini-evals realistas.

Skill real so entra depois que o procedimento atingir `operational` e provar reducao de retrabalho.

## Big Three scan

Sinais consolidados de OpenAI, Anthropic e Google:

| Tema | Sinal SOTA | Decisao Prometeus |
| --- | --- | --- |
| Skills | uteis para workflows repetidos, com trigger forte e progressive disclosure | manter em `shadow/` ate prova de uso |
| Subagents | bons para pesquisa paralela e contexto separado | usar sob demanda, nao criar registry local |
| Hooks | deterministas, mas perigosos quando viram arquitetura | aceitar apenas guard local testado |
| Agents | precisam tools, estado, handoff, guardrails e eval | runtime bloqueado ate baseline falhar |
| Evaluation | medir resposta, trajeto, ferramentas, groundedness e seguranca | mini-evals locais antes de framework |

## Local skills gate (2026-04-23)

`.claude/skills/` pode existir apenas para skills reais promovidas de procedures `operational`.

Trigger: procedure operacional >=30 dias, rubrica media >=0.8, evidencias em `EVIDENCE-LOG.md` e aprovacao humana por skill.

Nao-trigger: skill especulativa, copia de comunidade, ou duplicata estatica de procedure.

Rollback: deletar `.claude/skills/<name>/`; procedure original continua em `shadow/`.

## Error report memory protocol (2026-04-25)

Erro material deve gerar resposta curta com: erro, causa provavel, impacto, mudanca de plano, acao profissional e decisao fazer/nao fazer.

Trigger: erro que muda plano, validacao, confianca ou rota de execucao.

Nao-trigger: typo, falha cosmetica ou erro ja corrigido sem impacto.

## Solo medico agent/orchestration refresh (2026-04-25)

Incorporar padroes de agent engineering, nao runtimes. Privacidade, humano-no-loop, auditoria, custo e rollback vem antes de qualquer automacao.

Trigger para runtime: >=3 evidencias reais de retrabalho por falta de estado, HITL, tracing ou coordenacao, sem PHI e com rollback.

Nao-trigger: curiosidade SOTA, demo, single-user notes ou workflow manual simples.

## Applied when

| Data | Decisao | Aplicada em | Artefato/commit |
| --- | --- | --- | --- |
| 2026-04-23 | Decisao central | Bloco A do plano | commit 1c02049 |
| 2026-04-23 | SOTA research gate | Gate formal e rubrica | `shadow/PLAN-2026-04-23.md`, `shadow/SOTA-DECISIONS.md` |
| 2026-04-23 | Agent module frontier | Rejeicao de `.claude/agents/`; mapa de uso | `shadow/AGENT-USAGE.md` |
| 2026-04-23 | Padrao SOTA para procedimentos | Rubricas e mini-evals | `shadow/EMAIL-DIGEST-4P.md`, `shadow/STUDY-TRACK-DONE.md` |
| 2026-04-24 | Auditoria adversarial | Rebaixamento de labels aspiracionais e lanes | commits 1ea1dea, 0e6177d, b3bbdb4 |
| 2026-04-25 | Error report memory protocol | Protocolo de erro material | `AGENTS.md`, `shadow/FOUNDATION.md` |
| 2026-04-25 | Solo medico refresh | Overlay sem runtime novo | `AGENTS.md`, `shadow/AGENT-USAGE.md`, `shadow/FOUNDATION.md` |
| 2026-04-25 | Orchestration/harness/antifragile gate | Gate E2E e fault injection seedado | `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`, `scripts/check.ps1` |

## Claude Code e GEMINI.md adapters

`AGENTS.md` e fonte de verdade. `CLAUDE.md` e `GEMINI.md` so importam contexto e repetem riscos que mordem na ferramenta.

Contrato:

- primeira linha importa `AGENTS.md`;
- repetir apenas boundary e riscos da ferramenta;
- regra nova vai para `AGENTS.md`, `PROJECT_CONTRACT.md`, `TREE.md`, `shadow/` ou `Prometeus/wiki/`.

## Time minimo

| Papel | Ferramenta | Uso | Controle |
| --- | --- | --- | --- |
| Orquestrador | Codex | integrar, editar, verificar | nao delegar por reflexo |
| Pesquisa longa | Gemini/manual | PDFs, multimodal e sintese externa | artefato curto em `shadow/` |

## Fontes base

- OpenAI Codex AGENTS.md: `https://developers.openai.com/codex/guides/agents-md`
- OpenAI Codex Skills/Subagents: `https://developers.openai.com/codex/skills`, `https://developers.openai.com/codex/subagents`
- Anthropic Claude Code memory/skills/hooks/subagents: `https://code.claude.com/docs/en/memory`, `https://code.claude.com/docs/en/skills`, `https://code.claude.com/docs/en/hooks-guide`, `https://docs.anthropic.com/en/docs/claude-code/sub-agents`
- Google ADK/Gemini CLI: `https://adk.dev/agents/`, `https://google-gemini.github.io/gemini-cli/docs/cli/gemini-md.html`
- OpenAI Agents SDK guardrails/evals: `https://openai.github.io/openai-agents-python/guardrails/`, `https://developers.openai.com/api/docs/guides/agent-evals`
- MCP specification: `https://modelcontextprotocol.io/specification/2025-03-26`

## O que foi cortado

- Relatorios SOTA longos e tabelas intermediarias.
- Recomendacoes especulativas de skills/agentes sem uso real.
- Duplicacao do gate antifragile; a fonte especializada e `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`.

## Blocked ate evidencia (Bloco C do PLAN-2026-04-23)

Rascunhos aguardam evidencia em `shadow/EVIDENCE-LOG.md` antes de implementacao.

- C1 Evaluator-optimizer via subagent: exige rubrica rodada >=8 vezes e estavel.
- C2 Skill local: exige procedure `operational`, aprovacao humana e evidencia de reducao de retrabalho.
- C3 Runtime agentico: exige 3 evidencias reais, privacy plan sem PHI, eval e rollback.

Coautoria: Lucas + GPT-5.4 (Codex)