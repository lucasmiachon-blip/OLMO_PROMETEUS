# Project Hygiene

Objetivo: manter o open OLMO_PROMETEUS pequeno, legivel e reversivel enquanto ele cresce.

Regra: higiene nao remove nem move arquivo sem motivo claro. Primeiro audita, depois consolida, e so deleta com confirmacao humana.

## Gatilhos

Rodar higiene quando:

- uma pesquisa SOTA gerar mais de um arquivo novo;
- uma skill ou agente novo for criado;
- `private-learning/` comecar a misturar dado privado com runtime;
- um item mudar de `experiment` para `candidate`;
- o `git status` ficar dificil de explicar em uma frase;
- houver docs duplicados sobre o mesmo assunto.

## Checklist rapido

- `git status --short`: entender o que mudou.
- `rg --hidden --files -g "!private-learning/**" -g "!.git/**"`: ver sprawl fora da area privada.
- Checar se novos arquivos estao em uma casa clara: `shadow/`, `private-learning/`, `playground/`, `.agents/skills/` ou `.codex/agents/`.
- Checar se `private-learning/` continua em `.gitignore` e `.claudeignore`.
- Checar se docs SOTA antigos foram referenciados ou consolidados.
- Checar se `C:\Dev\Projetos\OLMO` aparece apenas como destino protegido, nunca como alvo de edicao.

## Limites

- Nao deletar arquivos sem confirmacao humana.
- Nao mover arquivos se isso puder quebrar referencias sem revisar os links.
- Nao criar nova skill/agente para cada ideia; exigir uso recorrente.
- Nao transformar pesquisa em arquitetura se nao houver trigger real.
- Nao colocar material privado em `shadow/`.

## Cadencia

- Pequena higiene: ao final de cada sessao com edicao.
- Higiene media: depois de 3 a 5 sessoes.
- Higiene forte: antes de qualquer conversa de migracao para OLMO.

## Snapshot atual

2026-04-23:

- Estrutura esta pequena e clara.
- Principal risco: acumulo de docs SOTA sem consolidacao futura.
- Acoes aplicadas: `INCORPORATION-LOG.md`, regra de `Digerido` persistido, este checklist.
- Sem edicao autorizada em `C:\Dev\Projetos\OLMO`.

Coautoria: Lucas + GPT-5.4 (Codex)
