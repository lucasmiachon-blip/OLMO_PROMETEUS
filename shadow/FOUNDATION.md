# Foundation

Objetivo: fortalecer a base do open OLMO_PROMETEUS sem criar infraestrutura falsa.

Esta base cobre quatro camadas: infra, memoria, harness e orquestracao.

Be terse: decisoes curtas, sem duplicar politica que ja vive em `AGENTS.md`.

## Regra fundamental

Nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.

Isso inclui scripts, hooks, automacoes, conectores, agentes, shell commands e edicoes manuais. Se uma tarefa exigir write externo, parar e pedir autorizacao explicita com caminho e acao exata.

## 1. Infra

O repo e um laboratorio isolado. A infraestrutura minima e:

- Git local limpo e commits pequenos.
- `AGENTS.md` como contrato operacional.
- `CLAUDE.md`, `CODEX.md` e `GEMINI.md` como adaptadores de ferramenta que importam `AGENTS.md`.
- `PROJECT_CONTRACT.md` como limite de risco.
- `VALUES.md` como filtro de decisao: 4 valores fundadores + V1-V7 principios operacionais.
- `TREE.md` como mapa profissional da arvore e da politica de incorporacao segura.
- `shadow/` para decisoes, gates e memoria operacional.
- `Prometeus/.obsidian/` para configurar o vault Obsidian `Prometeus`.
- `Prometeus/wiki/` para notas Obsidian e conhecimento duravel.
- `lab/wiki-graph-lab/` para a camada visual reversivel que le o vault sem duplicar a fonte de verdade.
- `private-learning/` para interface e material pessoal.
- `scripts/check.sh` como harness local Bash-first.
- `scripts/evolve.sh` como executor self-evolving Bash-first.
- `scripts/integrity.sh` como gate read-only de integridade/maturidade: sintaxe de scripts, targets de hooks locais, sync backlog JSON/Markdown, evidencia EV-B5, contrato antifragile verificavel e ausencia de comandos contra paths OLMO externos.
- `scripts/simulate-ci.sh` como simulador local read-only do workflow `Self Evolution` para o leg Linux/WSL; o leg Windows continua validacao remota.
- `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md > Producer-Consumer Matrix` como contrato T3: gate/hook novo sem produtor, artefato, consumidor, acao de falha, piso OLMO e protecao extra Prometeus fica bloqueado.
- `scripts/guard-olmo-write-hook.sh` como guard Bash do Claude PreToolUse: write externo para `OLMO`, `OLMO_COWORK`, typo `OLMO_COWOR`, workspace legado ROADMAP ou qualquer sibling `OLMO*` nao canonico vira `deny` (block); read externo vira `ask`.
- `scripts/test-olmo-boundary-guard.sh` como teste automatizado da trava OLMO.
- `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md` como gate E2E para orquestracao, harness e claims antifragile.

Nao existe sincronizacao automatica com `C:\Dev\Projetos\OLMO`.

Workspace canonico aprovado: `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4. Caminhos Windows e `/mnt/c` sao referencia historica, archive ou UI humana; nao sao fonte operacional.

Excecao aprovada em 2026-04-25 e portada para Bash em 2026-04-26: `.claude/settings.local.json` pode acionar um unico `PreToolUse` local que chama `scripts/guard-olmo-write-hook.sh` e bloqueia writes externos e pede permissao para reads externos quando o payload menciona `C:\Dev\Projetos\OLMO`, `OLMO_COWORK`, typos como `OLMO_COWOR`, workspace legado ROADMAP ou qualquer sibling `OLMO*` nao canonico. Isso nao cria `.claude/hooks/`, nao escreve fora do repo e existe apenas para tornar a boundary fail-closed. O harness roda teste positivo/negativo desse guard e falha se o workspace legado reaparecer.

Arquivos privados ou gerados devem ficar fora de Git e fora do contexto de agentes. Manter `.gitignore` e `.claudeignore` em paridade para `private-learning/`, buffers do Obsidian, workspace local, caches, plugins, `node_modules/` e `.venv/`.

## 2. Sem scaffolds fantasmas

Diretorios locais de agents, subagents, skills, hooks, `.claude/`, `.gemini/` e playground ficam fora do core.

Motivo: neste repo pequeno, scaffolds sem runtime real confundem memoria, contexto e decisao.

O caminho seguro e:

1. Primeiro, comando manual.
2. Depois, harness repetivel.
3. So depois de uso recorrente, considerar novo diretorio ou automacao.

Regra: nenhum hook pode tocar `C:\Dev\Projetos\OLMO`, arquivar email, mover arquivo sensivel ou fazer qualquer write externo sem autorizacao humana explicita.

## 3. Memoria

Memoria nao e conversa solta. Memoria operacional precisa morar em arquivo certo:

- contrato vivo: `AGENTS.md`;
- adaptadores de ferramenta: `CLAUDE.md`, `CODEX.md` e `GEMINI.md`;
- limites do projeto: `PROJECT_CONTRACT.md`;
- valores e principios operacionais: `VALUES.md`;
- decisoes SOTA: `shadow/SOTA-DECISIONS.md`;
- decisoes arquiteturais aceitas: `docs/adr/`;
- lanes e promotion gate: `shadow/WORK-LANES.md`;
- handoff de janela hidratada: `shadow/HANDOFF.md`;
- transicoes aplicadas: `shadow/INCORPORATION-LOG.md`;
- evidencia de uso real: `shadow/EVIDENCE-LOG.md`;
- classificacao e privacidade: `shadow/DATA-CLASSIFICATION.md`, `shadow/PHI-CHECKLIST.md`, `shadow/THREAT-MODEL.md`, `shadow/INCIDENT-LOG.md`;
- plans de rodada estrutural: `shadow/PLAN-*.md`;
- mapa de agentes/skills globais: `shadow/AGENT-USAGE.md`;
- maturidade e gaps profissionais executaveis: `scripts/evolve.sh` + `internal/evolution/`;
- higiene: `shadow/HYGIENE.md`;
- entrada do vault: `Prometeus/README.md`;
- wiki navegavel: `Prometeus/wiki/Home.md`;
- material pessoal local e ignorado: `private-learning/`.

Memorias automaticas ou globais de ferramentas ficam fora do repo e sao read-only para este projeto. A memoria operacional versionada fica em `AGENTS.md`, `shadow/` e `Prometeus/wiki/`.

Regra: se uma memoria nao muda comportamento futuro, ela nao entra no repo.

Erros materiais tambem sao memoria operacional quando mudam comportamento futuro. O protocolo vive em `AGENTS.md > Error Reports and Self-Improvement`: reportar erro, causa provavel, mudanca de plano, impacto, acao profissional, decisao `vamos fazer?` com justificativa e regra nova. Usar o protocolo para corrigir rota; nao transformar falhas pequenas em ritual.

## 4. Harness

O harness local padrao e Linux/WSL Ubuntu 24.04:

```bash
./scripts/check.sh
```

Ele valida:

- arquivos essenciais;
- estrutura basica do Obsidian vault `Prometeus`;
- cross-references do Obsidian: `[[wikilinks]]`, aliases e arquivos referenciados em Canvas;
- ausencia de referencias antigas;
- ausencia de tokens/segredos obvios;
- caminhos privados e gerados continuam ignorados por Git e pelo contexto de agentes;
- checks de ignore aceitam LF e CRLF para os workflows `ubuntu-latest` e `windows-latest`;
- checks textuais pulam arquivos ignorados e redigem linhas em achados de segredo;
- `scripts/integrity.sh` valida contratos vivos que tendem a driftar: scripts Bash, hook targets, backlog view, evidencia EV-B5, stale evidence como warning e antifragile sem narrativa vazia;
- todo gate/hook novo precisa linha producer-consumer antes de entrar no harness ou hook local;
- ausencia de scaffolds fantasmas na raiz;
- Git status legivel.

O harness nao substitui revisao humana. Ele evita regressao boba.

## 5. Orquestracao

Loop padrao:

1. Capturar materia-prima.
2. Escolher uma acao pequena.
3. Produzir artefato persistente.
4. Rodar harness.
5. Classificar em `private`, `experiment` ou `candidate`.
6. Comitar se a mudanca tiver valor.

Delegacao:

- Executor e exclusivo por tarefa: escolher Codex ou Claude Code para editar/orquestrar uma rodada; nunca os dois como executores simultaneos no mesmo escopo.
- Codex executa com `reasoning_effort=xhigh` quando a ferramenta/modelo suportar; se nao suportar, usar o maior esforco disponivel e registrar a limitacao.
- Claude Code pode ser o executor escolhido e usar subagentes globais (`Explore`, `Plan`, `general-purpose`) conforme mapa em `shadow/AGENT-USAGE.md`; sem scaffold local.
- Leituras auxiliares podem ser feitas por subagentes apenas quando a conversa justificar (ver padroes SOTA em `shadow/AGENT-USAGE.md`).
- Gemini entra para pesquisa longa/multimodal somente com objetivo, trigger, artefato, eficacia esperada, viabilidade e risco; nao executa writes neste repo.

Shell e linguagens (wired):

- Bash e o contrato versionado para scripts, harness e agentes.
- Markdown, JSON e Bash sao o core.
- Python: `uv` + `ruff` wired em `lab/wiki-graph-lab/pyproject.toml` + `uv.lock` (primeiro projeto real). Harness (`scripts/check.sh`) roda `ruff check` se manifesto presente.
- JS/JSON: `biome` wired em `biome.json` raiz (lint+format `internal/evolution/*.json` + `lab/**/*.js`). Harness roda `biome check` se manifesto presente. `pnpm` + `vite` entram quando houver projeto JS-heavy. `bun` 1.3.13 instalado para experimento por projeto.
- Diagnostico do stack: `./scripts/install-stack.sh` (idempotente, sem sudo).

Sampling:

- Gemini 3/API: default `temperature=1.0`; pode ser criativo em pesquisa.
- Claude API: default/alta temperatura para exploracao; se for executor de codigo, priorizar revisao e harness.
- Codex/OpenAI reasoning: controlar por `reasoning_effort` e verbosity; temperature nao e o knob principal em `xhigh`.

Sem fan-out automatico e sem registry local de agentes neste repo. Todo uso real de subagent ou procedure registrado em `shadow/EVIDENCE-LOG.md`.

Para o perfil de medico solo dev, orquestracao deve permanecer primeiro como procedimento auditavel em `shadow/`: estado claro, humano-no-loop, evidencia de eficacia, privacidade, viabilidade e rollback. Multimodel e a hipotese operacional preferida para tarefas frontier, mas frameworks externos de agentes so entram quando o procedimento manual provar retrabalho repetido sem expor dados sensiveis.
O gate `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md` e a fonte para decidir quando subir de procedimento para workflow, architect/editor, fanout ou runtime.
ADR 0004 registra a regra procedure-before-runtime; ADR 0005 registra producer-consumer para gates.
Self-evolution: `scripts/evolve.sh` le `internal/evolution/`, valida riscos e declara o proximo batch. O workflow `.github/workflows/self-evolution.yml` roda sem pedido manual, mas e read-only; ele pode falhar e informar, nao escrever ou decidir sozinho.


## 6. SOTA research gate

Mudancas de arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao seguem este gate:

1. Auditar o estado local.
2. Pesquisar fontes primarias atuais.
3. Escrever decisao curta, com trigger e nao-trigger.
4. Registrar risco, viabilidade, rollback e criterio negativo.
5. Editar apenas se a pesquisa justificar.

Regra anti-sprawl: se a melhor pratica externa depende de escala, equipe, CI, produto ou runtime que este repo nao tem, nao copiar. Adaptar para procedimento pequeno ou rejeitar.

## Barra de promocao

Algo so sobe de nivel quando tem:

- uso repetido;
- trigger claro;
- artefato claro;
- rollback;
- risco conhecido;
- harness passando;
- aprovacao humana antes de qualquer conversa sobre OLMO.

Coautoria: Lucas + GPT-5.x-Codex (xhigh)
