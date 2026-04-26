# Project Contract

## Objetivo

Validar um laboratorio paralelo, guiado por orquestracao de baixo risco, para vault, digest e study flow.

## Limites

- Regra fundamental: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Nao escrever em `C:\Dev\Projetos\OLMO` a partir daqui.
- Nao editar, mover, deletar, criar, arquivar ou sincronizar nada em repositorios siblings; leitura de sibling/legado so com permissao humana explicita na conversa.
- Qualquer write externo e bloqueado por padrao. Qualquer read externo exige pergunta previa, com caminho e motivo exatos.
- Nao copiar infraestrutura sensivel, hooks ou config de MCP.
- Automacao self-evolving permitida somente em modo read-only: pode checar, relatar e falhar; nao pode escrever, commitar, pushar, abrir issue/PR ou tocar dado sensivel sem aprovacao humana explicita.
- Nao manter scaffolds locais de agents, subagents, skills, hooks, `.claude/agents/`, `.claude/hooks/`, `.claude/commands/` ou `.gemini/` sem necessidade repetida e gate humano explicito.
- `.claude/settings.local.json` e aceito como state local ignorado e nao versionado. Excecao ativa: PreToolUse boundary guard local para bloquear write externo e pedir permissao em read externo de `OLMO`, `OLMO_COWORK`, typos como `OLMO_COWOR`, workspace legado ROADMAP e qualquer sibling `OLMO*`.
- Nao criar sincronizacao automatica com o repo principal.
- Nao promover artefatos sem trigger, evidencia e rollback.
- Nao mudar arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao sem SOTA research gate previo.

## SOTA research gate

Mudancas estruturais exigem:

1. auditoria local;
2. pesquisa SOTA em fonte primaria atual;
3. decisao curta registrada;
4. risco, custo, rollback e criterio negativo;
5. harness passando antes de commit.

Se a pesquisa apontar que a ideia nao e necessaria para este repo pequeno, a acao correta e nao implementar.

## Faixas operacionais

Estados dos artefatos: `private`, `experiment`, `candidate`, `operational`, `retired`, `blocked`.

Fonte unica da verdade dos estados, significados e acoes padrao: `shadow/WORK-LANES.md`. Transicoes aplicadas em `shadow/INCORPORATION-LOG.md`. Evidencia de uso real em `shadow/EVIDENCE-LOG.md`.

## Criterio de promocao

Um artefato daqui so entra em conversa de migracao quando:

1. funcionou localmente em ciclos repetidos;
2. tem artefato claro;
3. tem trigger de uso;
4. tem risco e rollback explicitos;
5. nao depende demais de contexto pessoal.

## Estrutura minima racional

- `AGENTS.md` define o contrato do repo.
- `CLAUDE.md` e `GEMINI.md` sao adaptadores finos que importam `AGENTS.md`.
- `TREE.md` define a arvore profissional, casas dos artefatos e politica de incorporacao segura.
- `shadow/WORK-LANES.md` define os estados e promotion gate.
- `shadow/INCORPORATION-LOG.md` registra as transicoes aplicadas.
- `shadow/EVIDENCE-LOG.md` registra uso real dos procedimentos.
- `shadow/SOTA-DECISIONS.md` consolida decisoes SOTA curtas.
- `shadow/AGENT-USAGE.md` mapeia uso de agentes/skills globais e SOTA agent contract, sem scaffold local.
- `shadow/FOUNDATION.md` define infra, memoria, harness e orquestracao.
- `shadow/GITHUB-REMOTE-WSL.md` documenta o diagnostico de GitHub remoto e autenticacao local.
- `scripts/check.sh` valida regressao leve antes de commit.
- `scripts/evolve.sh` valida a estrutura interna self-evolving e mostra o proximo batch.
- `scripts/guard-olmo-write-hook.sh` protege a boundary de workspace.
- `internal/evolution/` guarda backlog, risk register e review cadence do loop interno.
- `shadow/PLAN-*.md` documenta plans de mudanca estrutural por rodada.
- `Prometeus/README.md` e a entrada documental do vault.
- `Prometeus/.obsidian/` configura o vault Obsidian `Prometeus`.
- `Prometeus/wiki/` guarda a wiki Obsidian versionada.
- `private-learning/` e local e ignorado; nao e fonte versionada.
- `.claude/` e local e ignorado; nao e fonte versionada nem runtime ativo.
