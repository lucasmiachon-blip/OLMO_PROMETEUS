# Project Contract

## Objetivo

Validar um laboratorio paralelo, guiado por orquestracao de baixo risco, para vault, digest e study flow.

## Limites

- Regra fundamental: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Nao editar `C:\Dev\Projetos\OLMO` a partir daqui.
- Nao editar, mover, deletar, criar, arquivar ou sincronizar nada em repositorios siblings.
- Qualquer write externo exige autorizacao explicita na conversa, com caminho e acao exata.
- Nao copiar infraestrutura sensivel, hooks ou config de MCP.
- Nao manter scaffolds locais de agents, subagents, skills, hooks, `.claude/` ou `.gemini/` sem necessidade repetida e gate humano explicito.
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

| Faixa | Significado | Acao padrao |
|-------|-------------|-------------|
| `private` | material pessoal ou dependente de contexto | permanece local |
| `experiment` | artefato promissor, mas ainda instavel | repetir e medir |
| `candidate` | padrao reutilizavel e com gate claro | pode entrar em conversa de migracao |

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
- `shadow/WORK-LANES.md` registra a classificacao dos artefatos.
- `shadow/FOUNDATION.md` define infra, memoria, harness e orquestracao.
- `scripts/check.ps1` valida regressao leve antes de commit.
- `Prometeus/README.md` e a entrada documental do vault.
- `Prometeus/.obsidian/` configura o vault Obsidian `Prometeus`.
- `Prometeus/wiki/` guarda a wiki Obsidian versionada do projeto.
- `private-learning/` e local e ignorado; nao e fonte versionada.
