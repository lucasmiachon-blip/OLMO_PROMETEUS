# SOTA Stack 2026-04-26

Status: experiment
Purpose: preparar a conversa de 2026-04-27 entre Lucas + Codex/ChatGPT 5.5 + Gemini, como laboratorio de estado da arte para stack agentico, Linux, shell e toolchain. Nao e trilha de iniciante; e decisao profissional com gate, evidencia e rollback.

## Pergunta

Qual stack usar no Prometeus para CLIs agenticas, multimodel, linguagens, Linux, shell e ferramentas TS/Python?

## Metodo

- Pesquisa independente em fontes primarias/oficiais quando possivel.
- Separar fato, inferencia e decisao operacional.
- Usar o relatorio externo gerado por Opus como hipotese inicial, nao como autoridade.
- Nao alterar runtime, shell, distro, toolchain ou MCP sem trigger, rollback e harness.

## Achados verificaveis

### Codex CLI

Fatos:

- OpenAI documenta Codex CLI como agente local open-source que le, modifica e roda codigo, com modos `Suggest`, `Auto Edit` e `Full Auto`.
- A doc de ajuda da OpenAI descreve instalacao via `npm install -g @openai/codex`, auth via API key ou login, e Windows como experimental/potencialmente via WSL.
- O README do repo `openai/codex` mostra a implementacao Rust como CLI mantida e expõe sandbox `read-only`, `workspace-write` e `danger-full-access`.
- A pagina de modelos da OpenAI usada nesta pesquisa confirma `gpt-5.2-codex` com `low`, `medium`, `high` e `xhigh`, contexto de 400k e output max de 128k.

Inferencia:

- Para este repo, Codex continua bom como executor/verificador rigoroso, mas nao justifica criar runtime local novo.
- O contrato `AGENTS.md` segue sendo a ponte portavel correta.

Fontes:

- OpenAI Help: https://help.openai.com/en/articles/11096431-openai-codex-ci-getting-started
- OpenAI Codex repo: https://github.com/openai/codex/blob/main/codex-rs/README.md
- OpenAI model docs: https://developers.openai.com/api/docs/models/gpt-5.2-codex

### Gemini CLI e Gemini API

Fatos:

- A doc oficial do Gemini CLI descreve a ferramenta como agente open-source de terminal, com free tier de 60 requests/min e 1.000 requests/day, Gemini 2.5 Pro, 1M context, tools embutidas, Google Search grounding, file ops, shell, web fetching, MCP e Apache 2.0.
- A doc oficial do Gemini API lista `gemini-3.1-pro-preview` como preview atual, com input token limit de 1.048.576 e output de 65.536.
- A doc oficial do Gemini API ainda lista `gemini-2.5-pro` como modelo avancado para tarefas complexas, deep reasoning e coding.
- Preview/experimental em Gemini tem politica de estabilidade menor; a doc recomenda atenção aos padroes de versionamento.

Baseline de modelos ajustado em 2026-04-26:

| Uso | Modelo alvo | Status | Motivo |
|---|---|---|---|
| melhor Gemini para avaliacao SOTA/multimodal/agentic coding | `gemini-3.1-pro-preview` | preview oficial | melhor Gemini publico para inteligencia, software engineering e agentic workflows |
| baseline Gemini mais conservador para pesquisa/codigo | `gemini-2.5-pro` | modelo avancado 2.5 | usar se preview 3.1 estiver instavel, caro ou indisponivel |
| custo/latencia/testes exploratorios | `gemini-2.5-flash` ou alias atual do CLI | stable/CLI default conforme conta | bom para volume; nao usar como juiz final de arquitetura |
| endpoint agentico especializado | `gemini-3.1-pro-preview-customtools` | preview oficial | opcao para workflows com bash e custom tools; nao usar sem teste real |

Inferencia:

- Gemini e o melhor stakeholder para multimodal, agentic workflows e contexto longo; a versao `gemini-3.1-pro-preview` foi confirmada em fonte oficial, mas o claim de 2M context nao foi confirmado.
- O modelo alvo verificavel para API hoje e `gemini-3.1-pro-preview`; `gemini-2.5-pro` fica como baseline alternativo mais conservador.

Fontes:

- Gemini CLI docs: https://google-gemini.github.io/gemini-cli/
- Gemini CLI detailed docs: https://google-gemini.github.io/gemini-cli/docs/
- Gemini API models: https://ai.google.dev/gemini-api/docs/models/gemini
- Gemini API 2.5 models: https://ai.google.dev/gemini-api/docs/models/gemini-v2

### Claude Code

Fatos:

- A doc oficial de modelos da Anthropic lista Claude Opus 4.7 como modelo mais capaz, com API alias `claude-opus-4-7`; Claude Sonnet 4.6 como melhor combinacao de velocidade e inteligencia, com API alias `claude-sonnet-4-6`; e Claude Haiku 4.5 como modelo rapido near-frontier, com API alias `claude-haiku-4-5`.
- A doc de configuracao do Claude Code recomenda aliases em vez de pins quando o objetivo e seguir o melhor modelo disponivel: `best` equivale ao mais capaz disponivel, atualmente `opus`; `opus` usa o ultimo Opus para raciocinio complexo; `sonnet` usa o ultimo Sonnet para coding diario; `haiku` usa o Haiku rapido; `opusplan` usa Opus no plano e Sonnet na execucao quando disponivel.
- Claude Code subagents oficiais usam arquivos Markdown com frontmatter e podem ter ferramentas limitadas; docs recentes tambem descrevem `skills` preloaded e memoria persistente por subagent.
- Hooks oficiais incluem `PreToolUse`, `PostToolUse`, `UserPromptSubmit`, `Stop`, `SessionStart`, `SessionEnd`, e rodam com input JSON.

Baseline de modelos ajustado em 2026-04-26:

| Uso | Modelo/alias alvo | Snapshot/API quando precisar pin | Motivo |
|---|---|---|---|
| melhor Claude para decisao, arquitetura e bugs profundos | `best` ou `opus` no Claude Code | `claude-opus-4-7` | Opus 4.7 e o mais capaz nas docs oficiais |
| default profissional para execucao diaria | `sonnet` | `claude-sonnet-4-6` | melhor equilibrio capacidade/custo/latencia para coding |
| plano forte + execucao eficiente | `opusplan` quando disponivel | Opus no plano, Sonnet na execucao | reduz custo sem perder qualidade na decisao |
| tarefas pequenas/background | `haiku` | `claude-haiku-4-5` | rapido e barato; nao usar como juiz de arquitetura |
| contexto muito longo | `sonnet[1m]` quando conta/API suportar | full model name com sufixo `[1m]` | usar so quando o ganho de contexto superar custo |

Inferencia:

- A estrategia atual do Prometeus esta correta: usar recursos globais/externos quando necessario, mas nao criar `.claude/agents/`, `.claude/hooks/` ou skills locais antes de evidencia.
- Memoria persistente de subagent e poderosa, mas aumenta risco de sprawl e deve permanecer bloqueada neste repo ate haver trigger repetido.
- Para amanha, promptar Claude com `opus`/`best` para julgamento e, se houver execucao longa, preferir `opusplan` ou `sonnet` conforme custo/risco. Evitar hardcode de versoes no fluxo humano; usar snapshot apenas quando reproducibilidade de API for requisito.

Fontes:

- Claude models overview: https://docs.anthropic.com/en/docs/about-claude/models/all-models
- Claude Code model configuration: https://code.claude.com/docs/en/model-config
- Claude Code subagents: https://docs.anthropic.com/en/docs/claude-code/sub-agents
- Claude Code subagents advanced docs: https://code.claude.com/docs/en/sub-agents
- Claude Code hooks: https://docs.anthropic.com/en/docs/claude-code/hooks

### Linux e WSL

Fatos:

- Ubuntu 26.04 LTS foi anunciado em 2026-04-23; a nota oficial cita TPM-backed full-disk encryption, memory-safe components, improved permission controls, GNOME 50 on Wayland, AI/HPC toolkits, e suporte de manutencao para Desktop, Server, Cloud, WSL e Core.
- Microsoft WSL docs recomendam WSL 2 como default por kernel Linux real e compatibilidade de syscalls, mas alertam que performance entre filesystems Windows/Linux e excecao; a recomendacao para performance e guardar arquivos no mesmo OS das ferramentas usadas.
- A doc Microsoft de filesystem recomenda evitar trabalhar cruzado entre sistemas salvo motivo especifico; para linha de comando Linux, projeto em `/home/<user>/Project`; para ferramentas Windows, projeto no filesystem Windows.

Inferencia:

- Tecnica pura: se o trabalho for majoritariamente Linux CLI, `/home/...` no ext4 do WSL e mais performatico.
- Decisao operacional atual: Prometeus fica em `C:\Dev\Projetos\OLMO_PROMETEUS` porque o usuario estabeleceu esse caminho como normal/canonico, Obsidian/Windows importam, e o custo de nova migracao agora e maior que o ganho.
- Ubuntu 26.04 LTS pode entrar como upgrade planejado depois de workflow verde e backup; nao e trigger para mover repo hoje.

Fontes:

- Ubuntu announce: https://lists.ubuntu.com/archives/ubuntu-announce/2026-April/000323.html
- Canonical release: https://ubuntu.com/blog/canonical-releases-ubuntu-26-04-lts-resolute-raccoon
- Ubuntu release cycle: https://ubuntu.com/about/release-cycle
- Microsoft WSL compare versions: https://learn.microsoft.com/en-us/windows/wsl/compare-versions
- Microsoft WSL filesystems: https://learn.microsoft.com/th-th/windows/wsl/filesystems

### Shells

Fatos:

- Bash continua o default de scripts portaveis em Linux/CI.
- Fish 4.0 foi reescrito em Rust, mas Fish nao e POSIX shell.
- Nushell trabalha com dados estruturados e pipelines tipados, mas nao substitui Bash para CI/scripts POSIX.

Inferencia:

- Decisao conservadora: manter Bash como shell de harness e scripts versionados.
- Zsh/Oh My Zsh/powerlevel10k pode ser conforto pessoal, nao runtime do projeto.
- Fish/Nushell ficam como experimento local, nao como requisito do Prometeus.

Fontes:

- Fish 4.0 release coverage: https://www.phoronix.com/news/Fish-Shell-4.0-Released
- Nushell docs: https://www.nushell.sh/book/

### TypeScript, Python e toolchain

Fatos:

- `uv` e um gerenciador Python escrito em Rust que substitui fluxos de `pip`, `pip-tools`, `pipx`, `poetry`, `pyenv`, `twine`, `virtualenv`, com lockfile e gerenciamento de Python.
- `ruff` e linter/formatter Python em Rust, 10-100x mais rapido que ferramentas tradicionais segundo docs da Astral, com compatibilidade com Flake8/isort/Black.
- Bun e runtime/toolkit JS/TS all-in-one, com runtime, package manager, test runner e bundler; suporta TypeScript e JSX out of the box.
- pnpm e package manager focado em velocidade, economia de disco e monorepos.
- Biome e formatter/linter para web stack, cobrindo JS/TS/JSX/TSX/JSON/HTML/CSS/GraphQL.
- esbuild e bundler/minifier JS/CSS/TS/JSX focado em velocidade e base de varios toolchains modernos.

Inferencia:

- Para projetos novos: TS + Python e a dupla principal.
- Python: preferir `uv` + `ruff` quando houver projeto Python real.
- TS/app: escolher uma trilha por projeto, nao instalar tudo no Prometeus. Default conservador: `pnpm` + `vite` + `biome` para app web; `bun` como experimento quando velocidade e TS direto forem o objetivo.
- `esbuild` e dependencia/tool interno de muitos stacks; usar diretamente so para libs/scripts simples ou quando Vite/Bun nao forem adequados.

Fontes:

- uv docs: https://docs.astral.sh/uv/
- Ruff docs: https://docs.astral.sh/ruff/
- Bun docs: https://bun.com/docs/runtime
- pnpm docs: https://pnpm.io/
- Biome docs: https://biomejs.dev/
- esbuild docs: https://esbuild.github.io/

## Decisao operacional para 2026-04-27

Amanha a decisao deve ser tomada em tres pernas: Lucas como dono do contexto e risco, Codex/ChatGPT 5.5 como integrador critico, Gemini como contraponto independente.

1. Nao migrar distro, shell, toolchain ou runtime antes da conversa triadica.
2. Hidratar amanha por `shadow/HANDOFF.md` e ler este documento como pesquisa de stack.
3. Manter Prometeus canonicamente em `C:\Dev\Projetos\OLMO_PROMETEUS`; usar WSL via `/mnt/c/Dev/Projetos/OLMO_PROMETEUS` enquanto o vault/Windows forem parte do fluxo.
4. Se performance de Node/Python ficar materialmente ruim, abrir um experimento controlado de clone WSL ext4, sem apagar o canônico e sem sync automatico.
5. Toolchain SOTA aprovado como candidato de laboratorio, nao instalado por reflexo:
   - Python: `uv` + `ruff`.
   - TS app: `pnpm` + `vite` + `biome`.
   - Bun: experimento por projeto, nao default global.
   - Shell: Bash para scripts versionados; zsh apenas conforto pessoal.
6. Gemini API e parte obrigatoria da decisao triadica se o script/key forem apontados explicitamente. Modelo verificavel em fonte oficial: `gemini-3.1-pro-preview`; `gemini-3.1-pro-preview-customtools` pode ser testado para bash/custom tools; `gemini-2.5-pro` fica como baseline alternativo.
7. Claude Code para julgamento deve usar `best`/`opus` quando a conta permitir; para execucao diaria, `sonnet`; para plano+execucao, `opusplan` se disponivel.

## Perna Gemini API

Status: captured.

A resposta Gemini foi capturada em `shadow/SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md` usando o script externo autorizado do OLMO e a key do ambiente Windows, sem imprimir segredo. A resposta entra como evidencia para confronto, nao como decisao.

Prompt recomendado para rodar no Gemini API quando houver chave:

```text
Voce e Gemini como avaliador independente. Data de referencia: 2026-04-26. Avalie o stack para um laboratorio de estado da arte conduzido por Lucas + Codex/ChatGPT 5.5 + Gemini. Contexto: Prometeus e laboratorio operacional, nao trilha iniciante: CLIs agenticas, Claude Code/Codex/Gemini, TypeScript/Python, uv/ruff, pnpm/bun/biome/vite/esbuild, WSL/Ubuntu/Fedora, bash/zsh/fish/nushell. Separe fatos verificaveis, inferencias, riscos, custo, rollback e decisao operacional para 2026-04-27. Nao proponha migracao automatica sem trigger e evidencia. Aponte claims que parecam nao verificadas em fontes oficiais.
```

Comando sugerido, se `GEMINI_API_KEY` existir:

```bash
curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-pro-preview:generateContent?key=$GEMINI_API_KEY" \
  -H 'Content-Type: application/json' \
  -d @/tmp/prometeus-gemini-sota-prompt.json
```


## Local CLI state

Verificado em 2026-04-26:

| Ferramenta | Versao ativa | Status |
|---|---|---|
| Claude Code | `2.1.119` | atualizado; usar `best`/`opus` para julgamento SOTA |
| Codex CLI | `0.125.0` | atualizado; usar maior reasoning effort suportado |
| Gemini CLI | `0.39.1` | instalado; usar melhor modelo disponivel, preferindo `gemini-3.1-pro-preview` quando acessivel |
| Zellij | `0.44.1` | atualizado no PATH em `~/.local/bin/zellij` |
| WSL | `2.6.3.0` | atualizado pelo `wsl.exe --update` |
| Ubuntu WSL | `24.04.4 LTS` | atual dentro da linha 24.04; 26.04 fica para decisao com rollback |

Pacotes `apt` pendentes nao foram aplicados porque exigem senha sudo humana.

## Criterio negativo

Rejeitar migracao se:

- depender de benchmark de blog sem fonte primaria;
- exigir mover o repo canonico sem ganho medido;
- exigir instalar shell/toolchain global para um documento Markdown;
- criar MCP/hook/agent runtime sem 3 evidencias reais;
- introduzir PHI/dado sensivel ou automacao com write externo.

Coautoria: Lucas + GPT-5.4 xhigh (Codex)

## Workspace migration note

Fato operacional: o workspace canonico atual esta em `C:\Dev\Projetos\OLMO_PROMETEUS` e o WSL acessa por `/mnt/c/Dev/Projetos/OLMO_PROMETEUS`.

Inferencia: `/mnt/c` nao e o melhor caminho para trabalho Linux-heavy; Microsoft recomenda manter arquivos no mesmo filesystem das ferramentas usadas.

Decisao para amanha: avaliar uma migracao controlada para ext4 WSL apenas como experimento com rollback, preservando Obsidian/Windows e sem recriar clone fantasma.

## Gemini response captured

Arquivo: `shadow/SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md`.

Resumo para julgamento amanha:

- Gemini recomenda manter Ubuntu 24.04 LTS agora e bloquear Ubuntu 26.04 ate maturar/26.04.1.
- Gemini recomenda migrar workspace Linux-heavy para ext4 WSL como experimento controlado de 7 dias, com `C:\Dev` temporariamente preservado/read-only como rollback.
- Gemini recomenda `uv` + `ruff` + `bun` + `biome` como candidatos fortes, mas isso ainda precisa passar pelo gate do Prometeus antes de instalacao/adoção.
- Gemini recomenda Bash como shell entregue aos agentes; `nushell`/zsh podem ser conforto humano, nao contrato versionado.
- Gemini defende criar Agent Skills locais imediatamente; isso conflita com a regra anti-sprawl atual do Prometeus e deve ser confrontado, nao aceito.
- Gemini afirma `gemini-3.1-pro-preview` como fato verificado, e a fonte oficial atual confirma. O ponto que segue bloqueado e o claim de 2M context: a pagina oficial mostra 1.048.576 input tokens.

Decisao: resposta Gemini e perna de avaliacao, nao decisao final. Amanha Lucas + Codex/ChatGPT 5.5 julgam a recomendacao, confrontam conflitos e decidem experimento minimo com rollback.
