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
5. Toda mudanca estrutural precisa de trigger, risco, viabilidade, rollback e criterio negativo.
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

Incorporar padroes de agent engineering, nao runtimes. Eficacia, privacidade, humano-no-loop, auditoria, viabilidade e rollback vem antes de qualquer automacao.

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

## Triadic stack debate consolidation (2026-04-26)

Decisao: o output do exercicio triadico de hoje (Claude Opus 4.7 + Gemini base + Gemini 3.1 Pro Deep Think) entra neste arquivo como entry curta, nao como PLAN/MATRIX longo (727L combinado, descartados). Frame adversarial pos-debate: para um lab solo, ceremony bloat e anti-pattern explicito; decisao curta vence relatorio longo conforme `AGENTS.md > Operating Principles`.

Sintese:

- D04 (renormalize CRLF + `core.filemode false` local): aplicado hoje em commit `50979f9`. Pre-condicao tecnica antes de qualquer edit semantico futuro; trabalha junto com `.gitattributes` ja correto (`* text=auto eol=lf`).
- D01 (canonical Linux home): essencialmente completo nos commits `f24644d`, `c274a81`, `ed1a4ee`; residuo unico de drift (`lab/wiki-graph-lab/graph-data.js`, output gerado) movido para `.gitignore` em `50979f9`.
- D09 (Gemini 3.1 Pro Preview = 1M input tokens, 64k output): confirmado em fonte primaria Google `ai.google.dev/gemini-api/docs/models/gemini-3.1-pro-preview` (atualizado 2026-04-23). Substitui qualquer referencia historica a 2M.
- C01-C13 (Bash, Ubuntu 24.04, `uv`/`ruff`/`biome` quando houver projeto, sem runtime agentico, sem MCP proprio, sem hooks alem do guard): status quo, nao geram decisao formal — registro aqui apenas como confirmacao de que o exercicio triadico nao alterou nada.
- D02 (skills locais agora) e D06 (GPT-5.5 como 4o adversario): rejeitados; mantem bloqueios existentes via `shadow/AGENT-USAGE.md > Local skills contract` e `## Time minimo` deste arquivo.
- D05/D07/D08/D10 (`private-learning/` triage; verificar Codex landlock+seccomp; pricing GPT-5.5 vs Opus 4.7; existencia de `gemini-3.1-pro-preview-customtools`): deferidos para sessao dedicada quando houver impacto real, nao reflexo.

Trigger: SOTA gate executado pelos 3 raws (CL/GB/GD) + auditoria adversarial humana hoje.

Nao-trigger: nao gera runtime/agent/skill novo; nao adiciona governance; nao expande shadow/.

Risco: perda de detalhe argumentativo dos raws — mitigado pelo git history e pelos `SOTA-STACK-*-2026-04-26.md` ja comitados em `9e32ebe` (CONSOLIDATED-DIAGNOSIS, CLAUDE-RESPONSE, GEMINI-3.1-PRO-DIAGNOSIS, ARMS-PROMPT).

Custo: zero arquivos novos; ~25 linhas nesta entry; -727L deletados (PLAN+MATRIX).

Rollback: `git revert` desta entrada e re-criar PLAN/MATRIX a partir de chats salvos. Aceitavel: o conteudo essencial fica aqui.

Criterio negativo: se em 30 dias um topico do PLAN descartado for citado e nao houver registro suficiente nos raws comitados, reintroduzir aquele topico especifico como nota curta — uma por topico, sem PLAN longo retroativo.

Fontes externas (todas verificadas 2026-04-26 via WebSearch): git docs / GitHub / Edward Thomson (renormalize line endings; `.gitattributes` precede `core.autocrlf`); Microsoft WSL docs + vxlabs benchmarks (9P bridge ~5x slowdown `/mnt/c` vs ext4 nativo); Anthropic Claude Code docs 2026 + ofox.ai (hooks deterministicos / skills probabilisticas; minimum viable para solo dev); Google Gemini docs `gemini-3.1-pro-preview` (1M input / 64k output, atualizado 2026-04-23); DevOps.com + Apatero blog (ceremony bloat anti-pattern em solo project).

## OLMO/OLMO_GENESIS selective adaptation scan (2026-04-27)

Decisao: tratar `OLMO` e `OLMO_GENESIS` como ramos paralelos que evoluiram separados; `OLMO` parece hoje mais maduro operacionalmente, mas `OLMO_GENESIS` nao e apenas ancestral descartavel. Aproveitar convergencias e divergencias de padroes, nao copiar diretorios. A leitura read-only autorizada pelo Lucas em 2026-04-27 mostrou alto sinal no `OLMO` em maturidade executavel, auditoria producer-consumer de hooks, integridade, backlog priorizado, pre-commit/CI minimo e catalogo KBP pointer-only. `OLMO_GENESIS` preserva ideias paralelas uteis, mas tem mais ruido: `.env`, caches, venv, node_modules, agent-memory, skills/agentes locais em massa e runtime multiagente com mocks/simulated legs.

Incorporar agora:

- adaptar `maturity_audit.py` como gate pequeno em `scripts/evolve.sh`/`scripts/check.sh`, focado em gaps reais do Prometeus;
- adaptar `context_audit.py` de forma deterministica primeiro: paths locais, wikilinks, hook targets, shell sources e drift de docs;
- adaptar `tools/integrity.sh` como `scripts/check.sh --integrity` ou subcomando equivalente que escreve relatorio apenas dentro do repo;
- adaptar o metodo do `OLMO/docs/audit/hooks-runtime-S258.md`: todo hook/gate novo precisa matriz producer-consumer ou e teatro candidate;
- manter KBP pointer-only e citar KBP-N em decisoes/PRs antes de expandir o catalogo;
- avaliar `.pre-commit-config.yaml` e `.github/workflows/ci.yml` como subset seguro, sem herdar build de produto que nao existe aqui.

Nao incorporar agora:

- `.claude/agents`, `.claude/skills`, `.claude/hooks` em massa, APL telemetry, statusline, hook logs, agent-memory, triangulation runtime, MCP proprio, docker/otel e `tools/docling/` inteiro;
- conteudo clinico bruto de `genesis/10-Medicina`, inbox, emails dump ou memoria de evidence-researcher;
- scripts que chamem APIs/modelos externos, baixem modelos grandes ou escrevam fora do Prometeus.

Trigger: proxima rodada estrutural de qualidade/harness depois do PR-2 ou quando `scripts/check.sh` precisar provar claims de maturidade alem de existencia de arquivos. Ao minerar legado, comparar `OLMO` vs `OLMO_GENESIS` como forks paralelos: se ambos convergem no mesmo padrao, priorizar; se divergem, registrar tradeoff antes de adaptar.

Risco: importar complexidade e estado sujo do repo principal; misturar dado clinico/memoria externa; transformar SOTA em teatro de hooks.

Custo: 1 batch pequeno, preferencialmente 1 arquivo de auditoria + wiring no harness + uma entrada de backlog/evidencia.

Rollback: remover o subcomando/gate do harness e a entrada de backlog; as leituras externas nao deixam artefato copiado.

Criterio negativo: se o gate novo nao detectar regressao real em 30 dias ou duplicar checks existentes, simplificar para uma unica checagem em `scripts/check.sh` ou remover.

## Prometeus values and gap lens (2026-04-27)

Decisao: criar `VALUES.md` local adaptado de `OLMO/VALUES.md` e dos plans ativos/arquivados lidos read-only. Correcao do usuario: OLMO e o primeiro projeto decente e vira piso, nao teto. Prometeus nao tem barra menor; precisa ser maior em rigor verificavel, boundary, evidencia, reversibilidade, maturidade executavel e privacidade. A diferenca e o metodo: escopo experimental, sem contaminar o sistema principal. O objetivo e dar uma lente de gaps antes de T3/T4: toda melhoria deve declarar valor servido, dor real, trigger, artefato, consumer, evidencia, eficacia, viabilidade, risco, rollback e criterio negativo.

Trigger: o usuario perguntou se havia valores/objetivos e apontou que eles sao necessarios para identificar gaps.

Nao-trigger: nao importar automaticamente a identidade operacional do OLMO, subagents, skills, APL, antifragile L1-L7 ou conteudo medico do repo principal. Porem a exigencia de qualidade pode ser igual ou maior; o que muda e o caminho de prova.

Risco: virar manifesto decorativo. Mitigacao: `scripts/check.sh` e `scripts/integrity.sh` agora exigem `VALUES.md` com `Valores`, `Objetivos` e `Gap Lens`, e `PROJECT_CONTRACT.md` aponta para ele.

Custo: um arquivo raiz pequeno + cross-refs.

Rollback: remover `VALUES.md` e voltar a usar apenas `PROJECT_CONTRACT.md` se a lente nao for citada em decisoes/gaps nos proximos 30 dias.

Criterio negativo: se novas tarefas nao referirem V1-V9 ou Gap Lens ate 2026-05-27, simplificar o arquivo para uma secao curta em `PROJECT_CONTRACT.md`.

## Frontier orchestration objective (2026-04-27)

Decisao: Prometeus nao mira apenas reconhecimento academico/profissional; mira construir um sistema de LLMs orquestrados para educacao, pesquisa, EBM e auxilio direto que iguale ou supere humanos em tarefas delimitadas. Multimodel e a hipotese operacional preferida: a fronteira de orquestracao ainda esta evoluindo, mas o caminho provavel e combinar modelos/agentes especializados, handoffs, agents-as-tools, workflows, fan-out, critic/evaluator e HITL. Isso entra como V9, mas nao desbloqueia runtime agentico por entusiasmo: cada composicao precisa SOTA atual, baseline, eval local, eficacia, privacidade, HITL, viabilidade, rollback e criterio negativo.

Trigger: design de orquestracao, escolha de modelo, avaliacao de qualidade, educacao, pesquisa, EBM, revisao ou auxilio direto.

Nao-trigger: usar "melhor modelo" por reputacao, leaderboard generico, demo ou novidade sem benchmark local.

Risco: transformar ambicao frontier em arquitetura prematura ou falsa autoridade clinica. Mitigacao: humano-no-loop, sem PHI por padrao, tarefas delimitadas e comparacao contra baseline humano/procedural.

Viabilidade: acrescentar V9 e dois objetivos; nenhuma dependencia, runtime ou permissao nova.

Rollback: remover V9 e os objetivos 7-8 de `VALUES.md` se isso virar justificativa para sprawl sem eval.

Criterio negativo: se ate 2026-05-27 nenhuma decisao ou eval concreto usar V9 para comparar modelo/orquestracao contra baseline, rebaixar V9 para objetivo aspiracional fora da tabela de valores.

Fontes SOTA atuais: OpenAI Agents SDK documenta orquestracao por LLM ou por codigo, com handoffs e agents-as-tools; Anthropic recomenda padroes simples e composaveis antes de frameworks complexos; Google ADK documenta sistemas multiagentes com coordenador, pipeline sequencial, fan-out/gather, generator-critic, refinamento iterativo e HITL.

Modelos: OpenAI, Anthropic, Google e modelos locais sao familias candidatas; a escolha operacional deve ser feita no momento de uso com informacao atual e fonte primaria, nao fixada aqui. Custo nao decide o norte; apenas limita viabilidade quando latencia, manutencao, token budget ou privacidade tornarem uma composicao impraticavel.

## OLMO plans as maturity floor (2026-04-27)

Decisao: os valores e plans do `OLMO` sao baseline profissional para Prometeus. Foram lidos read-only `OLMO/VALUES.md`, o indice de plans, o plan ativo Conductor 2026 e amostras arquivadas S232, S253, S258 e S248. Padroes incorporaveis: anti-teatro, auditoria adversarial, evidence tiers, producer-consumer para hooks/gates, purge de aspiracional, convergencia multi-modelo so quando ha verificacao, e criterio de eficacia antes de debug-team/runtime. Prometeus deve exceder isso com mais boundary, menos superficie de runtime, mais privacidade e harness local que prove o contrato.

Trigger: antes de T3 e de qualquer nova estrutura de maturidade, self-evolution, hook, gate ou agente.

Nao-trigger: nao copiar `.claude/agents`, `.claude/skills`, hooks, APL, agent-memory, runtime multiagente ou conteudo clinico do `OLMO`.

Risco: transformar `OLMO` em autoridade estetica e importar cerimonia. Mitigacao: `VALUES.md > OLMO como piso` exige protecao local mensuravel para cada adaptacao.

Custo: um reforco documental e uma checagem textual no integrity gate.

Rollback: remover a secao `OLMO como piso` e a checagem se ela nao orientar nenhuma tarefa real ate 2026-05-27.

Criterio negativo: se uma pratica do `OLMO` for citada sem trigger, consumer e detector local, classificar como `nao incorporar`.

## Infra improvement research scan (2026-04-27)

Decisao: a proxima melhoria de infra deve priorizar saneamento de drift semantico e CI remoto antes de runtime, skill local ou multi-agent. A auditoria local mostrou harness verde, boundary forte e backlog vivo, mas tambem residuos de path Windows canonico em docs de agentes/modulos e pendencias P0/P1 ja suficientes para trabalhar sem criar estrutura nova.

Trigger: pedido de melhoria de infra, mudanca em harness/orquestracao, ou nova proposta de agente/skill/hook.

Nao-trigger: adicionar runtime agentico, framework externo, MCP proprio, skill local ou fanout permanente sem falha repetida documentada.

Risco: transformar pesquisa SOTA em mais governanca. Mitigacao: aplicar somente em itens ja existentes (`EV-B2`, `EV-DIGEST`, `PR-2`, `EV-B4`/ADR) e manter `scripts/check.sh --strict` como prova.

Custo: uma rodada pequena de documentacao/harness, sem dependencia nova.

Rollback: se a rodada aumentar docs sem reduzir busca/drift ou sem destravar CI/evidencia, reverter para o estado atual e manter apenas a entrada de evidencia.

Criterio negativo: se a melhoria proposta nao tiver consumer, falha observada ou detector local, nao implementar.

Fontes primarias verificadas em 2026-04-27: Anthropic Building Effective Agents; OpenAI Agents SDK guardrails/tracing; Google ADK multi-agent/memory/artifacts; NIST AI RMF/Generative AI Profile; Microsoft WSL filesystem docs.

## SOTA alignment batch 01 triage (2026-04-27)

Decisao: implementar apenas os controles com consumer real agora: simulacao local read-only do CI e stale evidence como warning. Deferir ou rejeitar o restante ate haver produtor, consumidor, falha observada e rollback claro.

Implement now: `scripts/simulate-ci.sh` para reproduzir o leg Linux/WSL do workflow `Self Evolution`; warning em `scripts/integrity.sh` para procedures `candidate`/`operational` sem evidencia recente.

Defer: `handoff_context.json` ate existir script/bootstrap consumidor; `Value-Traceable Commits` ate virar relatorio opcional baseado em backlog/decisoes, nao gate de commit.

Reject as stated: `guard-phi-input.sh` como bloqueio universal de prompt, porque nao impede PHI ja colado no chat externo; `issues: write` no workflow, porque o self-evolution atual e read-only e GH-403 precisa diagnostico antes de permissao extra.

Trigger: proposta de batch SOTA com hooks, CI, handoff e metricas.

Nao-trigger: adicionar runtime, hook ativo, permissao GitHub de escrita, JSON duplicado ou gate hard sem evidencia.

Risco: parecer menos ambicioso por rejeitar automacao vistosa; mitigacao: registrar limites tecnicos e entregar detector verificavel.

Custo: um script Bash pequeno, um warning no integrity gate e atualizacoes de contrato/backlog.

Rollback: remover `scripts/simulate-ci.sh`, a linha de required file em `scripts/check.sh`, a funcao stale-evidence de `scripts/integrity.sh` e as entradas documentais desta decisao.

Criterio negativo: se em 30 dias o simulador nao ajudar a diagnosticar `EV-B2` ou os warnings de stale evidence nao guiarem promocao/aposentadoria, simplificar ou remover.

## Cluster architecture seed (2026-04-28)

Decisao: Prometeus aceita agents/subagents/skills em `.claude/{agents,skills}/<cluster>/` com cap baixo + gate de evidencia. Reverte regra anterior `KBP-04` "mantem zero". Justificativa: tendencia industria das 3 plataformas (Claude Code, Codex, Gemini), nao precedente OLMO (que e vibe-coded, ver decisao "Evidence-first applied to subagent reports" abaixo).

Contrato unico: `shadow/CLUSTER-CONTRACT.md`. 4 clusters fixos (`harness`, `research`, `study`, `wiki`). Cap 2 por tipo por cluster. Frontmatter obrigatorio (8 campos para skills). Gate: procedure precisa de >=3 entries em `EVIDENCE-LOG.md` em 30d para virar skill seed; agent so depois de skill `operational` por 30d.

Phase 0 (hoje): pastas vazias com `.gitkeep` em 8 paths. Zero `.md` versionado em `.claude/agents/` ou `.claude/skills/`. Skills/agents entram em rodadas futuras, um por vez, apos gate.

Path to principal embutido em `CLUSTER-CONTRACT.md`: 8 criterios absolutos (maturidade executavel, boundary 100%, anti-teatro, evidencia operacional, PHI, reversibilidade, self-evolution, decisao humana). Hoje 0/8. Estimativa 12-18 meses. Nenhum criterio satisfeito por "OLMO esta pior".

Humildade simetrica: a mesma doutrina (evidencia-first, cap, cluster, anti-sprawl, gate) se aplica ao eventual sucessor de Prometeus. `Path to principal` e reversivel.

Trigger: tendencia industria 2026 + decisao do usuario "ajustes terao agents e subagents e skills, so nao tantos e muito mais organizacoes em clusters".

Risco: sprawl emergir mesmo com cap (cluster pode ser violado por convenience). Mitigacao: enforcer em `scripts/integrity.sh > check_cluster_contract` (batch B3).

Custo: 8 .gitkeep + 1 contrato (`CLUSTER-CONTRACT.md`) + atualizacao cross em `KBP.md`, `CLAUDE.md`, `TREE.md`, `AGENTS.md`, `AGENT-USAGE.md`.

Rollback: remover 8 pastas + `CLUSTER-CONTRACT.md` + reverter KBP-04 para "mantem zero". Documentos cross retornam ao estado anterior via git revert.

Criterio negativo: se em 60 dias (ate 2026-06-27) nenhuma skill ou agent entrar via gate, voltar a proibir `.claude/agents/` e `.claude/skills/` e tratar cluster como aspiracional.

Proxima acao: implementar `check_cluster_contract` em B3 (cap, frontmatter 8 fields, cluster batendo com pasta).

## Cluster contract enforcer (2026-04-28)

Decisao: implementar `check_cluster_contract` em `scripts/integrity.sh` para validar contrato de cluster (cap 2, frontmatter 8 campos, cluster batendo com pasta). OLMO `tools/integrity.sh` foi inspiracao mas implementacao em OLMO parse prosa em CLAUDE.md (fragil). Prometeus reescreveu do zero validando FS direto via `find` + `grep`/`awk` (44 linhas, < cap negativo de 50).

Validacoes vivas:

1. Toda subdir em `.claude/{agents,skills}/` deve ser um dos 4 clusters fixos (`harness`/`research`/`study`/`wiki`).
2. Cap 2 itens por cluster por tipo (agents `*.md` + skills `<name>/SKILL.md`).
3. Total surface <=16.
4. SKILL.md exige 8 frontmatter fields (`name`, `description`, `trigger`, `non-trigger`, `source`, `status`, `owner`, `cluster`).
5. Campo `cluster` em SKILL.md deve bater com pasta pai.

Testes inline executados antes do commit:

- pasta cluster invalida (`.claude/agents/foo/`) -> fail "cluster invalid".
- 3 skills em harness (cap 2) -> fail "cluster cap exceeded".
- SKILL.md sem frontmatter completo -> fail "SKILL.md missing frontmatter (missing: ...)".
- SKILL.md com `cluster: wiki` em pasta `harness` -> fail "cluster mismatch".

Phase 0 estado limpo (8 pastas vazias com .gitkeep) -> 0/16 surface, todos clusters em 0/2, harness passa.

Trigger: B3 do plano `happy-drifting-naur.md`. Pre-condicao: B2 estabeleceu o contrato em `shadow/CLUSTER-CONTRACT.md`.

Risco: regex de frontmatter pode validar campo presente mas valor vazio (ex: `cluster: ` sem valor). Mitigacao: enforcer atual checa `awk '/^cluster:/{print $2}'` que captura o valor; campo vazio falha o match com pasta pai.

Custo: 44 linhas em `scripts/integrity.sh`. Sem novo arquivo.

Rollback: remover funcao `check_cluster_contract` + chamada na lista de checks.

Criterio negativo: se em 60d (ate 2026-06-27) nenhum SKILL.md ou agent for criado (Phase 0 permanente), reduzir enforcer a apenas validacao de pastas (drop frontmatter check) ate haver SKILL.md real. Outra rejeicao: se enforcer crescer >60 linhas, simplificar.

Proxima acao: avaliar se enforcer detecta drift real nas proximas 3 rodadas; manter em silencio se Phase 0 persistir.

## Guard-secrets PHI lite + test fixtures (2026-04-28)

Decisao: estender `scripts/guard-secrets.sh` (ja com 15 patterns OLMO portados em 2026-04-26) com 1 pattern PHI conservador — CPF formatado (`\b[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}\b`). Criar `scripts/test-guard-secrets.sh` com fixtures positivos por pattern + falsos positivos comuns. Wire em `check.sh --strict`.

Avaliacao dos OLMO patterns (B4.1 do plano): os 15 patterns ja estavam wired em 2026-04-26 e passaram em fixtures sinteticos (verificado em `scripts/test-guard-secrets.sh`). Manter todos os 15 — todos batem em fixtures positivos validos. Adicao: 1 PHI pattern.

Decisao PHI conservadora: apenas CPF formatado entra Phase 0. Razao:

- CPF cru (11 digitos) gera muitos falsos positivos (telefones, IDs internos, datas longas, sequencias arbitrarias).
- CNS (15 digitos) raro em commits; ROI baixo, risco de ruido.
- Datas isoladas + nome adjacente (ex: "Joao Silva 1985-01-15") gera falsos positivos enormes em prosa portuguesa comum.

`shadow/PHI-CHECKLIST.md` agora documenta explicitamente "regex e suplemento, nao substituto", listando os falsos negativos garantidos (CPF cru, CNS, narrativa clinica, combinacoes reidentificantes). Detector e ultima linha; checklist humana e primeira.

Bugs encontrados durante implementacao (consertados antes do commit):

- `grep -v '\$\{'` em guard-secrets.sh era BRE quebrado (Unmatched chave). Substituido por `grep -vF` com fixed-string.
- Patterns iniciando com hifens (PEM headers) eram interpretados como flags pelo grep. Substituido por uso de `--` antes do pattern.
- Pattern PEM original era amplo demais: pegava texto livre que mencionava o nome do header em docs. Apertado para exigir prefixo + espaco + letras maiusculas, evitando self-reference em docs que descrevem o detector.

Trigger: B4 do plano `happy-drifting-naur.md`.

Risco: PHI false-positive em commits normais (CPF formatado em docs sinteticos legitimos). Mitigacao: allowlist via `${VAR}` nas matches existentes; criterio negativo abaixo.

Custo: +1 linha em PATTERNS, +124 linhas em test-guard-secrets.sh, +13 linhas em PHI-CHECKLIST.md, +3 linhas em check.sh.

Rollback: remover CPF pattern, deletar test-guard-secrets.sh, reverter PHI-CHECKLIST e check.sh wires.

Criterio negativo: se CPF false-positive bloquear edicao normal 2x na mesma sessao, downgrade para apenas patterns secret. Adicionar entry em `KBP.md`.

Proxima acao: monitorar catches reais (registrar em `EVIDENCE-LOG.md` com metadado nao-sensivel) nas proximas 4 semanas; considerar adicionar CNS ou data-iso-em-contexto se volume justificar.

## Retire Windows CI leg (2026-04-28)

Decisao: remover `windows-latest` da matrix em `.github/workflows/self-evolution.yml`. Workflow agora roda apenas em `ubuntu-latest`. Local Windows simulation continua bloqueada em `simulate-ci.sh windows` (sem mudanca).

Audit: `gh run list` mostrou 3 runs recentes (2026-04-27) onde ubuntu-latest passa em ~5s e windows-latest falha em ~19s no step Harness. OLMO CI (`/mnt/c/Dev/Projetos/OLMO/.github/workflows/ci.yml`, lido read-only com autorizacao 2026-04-28) e Linux-only (ubuntu-latest); confirma que precedente nao mantem dual-OS. Plan negative criterion B5: "debug gh auth >2h = aposentar Windows leg sem culpa" — gh auth WSL na verdade funciona (token gho_ ativo, scopes repo+workflow); falha vinha de divergencia bash POSIX vs git-bash do windows-latest no harness, nao de auth.

**Importante:** esta decisao afeta APENAS Prometeus (`OLMO_PROMETEUS/.github/workflows/self-evolution.yml`). O sibling OLMO em `/mnt/c/Dev/Projetos/OLMO` continua intocado e Lucas pode seguir rodando PowerShell + OLMO independentemente. Boundary respeitado.

EV-B2 movido de `next` para `applied` com acceptance ajustado:
- `.github/workflows/self-evolution.yml` existe (sim).
- workflow roda em push/PR/schedule/dispatch (sim).
- Windows leg formalmente aposentado (criterio negativo B5 cumprido).
- Branch protection: human decision deferida explicitamente para rodada futura (item P2 `BRANCH-PROT` ja registrado em `BACKLOG.md`).

R-CI-DRIFT movido de `open` para `controlled`. Reabertura: trigger registrado em `SOTA-DECISIONS.md` + evidencia de uso real Windows + 2h debug orcado.

EV-B6 promovido de `planned` para `next` (manter exatamente 1 next por contrato `evolve.sh check`).

Trigger: B5 do plano `happy-drifting-naur.md`.

Risco: perder cobertura cross-OS em runtime real. Mitigacao: harness foi desenhado Bash-first / Linux-first desde o inicio; cobertura Windows era aspiracional, nao operacional.

Custo: 4 linhas removidas em workflow yml; sem mudanca em scripts.

Rollback: restaurar `strategy.matrix.os: [ubuntu-latest, windows-latest]` em `self-evolution.yml`. Reverter R-CI-DRIFT para `open` se reabrir.

Criterio negativo: se em 60d alguem precisar rodar Windows runner em CI por trigger real (nao reflexo), reabrir Windows leg com debug priorizado.

Proxima acao: nenhuma; CI em estado limpo. EV-B6 e o proximo batch quando chegar.

## Evidence-first applied to subagent reports (2026-04-28)

Decisao: relatorios de Explore/Plan subagents sao input, nao verdade. Antes de agir em uma claim de subagent, validar contra estado real do repo.

Trigger: planejamento de cherrypick OLMO -> Prometeus rodada 2026-04-28. Explore agent reportou "evolve.sh next sai mudo" e "ADR index orfao". Validacao antes do batch B1 mostrou: (a) `scripts/evolve.sh:85-88` ja emite item; (b) `docs/adr/0001-0007.md` + `README.md` existem e `integrity.sh check_adr_index` passa.

Acao: B1.1 reduzido a melhoria real do `evolve.sh next` (adicionar campo `acceptance` na saida + bloquear emissao se backlog tiver failures). B1.2 (remover `check_adr_index`) descartado — check nao e orfao.

Regra: aplicar a mesma doutrina "OLMO is precedent, not authority" recursivamente aos meus proprios subagents. Subagent report = hipotese a validar, nao fato.

Trigger futuro: qualquer plano baseado em claim de Explore que envolve "remover/retirar X" precisa rodar comando de verificacao antes do edit.

Risco: validacao adiciona ~1 minuto por claim; mitigacao: paralelo com outros reads.

Rollback: nao aplicavel (decisao de processo, nao codigo).

Criterio negativo: se a regra criar friction sem catch real em 30 dias, simplificar para "spot-check apenas em removals destrutivos".

## Taxonomy artifact deferred (2026-04-29)

Decisao: criar `TAXONOMY.md` em raiz **rejeitado** por falta de evidencia de convencao enterprise. Variantes (`shadow/TAXONOMY.md`, ADR, `ARCHITECTURE.md`, `Prometeus/wiki/Notes/Taxonomy.md`) tambem adiadas. Artefato reabre apenas se processo de cherrypick OLMO -> Prometeus surfacar necessidade concreta de doc consolidador.

Trigger: nota fim-de-sessao 2026-04-28 ("criar taxonomy.md") + pedido do usuario nesta sessao para validar contra convencao enterprise antes de criar.

Evidencia: 3 buscas web (`"TAXONOMY.md" site:github.com root repository convention`, `enterprise repository documentation standard root level files conventions 2026`, `repository taxonomy classification professional codebase structure naming`). Hits `taxonomy` em GitHub sao todos taxonomias-de-dominio: InstructLab knowledge tree para LLM tuning, TokenTaxonomyFramework (Inter-work Alliance), OpenTreeOfLife species reference, Statamic CMS feature. Nenhum e meta-doc classificando o proprio repo. Padroes enterprise reais para classificacao de repositorios: `README.md`, `ARCHITECTURE.md`, ADRs em `docs/adr/`, TOGAF Architecture Repository (multi-arquivo, framework EA), wiki interno (Confluence/Notion), GitHub Enterprise repository properties/policies — nenhum e arquivo unico `TAXONOMY.md`.

Acao: foco vira framework de cherrypicking OLMO -> Prometeus ancorado em `AGENTS.md > SOTA Research Gate` + `VALUES.md` v2.5 (4 raizes + V1-V7) + doctrine "OLMO precedente, nao autoridade". Sem framework novo; uso explicito do que ja existe.

Nao-trigger: pedido reflexo ou estetico para "ter um TAXONOMY.md porque parece profissional".

Risco: rejeitar pode adiar consolidacao util se padroes emergirem mais tarde. Mitigacao: criterio de reabertura abaixo. Aceitar sem evidencia inflaria o repo (anti-pattern KBP-style).

Rollback: nao aplicavel (decisao de adiamento, nao de codigo).

Criterio negativo: se em 90 dias 3+ batches de cherrypick produzirem necessidade concreta de doc consolidador, reabrir escolha entre Opcao A (ADR), Opcao B (`ARCHITECTURE.md` global), Opcao C (`shadow/REPOSITORY-TYPES.md` operacional) com base no padrao real observado.

Fontes:

- `https://github.com/kmindi/special-files-in-repository-root`
- `https://medium.com/code-factory-berlin/github-repository-structure-best-practices-248e6effc405`
- `https://bps-enterprise-devsecops.github.io/reponaming.html`
- `https://pubs.opengroup.org/architecture/togaf91-doc/arch/chap41.html`
- `https://github.com/instructlab/taxonomy`
- `https://github.com/InterWorkAlliance/TokenTaxonomyFramework`

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
| 2026-04-26 | Triadic stack debate consolidation | D04 aplicado + entry curta substitui PLAN+MATRIX (727L → 25L); D01/D09 confirmados; D05/D07/D08/D10 deferidos | commit `50979f9`, `shadow/SOTA-DECISIONS.md`, `shadow/INCORPORATION-LOG.md`, `shadow/EVIDENCE-LOG.md` |
| 2026-04-27 | OLMO/OLMO_GENESIS selective adaptation scan | Leitura read-only autorizada; padroes aproveitaveis separados de runtime/ruido bloqueado | `shadow/SOTA-DECISIONS.md`, `shadow/EVIDENCE-LOG.md`, `internal/evolution/backlog.json`, `shadow/BACKLOG.md` |
| 2026-04-27 | Prometeus values and gap lens | `OLMO/VALUES.md` adaptado para o laboratorio; valores viram filtro de gaps | `VALUES.md`, `PROJECT_CONTRACT.md`, `AGENTS.md`, `TREE.md`, `shadow/FOUNDATION.md`, `scripts/check.sh`, `scripts/integrity.sh` |
| 2026-04-27 | OLMO plans as maturity floor | OLMO tratado como piso profissional; Prometeus precisa exceder com boundary, evidencia, privacidade e rollback | `VALUES.md`, `shadow/SOTA-DECISIONS.md`, `scripts/integrity.sh` |
| 2026-04-27 | Infra improvement research scan | Pesquisa externa confirma foco em simplicidade, guardrails, tracing quando houver agente real e WSL ext4; proxima infra deve atacar drift/CI/evidencia antes de runtime | `shadow/SOTA-DECISIONS.md`, `shadow/EVIDENCE-LOG.md` |
| 2026-04-27 | ADR sanitation pass | Extraidas decisoes centrais para ADRs 0002-0005 e corrigido drift de path canonico em docs ativos de agentes/orquestracao | `docs/adr/`, `shadow/AGENT-MODULES.md`, `shadow/AGENT-USAGE.md`, `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md` |
| 2026-04-27 | SOTA alignment batch 01 triage | Implementado CI local read-only + stale evidence warning; PHI prompt hook, handoff JSON, value commit gate e issues:write deferidos/rejeitados | `scripts/simulate-ci.sh`, `scripts/check.sh`, `scripts/integrity.sh`, `shadow/BACKLOG.md`, `internal/evolution/backlog.json` |
| 2026-04-27 | Frontier orchestration objective | V9 adicionado: LLMs orquestrados para educacao, pesquisa, EBM e auxilio direto, com modelos escolhidos por eval local e HITL | `VALUES.md`, `PROJECT_CONTRACT.md`, `shadow/SOTA-DECISIONS.md` |
| 2026-04-27 | Multimodel SOTA efficacy priority | Multimodel vira hipotese operacional preferida; SOTA e eficacia acima de custo, que vira constraint de viabilidade | `VALUES.md`, `PROJECT_CONTRACT.md`, `docs/adr/0007-multimodel-sota-efficacy.md` |
| 2026-04-28 | Values drift correction | V1-V9 + Gap Lens -> 4 raizes + V1-V7 com frontmatter YAML (related: Ignis Animi/Flammula of uncertainty; notes: Notion migracao); removido Identidade, OLMO-piso, Gap Lens, Anti-valores prosa, V9 (em ADR 0007) | `VALUES.md` v2.5, `scripts/check.sh`, `scripts/integrity.sh`, `AGENTS.md`, `PROJECT_CONTRACT.md`, `shadow/HANDOFF.md`, `shadow/FOUNDATION.md` |
| 2026-04-29 | Taxonomy artifact deferred | TAXONOMY.md root + variantes adiados sem evidencia de convencao enterprise; reabre se cherrypick surfacar necessidade em 90d | `shadow/SOTA-DECISIONS.md`, `shadow/HANDOFF.md`, `~/.claude/plans/rosy-roaming-karp.md` |

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
