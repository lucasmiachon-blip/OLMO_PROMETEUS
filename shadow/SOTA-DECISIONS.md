# SOTA Decisions

Data: 2026-04-25
Escopo: open OLMO_PROMETEUS
Status: indice operacional de decisoes; detalhes longos ficam em docs especializados.

## Decisao central

Prometeus deve continuar pequeno, verificavel e reversivel.

Manter:

- `AGENTS.md` como contrato central.
- `CLAUDE.md`, `CODEX.md` e `GEMINI.md` como adaptadores finos.
- `shadow/` para decisoes, procedures e gates.
- `Prometeus/wiki/` para conhecimento navegavel.
- `scripts/check.sh` como harness antes de commit.
- Boundary absoluta: nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.

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
6. Be terse: consolidar, nao multiplicar documentos.

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

## Canonical Linux workspace with Windows UI fallback (2026-04-26)

Decisao: o workspace canonico unico e `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4, com `bash`, `rg` e `jq`. Caminhos Windows e `/mnt/c` ficam como referencia historica, archive, fallback ou UI humana, nao como fonte operacional.

Trigger: trabalho local de Codex, Claude, Gemini, harness, maturidade, self-evolution, docs e scripts neste laboratorio.

Nao-trigger: abrir o vault no Obsidian pelo Windows via `\\wsl.localhost\...` ou validar interface grafica fora do WSL.

Risco: drift entre Obsidian/Windows e filesystem Linux; paths antigos em docs; confusao de agentes se `C:\Dev` e `/home` coexistirem.

Custo: atualizar contratos e docs de entrada; manter Windows apenas como UI/fallback documentado.

Rollback: voltar `README.md`, `AGENTS.md`, `TREE.md`, `CLAUDE.md`, `CODEX.md`, `GEMINI.md`, `PROJECT_CONTRACT.md`, `shadow/FOUNDATION.md`, `shadow/HANDOFF.md` e `scripts/check.sh` para Windows-first se Obsidian/Windows ou workflow remoto bloquearem o uso.

Criterio negativo: se `\\wsl.localhost` quebrar o vault, se WSL/ext4 bloquear uso real, ou se workflow remoto/local falhar por path sem correcao simples, voltar para cross-platform neutro ou Windows-first.

Fonte primaria: Microsoft WSL docs recomendam manter arquivos do projeto no filesystem WSL para melhor performance quando se trabalha pela linha de comando Linux; o clone atual ja esta em `/home/...`, nao em `/mnt/c`.

## Exclusive executor rule (2026-04-26)

Decisao: Codex e Claude Code sao os dois executores autorizados para edicao/orquestracao, mas nunca juntos no mesmo escopo de tarefa. Em cada rodada, escolher um executor; o outro pode ser usado apenas como review/adversario em rodada separada. Gemini fica como pesquisa/contraponto e nao executa writes.

Trigger: reduzir drift, autoria ambigua e edicoes concorrentes entre ferramentas.

Nao-trigger: pesquisa read-only, comparacao SOTA ou review sem write.

Risco: escolher o executor errado para uma tarefa especifica; mitigacao: manter rollback por commit pequeno e harness passando.

Custo: menos paralelismo de edicao.

Rollback: voltar a permitir coexecucao apenas se houver evidencia de que exclusao mutua bloqueia trabalho real.

Criterio negativo: se duas ferramentas editarem o mesmo escopo na mesma rodada, parar, auditar diff e escolher uma fonte de verdade antes de continuar.

## Sampling policy (2026-04-26)

Decisao: Gemini pode ser menos terse e usar default `temperature=1.0` para pesquisa criativa/divergente; Claude API pode usar temperatura alta/default em exploracao; Codex/OpenAI reasoning em `xhigh` e governado por reasoning effort/verbosity, nao por temperature.

Trigger: chamadas API ou prompts manuais onde sampling e configuravel.

Nao-trigger: Codex/Claude Code CLI quando a ferramenta nao expõe temperature.

Risco: criatividade excessiva virar arquitetura. Mitigacao: toda saida vira decisao curta antes de editar.

Criterio negativo: se sampling alto gerar claims sem fonte, marcar `[NAO VERIFICADO]` e nao implementar.

Fontes: Google Gemini text generation docs recomendam manter Gemini 3 no default `temperature=1.0`; Anthropic Messages API documenta `temperature` como randomness opcional; OpenAI GPT-5.2 docs indicam que `temperature` so e suportado com `reasoning.effort=none`, enquanto `xhigh` usa reasoning effort/verbosity.

## Privacy guard minimum (2026-04-26)

Decisao: criar controles minimos e versionados para dado sensivel antes de qualquer fluxo clinico: classificacao de dados, checklist PHI, threat model e incident log sem conteudo sensivel.

Trigger: qualquer pedido envolvendo saude, dado pessoal, paciente, PDF clinico, email real, agenda, imagem, audio ou export externo.

Nao-trigger: exemplos sinteticos, docs oficiais, harness sem dado real ou procedimento abstrato.

Risco: virar checklist sem uso; mitigacao: `scripts/check.sh` exige os arquivos e `EVIDENCE-LOG.md` registra uso real.

Custo: quatro arquivos pequenos em `shadow/`, sem runtime novo.

Rollback: remover os quatro arquivos e suas entradas no harness se ficarem sem uso e o projeto continuar sem dados sensiveis.

Criterio negativo: se o fluxo exigir dado real de paciente, manter `blocked` ate haver ambiente privado aprovado, sem prompt externo e com retencao/rollback explicitos.

Fonte primaria: HHS HIPAA Minimum Necessary Requirement e NIST SP 800-61 Rev. 3.

## Triadic SOTA stack diagnosis (2026-04-26)

Decisao: consolidar o output do exercicio triadico (Claude Code Opus + Gemini 3.1 Pro Deep Think + arms prompt comum) em uma decisao unica; raws ficam em `shadow/SOTA-STACK-*-2026-04-26.md` como evidencia.

Sintese (convergencia Claude+Gemini, sem dissensao significativa):

- Canonical workspace: `/home/lucasmiachon/projects/OLMO_PROMETEUS` (Linux ext4); copia Windows em `_archive/OLMO_PROMETEUS-archived-20260426-142912/` como referencia, nao fonte. (Operacionalizado em Stage 4 do plano de drift correction.)
- Git index staleness (CRLF/LF): 13 arquivos modificados em working tree (`CLAUDE.md`, `GEMINI.md`, `Prometeus/wiki/*`, `internal/evolution/*.json`) sao artefatos CRLF→LF cross-OS (NTFS→ext4), nao edits reais. Solucao SOTA: `git add --renormalize .` + `git config core.filemode false`. **Decisao separada, fora do escopo deste stage** — registrada aqui para tratamento posterior.
- `private-learning/` nao migrou; permanece em `_archive/`. Risco PHI baixo enquanto nao for usado; copiar manualmente quando precisar.
- Stack confirmado: Claude Code (autoria diaria), Codex CLI (integrador, `xhigh`), Gemini 3.1 Pro Deep Think (pesquisa SOTA + parse multimodal).
- Toolchain: `uv`+`ruff` (Python), `pnpm`+`biome` (TS), `bun` apenas como experimento.
- OS: Ubuntu 24.04 LTS confirmado; bloquear upgrade 26.04 por 8 semanas.
- Shell: bash no WSL como contrato para agentes/scripts; zsh/fish/nushell so como preferencia humana.

Trigger: pesquisa SOTA externa solicitada para validar stack pos-migracao Windows→Linux.

Nao-trigger: nao gera runtime/agent/skill novo; apenas alinha decisoes existentes a evidencia atual.

Risco: dossier virar relatorio inerte se nao citado em decisoes futuras.

Custo: 4 arquivos `SOTA-STACK-*-2026-04-26.md` adicionados (`ARMS-PROMPT`, `CLAUDE-RESPONSE`, `GEMINI-3.1-PRO-DIAGNOSIS`, `CONSOLIDATED-DIAGNOSIS`); ~660 linhas em raws.

Rollback: `git rm --cached shadow/SOTA-STACK-*-2026-04-26.md` se a sintese for revogada.

Criterio negativo: se as proximas 3 mudancas estruturais nao citarem este bloco como evidencia, considerar SOTA exercicio como ritual sem uso e simplificar.

Indice de evidencia (raws sob `shadow/`):

- `SOTA-STACK-2026-04-26.md` (ja tracked, commit 661e8e3) — overview inicial.
- `SOTA-STACK-GEMINI-PROMPT-2026-04-26.md` (ja tracked) — prompt Gemini.
- `SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md` (ja tracked) — resposta Gemini inicial.
- `SOTA-STACK-CLI-PROMPTS-2026-04-27.md` (ja tracked, commit 450c997) — playbook para sessoes CLI; data 04-27 e proposital (sessao futura), nao premature.
- `SOTA-STACK-ARMS-PROMPT-2026-04-26.md` (este stage) — prompt unico triadico distribuido.
- `SOTA-STACK-CLAUDE-RESPONSE-2026-04-26.md` (este stage) — resposta Claude Opus.
- `SOTA-STACK-GEMINI-3.1-PRO-DIAGNOSIS-2026-04-26.md` (este stage) — Gemini 3.1 Pro Deep Think.
- `SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md` (este stage) — sintese final pelo Gemini.

## PreToolUse hook port to bash (2026-04-26)

Decisao: `.claude/settings.local.json > hooks.PreToolUse.command` migra de `powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\guard-olmo-write-hook.ps1` para `bash ./scripts/guard-olmo-write-hook.sh`. Preserva contrato (deny de write fora do canonical, allow interno) e troca apenas o shell de invocacao para bater com o canonical Linux/WSL atual. O `.ps1` nao existe mais no repo (foi removido em commit anterior) — o hook estava silenciosamente quebrado.

Trigger: settings.local.json apontava para PowerShell mas FOUNDATION.md ja assumia bash-first; canonical migrou para `/home/lucasmiachon/projects/OLMO_PROMETEUS` onde PowerShell nao roda.

Nao-trigger: nenhuma mudanca de contrato do guard ou de matcher; apenas troca de invocador.

Risco: Claude Code rejeitar a nova shape do hook ou hook silenciosamente nao firar. Mitigacao: `scripts/test-olmo-boundary-guard.sh` valida deny+allow neste stage.

Custo: 1 string trocada em settings.local.json (em .gitignore).

Rollback: stash de `.claude/settings.local.json` antes do edit; restaurar do stash. Como o arquivo nao e versionado, `git restore` nao se aplica.

Criterio negativo: se test-olmo-boundary-guard.sh nao mostrar 1 deny + 1 allow, parar e diagnosticar antes de aceitar a mudanca.

## AGENTS.md state alignment (2026-04-26)

Decisao: alinhar `AGENTS.md > Do` ao estado real registrado em `shadow/INCORPORATION-LOG.md` entries 28-30 (2026-04-24): `email-digest-4p` e `study-track-done` foram rebaixados a `experiment` por EVIDENCE-LOG vazio; `obsidian-crossref-check` foi rebatido a `candidate` por nao cumprir gate formal. AGENTS.md ainda os tratava como praticas centrais.

Trigger: drift textual entre contrato (`AGENTS.md`) e estado de lanes (`INCORPORATION-LOG.md`) detectado em auditoria de hoje.

Nao-trigger: nenhuma mudanca arquitetural ou de procedimento; apenas remocao de declaracao operacional sem evidencia.

Risco: virar pretexto para reescrever AGENTS.md alem do necessario.

Custo: edicao cirurgica em 1 secao do AGENTS.md (`## Do`).

Rollback: `git restore AGENTS.md shadow/SOTA-DECISIONS.md shadow/INCORPORATION-LOG.md`.

Criterio negativo: se grep mostrar que `email-digest-4p` ou `study-track-done` sao citados como pratica central em outro doc operacional, esse doc tambem precisa de alinhamento.

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
| 2026-04-26 | Linux canonical workspace | `/home/lucasmiachon/projects/OLMO_PROMETEUS` como fonte operacional; Windows apenas UI/fallback | `AGENTS.md`, `README.md`, `CLAUDE.md`, `CODEX.md`, `GEMINI.md`, `TREE.md`, `PROJECT_CONTRACT.md`, `shadow/FOUNDATION.md`, `shadow/HANDOFF.md`, `scripts/check.sh` |
| 2026-04-26 | Exclusive executor rule | Codex ou Claude Code executa por rodada; Gemini pesquisa sem write | `AGENTS.md`, `PROJECT_CONTRACT.md`, `shadow/FOUNDATION.md`, `shadow/SOTA-DECISIONS.md` |
| 2026-04-26 | Sampling policy | Gemini criativo com temperature 1; Codex por reasoning effort | `AGENTS.md`, `GEMINI.md`, `shadow/FOUNDATION.md`, `shadow/SOTA-DECISIONS.md` |
| 2026-04-26 | Privacy guard minimum | Controles minimos de dado sensivel/PHI exigidos pelo harness | `shadow/DATA-CLASSIFICATION.md`, `shadow/PHI-CHECKLIST.md`, `shadow/THREAT-MODEL.md`, `shadow/INCIDENT-LOG.md`, `scripts/check.sh` |
| 2026-04-26 | Bash-first WSL2 harness | Runtime antigo sai do gate principal; workflow passa para Bash | `scripts/check.sh`, `scripts/evolve.sh`, `.github/workflows/self-evolution.yml` |
| 2026-04-26 | Remove legacy scripts | Guard e harness portados para Bash; scripts antigos removidos do repo | `scripts/guard-olmo-write-hook.sh`, `scripts/test-olmo-boundary-guard.sh`, `scripts/check.sh` |

## Claude Code, Codex e GEMINI.md adapters

`AGENTS.md` e fonte de verdade. `CLAUDE.md`, `CODEX.md` e `GEMINI.md` so importam contexto e repetem riscos que mordem na ferramenta.

Contrato:

- primeira linha importa `AGENTS.md`;
- repetir apenas boundary e riscos da ferramenta;
- regra nova vai para `AGENTS.md`, `PROJECT_CONTRACT.md`, `TREE.md`, `shadow/` ou `Prometeus/wiki/`.

## Time minimo

| Papel | Ferramenta | Uso | Controle |
| --- | --- | --- | --- |
| Executor | Codex ou Claude Code | integrar, editar, verificar | escolher um por rodada; nunca ambos editando o mesmo escopo |
| Pesquisa longa | Gemini/manual | PDFs, multimodal e sintese externa | artefato curto em `shadow/`; sem write |

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
