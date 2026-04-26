# Project Hygiene

Objetivo: manter o open OLMO_PROMETEUS pequeno, legivel e reversivel enquanto ele cresce.

Regra: higiene nao remove nem move arquivo sem motivo claro. Primeiro audita, depois consolida, e so deleta com confirmacao humana.

## Gatilhos

Rodar higiene quando:

- uma pesquisa SOTA gerar mais de um arquivo novo;
- alguem sugerir criar skill, agente, hook, playground ou scaffold novo;
- `private-learning/` comecar a misturar dado privado com runtime;
- um item mudar de `experiment` para `candidate`;
- o `git status` ficar dificil de explicar em uma frase;
- houver docs duplicados sobre o mesmo assunto.

## Checklist rapido

- `git status --short`: entender o que mudou.
- `./scripts/check.sh`: rodar harness local no Ubuntu/WSL rapido.
- `rg --hidden --files -g "!private-learning/**" -g "!.git/**"`: ver sprawl fora da area privada.
- Checar se novos arquivos estao em uma casa clara: `shadow/`, `Prometeus/wiki/`, `private-learning/` local ignorado ou `scripts/`.
- Checar se `shadow/HANDOFF.md` continua enxuto e aponta para fontes canonicas em vez de duplicar docs.
- Checar `TREE.md` quando a raiz, hooks, skills ou agentes mudarem.
- Checar se instrucoes de abertura do Obsidian apontam para `\\wsl.localhost\Ubuntu\home\lucasmiachon\projects\OLMO_PROMETEUS\Prometeus` quando usadas no Windows.
- Checar se o harness valida `[[wikilinks]]`, aliases e referencias de Canvas antes de commit.
- Checar se notas wiki duraveis estao em `Prometeus/wiki/Notes`, `Prometeus/wiki/Categories` ou `Prometeus/wiki/References`.
- Checar se notas em `Prometeus/wiki/Notes` tem >=2 wikilinks (warn do harness); notas com <2 links sao espelhos de `shadow/` e viram candidatas a delete.
- Rodar `./scripts/evolve.sh check`; self-evolution deve ter exatamente um proximo batch e workflow read-only.
- Checar se capturas cruas continuam ignoradas em `Prometeus/wiki/Clippings`, `Prometeus/wiki/Daily` e `Prometeus/wiki/Attachments`.
- Checar se `.claude/`, `private-learning/`, buffers do Obsidian, workspace local, caches, plugins, `node_modules/` e `.venv/` continuam em `.gitignore` e `.claudeignore`.
- Checar que `.agents/`, `.codex/`, `agents/`, `subagents/`, `skills/`, `hooks/`, `playground/` e `.claude/agents|skills|hooks|commands/` nao reapareceram na raiz sem gate.
- Checar se `shadow/EVIDENCE-LOG.md` tem entries recentes (warn do harness se >21 dias sem mudanca); se nao tiver, considerar que o procedimento nao esta em uso real.
- Checar se `shadow/AGENT-USAGE.md` existe e foi revisado recentemente (delete em 30 dias sem referencia conforme criterio negativo interno).
- Checar se o `shadow/PLAN-*.md` mais recente esta referenciado como gate em `shadow/SOTA-DECISIONS.md > Applied when`.
- Checar se procedures em `candidate` ou `operational` tem secao `## Rubric` e `## Mini-evals`.
- Checar se docs SOTA antigos foram referenciados ou consolidados.
- Checar se `C:\Dev\Projetos\OLMO` aparece apenas como destino protegido, nunca como alvo de edicao.
- Checar se a regra "nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`" continua presente.

## Limites

- Nao deletar arquivos sem confirmacao humana.
- Nao mover arquivos se isso puder quebrar referencias sem revisar os links.
- Nao criar nova skill/agente para cada ideia; exigir uso recorrente.
- Nao criar diretorio de runtime sem trigger, evidencia, custo, risco e rollback.
- Nao transformar pesquisa em arquitetura se nao houver trigger real.
- Nao colocar material privado em `shadow/`.
- Nao colocar captura crua ou pessoal no vault versionado.
- Nao manter dois documentos que respondem a mesma pergunta.

## Barra de qualidade

Um arquivo fica no repo se:

- tem uso diario ou recorrente;
- e contrato, gate, skill, dashboard ou evidencia ainda necessaria;
- reduz risco operacional;
- pode ser explicado em uma frase.

Se nao passar nessa barra, consolidar ou deletar.

## Cadencia

- Pequena higiene: ao final de cada sessao com edicao.
- Higiene media: depois de 3 a 5 sessoes.
- Higiene forte: antes de qualquer conversa de migracao para OLMO.

## Snapshot atual

2026-04-26:

- Survivor unico confirmado: `/home/lucasmiachon/projects/OLMO_PROMETEUS`.
- Vault canonico: `/home/lucasmiachon/projects/OLMO_PROMETEUS/Prometeus`.
- Windows fica como UI humana via `\\wsl.localhost\Ubuntu\home\lucasmiachon\projects\OLMO_PROMETEUS\Prometeus`, nao fonte operacional.
- Contrato de executores: Codex ou Claude Code por rodada; Gemini pesquisa sem write.
- Legado registrado em `shadow/LEGACY-ROOTS-2026-04-26.md` e `shadow/LEGACY-INCORPORATION-2026-04-26.md`; parking lot preserva potenciais sem copiar scaffold.
- Commits granulares recentes: `df2fa9b`, `e1691b6`, `6e7cadd`.
- Nao ha diretorio irmao de roadmap no filesystem.
- Remote Git configurado e push para `origin/main` funciona.
- GitHub Actions `Self Evolution` existe, mas falha de forma recorrente no passo `Harness`; log detalhado via `gh run view --log-failed` retornou HTTP 403 por falta de admin.
2026-04-25:

- Snapshot Windows-first ficou historico; a fonte operacional foi migrada para Linux/WSL ext4 em 2026-04-26.
2026-04-24:

- Workspace canonico confirmado em `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Vault canonico confirmado em `C:\Dev\Projetos\OLMO_PROMETEUS\Prometeus`.
- Companion visual versionado em `lab/wiki-graph-lab/`, lendo apenas `Prometeus/wiki/`.
- Diretorio legado restante foi removido; o survivor unico e `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Harness passou e Git ficou limpo apos a consolidacao documental.
2026-04-23:

- Estrutura esta pequena e clara.
- Principal risco: recriar sprawl SOTA depois da limpeza.
- Acoes aplicadas: `INCORPORATION-LOG.md`, regra de `Digerido` persistido, este checklist e consolidacao em `SOTA-DECISIONS.md`.
- Sem edicao autorizada em `C:\Dev\Projetos\OLMO`.
- Frame adversarial aplicado: contexto de agente e Git precisam ignorar as mesmas areas privadas/geradas.

Coautoria: Lucas + GPT-5.4 (Codex)
