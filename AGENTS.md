# AGENTS.md - open OLMO_PROMETEUS

> Consumer: Codex app/CLI, Claude Code, Gemini CLI e outros agentes que trabalhem neste repo isolado.

## Intent

`open OLMO_PROMETEUS` e um laboratorio paralelo, pequeno e de baixo risco.

- Pode editar arquivos dentro deste repositorio.
- Nao deve escrever em `C:\Dev\Projetos\OLMO`, `C:\Dev\Projetos\OLMO_COWORK`, typos como `OLMO_COWOR`, `/mnt/c/Dev/Projetos/OLMO*` ou qualquer sibling `OLMO*`; leitura externa exige permissao humana explicita na conversa.
- O foco e validar fluxo, digest, estudo, wiki operacional e gates de promocao.
- Workspace canonico unico: `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4, com `bash`, `rg` e `jq`. Caminhos Windows/`/mnt/c` sao referencia historica, archive ou UI humana; nao sao fonte operacional.

## Fundamental Boundary

Regra fundamental: nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.

- Nao editar, mover, deletar, criar, arquivar, sincronizar ou gerar artefatos fora deste repo.
- Nao executar automacao, hook, script ou ferramenta que faca write externo.
- Nao escrever em `C:\Dev\Projetos\OLMO`, `C:\Dev\Projetos\OLMO_COWORK`, `/mnt/c/Dev/Projetos/OLMO*` ou outros siblings; nao ler siblings sem perguntar primeiro.
- Se uma tarefa exigir write fora daqui, parar: write externo e bloqueado. Se exigir read fora daqui, pedir autorizacao explicita antes de ler.
- Se a sessao iniciar em workspace legado ROADMAP, `OLMO_COWORK`, typo `OLMO_COWOR`, `/mnt/c/Dev/Projetos/OLMO_PROMETEUS` ou cwd diferente, corrigir para `/home/lucasmiachon/projects/OLMO_PROMETEUS` antes de qualquer edit; se a ferramenta de patch estiver presa fora daqui, parar e relatar.
- A autorizacao precisa citar o caminho externo e a acao exata.

## Operating Principles

- Prefira artefatos reversiveis: Markdown, HTML simples, JSON e scripts pequenos.
- Mantenha o blast radius baixo: faca a menor mudanca util.
- Be terse: escreva o minimo claro; decisao curta vence relatorio longo. Excecao: Gemini pode ser mais criativo/exploratorio quando usado explicitamente para pesquisa ou divergencia.
- Legacy/incorporacao: sempre ler antes de mover; incorporar seletivamente com justificativa `incorporar` ou `nao incorporar`; sem bulk copy, sem sincofancia, sem mover antes da reflexao.
- Use pesquisa e docs para reduzir incerteza antes de aumentar estrutura.
- Consolide antes de criar documento novo; pesquisa vira decisao curta.
- Trate migracao para `OLMO` como evento humano, nao como reflexo.
- Mudanca de arquitetura, agente, skill, hook, MCP ou orquestracao exige SOTA research gate antes de editar.

## SOTA Research Gate

Antes de mudar arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao:

1. Auditar o estado local primeiro.
2. Pesquisar fontes primarias e atuais, preferindo docs oficiais.
3. Registrar uma decisao curta em `shadow/SOTA-DECISIONS.md` ou no arquivo operacional correto.
4. Explicitar trigger, nao-trigger, risco, custo, rollback e criterio negativo.
5. So entao editar.

Se a pesquisa nao justificar a mudanca, nao implementar. Sem bajulacao, sem arquitetura aspiracional e sem copiar moda.

## Solo Doctor Dev Standard

Este repo deve operar como laboratorio de um medico solo dev: alta utilidade, baixo atrito e risco clinico controlado.

- Nao colocar dados de paciente, PHI ou dados pessoais sensiveis em arquivos versionados, prompts externos, automacoes ou agentes, salvo workflow privado aprovado explicitamente.
- Usar exemplos sinteticos, anonimizados ou minimizados por padrao; quando pesquisa externa envolver saude, citar fonte e separar fato, inferencia e decisao.
- Agentes e automacoes podem preparar, auditar e resumir; decisao clinica, legal, financeira ou de privacidade fica humana.
- Preferir procedimento manual + harness + evidencia antes de framework de orquestracao.
- Runtime agentico novo so entra apos >=3 evidencias de retrabalho real em `shadow/EVIDENCE-LOG.md`, trigger claro, rollback e aprovacao humana.
- O padrao de ouro e: auditavel, reversivel, sem dados sensiveis, humano-no-loop e proporcional ao tamanho real do projeto.

## Daily Loop

1. Capture materia-prima em `private-learning/` ou em uma nota temporaria.
2. Converta a materia com um procedimento pequeno documentado em `shadow/` ou na wiki.
3. Classifique o resultado como `private`, `experiment` ou `candidate`.
4. So discuta migracao para `OLMO` quando houver trigger, evidencia e rollback.

## Lanes

Estados dos artefatos: `private`, `experiment`, `candidate`, `operational`, `retired`, `blocked`.

Fonte unica de verdade dos estados, criterios e gate minimo: `shadow/WORK-LANES.md`. Transicoes aplicadas ficam em `shadow/INCORPORATION-LOG.md`. Evidencia que sustenta promocao ate `operational` vive em `shadow/EVIDENCE-LOG.md`.

Regra: agentes que precisarem de criterio detalhado seguem o link acima. Duplicar a tabela aqui cria drift.

## Layout

- `private-learning/`: cockpit visual e material pessoal local, ignorado pelo Git e pelo contexto.
- `VALUES.md`: valores, objetivos e lente de gaps para decidir se uma mudanca melhora o laboratorio ou so adiciona estrutura.
- `CLAUDE.md`: adaptador fino para Claude Code; importa `AGENTS.md`.
- `CODEX.md`: adaptador fino para Codex; importa `AGENTS.md`.
- `GEMINI.md`: adaptador fino para Gemini CLI; importa `AGENTS.md`.
- `.github/workflows/self-evolution.yml`: watchdog read-only que roda harness/evolucao sem write automatico.
- `internal/evolution/`: backlog (canonical), risk register, review cadence e `failure-registry.jsonl` do loop self-evolving; nao guarda dado sensivel.
- `shadow/`: fonte operacional. Contratos, gates, rubricas, evidencia e mapas de uso.
  - `shadow/WORK-LANES.md`: fonte unica dos estados (private, experiment, candidate, operational, retired, blocked) e promotion gate.
  - `shadow/EVIDENCE-LOG.md`: registro de uso real dos procedimentos (gate para `operational`).
  - `shadow/SOTA-DECISIONS.md`: decisoes curtas apos SOTA research gate.
  - `shadow/AGENT-USAGE.md`: mapa de agentes/skills globais usados sem scaffold local.
  - `shadow/INCORPORATION-LOG.md`: log de transicoes de estado aplicadas.
  - `shadow/PLAN-*.md`: plans operacionais ativos de mudancas estruturais (um por rodada). Plans fechados ficam em `shadow/PLAN-ARCHIVE/YYYY-MM-DD.md`.
  - `shadow/BACKLOG.md`: view markdown derivada de `internal/evolution/backlog.json`; tiers P0/P1/P2/Frozen/Resolved + effort + dormancy.
  - `shadow/KBP.md`: catalogo pointer-only de Known Bad Patterns; cross-ref para regras canonicas, sem prosa inline.
  - `shadow/DATA-CLASSIFICATION.md`, `shadow/PHI-CHECKLIST.md`, `shadow/THREAT-MODEL.md`, `shadow/INCIDENT-LOG.md`: guardas minimos para privacidade, PHI e incidentes sem conteudo sensivel.
- `TREE.md`: mapa da arvore raiz, casas dos artefatos e politica de incorporacao do `OLMO`.
- `Prometeus/README.md`: entrada documental do vault Obsidian.
- `Prometeus/.obsidian/`: configuracao do vault Obsidian `Prometeus`.
- `Prometeus/wiki/`: conhecimento duravel e navegavel via graph view. Complementa `shadow/`, nao substitui.
  - `Prometeus/wiki/Notes/`: notas conceituais com no minimo 2 wikilinks para outras notas. Notas com <2 wikilinks sao espelhos de `shadow/` e viram candidatas a delete em HYGIENE.
- `scripts/`: harness local Bash-first (`scripts/check.sh`, `scripts/evolve.sh`, `scripts/guard-olmo-write-hook.sh`).

## Memoria

Este projeto nao usa memoria automatica como fonte operacional. A memoria do projeto vive em `AGENTS.md`, `shadow/` e `Prometeus/wiki/`. Memorias globais de ferramentas ficam fora do repo e sao read-only para este projeto.

## Stack Baseline

- Modelos/agentes: Codex e Claude Code sao os executores possiveis, mas nunca juntos na mesma tarefa/rodada de edicao. Escolha um executor por vez: Codex para auditoria/edicao rigorosa com maior reasoning disponivel (`xhigh` quando suportado); Claude Code para autoria/arquitetura quando for o executor escolhido. Gemini entra para pesquisa longa, multimodalidade e contraponto, nao como executor de write. ChatGPT/API entra manualmente quando Lucas pedir. Nenhum deles vira runtime persistente sem gate.
- Sampling: Gemini 3/API fica no default `temperature=1.0` para pesquisa criativa; Claude API pode usar temperatura alta/default `1.0` para geracao e arquitetura exploratoria; Codex/GPT reasoning usa `reasoning_effort`/verbosity, nao temperature, quando `xhigh` estiver ativo.
- Adaptadores: `AGENTS.md` e a fonte unica. `CLAUDE.md`, `CODEX.md` e `GEMINI.md` sao adaptadores finos; nao duplicam politica.
- Shell: `bash` e o contrato de scripts, harness e agentes. `zsh`, `fish` e `nushell` podem ser conforto humano local, nunca requisito versionado.
- Linguagens: Markdown/JSON/Bash sao o core. Python wired via `uv` + `ruff` em [`lab/wiki-graph-lab/pyproject.toml`](lab/wiki-graph-lab/pyproject.toml) + `uv.lock` (primeiro projeto real). JS/JSON wired via `biome` em [`biome.json`](biome.json) raiz (lint+format `internal/evolution/*.json` + `lab/**/*.js`); `pnpm` + `vite` entram quando houver projeto JS-heavy real. `bun` 1.3.13 instalado para experimento por projeto. Diagnostico: `./scripts/install-stack.sh`.
- Sistema: Linux/WSL Ubuntu 24.04 LTS em ext4 e o runtime operacional. Windows e Obsidian continuam UI humana quando util; o vault pode ser aberto via `\\wsl.localhost\Ubuntu\home\lucasmiachon\projects\OLMO_PROMETEUS\Prometeus`. Ubuntu 26.04, Fedora ou Linux nativo fora do WSL ficam bloqueados ate trigger, metrica e rollback.

## Error Reports and Self-Improvement

Quando ocorrer erro material (tool, shell, path, permissao, teste, pesquisa ou suposicao quebrada), parar antes de trocar a estrategia e reportar:

- Erro: o que falhou, comando/ferramenta e mensagem principal.
- Por que: hipotese tecnica mais provavel, sem inventar certeza.
- O que mudou: qual plano mudou por causa do erro.
- Impacto: o que ficou incompleto, arriscado ou sem validacao.
- O que um profissional faria: acao profissional para diagnosticar ou corrigir.
- Vamos fazer?: sim ou nao, com justificativa proporcional ao risco, custo e escopo.
- Regra nova: aprendizado pratico para evitar repeticao.

Se o erro indicar sandbox, permissao ou rede e o comando for essencial, repetir o mesmo comando com aprovacao conforme politica antes de mudar rota. A memoria desse aprendizado so entra no repo quando muda comportamento futuro.

## Do

- atualizar gates de promocao e risco;
- explicitar o que e experimento e o que e candidato;
- citar fontes quando a resposta depender de pesquisa externa.

Procedures em `experiment` (sem evidencia em `shadow/EVIDENCE-LOG.md`, ver `shadow/INCORPORATION-LOG.md` 2026-04-24): `email-digest-4p` (digest em 4 paragrafos), `study-track-done` (trilha de estudo com criterio de `done`), `obsidian-crossref-check` (harness roda, falta uso citado). Rodar e registrar em EVIDENCE-LOG antes de tratar como pratica central.

## Do Not

- tocar o repo principal por reflexo;
- escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`;
- copiar hooks, MCP ou infraestrutura sensivel do `OLMO`;
- ativar hook sem trigger, evidencia, rollback e aprovacao humana explicita;
- permitir self-evolution com write, commit, push, issue, PR ou dado sensivel sem aprovacao humana explicita;
- recriar diretorios locais de agents, subagents, skills, hooks, `.claude/agents/`, `.claude/hooks/`, `.claude/commands/` ou `.gemini/` sem necessidade repetida e aprovacao explicita;
- criar skill em `.claude/skills/<name>/` sem procedure operational em `shadow/` e sem frontmatter valido (`name`, `description`, `trigger`, `non-trigger`, `source`, `status`, `owner`) — ver `shadow/AGENT-USAGE.md > Local skills contract`;
- tratar `.claude/settings.local.json` como runtime ativo (e state local; fica em `.gitignore`/`.claudeignore`);
- marcar `done` sem evidencia de entendimento ou aplicacao;
- misturar material pessoal com runtime do projeto;
- colocar captura privada/crua no vault versionado;
- inflar o repo com agentes, skills ou scaffolds sem uso recorrente.
- manter relatorios longos quando uma decisao curta resolve.

## Validation Before Finish

- Se editar docs ou HTML, cheque nomes, titulos e links locais.
- Se editar base, memoria, harness ou orquestracao, atualize `shadow/FOUNDATION.md`.
- Se editar a wiki, preserve links Obsidian e a separacao entre conhecimento duravel e captura privada.
- Quando houver mudanca persistente, rode `./scripts/check.sh` no Ubuntu/WSL.
- Se um artefato virar `candidate`, atualize `shadow/WORK-LANES.md`.
- Se a sessao criar varios artefatos, confira `shadow/HYGIENE.md`.
- Se rodou um procedimento (`email-digest-4p`, `study-track-done`, `sota-research-gate`) em uso real, registre linha em `shadow/EVIDENCE-LOG.md`.
- Se a tarefa esbarrar no repo principal, pare e peca autorizacao explicita.

## Coauthorship

- Codex: usar `reasoning_effort=xhigh` quando a ferramenta/modelo suportar. Se `xhigh` nao estiver disponivel, usar o maior esforco suportado e registrar a limitacao na resposta.
- Codex: `Coautoria: Lucas + GPT-5.x-Codex (xhigh)`
- Outros modelos: registrar papel, trigger, artefato, custo e risco antes de adotar no fluxo.
