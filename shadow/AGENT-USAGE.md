# Agent Usage Map

Data: 2026-04-23
Status: experiment (novo no Bloco B do PLAN-2026-04-23)
Escopo: como este projeto usa agents/skills/subagents globais SEM criar scaffold local.

## Purpose

Mapear quais agents/subagents/skills globais do Claude Code (e outras ferramentas) este projeto autoriza, quando usar, e como Claude deve operar para manter contexto enxuto e evidencia auditavel. Este arquivo substitui a tentacao de criar `.claude/agents/` local: toda necessidade de agente e coberta por recurso global + procedimento em `shadow/`.

## Global skills e subagents disponiveis

Skills do Claude Code instaladas (nivel user, nao versionadas no repo):

- `/wiki-query`, `/wiki-lint`: operacoes sobre memoria/wiki.
- `/dream`: consolidacao de memoria entre sessoes (nao usada automaticamente aqui; ver `AGENTS.md` Memoria).
- `/schedule`, `/loop`: tarefas recorrentes e follow-ups.
- `/code-review:code-review`, `/review`, `/security-review`: revisoes estruturadas.
- `/codex:rescue`, `/codex:setup`: delegacao ao Codex quando util.
- `/update-config`, `/keybindings-help`, `/fewer-permission-prompts`: config do harness.
- `/simplify`: limpeza de codigo.
- `/ultrareview`: user-triggered cloud review.

Subagent types via `Agent` tool:

- `Explore` (read-only): pesquisa ampla no repo com escopo dedicado.
- `Plan` (read-only): design de implementacao e tradeoff analysis.
- `general-purpose`: tarefas abertas multi-step.
- `codex:codex-rescue`: delegacao complexa ao Codex.
- `claude-code-guide`: duvidas sobre Claude Code/API/SDK.
- `statusline-setup`: config statusline.

## Mapeamento procedure -> agente

| Procedure | Agente sugerido | Quando usar | Quando NAO usar |
| --- | --- | --- | --- |
| `email-digest-4p` | direct prompt | 4P curto cabe no contexto principal; sinal depende de curadoria humana | — |
| `study-track-done` | direct prompt | tabela compacta, decisao local | — |
| `sota-research-gate` | `Explore` (audit local) + `WebSearch`/`WebFetch` (SOTA externo) | auditoria de multiplos arquivos + pesquisa atual | questao pontual onde um `Read` resolve |
| exploracao ampla do repo | `Explore` | >=3 queries, >=4 arquivos, incerteza de localizacao | caminho conhecido |
| plano de refactor grande | `Plan` | >=3 arquivos tocados, tradeoffs nao obvios | edits locais |
| consolidacao de memoria | `/dream` | fim de sessao densa com correcoes/insights novos | sessao curta |
| follow-up agendado | `/schedule` | revisao em N semanas (ex: EVIDENCE-LOG em 4 semanas) | acao imediata |
| code review antes de commit grande | `/code-review:code-review` | commit toca >=5 arquivos ou logica core | edit trivial |
| rescue quando loop trava | `/codex:rescue` | Claude ciclando sem progresso | duvida simples |

## SOTA agent contract (Claude definition)

Padroes SOTA 2026 que Claude aplica neste projeto (fontes: Anthropic multi-agent research, AdaRubric, Memory in the Age of AI Agents, Anthropic 2026 Agentic Coding Trends):

### Orquestrador-worker + parallelization
Quando uma tarefa tem >=3 sub-tarefas independentes (ex: auditar harness + shadow/ + wiki), delegar cada uma a um `Explore` separado em paralelo no mesmo turno. Sintese fica no contexto principal. Cada subagent recebe: objetivo, output format, ferramentas minimas, escopo, e "no edit" explicito. Serial so quando output de A alimenta input de B.

### Evaluator-optimizer
Procedures com rubrica (ver email-digest-4p, study-track-done, sota-research-gate) sao auto-avaliados: gerar output -> pontuar com rubric -> se <0.7, iterar. Nao precisa subagent separado; mesmo loop principal.

### Context discipline
Subagent absorve o ruido da pesquisa; contexto principal fica para decisao. Arvores grandes vao para `Explore`, nao para `Read` direto. Prompt do subagent pede relatorio curto (sob N palavras) para nao encher o contexto na volta.

### Memory policy
Este projeto nao mantem memoria propria do Claude Code (`.claude/projects/.../memory/` vazio por design). Memoria operacional vive em `AGENTS.md`, `shadow/`, `Prometeus/wiki/`. `/dream` pode ser usado para memoria global do user, nao para escrita no repo.

### Tool minimalism
Cada subagent recebe apenas as ferramentas que precisa. `Explore` ja e read-only; `Plan` ja e read-only. Subagent que precise editar deve ter justificativa no prompt, e preferencialmente usar worktree isolation.

## Solo medico SOTA overlay (2026-04-25)

Pesquisa atual em Anthropic Claude Code, OpenAI Agents SDK, LangGraph, CrewAI e Paperclip confirma: o melhor ganho agora e contrato operacional, nao runtime novo.

### Incorporar agora

- `AGENTS.md` continua fonte portavel; `CLAUDE.md` fica adaptador fino. `.claude/rules/` so entra se houver regra path-specific repetida que esteja inflando contexto global.
- Subagents entram explicitamente, read-only por padrao, para pesquisa/review/debug com escopo fechado. Agent teams experimentais so para pesquisa/review paralela, nunca para tocar dados sensiveis ou rodar sem supervisao.
- Skills continuam procedure-first: so promover procedure operacional, com trigger/non-trigger fortes. Skills com side effect ou risco medico devem ser manual-trigger quando a ferramenta suportar.
- Orquestracao copia os padroes, nao os frameworks: estado, ticket, budget, audit log, humano-no-loop, rollback e criterio negativo.
- Para qualquer fluxo medico: sem PHI/dados sensiveis em prompt, repo ou automacao; usar dado sintetico/de-identificado; registrar fontes e limites.

### Nao incorporar ainda

- LangGraph, CrewAI, Paperclip ou OpenAI Agents SDK como dependencia/runtime local.
- `.claude/agents/`, hooks ou agent teams persistentes.
- Agentes 24/7, heartbeats ou autonomia de negocio sobre dados medicos.

Trigger futuro: >=3 ciclos reais em `EVIDENCE-LOG.md` mostram que um procedimento manual falha por falta de estado duravel, HITL formal, tracing ou coordenacao multi-agente. Sem esse trigger, o custo operacional e o risco de privacidade superam o ganho.

## Local skills contract

Aberto em 2026-04-23 por decisao em `shadow/SOTA-DECISIONS.md > Local skills gate`. `.claude/skills/` agora e casa valida para skills promovidas. `.claude/agents/`, `.claude/hooks/`, `.claude/commands/` permanecem proibidos.

### Quando um procedure vira skill local (cumulativo)

- procedure em lane `operational` em `shadow/WORK-LANES.md`;
- >=3 entradas em `shadow/EVIDENCE-LOG.md` com rubric media >=0.8;
- >=30 dias em `operational` sem edit estrutural do procedure;
- dor concreta onde matching por description (SKILL.md) ganha sobre Read do procedure;
- aprovacao humana explicita por skill.

### SKILL.md minimo

Cada subdir `.claude/skills/<name>/SKILL.md` precisa de frontmatter:

```yaml
---
name: <curto, verbo-substantivo>
description: <1 frase para matching implicito>
trigger: <quando entra>
non-trigger: <quando nao entra>
source: <caminho do procedure em shadow/>
status: experiment | candidate | operational
owner: Lucas
---
```

Corpo: resumo curto + links + mini-evals. Nao duplicar integralmente o procedure; o procedure em `shadow/` continua fonte de verdade. Edits estruturais vao no procedure; SKILL.md so atualiza quando trigger ou description mudam.

### Guardrails de skills locais

- Uma skill por procedure; nao criar skill sem procedure em shadow/.
- Skill nao pode escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Cada uso real de skill vira linha em `shadow/EVIDENCE-LOG.md`.
- Se em 60 dias (ate 2026-06-22) nenhuma skill reduzir retrabalho, reverter e voltar a proibir `.claude/skills/`.

## Guardrails

- Subagents read-only por default.
- No write outside `C:\Dev\Projetos\OLMO_PROMETEUS` (Fundamental Boundary vale para subagents tambem).
- Cada uso de subagent que gera artefato persistente = linha em `shadow/EVIDENCE-LOG.md`.
- Cost awareness: subagent = tokens extras. Usar quando economiza contexto principal ou da paralelismo util.

## Non-triggers

Nao usar subagent/skill quando:

- caminho do arquivo e conhecido (use `Read` direto);
- pergunta e simples (use direct prompt);
- decisao requer julgamento humano (pergunte ao Lucas);
- edit pequeno (use `Edit` direto, nao `Plan`);
- scope inteiro cabe em 1-2 reads.

## Evidence

Usos reais deste mapa viram linhas em `shadow/EVIDENCE-LOG.md`. Se em 30 dias este arquivo nao for referenciado em EVIDENCE-LOG nem em commit, e candidato a `retired`.

Coautoria: Lucas + Claude Opus 4.7 (1M)
