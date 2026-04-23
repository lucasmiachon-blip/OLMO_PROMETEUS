# SOTA para AGENTS.md, Skills e Time Multimodelo

Data: 2026-04-22
Escopo: open OLMO_PROMETEUS
Objetivo: definir o estado da arte operacional para instrucoes de agentes, skills, guardrails e composicao de um time multimodelo de alta sinalizacao e baixo risco.

## TL;DR

O padrao mais racional hoje e:

- `AGENTS.md` como contrato aberto e portavel entre agentes.
- `skills` para workflows repetiveis com progressive disclosure.
- `subagents` estreitos, opinativos e com superficie de ferramentas minima.
- `rules` e `guardrails` para seguranca e custo; nao para esconder logica de negocio.
- `hooks` so para automacao deterministicamente util; no Codex para Windows isso ainda nao deve ser base da arquitetura.
- `human-in-the-loop` continua obrigatorio para merge, producao e promocao para o repo principal.

## 1. O que ja e consenso pratico em 2026

### 1.1 AGENTS.md virou o formato mais portavel

O formato `AGENTS.md` deixou de ser um hack local e virou uma convencao aberta. Hoje ele ja e reconhecido por Codex, GitHub Copilot e pelo ecossistema `agents.md`.

Implicacao pratica para o Prometeus:

- use `AGENTS.md` como contrato central do repositorio;
- mantenha o README humano e o AGENTS focado em build, teste, arquitetura, convencoes e riscos;
- use arquivos aninhados apenas quando subarvores realmente divergem.

### 1.2 Skills sao o melhor formato para workflow reutilizavel

O padrao moderno nao e enfiar tudo em um prompt gigante. E separar:

- instrucoes sempre carregadas = metadata;
- instrucoes operacionais = `SKILL.md`;
- detalhes pesados = `references/`;
- comportamento deterministico = `scripts/`;
- templates/recursos = `assets/`.

Isso reduz custo de contexto e melhora acionamento.

### 1.3 O time de agentes deve ser estreito, nao heroico

A documentacao mais madura converge para o mesmo principio: os melhores agentes customizados sao estreitos e opinativos.

O erro comum e criar um "super agente" que faz tudo.
O acerto e criar papeis separados:

- orquestrador;
- explorador;
- reviewer;
- pesquisador de docs;
- pesquisador multimodal/long-context;
- guardrail checker.

## 2. SOTA de AGENTS.md

## 2.1 O que um bom AGENTS.md precisa conter

O que mais aparece como pratica vencedora nas fontes oficiais:

- resumo curto do repositorio e do que ele faz;
- comandos validados de bootstrap, build, test, lint e run;
- ordem correta dos comandos;
- precondicoes e workarounds conhecidos;
- arquitetura e layout principal;
- validacoes obrigatorias antes de encerrar tarefa;
- convencoes de codigo e testes;
- regras de risco e paths protegidos.

## 2.2 O que nao colocar

- tarefas temporarias do sprint;
- filosofia vaga sem acao;
- texto enorme duplicando README e docs;
- instrucoes desatualizadas ou nao validadas;
- detalhes que seriam melhores em um skill.

## 2.3 Regra de ouro

`AGENTS.md` deve responder rapidamente:

- como este projeto funciona;
- como modificar com seguranca;
- como validar uma mudanca;
- o que nunca deve ser tocado sem permissao.

## 2.4 Estrategia recomendada para open OLMO_PROMETEUS

Criar:

- `AGENTS.md` na raiz: contrato global;
- `private-learning/AGENTS.md` so se houver comportamento muito diferente;
- `shadow/AGENTS.md` para regras de pesquisa, promocao e experimentos;
- evitar espalhar varios arquivos se as instrucoes forem parecidas.

## 3. SOTA de Skills

## 3.1 Skill boa e enxuta

A melhor orientacao encontrada para skills e a mesma no Codex local e na documentacao oficial:

- metadata forte (`name`, `description`) para trigger;
- corpo curto, idealmente bem abaixo de 500 linhas;
- exemplos pequenos;
- referencias fora do corpo principal;
- scripts quando a operacao precisa de determinismo;
- assets quando o output precisa de template ou recurso reutilizavel.

## 3.2 Progressive disclosure e obrigatorio

O padrao vencedor e:

1. metadata sempre presente;
2. `SKILL.md` so quando a skill ativa;
3. referencias e scripts apenas quando necessario.

Se a skill exigir tudo de uma vez, ela esta grande demais.

## 3.3 Descricao da skill e o gatilho principal

A descricao precisa explicar:

- o que a skill faz;
- quando deve ser usada;
- quais termos ou contextos devem disparar o uso.

Descricao vaga gera undertrigger.
Descricao inchada gera falso positivo.

## 3.4 Skills iniciais recomendadas para o Prometeus

Primeiro lote:

- `digest-4p`: converte inbox e notas em digest de 4 paragrafos.
- `study-track-done`: move temas entre `capturado`, `em-estudo`, `aplicando`, `done`.
- `promotion-gate`: decide se algo continua privado, vira experimento ou candidato.
- `repo-reality-check`: lembra e executa build/test/lint basicos antes de encerrar.
- `research-synthesis`: padroniza coleta e sintese com fontes e links.
- `docs-drift-check`: compara docs vs artefatos e marca divergencias.

## 3.5 O que evitar em skills

- skill que so repete conhecimento generico do modelo;
- skill que depende de texto enorme no corpo;
- skill sem criterio de trigger;
- skill sem eval minima;
- skill com scripts que fazem efeitos colaterais opacos.

## 4. Rules, hooks e guardrails

## 4.1 Rules

Rules sao boas para uma coisa: controlar comandos fora do sandbox por prefixo.

Use para:

- `git pull`;
- `gh pr view`;
- `npm test` em certos contextos;
- comandos recorrentes que exigem aprovacao previsivel.

Nao use para:

- impor politica sem transparencia;
- modelar workflow de negocio;
- criar automacao opaca demais.

## 4.2 Hooks

Hooks sao poderosos, mas ainda experimentais em ferramentas importantes.
No Codex oficial, hooks continuam experimentais e estao temporariamente desabilitados no Windows.

Conclusao pratica para este ambiente:

- no `open OLMO_PROMETEUS` em Windows, nao basear a arquitetura em hooks do Codex;
- se hooks forem usados, que sejam opcionais e facilmente removiveis;
- priorizar scripts explicitos, comandos dedicados e skills.

## 4.3 Guardrails

O melhor padrao atual para times de agentes e usar guardrails em tres niveis:

- input: bloqueia pedidos indevidos antes do modelo caro rodar;
- output: valida a saida final antes de seguir;
- tool-level: valida cada tool call sensivel.

Quando o fluxo tem handoffs ou especialistas, tool guardrails sao mais confiaveis do que depender apenas de guardrails de agente.

## 5. SOTA de subagentes

## 5.1 Estrutura vencedora

Subagentes devem ser:

- estreitos;
- opinativos;
- com ferramental compativel com a funcao;
- delegados explicitamente;
- sem recursao profunda por padrao.

## 5.2 Defaults racionais

Para Codex, a propria documentacao aponta defaults bem sensatos:

- `max_threads` em torno de `6`;
- `max_depth = 1` por padrao;
- mais profundidade so quando realmente precisar.

Subir profundidade cedo demais aumenta:

- custo;
- latencia;
- imprevisibilidade;
- fan-out inutil.

## 5.3 Padrao de papeis

O melhor padrao observado para engenharia:

- `orchestrator`: entende objetivo, divide, integra e decide.
- `explorer`: mapeia o terreno e retorna evidencia.
- `reviewer`: procura bugs, regressao, seguranca, testes.
- `docs_researcher`: verifica comportamento em docs primarias.
- `multimodal_researcher`: opera long-context, PDFs, imagens, multimodal.
- `guardrail_checker`: valida se a proposta viola contrato, risco ou seguranca.

## 6. Composicao multimodelo recomendada

## 6.1 OpenAI / Codex

### Papel

- orquestracao principal;
- implementacao end-to-end;
- integracao de resultados;
- edicao local com tool use forte;
- PR review de alta qualidade;
- definicao de contratos (`AGENTS.md`, skills, subagents).

### Modelos recomendados

- `gpt-5.4`: melhor escolha geral para complex reasoning, coding e workflows profissionais.
- `gpt-5.4-mini`: melhor mini para coding, computer use e subagents de alto volume.
- `gpt-5.3-codex`: excelente para tarefas de agentic coding em ambientes tipo Codex.

### Uso recomendado no Prometeus

- `gpt-5.4` = reviewer e orquestrador pesado;
- `gpt-5.4-mini` = docs researcher, classificadores internos, agentes baratos de apoio;
- `gpt-5.3-codex` = executor de coding quando estivermos 100% dentro do loop de implementacao em Codex.

## 6.2 Anthropic / Claude Code

### Papel

- segunda opiniao forte para revisao;
- memoria de projeto via `CLAUDE.md`;
- subagentes especializados por Markdown com frontmatter simples;
- hooks maduros para Linux/macOS;
- slash commands uteis para fluxos recorrentes.

### Modelos recomendados segundo a propria doc de tool use

- `Claude Opus 4` e `Claude Sonnet 4` para tools complexas e queries ambiguas;
- `Claude Haiku 3.5` para ferramentas simples e fluxos mais baratos.

### Uso recomendado no Prometeus

- Sonnet 4 = revisor independente, auditor de doc, analisador de edge cases;
- Haiku 3.5 = guardrails baratos, classificacao simples, triagem.

## 6.3 Google / Gemini

### Papel

- leitura de contexto enorme;
- pesquisa multimodal;
- analise de PDFs, audio, video e codebases grandes;
- extracao estruturada com schema;
- caching para workloads repetitivos grandes.

### Modelos recomendados

- `Gemini 2.5 Pro`: melhor para reasoning pesado, codebases grandes e long context.
- `Gemini 2.5 Flash`: melhor preco/performance para workloads agenticos de maior volume.
- `Gemini 2.5 Flash-Lite`: melhor para throughput e baixo custo.

### Uso recomendado no Prometeus

- 2.5 Pro = pesquisador multimodal / long-context;
- 2.5 Flash = pesquisador de alta vazao com bom equilibrio;
- 2.5 Flash-Lite = extracao e classificacao baratas.

## 7. Arquitetura recomendada para o time do Prometeus

## 7.1 Time-base

### 1. Orchestrator

- plataforma: Codex
- modelo: `gpt-5.4`
- responsabilidade: decompor tarefas, decidir lanes, integrar resultados, validar promocao

### 2. Explorer

- plataforma: Codex custom agent
- modelo: `gpt-5.4-mini` ou codex spark-like quando disponivel
- responsabilidade: mapear codebase, arquivos, comandos, dependencias
- restricao: read-only

### 3. Reviewer

- plataforma: Codex custom agent ou Claude
- modelo: `gpt-5.4` ou `Claude Sonnet 4`
- responsabilidade: bugs, seguranca, regressao, testes
- restricao: read-only por padrao

### 4. Docs Researcher

- plataforma: Codex
- modelo: `gpt-5.4-mini`
- responsabilidade: verificar docs primarias e comportamento de API
- restricao: sem editar codigo

### 5. Multimodal Researcher

- plataforma: Gemini
- modelo: `Gemini 2.5 Pro`
- responsabilidade: PDFs longos, imagens, audio, video, long context, grandes lotes de material

### 6. Cheap Guardrail

- plataforma: Claude ou Gemini
- modelo: `Haiku 3.5` ou `Gemini 2.5 Flash-Lite`
- responsabilidade: triagem de input, classificacao e bloqueios baratos antes do modelo caro

## 7.2 Regra de passagem entre agentes

- o orquestrador decide o destino;
- o explorador nao corrige;
- o reviewer nao implementa;
- o docs researcher nao inventa;
- o multimodal researcher nao vira owner do repo;
- merge e promocao continuam humanos.

## 8. Blueprint recomendado para o open OLMO_PROMETEUS

## 8.1 Arquivos

- `AGENTS.md` na raiz
- `shadow/TEAM-ARCHITECTURE.md`
- `shadow/SOTA-AGENTS-SKILLS-TEAM-2026-04-22.md`
- `.agents/skills/`
- `.codex/agents/`

## 8.2 Skills iniciais

- `digest-4p`
- `study-track-done`
- `promotion-gate`
- `repo-reality-check`
- `research-synthesis`
- `docs-drift-check`

## 8.3 Subagents iniciais

- `explorer`
- `reviewer`
- `docs_researcher`
- `multimodal_researcher`
- `guardrail_checker`

## 8.4 Politica de operacao

- `AGENTS.md` curto e validado
- skills so para workflows repetidos
- subagentes so por pedido explicito ou fluxo claramente paralelo
- `max_depth = 1`
- hooks do Codex fora do caminho critico no Windows
- toda promocao para `OLMO` depende de gate humano

## 9. O que eu recomendo fazer agora

1. Criar um `AGENTS.md` raiz do `open OLMO_PROMETEUS` alinhado com este blueprint.
2. Criar as 3 primeiras skills:
   - `digest-4p`
   - `study-track-done`
   - `promotion-gate`
3. Criar 3 subagentes primeiro:
   - `explorer`
   - `reviewer`
   - `docs_researcher`
4. Rodar tudo com uma politica simples:
   - Codex orquestra
   - Gemini pesquisa material grande/multimodal
   - Claude faz segunda opiniao e auditoria
5. Medir:
   - tempo para fechar tarefa
   - taxa de retrabalho
   - quantos itens viram candidato de migracao com qualidade

## 10. Fontes primarias usadas

### OpenAI / Codex

- Codex AGENTS.md: https://developers.openai.com/codex/guides/agents-md
- Codex Skills: https://developers.openai.com/codex/skills
- Codex Rules: https://developers.openai.com/codex/rules
- Codex Hooks: https://developers.openai.com/codex/hooks
- Codex Subagents: https://developers.openai.com/codex/subagents
- Building an AI-Native Engineering Team: https://developers.openai.com/codex/guides/build-ai-native-engineering-team
- OpenAI Models: https://developers.openai.com/api/docs/models
- GPT-5.4: https://developers.openai.com/api/docs/models/gpt-5.4
- GPT-5.4 mini: https://developers.openai.com/api/docs/models/gpt-5.4-mini
- GPT-5.3-Codex: https://developers.openai.com/api/docs/models/gpt-5.3-codex
- Using skills to accelerate OSS maintenance: https://developers.openai.com/blog/skills-agents-sdk
- Agents SDK overview: https://openai.github.io/openai-agents-python/
- Agents SDK agents: https://openai.github.io/openai-agents-python/agents/
- Agents SDK handoffs: https://openai.github.io/openai-agents-python/handoffs/
- Agents SDK guardrails: https://openai.github.io/openai-agents-python/guardrails/

### Anthropic

- Claude Code subagents: https://docs.anthropic.com/en/docs/claude-code/sub-agents
- Claude Code hooks: https://docs.anthropic.com/en/docs/claude-code/hooks
- Claude Code memory / CLAUDE.md: https://docs.anthropic.com/en/docs/claude-code/memory
- Claude Code settings: https://docs.anthropic.com/en/docs/claude-code/settings
- Claude Code slash commands: https://docs.anthropic.com/en/docs/claude-code/slash-commands
- Tool use and model selection: https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/implement-tool-use

### Google / Gemini

- Gemini models: https://ai.google.dev/models/gemini
- Gemini function calling: https://ai.google.dev/gemini-api/docs/function-calling
- Gemini system instructions: https://ai.google.dev/gemini-api/docs/system-instructions
- Gemini structured outputs: https://ai.google.dev/gemini-api/docs/structured-output
- Gemini context caching: https://ai.google.dev/gemini-api/docs/caching/
- Gemini long context: https://ai.google.dev/gemini-api/docs/long-context

### AGENTS.md ecosystem

- AGENTS.md open format: https://agents.md/
- GitHub Copilot repository instructions and AGENTS.md support: https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions

### Contexto local do proprio stack

- Codex skill-creator global: `C:\Users\lucas\.codex\skills\.system\skill-creator\SKILL.md`
- Codex openai-docs global: `C:\Users\lucas\.codex\skills\.system\openai-docs\SKILL.md`
- skill-creator local do workspace anterior, usado apenas como referencia historica durante a criacao inicial
