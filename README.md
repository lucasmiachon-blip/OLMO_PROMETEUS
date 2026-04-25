# open OLMO_PROMETEUS

Laboratorio paralelo e independente para validar fluxo, digest, estudo e wiki operacional sem qualquer contaminacao do repo principal.

## Regra principal

- Este repositorio nao e o `OLMO`.
- Nada daqui sincroniza automaticamente com `C:\Dev\Projetos\OLMO`.
- Toda promocao para o repo principal depende de validacao humana explicita.
- O foco inicial continua sendo a fatia: Prometeus vault + shadow decisions + harness.

## Sistema operacional do repo

- `AGENTS.md`: contrato operacional do laboratorio
- `CLAUDE.md`: adaptador Boris-style para Claude Code, importando `AGENTS.md`
- `GEMINI.md`: adaptador para Gemini CLI, importando `AGENTS.md`
- `TREE.md`: mapa profissional da arvore e politica de incorporacao segura
- `PROJECT_CONTRACT.md`: limites, faixas e criterio de promocao
- `shadow/`: regras operacionais, gates, evidencia e pesquisa aplicada
- `shadow/WORK-LANES.md`: fonte unica dos 6 estados (private, experiment, candidate, operational, retired, blocked) e promotion gate
- `shadow/INCORPORATION-LOG.md`: log de transicoes de estado aplicadas
- `shadow/EVIDENCE-LOG.md`: registro de uso real dos procedimentos (gate para `operational`)
- `scripts/maturity.ps1`: camada executavel de maturidade CMMI adaptada; roda gaps, batches e checks
- `scripts/evolve.ps1`: executor self-evolving; valida backlog interno, riscos, review cadence e workflow read-only
- `internal/evolution/`: estrutura interna versionada do self-evolution loop (backlog, risk register, review)
- `shadow/SOTA-DECISIONS.md`: decisoes SOTA curtas + `Applied when` + stubs `Blocked ate evidencia`
- `shadow/AGENT-MODULES.md`: contrato experimental para agentes; eixo tecnico ortogonal a WORK-LANES
- `shadow/AGENT-USAGE.md`: mapa de agentes/skills globais usados sem scaffold local + SOTA agent contract
- `shadow/PLAN-*.md`: plan por rodada estrutural (ex: `PLAN-2026-04-23.md` para Bloco A+B+C-prep)
- `shadow/FOUNDATION.md`: base de infra, memoria, harness e orquestracao
- `shadow/HYGIENE.md`: checklist de higiene para evitar sprawl
- `shadow/EMAIL-DIGEST-4P.md`, `shadow/STUDY-TRACK-DONE.md`: procedures com rubric e mini-evals
- `scripts/check.ps1`: harness local de regressao leve
- `.github/workflows/self-evolution.yml`: watchdog read-only para rodar checks sem pedido manual
- `Prometeus/.obsidian/`: configuracao do Obsidian para abrir o vault `Prometeus`
- `Prometeus/wiki/`: wiki operacional versionada do projeto
- `lab/wiki-graph-lab/`: companion visual local para explorar o vault fora do graph cru
- `private-learning/`: area local ignorada para cockpit e material pessoal
- `.claude/`: state local do Claude Code (`settings.local.json`); ignorado por Git

## Nucleo enxuto

- Sem diretórios locais de agents, subagents, skills ou hooks.
- `CLAUDE.md` e `GEMINI.md` sao pontes de contexto, nao novas fontes de verdade.
- Procedimentos duraveis ficam em `shadow/` ou em notas do `Prometeus/wiki/`.
- `private-learning/` fica local e ignorado, sem entrar no contexto versionado.
- Qualquer nova automacao ou agente precisa passar por trigger, evidencia, custo, risco e rollback.
- Mudancas estruturais passam pelo SOTA research gate antes de edicao.
- Agentes so entram como modulos encapsulados depois de procedimento, contrato, eval e uso real.

## Fluxo diario recomendado

1. capturar materia-prima em `private-learning/`;
2. transformar com um procedimento pequeno documentado em `shadow/` ou na wiki;
3. registrar o uso real em `shadow/EVIDENCE-LOG.md` (gate para `operational`);
4. classificar o artefato em `private`, `experiment`, `candidate`, `operational`, `retired` ou `blocked` (ver `shadow/WORK-LANES.md`);
5. se o procedimento tem `## Rubric`, rodar a rubrica e anotar score na observacao da linha do EVIDENCE-LOG;
6. so discutir migracao para `OLMO` depois do gate humano.
7. antes de nova mudanca estrutural, rodar `powershell -ExecutionPolicy Bypass -File .\scripts\evolve.ps1 -Mode next`.

## Higiene do projeto

Ao final de sessoes com edicao, conferir `shadow/HYGIENE.md` antes de criar mais estrutura.

## Fronteira atual

O aprendizado atual e tratar agentes como modulos encapsulados:

- contrato antes de runtime;
- ferramentas minimas;
- memoria explicita;
- guardrails e rollback;
- eval antes de promocao.

O contrato vive em `shadow/AGENT-MODULES.md`; a nota navegavel vive no vault em `Prometeus/wiki/Notes/Agent Module Encapsulation.md`.

Para agentes/skills globais do Claude Code (ex: `Explore`, `Plan`, `/dream`, `/schedule`, `/code-review`), o mapa de uso e o SOTA agent contract vivem em `shadow/AGENT-USAGE.md`. Nenhum scaffold local `.claude/agents|skills|hooks|commands/` e permitido sem gate.

## Harness local

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1
```

Use antes de commit quando a sessao mexer em docs, wiki, shadow ou scripts.

## Obsidian

Abra no Obsidian esta pasta:

```text
C:\Dev\Projetos\OLMO_PROMETEUS\Prometeus
```

Use `Prometeus/README.md` ou `Prometeus/wiki/Home.md` como entrada. Assim o nome do vault aparece como `Prometeus`, enquanto o repo continua isolado em `OLMO_PROMETEUS`. A wiki segue a ideia bottom-up do Kepano e o minimalismo do Karpathy: notas pequenas, links claros, escopo limitado e harness simples. Captura crua, diaria ou privada fica ignorada pelo Git em `Prometeus/wiki/Clippings/`, `Prometeus/wiki/Daily/` e `Prometeus/wiki/Attachments/`.

O second brain e Graph-first. No Graph View, use `path:wiki`, tags ligadas e orfaos visiveis. O grafo deve crescer; a qualidade vem de hubs como `Prometeus/wiki/Atlas/Second Brain Atlas.md`, nao de esconder nos.

O Canvas `Prometeus/wiki/Maps/Prometeus.canvas` continua como vitrine curada. Ele mostra uma narrativa bonita; o Graph View mostra o second brain real.

## Origem da primeira fatia

A base inicial veio de um laboratorio anterior que nao oferecia isolamento Git real. Este repo existe para manter a separacao segura em `OLMO_PROMETEUS`.



