# SOTA Stack Codex Proposal 2026-04-26

## 1. Identidade

```yaml
avaliador: "Codex"
superficie: "Codex CLI"
modelo: "GPT-5.x-Codex [modelo efetivo exato nao exposto pela sessao]"
nivel_raciocinio: "xhigh solicitado; confirmacao runtime nao exposta"
data_referencia: "2026-04-26"
cwd_verificado: "/home/lucasmiachon/projects/OLMO_PROMETEUS"
browsing_pesquisa: "nao"
fontes_externas_usadas: "nao nesta rodada; apenas URLs ja registradas nos raws"
limitacoes: "nao li os arquivos explicitamente proibidos; nao verifiquei claims atuais na web; claims de versao/modelo/preco ficam como raw-cited ou [NAO VERIFICADO]"
```

Fontes lidas:

- `shadow/SOTA-STACK-2026-04-26.md`
- `shadow/SOTA-STACK-ARMS-PROMPT-2026-04-26.md`
- `shadow/SOTA-STACK-CLAUDE-RESPONSE-2026-04-26.md`
- `shadow/SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md`
- `shadow/SOTA-STACK-GEMINI-3.1-PRO-DIAGNOSIS-2026-04-26.md`
- `shadow/SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md`
- `shadow/SOTA-STACK-CLI-PROMPTS-2026-04-27.md`
- `shadow/SOTA-STACK-GEMINI-PROMPT-2026-04-26.md`
- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `TREE.md`, `PROJECT_CONTRACT.md`
- `shadow/AGENT-USAGE.md`, `shadow/WORK-LANES.md`, `shadow/SOTA-DECISIONS.md`

Fontes evitadas:

- `shadow/SOTA-STACK-DEBATE-MATRIX-2026-04-26.md`
- `shadow/PLAN-2026-04-26-SOTA-DECISIONS.md`
- `~/.claude/plans/virtual-zooming-bachman.md`

Criterio de desempate: contrato local e boundary vencem recomendacao de modelo; depois vem fonte primaria atual; depois evidencia local repetida; depois custo, rollback e criterio negativo. Consenso entre Claude/Gemini ajuda, mas nao supera `AGENTS.md`, `PROJECT_CONTRACT.md` ou `WORK-LANES.md`.

## 2. Tese principal

O stack profissional aqui nao e "mais agentes"; e menos superficie ativa, com decisoes registradas e reversiveis.

O repo ja tem o desenho correto para um laboratorio pequeno: `AGENTS.md` como contrato, `shadow/` como memoria operacional, `Prometeus/wiki/` como conhecimento navegavel e `scripts/check.sh` como harness. Isso esta explicitado em `AGENTS.md:72-92`, `PROJECT_CONTRACT.md:49-70` e `SOTA-DECISIONS.md:7-27`.

A unica decisao estrutural que merece prioridade e alinhar o workspace canonico com a realidade operacional. O contrato inicial diz `C:\Dev\Projetos\OLMO_PROMETEUS` via `/mnt/c` (`AGENTS.md:12`, `PROJECT_CONTRACT.md:9`), enquanto os raws posteriores dizem que o canonico ja passou a `/home/lucasmiachon/projects/OLMO_PROMETEUS` (`SOTA-DECISIONS.md:166-179`). Esse drift e mais perigoso que escolher entre `bun` e `pnpm`.

Toolchain deve ser candidato por projeto, nao instalacao global especulativa: `uv`/`ruff` quando houver Python real; `pnpm`/`vite`/`biome` como default TS conservador; `bun` como experimento. Isso segue `SOTA-STACK-2026-04-26.md:156-160` e evita inflar o repo contra `AGENTS.md:120-134`.

Skills locais, MCP, hooks novos, runtime agentico e migracao automatica continuam bloqueados. Gemini recomenda skills locais imediatas (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:45-49`), mas isso conflita diretamente com o contrato de skills locais (`AGENT-USAGE.md:86-122`) e com `AGENTS.md:127-128`.

## 3. Lista exaustiva de decisoes em pauta extraidas dos raws

1. Workspace canonico: manter Windows `/mnt/c` ou formalizar `/home/...` ext4.
2. Migracao: fazer experimento manual com metricas ou mover automaticamente.
3. Git index/CRLF: rodar `git add --renormalize .` e `git config core.filemode false` ou adiar.
4. `private-learning/`: copiar do archive externo ou manter bloqueado ate permissao.
5. OS: manter Ubuntu 24.04 LTS, subir para Ubuntu 26.04 LTS, ou considerar Fedora/Linux nativo.
6. Shell: Bash como contrato; zsh/fish/nushell como conforto humano ou runtime.
7. Agentes: papel de Codex, Claude Code, Gemini CLI/API e ChatGPT/API.
8. Modelos: usar Codex xhigh, Claude `best`/`opus`, Gemini 3.1 Pro Preview, GPT-5.5.
9. Gemini customtools/API: usar endpoint customtools/bash em workflow ou bloquear ate teste.
10. Local skills: criar `.claude/skills/` agora ou manter procedure-first.
11. Runtime agentico: LangGraph/CrewAI/OpenAI Agents SDK/MCP proprio/agent teams.
12. Hooks: manter apenas guard boundary ou expandir hooks.
13. Python: `uv` + `ruff` como default quando houver projeto.
14. TypeScript: `pnpm` + `vite` + `biome` vs `bun` default; `esbuild` direto ou indireto.
15. Obsidian/vault: preservar fluxo Windows/Obsidian e avaliar `\\wsl.localhost`.
16. Harness: manter Bash-first `scripts/check.sh`/`evolve.sh`; validar workflow remoto.
17. Privacy/PHI: controles minimos antes de qualquer fluxo clinico real.
18. Pesquisa SOTA: fonte primaria e decisao curta; relatorios longos como raws, nao runtime.
19. Lanes/promocao: nao promover procedure sem EVIDENCE-LOG.
20. Zellij/apt/pacotes locais: conforto operacional, nao decisao do repo.

## 4. Decisoes

### D1. Workspace canonico

- Proposta: formalizar `/home/lucasmiachon/projects/OLMO_PROMETEUS` como canonico somente se Lucas confirmar que esta e a fonte real; senao corrigir a sessao para o canonico Windows antes de novas edicoes estruturais.
- PQ SIM: `SOTA-DECISIONS.md:172` declara canonical workspace em `/home/...`; o raw Gemini consolidado diz que `AGENTS.md` e `FOUNDATION.md` ainda citam `C:` enquanto a operacao real ja ocorre em `~/projects` (`SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md:24-27`).
- PQ NAO: `AGENTS.md:12`, `AGENTS.md:16-23`, `PROJECT_CONTRACT.md:9-12` e `TREE.md:7-12` ainda definem boundary como `C:\Dev\Projetos\OLMO_PROMETEUS`; editar docs para `/home` sem decisao humana pode violar o contrato vigente.
- Confianca: MEDIA. Criterio: ha forte evidencia local de drift, mas a mudanca de boundary e estrutural e exige confirmacao humana.
- Acao agora: registrar como decisao P0 a resolver antes de novas mudancas de arquitetura; nao ler/copiar archive externo sem permissao.
- Revisar quando: apos Lucas confirmar o canonico real e apos `./scripts/check.sh` passar no path escolhido.

### D2. Migracao automatica de filesystem

- Proposta: rejeitar migracao automatica; se ainda houver migracao pendente, fazer experimento manual de 7 dias com backup, metricas e rollback.
- PQ SIM: o prompt comum proibe migracao automatica (`SOTA-STACK-ARMS-PROMPT-2026-04-26.md:81-89`) e o playbook define criterio negativo contra mover repo sem backup/metrica/rollback (`SOTA-STACK-CLI-PROMPTS-2026-04-27.md:110-119`).
- PQ NAO: Gemini recomenda "transplante controlado do rootdir" (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:45-48`) e experimento com `rsync` (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:66-79`).
- Confianca: ALTA. Criterio: contrato local e prompt de avaliacao bloqueiam automacao destrutiva.
- Acao agora: nenhuma migracao; apenas decidir e documentar.
- Revisar quando: benchmark local mostrar ganho material sem quebrar Obsidian.

### D3. Git index staleness / CRLF

- Proposta: tratar como correcao tecnica candidata, mas nao rodar `git add --renormalize .` ate separar mudancas reais do usuario e decidir escopo.
- PQ SIM: Gemini 3.1 diagnostica index staleness e CRLF (`SOTA-STACK-GEMINI-3.1-PRO-DIAGNOSIS-2026-04-26.md:22-37`); o consolidado recomenda `git add --renormalize .` e `core.filemode false` (`SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md:19-23`).
- PQ NAO: o worktree atual tem varias modificacoes ja existentes; `AGENTS.md:136-145` exige validacao antes de terminar, e o contrato de edicao proibe reverter ou misturar alteracoes do usuario.
- Confianca: MEDIA. Criterio: diagnostico e plausivel, mas a acao e ampla e mexe em muitos arquivos.
- Acao agora: deixar como stage separado, com diff auditado antes.
- Revisar quando: apos comparar `git diff --check`, line endings e escopo exato dos 13 arquivos.

### D4. `private-learning/` nao migrado

- Proposta: bloquear qualquer copia/leitura do archive externo ate permissao humana explicita com caminho e acao.
- PQ SIM: Gemini afirma que `private-learning/` ficou no archive (`SOTA-STACK-GEMINI-3.1-PRO-DIAGNOSIS-2026-04-26.md:32-33`; `SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md:24-27`).
- PQ NAO: `AGENTS.md:20-23` e `PROJECT_CONTRACT.md:11-12` exigem permissao para read externo; `private-learning/` pode conter material pessoal (`AGENTS.md:57-62`, `TREE.md:83-90`).
- Confianca: ALTA. Criterio: mesmo que o raw esteja correto, a acao exige read/write externo e pode envolver dado privado.
- Acao agora: registrar bloqueio; pedir permissao so quando houver necessidade real.
- Revisar quando: Lucas pedir recuperacao citando caminho e destino.

### D5. Ubuntu 24.04 vs 26.04

- Proposta: manter Ubuntu 24.04 LTS; bloquear upgrade para 26.04 ate janela de maturacao ou trigger concreto.
- PQ SIM: `SOTA-STACK-2026-04-26.md:106-115` trata 26.04 como upgrade planejado, nao trigger; Gemini recomenda bloquear 26.04 por risco de recem-lancado (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:50-53`); decisao consolidada bloqueia por 8 semanas (`SOTA-DECISIONS.md:177`).
- PQ NAO: Ubuntu 26.04 foi descrito como LTS com recursos novos (`SOTA-STACK-2026-04-26.md:104-109`), mas isso nao e ganho local medido.
- Confianca: ALTA. Criterio: baixo valor imediato, risco operacional maior que beneficio.
- Acao agora: nao atualizar distro.
- Revisar quando: 26.04.1, bug bloqueante em 24.04, ou benchmark/necessidade especifica.

### D6. Fedora ou Linux nativo fora do WSL

- Proposta: rejeitar por ora.
- PQ SIM: o escopo CLI pede avaliar Fedora (`SOTA-STACK-CLI-PROMPTS-2026-04-27.md:53-56`), mas nenhum raw lido apresenta evidencia local de ganho.
- PQ NAO: o fluxo preserva Windows/Obsidian (`SOTA-STACK-CLI-PROMPTS-2026-04-27.md:57-59`) e o contrato atual e WSL/Bash (`AGENTS.md:12`, `CLAUDE.md:7-13`).
- Confianca: ALTA. Criterio: sem fonte local, sem metrica, sem trigger.
- Acao agora: bloquear.
- Revisar quando: Lucas mudar plataforma primaria ou houver incompatibilidade insoluvivel no WSL.

### D7. Shell

- Proposta: Bash como contrato de scripts/agentes; zsh/fish/nushell apenas preferencia humana nao versionada.
- PQ SIM: `SOTA-STACK-2026-04-26.md:124-141` recomenda Bash para harness; Gemini tambem diz Bash para subshell dos modelos (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:39`); `CLAUDE.md:7-13` documenta comandos Bash.
- PQ NAO: Gemini sugere nushell para humano com JSON/CSV (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:39`).
- Confianca: ALTA. Criterio: scripts versionados precisam ser previsiveis e portaveis.
- Acao agora: manter Bash-first.
- Revisar quando: um script real exigir dados estruturados que Bash+jq nao cubra.

### D8. Papel dos agentes

- Proposta: Codex como integrador/verificador, Claude como avaliador/autor forte quando acionado, Gemini como pesquisa SOTA/multimodal; ChatGPT como juiz manual se Lucas acionar, nao quarto runtime automatico.
- PQ SIM: `SOTA-DECISIONS.md:263-269` define time minimo; `SOTA-STACK-2026-04-26.md:170-185` propõe decisao triadica; Gemini consolidado recomenda Codex+Claude+Gemini (`SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md:28-34`).
- PQ NAO: Gemini inicial propõe scripts de orquestracao interna disparando APIs (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:38`), o que aproxima runtime novo.
- Confianca: ALTA. Criterio: mantem utilidade multimodelo sem persistencia nova.
- Acao agora: manter triade sob demanda.
- Revisar quando: 3 ciclos mostrarem ruido/custo maior que beneficio.

### D9. Modelos e claims de versao

- Proposta: registrar modelos como alvos nos raws, mas nao hardcodar versoes/precos sem verificacao primaria na sessao de decisao.
- PQ SIM: arms prompt exige marcar modelo e pesquisar claims instaveis (`SOTA-STACK-ARMS-PROMPT-2026-04-26.md:23-43`, `:79-97`); o stack inicial lista fontes oficiais para Codex, Gemini e Claude (`SOTA-STACK-2026-04-26.md:33-37`, `:62-67`, `:94-100`).
- PQ NAO: Claude/Gemini fazem claims sobre GPT-5.5, pricing e capabilities (`SOTA-STACK-CLAUDE-RESPONSE-2026-04-26.md:49-57`; `SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:11-15`) que eu nao verifiquei nesta sessao.
- Confianca: MEDIA. Criterio: modelos podem mudar e a sessao nao fez browsing.
- Acao agora: usar aliases/maior modelo disponivel quando humano escolher; marcar claims instaveis como `[NAO VERIFICADO]`.
- Revisar quando: antes de qualquer custo recorrente ou pin de API.

### D10. Gemini customtools/API para bash

- Proposta: bloquear como runtime; aceitar apenas teste manual isolado se houver objetivo, chave e artefato.
- PQ SIM: `SOTA-STACK-2026-04-26.md:55` lista `gemini-3.1-pro-preview-customtools` como opcao "nao usar sem teste real"; Gemini recomenda endpoint para bash nao-supervisionado (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:38`).
- PQ NAO: automacao nao-supervisionada conflita com humano-no-loop e baixo risco (`AGENTS.md:46-55`, `PROJECT_CONTRACT.md:14-19`).
- Confianca: ALTA. Criterio: nao ha evidencia de necessidade recorrente.
- Acao agora: nao implementar.
- Revisar quando: 3 evidencias mostrarem que prompt/procedure manual falha por falta de tool execution externa.

### D11. Local skills

- Proposta: rejeitar criacao imediata de `.claude/skills/`; manter procedure-first.
- PQ SIM: Gemini recomenda criar skills imediatamente (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:45-49`).
- PQ NAO: `AGENT-USAGE.md:86-122` exige procedure operational, >=3 entradas, media >=0.8, 30 dias e aprovacao humana; `AGENTS.md:127-128` proibe skill sem esse gate.
- Confianca: ALTA. Criterio: conflito direto com contrato local.
- Acao agora: bloquear.
- Revisar quando: uma procedure virar `operational` e cumprir o contrato por 30 dias.

### D12. Runtime agentico, MCP proprio e agent teams

- Proposta: bloquear LangGraph/CrewAI/OpenAI Agents SDK/MCP proprio/agent teams persistentes.
- PQ SIM: `AGENT-USAGE.md:66-85` diz incorporar padroes, nao runtimes; `SOTA-DECISIONS.md:104-110` exige >=3 evidencias reais para runtime.
- PQ NAO: Gemini e Claude descrevem ecossistemas agenticos e MCP como SOTA (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:20-25`; `SOTA-STACK-2026-04-26.md:73-77`), mas isso e contexto, nao trigger local.
- Confianca: ALTA. Criterio: sem evidencia local de retrabalho, custo e privacidade dominam.
- Acao agora: bloquear.
- Revisar quando: `EVIDENCE-LOG.md` tiver 3 falhas reais por falta de estado/HITL/tracing/coordenacao.

### D13. Hooks

- Proposta: manter apenas boundary guard testado; nao expandir hooks.
- PQ SIM: `PROJECT_CONTRACT.md:16` aceita excecao do guard boundary; `SOTA-DECISIONS.md:203-217` documenta port para Bash.
- PQ NAO: Claude docs/raws dizem hooks existem e sao poderosos (`SOTA-STACK-2026-04-26.md:75-77`), mas `SOTA-DECISIONS.md:20-27` rejeita hooks como arquitetura.
- Confianca: ALTA. Criterio: hook e alto impacto e baixo valor sem incidente recorrente.
- Acao agora: nenhum hook novo.
- Revisar quando: boundary atual falhar em caso real e houver teste de regressao.

### D14. Python toolchain

- Proposta: `uv` + `ruff` como default por projeto Python real; nao instalar/configurar por reflexo neste repo documental.
- PQ SIM: `SOTA-STACK-2026-04-26.md:147-159` descreve `uv`/`ruff` e recomenda quando houver projeto Python real; Gemini converge (`SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md:31-33`).
- PQ NAO: Gemini inicial recomenda adocao "amanha" (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:45-47`) mesmo sem projeto Python ativo citado.
- Confianca: ALTA. Criterio: boa escolha tecnica, mas sem acao ate haver projeto.
- Acao agora: documentar como candidato por projeto.
- Revisar quando: aparecer pacote/script Python que precise deps, lint ou formatter.

### D15. TypeScript toolchain

- Proposta: `pnpm` + `vite` + `biome` como default conservador por app; `bun` experimento por projeto; `esbuild` direto so para caso simples.
- PQ SIM: `SOTA-STACK-2026-04-26.md:156-160` recomenda trilha unica por projeto; `SOTA-DECISIONS.md:176` registra `bun` apenas experimento.
- PQ NAO: Gemini recomenda `bun` como runtime de baixa latencia e adocao amanha (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:22-25`, `:45-47`).
- Confianca: ALTA. Criterio: conservador, reversivel, sem instalar tudo.
- Acao agora: nenhuma instalacao global.
- Revisar quando: houver app TS real com benchmark local.

### D16. Obsidian/vault

- Proposta: preservar Obsidian/Windows como requisito humano; testar `\\wsl.localhost` antes de declarar `/home` operacional para o vault.
- PQ SIM: `AGENTS.md:88-91` define `Prometeus/wiki/` como vault/versionado; Gemini recomenda Windows Obsidian via `\\wsl.localhost` (`SOTA-STACK-GEMINI-3.1-PRO-DIAGNOSIS-2026-04-26.md:47-48`).
- PQ NAO: se Obsidian tiver file watching/inotify ruim, Gemini recomenda abortar migracao de FS (`SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md:61-63`).
- Confianca: MEDIA. Criterio: sem teste de UI nesta sessao.
- Acao agora: incluir Obsidian como criterio negativo de qualquer mudanca de path.
- Revisar quando: apos 24-48h de uso real no path escolhido.

### D17. Harness e GitHub workflow

- Proposta: manter `scripts/check.sh` e `scripts/evolve.sh` como gate; validar remoto separadamente quando credenciais permitirem.
- PQ SIM: `AGENTS.md:136-145` exige `./scripts/check.sh` quando houver mudanca persistente; `TREE.md:144-150` recomenda `./scripts/check.sh --strict`; `PROJECT_CONTRACT.md:61-63` lista harness.
- PQ NAO: Gemini consolidado inclui `gh run list` como acao imediata (`SOTA-STACK-CONSOLIDATED-DIAGNOSIS-2026-04-26.md:35-40`), mas isso pode exigir auth/rede.
- Confianca: ALTA. Criterio: harness local e contrato; remoto e verificacao adicional.
- Acao agora: rodar `./scripts/check.sh` apos este arquivo.
- Revisar quando: antes de promover qualquer artefato para candidate/operational.

### D18. Privacy/PHI

- Proposta: manter privacy guard minimo como pre-condicao; bloquear dados reais em prompts externos.
- PQ SIM: `AGENTS.md:46-55` define Solo Doctor Dev Standard; `SOTA-DECISIONS.md:148-164` registra privacy guard minimum.
- PQ NAO: Gemini menciona PDFs medicos e parse multimodal (`SOTA-STACK-GEMINI-3.1-PRO-DIAGNOSIS-2026-04-26.md:41-43`), mas isso aumenta risco se houver PHI.
- Confianca: ALTA. Criterio: risco clinico domina conveniencia.
- Acao agora: nenhuma mudanca; manter bloqueio.
- Revisar quando: houver pedido envolvendo email, agenda, PDF clinico, imagem, audio ou dado pessoal real.

### D19. Pesquisa SOTA e higiene documental

- Proposta: manter raws como evidencia, mas decisao operacional deve virar bloco curto em `SOTA-DECISIONS.md`; nao transformar debate em museu.
- PQ SIM: `SOTA-DECISIONS.md:28-35` diz pesquisa vira decisao curta; `AGENTS.md:120-134` proibe relatorios longos quando decisao curta resolve; `SOTA-STACK-CLI-PROMPTS-2026-04-27.md:6-13` diz que respostas sao evidencia, nao autoridade.
- PQ NAO: a propria tarefa pede mais um relatorio longo como perna adversarial.
- Confianca: ALTA. Criterio: este arquivo e raw de decisao, nao deve virar runtime.
- Acao agora: salvar este proposal; depois consolidar em comparacao curta.
- Revisar quando: apos `SOTA-STACK-COMPARISON-2026-04-26.md`.

### D20. Lanes e promocao de procedures

- Proposta: nao promover `email-digest-4p`, `study-track-done` ou `obsidian-crossref-check` sem evidencias.
- PQ SIM: `AGENTS.md:118` diz procedures estao em experiment sem evidencia; `WORK-LANES.md:72-82` exige >=3 entradas e rubrica; `SOTA-DECISIONS.md:219-233` alinhou drift.
- PQ NAO: nenhuma resposta raw oferece evidencia nova de uso real.
- Confianca: ALTA. Criterio: gate local claro.
- Acao agora: manter lanes.
- Revisar quando: `EVIDENCE-LOG.md` tiver uso real suficiente.

### D21. Zellij, apt upgrade e conforto local

- Proposta: nao transformar em decisao de stack do repo.
- PQ SIM: `SOTA-STACK-2026-04-26.md:207-220` lista estado local de Zellij/WSL/Ubuntu e apt pendente.
- PQ NAO: nao ha trigger, artefato, risco/rollback de projeto.
- Confianca: ALTA. Criterio: conforto local nao deve virar contrato.
- Acao agora: nenhuma.
- Revisar quando: uma ferramenta local for requisito de harness ou docs.

## 5. Sequencia de stages proposta

1. Stage 0 - Sanidade: confirmar que este proposal nao leu arquivos proibidos e rodar `./scripts/check.sh`.
2. Stage 1 - Decisao humana de boundary: Lucas decide se o canonico oficial e `/home/lucasmiachon/projects/OLMO_PROMETEUS` ou `C:\Dev\Projetos\OLMO_PROMETEUS`.
3. Stage 2 - Patch minimo de contrato: atualizar apenas os arquivos de contrato afetados pelo path escolhido; registrar trigger, risco, rollback e criterio negativo em `SOTA-DECISIONS.md`.
4. Stage 3 - Git hygiene separado: auditar diff e line endings; so entao decidir `git add --renormalize .` e `core.filemode false`.
5. Stage 4 - Obsidian validation: abrir vault pelo fluxo escolhido e observar 24-48h sem quebrar indexacao.
6. Stage 5 - Remote validation: quando auth/rede estiverem disponiveis, validar GitHub workflow; nao misturar com path migration.
7. Stage 6 - Toolchain por projeto: adotar `uv`/`ruff` ou TS stack apenas quando houver projeto real.
8. Stage 7 - Evidence loop: usar procedures experimentais em ciclos reais e registrar `EVIDENCE-LOG.md` antes de qualquer skill/runtime.

## 6. Bloqueios explicitos

- Migracao automatica de repo, vault ou archive.
- Read/write em `/mnt/c/Dev/Projetos/_archive/...`, siblings `OLMO*` ou qualquer externo sem permissao explicita.
- Criar `.claude/skills/`, `.claude/agents/`, `.claude/hooks/`, `.claude/commands/`, `.gemini/`, `agents/`, `subagents/`, `skills/`, `hooks/` ou MCP local agora.
- Usar Gemini customtools ou ChatGPT/GPT-5.5 como runtime automatico.
- Hardcodar claims de GPT-5.5, Gemini 3.1, Claude pricing, Codex sandbox internals ou Ubuntu 26.04 sem verificacao primaria atual. Nesta proposta, esses pontos ficam raw-cited ou `[NAO VERIFICADO]`.
- Instalar toolchain global sem projeto que precise.
- Promover procedure sem `EVIDENCE-LOG.md`.
- Usar dado clinico real/PHI em prompt externo.

## 7. Conflitos da propria proposta com contract local

- Esta proposta foi salva em `/home/lucasmiachon/projects/OLMO_PROMETEUS`, enquanto varias regras ainda dizem que o workspace canonico e `C:\Dev\Projetos\OLMO_PROMETEUS` (`AGENTS.md:12`, `PROJECT_CONTRACT.md:9`). Mitigacao: a propria tarefa definiu o repo como `/home/lucasmiachon/projects/OLMO_PROMETEUS`, e `SOTA-DECISIONS.md:172` ja registra `/home` como canonico em diagnostico triadico; ainda assim, isso deve ser resolvido formalmente.
- O arquivo e mais longo que uma decisao curta, contrariando o espirito anti-sprawl de `AGENTS.md:134`. Mitigacao: a tarefa pediu proposta independente no formato detalhado; proxima etapa deve consolidar.
- Nao fiz browsing externo, entao nao cumpro pesquisa primaria nova para claims instaveis. Mitigacao: nao usei esses claims como fatos finais sem marcar `[NAO VERIFICADO]` ou citacao de raw.

## 8. Veredito final

O desempate favorece o contrato local contra qualquer recomendacao de modelo que aumente runtime.

A decisao P0 e alinhar boundary/path canonico; sem isso, agentes recebem instrucoes contraditorias.

Depois disso, separar Git hygiene de migracao e de toolchain. Misturar os tres aumenta risco e apaga autoria das mudancas.

`uv`/`ruff`, `pnpm`/`vite`/`biome` e Bash sao bons defaults, mas so entram quando houver projeto ou script que precise deles.

Skills locais, MCP, hooks novos, customtools e runtime agentico ficam bloqueados ate evidencia real, trigger claro, rollback e aprovacao humana.

Coautoria: Lucas + GPT-5.x-Codex (xhigh)
