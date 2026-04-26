# SOTA Stack Comparison 2026-04-26

Status: comparison
Escopo: comparar propostas Claude, Gemini, consolidado, Codex e pesquisa SOTA adicional de 2026-04-26.

Fontes locais principais:

- `shadow/SOTA-STACK-CLAUDE-RESPONSE-2026-04-26.md`
- `shadow/SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md`
- `shadow/SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md`
- `shadow/SOTA-STACK-CODEX-PROPOSAL-2026-04-26.md`
- `AGENTS.md`, `PROJECT_CONTRACT.md`, `shadow/AGENT-USAGE.md`, `shadow/WORK-LANES.md`, `shadow/SOTA-DECISIONS.md`

Fontes externas consultadas nesta rodada:

- OpenAI Codex: https://github.com/openai/codex
- OpenAI Agents SDK: https://openai.github.io/openai-agents-python/
- Anthropic Claude Code docs: https://docs.anthropic.com/en/docs/claude-code/overview
- Anthropic subagents: https://docs.anthropic.com/en/docs/claude-code/sub-agents
- Anthropic hooks: https://docs.anthropic.com/en/docs/claude-code/hooks
- Gemini CLI: https://github.com/google-gemini/gemini-cli
- Gemini API model docs: https://ai.google.dev/gemini-api/docs/models/gemini-v2
- Google ADK: https://google.github.io/adk-docs/get-started/about/
- OpenHands: https://github.com/OpenHands/OpenHands
- Cline: https://github.com/cline/cline
- Aider: https://github.com/aider-ai/aider
- LangGraph: https://github.com/langchain-ai/langgraph
- CrewAI: https://github.com/crewAIInc/crewAI
- MCP reference servers: https://github.com/modelcontextprotocol/servers

## 1. Escolha recomendada

Escolha: seguir a proposta Codex como decisao operacional, com a tese Claude como apoio principal e Gemini como adversario tecnico, nao como plano executavel.

Confianca: ALTA para bloqueios e toolchain conservador; MEDIA para path canonico ate confirmacao humana final.

Resumo:

- Aceitar: reconciliar workspace canonico como P0; manter Ubuntu 24.04; Bash como contrato; Codex/Claude/Gemini como ferramentas sob demanda; `uv`/`ruff` e `pnpm`/`vite`/`biome` por projeto; `bun` experimento.
- Adiar: `git add --renormalize .`, `core.filemode false`, recuperacao de `private-learning/`, validacao remota e benchmark Obsidian/WSL como stages separados.
- Rejeitar agora: migracao automatica, skills locais imediatas, MCP proprio, hooks novos, runtime agentico, Gemini customtools/bash nao-supervisionado, instalacao global de toolchain sem projeto.

## 2. Criterio de desempate

1. Contrato local vence modelo. `AGENTS.md` e `PROJECT_CONTRACT.md` bloqueiam write externo, runtime agentico e scaffold sem gate.
2. Evidencia local vence claim de benchmark. Stars, blogs e "SOTA" nao substituem `EVIDENCE-LOG.md`.
3. Fonte primaria vence resposta de modelo. Claims de preco, versao, sandbox e contexto precisam fonte oficial atual.
4. Menor mudanca reversivel vence plano ambicioso. Este repo e laboratorio pequeno de baixo risco.

## 3. Comparacao por proposta

| Proposta | Ponto forte | Ponto fraco | Veredito |
|---|---|---|---|
| Claude | Identifica o risco central: inflar runtime sem 3 usos reais; aponta path canonico como urgencia; bloqueia skills e Ubuntu 26.04. | Inclui claims externos fortes de modelos/precos que precisam verificacao primaria no dia da decisao. | Usar como apoio principal de governanca. |
| Gemini inicial | Pressiona pontos tecnicos reais: ext4 WSL, Ubuntu 24.04, bash para agentes, toolchain moderno. | Recomenda skills locais imediatas, orquestracao via APIs e adocao de toolchain "amanha"; conflita com contract local. | Usar como adversario tecnico; rejeitar execucao direta. |
| Gemini consolidado | Resume bem: path drift, Git index, private-learning, Ubuntu 24.04, toolchain. | Mistura varias acoes D1: atualizar AGENTS, copiar archive, renormalizar git, gh run. Isso aumenta blast radius. | Dividir em stages; nao executar em bloco. |
| Codex proposal | Melhor aderencia ao contrato: separa path, git hygiene, archive, toolchain e runtime; marca claims nao verificados. | Menos agressiva na captura de performance ext4 e nao fez browsing durante a proposta independente. | Escolha operacional. Complementar com pesquisa SOTA externa. |
| Pesquisa SOTA adicional | Confirma tracao real de Codex, Claude Code, Gemini CLI, opencode, OpenHands, Cline, Aider, LangGraph, CrewAI, MCP. | Stars medem adocao, nao seguranca nem adequacao local. | Usar para benchmark manual, nao para adotar runtime. |

## 4. Decisoes com pq sim, pq nao, riscos e confianca

### D1. Workspace canonico

Decisao: confirmar com Lucas e formalizar `/home/lucasmiachon/projects/OLMO_PROMETEUS` como canonico se esta for a fonte real.

PQ SIM:

- Claude aponta divergencia entre docs Windows e cwd real em `/home/...`.
- Gemini consolidado diz que `AGENTS.md`/`FOUNDATION.md` ainda citam `C:` enquanto a operacao real ja ocorre em `~/projects`.
- Codex identifica isso como P0 e mais importante que escolher toolchain.

PQ NAO:

- `AGENTS.md` e `PROJECT_CONTRACT.md` ainda definem boundary antiga em `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Alterar boundary sem decisao humana pode legitimar workspace errado.

Riscos:

- Agente escrever no path errado.
- Obsidian/Windows quebrar em `\\wsl.localhost`.
- Drift documental virar instrucao contraditoria para todos os agentes.

Confianca: MEDIA-ALTA. Alta de que o drift precisa resolucao; media sobre o path final ate Lucas confirmar.

Acao: decisao humana curta; depois patch minimo de contratos.

### D2. Git index / CRLF

Decisao: nao rodar `git add --renormalize .` ainda; auditar diff e line endings em stage separado.

PQ SIM:

- Gemini 3.1 e consolidado diagnosticam staleness de indice e CRLF/LF.
- Isso explica parte do working tree sujo.

PQ NAO:

- O worktree tem varias mudancas existentes; renormalizacao mistura mudanca mecanica com possiveis edits reais.
- O contrato local exige nao reverter nem mascarar alteracoes do usuario.

Riscos:

- Perder autoria semantica do diff.
- Commit grande mecanico esconder regressao de wiki/json.

Confianca: MEDIA. Diagnostico plausivel; acao ampla demais para D1.

Acao: `git diff --check`, inspecao de line endings e commit separado se aprovado.

### D3. `private-learning/`

Decisao: bloquear copia/leitura do archive ate permissao explicita.

PQ SIM:

- Gemini diz que a pasta nao migrou e esta no archive.
- Pode ser material pessoal local.

PQ NAO:

- Qualquer read/write externo exige permissao humana citando caminho e acao.
- Pode conter dado privado ou sensivel.

Riscos:

- Vazamento de material pessoal.
- Misturar cockpit privado com repo versionado.

Confianca: ALTA.

Acao: pedir permissao apenas quando houver necessidade real.

### D4. Ubuntu / WSL

Decisao: manter Ubuntu 24.04 LTS e bloquear Ubuntu 26.04 por enquanto.

PQ SIM:

- Claude, Gemini e Codex convergem em bloquear 26.04 por maturidade.
- O ganho local de 26.04 nao foi medido.

PQ NAO:

- 26.04 LTS existe e traz recursos novos, mas isso e insuficiente para este repo.

Riscos:

- Upgrade prematuro quebrar WSL, Obsidian, hooks ou build.
- Desviar foco para manutencao de SO.

Confianca: ALTA.

Acao: manter 24.04; revisar apos 26.04.1 ou trigger concreto.

### D5. Shell

Decisao: Bash como contrato; zsh/fish/nushell apenas conforto humano local.

PQ SIM:

- Todos convergem que scripts/agentes devem receber Bash.
- Harness atual e Bash-first.

PQ NAO:

- Gemini sugere nushell para humano em JSON/CSV; isso pode ser util fora do contrato.

Riscos:

- Trocar shell versionado aumenta suporte e confusao.

Confianca: ALTA.

Acao: manter.

### D6. Agentes Big Three

Decisao: Codex como executor/auditor local; Claude como arquiteto/revisor em decisoes sensiveis; Gemini como pesquisa SOTA/long-context/multimodal; ChatGPT manual se Lucas acionar.

PQ SIM:

- Claude e Codex convergem em triade sem runtime.
- Pesquisa SOTA confirma que Codex, Claude Code e Gemini CLI sao stacks fortes, mas ferramentas oficiais continuam com risco de permissoes, hooks, MCP e dados.

PQ NAO:

- Gemini inicial quer scripts de orquestracao com APIs e customtools; isso cria runtime.

Riscos:

- Custo de tokens.
- Prompt externo com PHI.
- Deriva para automacao permanente.

Confianca: ALTA.

Acao: manter como uso sob demanda, nao instalar scaffold.

### D7. Toolchain Python/TS

Decisao: `uv` + `ruff` para projeto Python real; `pnpm` + `vite` + `biome` para app TS; `bun` experimento; `esbuild` direto so em scripts/libs simples.

PQ SIM:

- Claude, Gemini consolidado e Codex convergem parcialmente.
- Pesquisa SOTA confirma que essas ferramentas sao mainstream em 2026, mas isso nao exige instalacao agora.

PQ NAO:

- Gemini inicial recomenda adocao imediata de `uv`/`ruff`/`bun`/`biome`; sem projeto ativo, vira peso morto.

Riscos:

- Instalar tudo por reflexo.
- Criar config sem consumidor.
- Fazer toolchain virar arquitetura.

Confianca: ALTA.

Acao: documentar como default futuro; nao instalar.

### D8. Skills, hooks, MCP e runtime agentico

Decisao: bloquear agora.

PQ SIM:

- O estado da arte externo mostra muita tracao: Claude Code subagents/hooks, OpenAI Agents SDK, Google ADK, LangGraph, CrewAI, MCP, OpenHands, Cline.
- Essas ferramentas sao relevantes como pesquisa.

PQ NAO:

- `AGENT-USAGE.md` exige procedure operational, evidencia, 30 dias e aprovacao para skill local.
- `SOTA-DECISIONS.md` exige 3 evidencias reais de retrabalho para runtime agentico.
- MCP/hook aumenta superficie de dados e comando.

Riscos:

- Automacao escrever fora do repo.
- Expor dado sensivel em tracing/conector.
- Criar sprawl dificil de remover.

Confianca: ALTA.

Acao: usar como benchmark manual; nao incorporar.

## 5. Plano escolhido

1. Fechar decisao humana sobre workspace canonico.
2. Fazer patch minimo dos contratos de path.
3. Rodar `./scripts/check.sh`.
4. Separar stage de Git hygiene.
5. Separar stage de Obsidian validation.
6. Separar stage de remote validation.
7. Rodar benchmark manual de 2-3 CLIs em tarefa sintetica pequena, sem write externo e sem PHI.
8. Registrar evidencia antes de qualquer promocao.

## 6. Fresh-eyes GPT-5.5 xhigh

Gauss (`gpt-5.5`, `xhigh`) revisou a comparacao sem editar arquivos e confirmou o veredito geral, com tres ajustes:

1. A escolha e melhor descrita como **plano operacional contract-constrained**, nao como ranking neutro do SOTA absoluto.
2. A Comparison deve separar mais explicitamente os **diagnosticos Gemini aceitos** (ext4, Bash, Ubuntu 24.04, Git hygiene, `private-learning/`) das **acoes Gemini rejeitadas** (skills imediatas, runtime API, toolchain sem projeto).
3. A confianca no path canonico deve ficar abaixo de ALTA ate confirmacao humana explicita, porque ainda ha contrato antigo apontando para `C:\Dev\Projetos\OLMO_PROMETEUS`.

Efeito no veredito: nao muda a escolha final; baixa a confianca do path canonico para MEDIA-ALTA e reforca que Git hygiene e `private-learning/` sao riscos reais, mas staged/bloqueados por boundary.

## 7. Veredito

Minha escolha e Codex proposal + tese Claude, com Gemini como teste de estresse.

Motivo: ela maximiza reversibilidade e minimiza superficie ativa. O SOTA externo confirma que ha muita coisa boa para testar, mas nao derruba o fato local: este repo ainda precisa resolver path, git hygiene e evidencia de uso antes de runtime.

Nao escolheria a proposta Gemini inicial como plano, porque ela mistura boas observacoes tecnicas com acoes que violam o contract local: skills imediatas, orquestracao API e toolchain sem projeto.

Nao escolheria o consolidado como D1 literal, porque ele agrupa muitas acoes sensiveis no mesmo dia.

Confianca final: ALTA para nao adotar runtime/hook/MCP/skill agora; ALTA para manter Ubuntu 24.04/Bash/toolchain por projeto; MEDIA-ALTA para formalizar `/home/...` como canonico apos confirmacao humana.

Coautoria: Lucas + GPT-5.x-Codex (xhigh)
