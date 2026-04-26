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
- `scripts/check.sh` como harness antes de commit.
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

## Codex xhigh default (2026-04-26)

Decisao: neste repo, Codex deve usar `reasoning_effort=xhigh` quando a ferramenta/modelo suportar, sem criar scaffold local, hook, skill ou registry.

Trigger: tarefas de edicao, revisao, gate, harness, boundary ou decisao operacional dentro do `OLMO_PROMETEUS`.

Nao-trigger: tarefas triviais onde a ferramenta ativa nao expõe `xhigh`, ou chamadas a outros modelos/ferramentas que nao suportam esse parametro.

Risco: maior latencia e custo por mais tokens de raciocinio; pode ser desproporcional para tarefas pequenas.

Custo: aceitar respostas mais lentas do Codex neste laboratorio em troca de mais rigor em boundary, validacao e edicao.

Rollback: remover a regra de `AGENTS.md` e voltar ao maior esforco padrao da ferramenta.

Criterio negativo: se `xhigh` causar atrito recorrente, custo injustificado ou nao melhorar erros reais registrados, rebaixar para `high` ou padrao da ferramenta.

Fonte primaria: OpenAI Models docs indicam que GPT-5.2-Codex e GPT-5.3-Codex suportam `low`, `medium`, `high` e `xhigh`; a referencia da API tambem lista `xhigh` como valor de `reasoning_effort` para modelos suportados.

## Canonical Windows workspace with WSL runner (2026-04-26)

Decisao: o workspace canonico permanece `C:\Dev\Projetos\OLMO_PROMETEUS`. Quando a execucao ocorrer no WSL, usar o mesmo workspace via `/mnt/c/Dev/Projetos/OLMO_PROMETEUS`, com `bash`, `rg` e `jq`.

Trigger: trabalho local de Codex, harness, maturidade, self-evolution, docs e scripts neste laboratorio.

Nao-trigger: abrir o vault no Obsidian pelo Windows ou validar interface grafica fora do WSL.

Risco: drift entre comandos Ubuntu e Windows; risco menor porque o harness remoto ainda cobre `ubuntu-latest` e `windows-latest`.

Custo: manter comandos duplicados apenas nos pontos de entrada; evitar duplicacao extensa nos docs.

Rollback: voltar o `README.md`, `AGENTS.md`, `TREE.md`, `CLAUDE.md`, `shadow/FOUNDATION.md`, `shadow/HYGIENE.md` e `shadow/HANDOFF.md` para Windows-first.

Criterio negativo: se Ubuntu/WSL gerar incompatibilidade recorrente, falha no workflow Windows ou bloquear uso do vault, voltar para cross-platform neutro.

Fonte primaria: Microsoft WSL docs recomendam manter arquivos do projeto no filesystem WSL para melhor performance quando se trabalha pela linha de comando Linux; o clone atual ja esta em `/home/...`, nao em `/mnt/c`.

## Privacy guard minimum (2026-04-26)

Decisao: criar controles minimos e versionados para dado sensivel antes de qualquer fluxo clinico: classificacao de dados, checklist PHI, threat model e incident log sem conteudo sensivel.

Trigger: qualquer pedido envolvendo saude, dado pessoal, paciente, PDF clinico, email real, agenda, imagem, audio ou export externo.

Nao-trigger: exemplos sinteticos, docs oficiais, harness sem dado real ou procedimento abstrato.

Risco: virar checklist sem uso; mitigacao: `scripts/check.sh` exige os arquivos e `EVIDENCE-LOG.md` registra uso real.

Custo: quatro arquivos pequenos em `shadow/`, sem runtime novo.

Rollback: remover os quatro arquivos e suas entradas no harness se ficarem sem uso e o projeto continuar sem dados sensiveis.

Criterio negativo: se o fluxo exigir dado real de paciente, manter `blocked` ate haver ambiente privado aprovado, sem prompt externo e com retencao/rollback explicitos.

Fonte primaria: HHS HIPAA Minimum Necessary Requirement e NIST SP 800-61 Rev. 3.

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
| 2026-04-25 | Orchestration/harness/antifragile gate | Gate E2E e fault injection seedado | `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`, `scripts/check.sh` |
| 2026-04-26 | Codex xhigh default | Preferencia de reasoning effort para Codex | `AGENTS.md`, `shadow/SOTA-DECISIONS.md`, `shadow/FOUNDATION.md` |
| 2026-04-26 | Ubuntu/WSL fast path | Comandos Ubuntu/WSL como padrao de velocidade, Windows como compatibilidade | `AGENTS.md`, `README.md`, `CLAUDE.md`, `TREE.md`, `shadow/FOUNDATION.md`, `shadow/HYGIENE.md`, `shadow/HANDOFF.md` |
| 2026-04-26 | Privacy guard minimum | Controles minimos de dado sensivel/PHI exigidos pelo harness | `shadow/DATA-CLASSIFICATION.md`, `shadow/PHI-CHECKLIST.md`, `shadow/THREAT-MODEL.md`, `shadow/INCIDENT-LOG.md`, `scripts/check.sh` |
| 2026-04-26 | Bash-first WSL2 harness | Runtime antigo sai do gate principal; workflow passa para Bash | `scripts/check.sh`, `scripts/evolve.sh`, `.github/workflows/self-evolution.yml` |
| 2026-04-26 | Remove legacy scripts | Guard e harness portados para Bash; scripts antigos removidos do repo | `scripts/guard-olmo-write-hook.sh`, `scripts/test-olmo-boundary-guard.sh`, `scripts/check.sh` |

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

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
