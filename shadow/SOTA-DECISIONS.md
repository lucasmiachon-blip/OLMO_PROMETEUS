# SOTA Decisions

Data: 2026-04-23
Escopo: open OLMO_PROMETEUS
Status: decisao operacional, nao arquitetura aspiracional

## Decisao central

O melhor do SOTA para este projeto pequeno e manter pouca estrutura, bem nomeada e verificavel.

Manter:

- `AGENTS.md` como contrato central e portavel.
- `CLAUDE.md` e `GEMINI.md` como adaptadores finos para ferramentas que nao leem `AGENTS.md` por padrao.
- Procedimentos pequenos como docs em `shadow/` ou notas em `Prometeus/wiki/`.
- Gmail como fila simples: `Processar`, `Alta`, `Ruido`, `Digerido`.
- `Digerido` somente depois de artefato persistente.
- `shadow/INCORPORATION-LOG.md` como gate antes de qualquer conversa sobre OLMO.
- `scripts/check.ps1` como harness leve antes de commit.
- `C:\Dev\Projetos\OLMO_PROMETEUS\Prometeus` como vault Obsidian, com notas em `wiki/`, nao como inbox privado permanente.
- Boundary absoluta: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Raiz sem scaffolds fantasmas: nada de `.agents`, `.codex`, `agents`, `subagents`, `skills`, `hooks` ou `playground` sem gate.

Nao incorporar agora:

- hooks como base da arquitetura;
- MCP proprio;
- A2A local;
- agentes demais;
- skills especulativas;
- registry local de agentes ou skills;
- `.claude/`, `.gemini/` ou configs de ferramenta como runtime ativo;
- relatorios SOTA longos que viram museu.
- hooks reais antes de um comando manual provar utilidade.

## Regras praticas

1. Criar skill/agente novo apenas depois de uso recorrente, dor repetida e aprovacao explicita.
2. Antes disso, manter o procedimento em `shadow/` ou na wiki.
3. Pesquisa externa vira decisao curta, nao biblioteca grande.
4. Qualquer coisa que pareca migravel passa por `private -> experiment -> candidate`.
5. Nada toca `C:\Dev\Projetos\OLMO` sem autorizacao humana explicita.

## SOTA research gate

Decisao: toda mudanca de arquitetura, agente, skill, hook, MCP, memoria ou orquestracao precisa de pesquisa SOTA antes de editar.

Contrato minimo:

- auditar primeiro o estado local;
- usar fontes primarias atuais, preferindo docs oficiais;
- registrar uma decisao curta, nao um relatorio longo;
- citar fontes quando a decisao depender de pesquisa externa;
- explicitar trigger, nao-trigger, risco, custo e rollback;
- incluir criterio negativo: quando nao aplicar a ideia;
- rodar harness antes de commit.

Regra anti-sycophancy: se a pesquisa nao sustenta a proposta para o tamanho real do Prometeus, a resposta correta e rejeitar, reduzir ou adiar a mudanca. SOTA nao e moda; e ajuste entre pratica externa, escala local e risco operacional.

### Rubric do SOTA research gate

Score minimo pass = 0.7 (de 1.0). Rodar apos cada aplicacao do gate e registrar em `shadow/EVIDENCE-LOG.md`.

| Dimensao | Peso | 0 | 1 | 2 |
| --- | --- | --- | --- | --- |
| Auditoria local primeiro | 0.2 | pulou | superficial | estado atual explicitado antes de buscar externo |
| Fontes primarias atuais | 0.2 | sem fontes | fontes secundarias ou antigas | docs oficiais vigentes (Anthropic, OpenAI, Google, papers) |
| Decisao curta | 0.2 | relatorio longo | decisao com bullets excessivos | decisao <=20 linhas com trigger, risco, rollback |
| Criterio negativo explicito | 0.2 | ausente | vago | "se X em Y prazo, rejeitar/ajustar" operacional |
| Artefato registrado | 0.2 | sem artefato persistente | decisao solta | linha em SOTA-DECISIONS + transicao em INCORPORATION-LOG |

Formula: `score = 0.2 * soma(niveis)/10`. Normalizar cada dimensao para 0-1.

## Agent module frontier

Decisao: tratar agentes como modulos encapsulados, nao como personas ou pastas.

O contrato vive em `shadow/AGENT-MODULES.md` e a nota navegavel vive em `Prometeus/wiki/Notes/Agent Module Encapsulation.md`.

Resumo operacional:

- primeiro procedimento;
- depois modulo documentado;
- depois runner manual;
- so entao agente real;
- todo modulo declara input, output, estado, tools, permissoes, guardrails, eval, custo e rollback.

Sinal SOTA: OpenAI enfatiza agents com instrucoes, tools, handoffs e guardrails; Anthropic enfatiza subagentes focados, contexto separado e ferramentas limitadas; Google ADK enfatiza tipos de agentes e avaliacao por resposta, trajetoria, ferramentas, groundedness e seguranca.

Decisao Prometeus: nao criar runtime de agente enquanto os candidatos atuais funcionam como procedimentos e harness. `Agent Module Encapsulation` fica em `experiment`.

## Padrao SOTA para procedimentos

Enquanto nao houver skill real, cada procedimento duravel deve ter:

- trigger e nao-trigger;
- contrato de entrada;
- output esperado;
- workflow curto;
- criterios negativos;
- mini-evals com prompts realistas.

Se algum procedimento passar a ser usado recorrentemente, so entao considerar uma skill real com `SKILL.md`, descricao forte de trigger, progressive disclosure e evals. Ate la, procedimento em `shadow/` e mais barato que scaffold.

## Big Three scan

Busca oficial em 2026-04-23: OpenAI, Anthropic e Google convergem em quatro pontos.

| Fonte | Sinal operacional | Decisao Prometeus |
| --- | --- | --- |
| OpenAI Codex Skills | Skills sao workflows reutilizaveis com `SKILL.md`, `name`, `description`, recursos opcionais e progressive disclosure. Descricao define matching implicito. | Manter playbooks em `shadow/` ate haver uso repetido. Se virar skill, exigir trigger/nao-trigger forte, corpo curto e mini-evals. |
| OpenAI Codex Subagents | Subagentes servem para tarefas paralelas complexas, custam mais tokens e so devem ser usados quando explicitamente pedidos. | Nao manter registry local de subagentes. Delegacao fica por conversa, nao por scaffold persistente. |
| Anthropic Claude Code Memory | Claude Code le `CLAUDE.md`, nao `AGENTS.md`; recomenda criar `CLAUDE.md` importando `AGENTS.md` quando o repo ja usa AGENTS. | Criar apenas um adaptador fino `CLAUDE.md` com `@AGENTS.md`. Nao criar `.claude/`, rules, hooks ou auto-memory versionada. |
| Anthropic Claude Code Best Practices | Recomenda explorar primeiro, planejar, dar verificacao ao agente, gerenciar contexto agressivamente e usar subagentes para investigacao quando isso poupar contexto principal. | Antes de mudanca estrutural: auditar, pesquisar, decidir e verificar. Subagente nao vira pasta persistente por padrao. |
| Anthropic Claude Skills | Skills entram quando o usuario repete playbooks/checklists ou quando uma parte de memoria vira procedimento; corpo carrega sob demanda. | A regra "procedimento primeiro, skill depois" esta correta. Migrar para skill apenas quando a repeticao justificar custo. |
| Anthropic Subagents | Subagentes devem ter escopo, ferramentas e modelo claros; subagente read-only deve limitar ferramentas. | Se algum dia voltar, deve ser read-only por padrao, com ferramentas minimas e uso explicito. |
| Anthropic Hooks | Hooks dao controle deterministico, mas rodam comandos automaticamente no ciclo do agente. | Continuar sem hooks ativos. Primeiro comando manual, depois harness, so entao discutir automacao. |
| Google Gemini CLI `GEMINI.md` | Gemini CLI carrega contexto hierarquico por `GEMINI.md`, suporta imports `@file.md` e permite customizar nomes de contexto. | Criar apenas um adaptador fino `GEMINI.md` com `@AGENTS.md`. Nao criar `.gemini/`, extensoes, MCP ou comandos ativos. |
| Google ADK Agents | Distingue LLM agents, workflow agents deterministicos e custom agents; workflow agents dao previsibilidade. | Para Prometeus, preferir workflow documentado e harness deterministico antes de agente LLM. |
| Google ADK Evaluation/Artifacts | ADK enfatiza avaliacao, artefatos persistentes, estado/memoria e ferramentas separadas. | Separar memoria (`shadow`/wiki), artefatos e estado privado. Todo procedimento duravel precisa de mini-evals. |
| Google ADK Evaluation | Agentes precisam ser avaliados por resposta final, trajetoria, uso de ferramentas, groundedness e seguranca; testes agenticos nao sao so unit tests deterministas. | Se Prometeus criar agente real, precisa eval minimo antes de virar runtime. Enquanto isso, mini-evals nos procedimentos bastam. |

Conclusao: o SOTA nao pede mais pastas. Pede menos contexto carregado por padrao, gatilhos melhores, artefatos persistentes, avaliacoes pequenas e automacao so quando a regra for deterministica.

## Applied when

Registro de quando cada decisao acima foi aplicada a uma mudanca real. Uma entrada por aplicacao, com data, artefato e commit quando disponivel. Se uma decisao ficar >30 dias sem aplicacao registrada, e candidata a remocao (museu).

| Data | Decisao | Aplicada em | Artefato/commit |
| --- | --- | --- | --- |
| 2026-04-23 | Decisao central (manter pouca estrutura bem nomeada) | Bloco A deste plano | commit 1c02049 |
| 2026-04-23 | SOTA research gate | Redacao do `shadow/PLAN-2026-04-23.md` como gate formal desta rodada | `shadow/PLAN-2026-04-23.md` |
| 2026-04-23 | Agent module frontier (modulo primeiro, runtime depois) | Rejeitar criacao de `.claude/agents/` local; mapear agentes globais em `shadow/AGENT-USAGE.md` | `shadow/AGENT-USAGE.md` |
| 2026-04-23 | Padrao SOTA para procedimentos (mini-evals + rubrica) | Adicionar `## Rubric` em email-digest-4p, study-track-done e SOTA research gate | `shadow/EMAIL-DIGEST-4P.md`, `shadow/STUDY-TRACK-DONE.md`, `shadow/SOTA-DECISIONS.md` |
| 2026-04-23 | Adaptadores CLAUDE.md/GEMINI.md finos | Refactor Boris-style "things that will bite you" | commit 1c02049 |

## Claude Code e GEMINI.md adapters

Decisao: manter `AGENTS.md` como fonte de verdade e criar `CLAUDE.md` e `GEMINI.md` apenas como pontes de contexto.

Contrato dos adaptadores:

- primeira linha importa `AGENTS.md`;
- repetir apenas a boundary absoluta;
- declarar que nao sao fonte de verdade;
- proibir `.claude/`, `.gemini/`, hooks, MCP, subagentes, skills ou comandos ativos sem gate;
- qualquer regra nova deve ir para a casa certa: `AGENTS.md`, `PROJECT_CONTRACT.md`, `TREE.md`, `shadow/` ou `Prometeus/wiki/`.

Risco: imports carregam contexto no inicio da sessao. Por isso os adaptadores devem permanecer curtos e nao importar arvores grandes.

## Time minimo

| Papel | Modelo/ferramenta | Uso | Risco controlado |
|------|--------------------|-----|------------------|
| Orquestrador | Codex | integrar, editar, decidir proximo passo | nao delegar por reflexo |
| Gemini | externo/manual | pesquisa longa, multimodal, PDFs | artefato curto em `shadow/` |

## Fontes base

- OpenAI Codex AGENTS.md: `https://developers.openai.com/codex/guides/agents-md`
- OpenAI Codex Skills: `https://developers.openai.com/codex/skills`
- OpenAI Codex Subagents: `https://developers.openai.com/codex/subagents`
- Anthropic Claude Code Skills: `https://code.claude.com/docs/en/skills`
- Anthropic Claude Code Hooks: `https://code.claude.com/docs/en/hooks-guide`
- Anthropic Claude Code memory: `https://code.claude.com/docs/en/memory`
- OpenAI Agent evals: `https://developers.openai.com/api/docs/guides/agent-evals`
- AGENTS.md convention: `https://agents.md/`
- GitHub Copilot repository instructions: `https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions`
- Anthropic Claude Code subagents: `https://docs.anthropic.com/en/docs/claude-code/sub-agents`
- Google ADK agents: `https://adk.dev/agents/`
- Google ADK overview: `https://adk.dev/get-started/about/`
- Google ADK skills: `https://adk.dev/skills/`
- Google Gemini CLI GEMINI.md: `https://google-gemini.github.io/gemini-cli/docs/cli/gemini-md.html`
- Google Gemini models: `https://ai.google.dev/gemini-api/docs/models`
- Google Gemini long context: `https://ai.google.dev/gemini-api/docs/long-context`
- Google Agent2Agent announcement: `https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/`
- MCP specification: `https://modelcontextprotocol.io/specification/2025-03-26`

## O que foi cortado

- Relatorio SOTA longo de 2026-04-22: bom para exploracao, ruim como documento operacional.
- Mapa SOTA intermediario de 2026-04-23: substituido por esta decisao curta.
- Recomendacoes especulativas de skills/agentes que ainda nao tiveram uso real.

## Blocked ate evidencia (Bloco C do PLAN-2026-04-23)

Decisoes rascunho aguardando evidencia em `shadow/EVIDENCE-LOG.md` antes de virar rodada de implementacao. Cada item exige SOTA research gate separado quando o trigger bater.

### C1 — Evaluator-optimizer via subagent

- Trigger: rubrica de algum procedure (Bloco B1) rodada >=8 vezes sem ajuste (rubrica estavel).
- Nao trigger: rubricas ainda em calibracao.
- Decisao candidata: usar `Explore` subagent com prompt contendo a rubrica para critica cega de output do procedure.
- Risco: custo de tokens e ciclo de critica que pode virar ritual.
- Rollback: remover subagent step; manter avaliacao manual.

### C2 — Promover procedure para skill formal

- Trigger: procedure chega a `operational` com >=3 execucoes documentadas e rubrica passando.
- Nao trigger: procedure ainda em `candidate` ou `experiment`.
- Decisao candidata: criar `Prometeus/wiki/skills/<name>/SKILL.md` dentro do repo. NAO criar `.claude/skills/` local.
- Risco: skill nao carregar automaticamente, duplicar procedure.
- Rollback: deletar skill, manter procedure.

### C3 — `.claude/` local scaffolds (REJEITADO agora)

- Decisao: nao criar `.claude/agents/`, `.claude/skills/`, `.claude/hooks/`, `.claude/commands/`. Reavaliar apenas com 3 dores concretas documentadas em `EVIDENCE-LOG.md` onde ausencia de scaffold local causou retrabalho real.

### C4 — Memoria operacional durable layer

- Trigger: `EVIDENCE-LOG.md` acumula >=10 entradas cujos insights destilem para <=8 frases load-bearing.
- Nao trigger: <10 entradas ou entradas redundantes.
- Decisao candidata: secao `## Durable insights` em `AGENTS.md`, cap de 8 linhas.
- Risco: inflar AGENTS.md e reintroduzir memoria especulativa.
- Rollback: deletar secao.

Criterio negativo global: se ate 2026-05-23 nenhum stub for alcancado, reavaliar se Bloco C inteiro deve ser abandonado em vez de implementado.

Coautoria: Lucas + GPT-5.4 (Codex)
