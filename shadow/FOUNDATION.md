# Foundation

Objetivo: fortalecer a base do open OLMO_PROMETEUS sem criar infraestrutura falsa.

Esta base cobre quatro camadas: infra, memoria, harness e orquestracao.

## Regra fundamental

Nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

Isso inclui scripts, hooks, automacoes, conectores, agentes, shell commands e edicoes manuais. Se uma tarefa exigir write externo, parar e pedir autorizacao explicita com caminho e acao exata.

## 1. Infra

O repo e um laboratorio isolado. A infraestrutura minima e:

- Git local limpo e commits pequenos.
- `AGENTS.md` como contrato operacional.
- `CLAUDE.md` e `GEMINI.md` como adaptadores de ferramenta que importam `AGENTS.md`.
- `PROJECT_CONTRACT.md` como limite de risco.
- `TREE.md` como mapa profissional da arvore e da politica de incorporacao segura.
- `shadow/` para decisoes, gates e memoria operacional.
- `Prometeus/.obsidian/` para configurar o vault Obsidian `Prometeus`.
- `Prometeus/wiki/` para notas Obsidian e conhecimento duravel.
- `lab/wiki-graph-lab/` para a camada visual reversivel que le o vault sem duplicar a fonte de verdade.
- `private-learning/` para interface e material pessoal.
- `scripts/check.ps1` como harness local.
- `scripts/guard-olmo-write-hook.ps1` como guard local do Claude PreToolUse contra o caminho proibido e workspace legado ROADMAP.
- `scripts/test-olmo-boundary-guard.ps1` como teste automatizado da trava OLMO.
- `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md` como gate E2E para orquestracao, harness e claims antifragile.
- `scripts/test-orchestration-e2e.ps1 -DryRun` como teste E2E sem side effects desse gate.
- `scripts/test-antifragile-learning.ps1 -DryRun -Scenario All -Seed 42` como teste de aprendizado: injeta erro sintetico de catalogo, exige deteccao, evidencia e regressao; `-Scenario CASE_edges` cobre bordas do contrato; `-Scenario Random -Seed N` reproduz um caso pseudoaleatorio.

Nao existe sincronizacao automatica com `C:\Dev\Projetos\OLMO`.

Excecao aprovada em 2026-04-25: `.claude/settings.local.json` pode acionar um unico `PreToolUse` local que chama `scripts/guard-olmo-write-hook.ps1` e bloqueia qualquer payload de ferramenta que mencione `C:\Dev\Projetos\OLMO` ou o workspace legado ROADMAP. Isso nao cria `.claude/hooks/`, nao escreve fora do repo e existe apenas para tornar a boundary fail-closed. O harness roda teste positivo/negativo desse guard e falha se o workspace legado reaparecer.

Arquivos privados ou gerados devem ficar fora de Git e fora do contexto de agentes. Manter `.gitignore` e `.claudeignore` em paridade para `private-learning/`, buffers do Obsidian, workspace local, caches, plugins, `node_modules/` e `.venv/`.

## 2. Sem scaffolds fantasmas

Diretorios locais de agents, subagents, skills, hooks, `.claude/`, `.gemini/` e playground ficam fora do core.

Motivo: no nosso ambiente Windows e neste repo pequeno, scaffolds sem runtime real confundem memoria, contexto e decisao.

O caminho seguro e:

1. Primeiro, comando manual.
2. Depois, harness repetivel.
3. So depois de uso recorrente, considerar novo diretorio ou automacao.

Regra: nenhum hook pode tocar `C:\Dev\Projetos\OLMO`, arquivar email, mover arquivo sensivel ou fazer qualquer write externo sem autorizacao humana explicita.

## 3. Memoria

Memoria nao e conversa solta. Memoria operacional precisa morar em arquivo certo:

- contrato vivo: `AGENTS.md`;
- adaptadores de ferramenta: `CLAUDE.md` e `GEMINI.md`;
- limites do projeto: `PROJECT_CONTRACT.md`;
- decisoes SOTA: `shadow/SOTA-DECISIONS.md`;
- lanes e promotion gate: `shadow/WORK-LANES.md`;
- handoff de janela hidratada: `shadow/HANDOFF.md`;
- transicoes aplicadas: `shadow/INCORPORATION-LOG.md`;
- evidencia de uso real: `shadow/EVIDENCE-LOG.md`;
- plans de rodada estrutural: `shadow/PLAN-*.md`;
- mapa de agentes/skills globais: `shadow/AGENT-USAGE.md`;
- maturidade e gaps profissionais executaveis: `scripts/maturity.ps1`;
- self-evolution interno: `scripts/evolve.ps1` + `internal/evolution/`;
- higiene: `shadow/HYGIENE.md`;
- entrada do vault: `Prometeus/README.md`;
- wiki navegavel: `Prometeus/wiki/Home.md`;
- material pessoal local e ignorado: `private-learning/`.

Memoria automatica do Claude Code em `C:\Users\lucas\.claude\projects\...\memory\` e intencionalmente vazia para este projeto. Memoria global do usuario (`~/.claude/CLAUDE.md`) e read-only por este repo.

Regra: se uma memoria nao muda comportamento futuro, ela nao entra no repo.

Erros materiais tambem sao memoria operacional quando mudam comportamento futuro. O protocolo vive em `AGENTS.md > Error Reports and Self-Improvement`: reportar erro, causa provavel, mudanca de plano, impacto, acao profissional, decisao `vamos fazer?` com justificativa e regra nova. Usar o protocolo para corrigir rota; nao transformar falhas pequenas em ritual.

## 4. Harness

O harness local e:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1
```

Ele valida:

- arquivos essenciais;
- estrutura basica do Obsidian vault `Prometeus`;
- cross-references do Obsidian: `[[wikilinks]]`, aliases e arquivos referenciados em Canvas;
- ausencia de referencias antigas;
- ausencia de tokens/segredos obvios;
- caminhos privados e gerados continuam ignorados por Git e pelo contexto de agentes;
- checks de ignore aceitam LF e CRLF para o workflow `windows-latest`;
- checks textuais pulam arquivos ignorados e redigem linhas em achados de segredo;
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

- Codex orquestra e edita.
- Claude Code usa subagentes globais (`Explore`, `Plan`, `general-purpose`) conforme mapa em `shadow/AGENT-USAGE.md`; sem scaffold local.
- Leituras auxiliares podem ser feitas por subagentes apenas quando a conversa justificar (ver padroes SOTA em `shadow/AGENT-USAGE.md`).
- Gemini entra para pesquisa longa/multimodal somente com objetivo, trigger, artefato, custo e risco.

Sem fan-out automatico e sem registry local de agentes neste repo. Todo uso real de subagent ou procedure registrado em `shadow/EVIDENCE-LOG.md`.

Para o perfil de medico solo dev, orquestracao deve permanecer primeiro como procedimento auditavel em `shadow/`: estado claro, humano-no-loop, evidencias, custo e rollback. Frameworks externos de agentes so entram quando o procedimento manual provar retrabalho repetido sem expor dados sensiveis.
O gate `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md` e a fonte para decidir quando subir de procedimento para workflow, architect/editor, fanout ou runtime.
Self-evolution: `scripts/evolve.ps1` le `internal/evolution/`, alinha com `scripts/maturity.ps1`, valida riscos e declara o proximo batch. O workflow `.github/workflows/self-evolution.yml` roda sem pedido manual, mas e read-only; ele pode falhar e informar, nao escrever ou decidir sozinho.


## 6. SOTA research gate

Mudancas de arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao seguem este gate:

1. Auditar o estado local.
2. Pesquisar fontes primarias atuais.
3. Escrever decisao curta, com trigger e nao-trigger.
4. Registrar risco, custo, rollback e criterio negativo.
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

Coautoria: Lucas + GPT-5.4 (Codex)
