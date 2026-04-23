# open OLMO_PROMETEUS

Laboratorio paralelo e independente para validar fluxo, dashboard, digest e study track sem qualquer contaminacao do repo principal.

## Regra principal

- Este repositorio nao e o `OLMO`.
- Nada daqui sincroniza automaticamente com `C:\Dev\Projetos\OLMO`.
- Toda promocao para o repo principal depende de validacao humana explicita.
- O foco inicial continua sendo a fatia: dashboard + digest + study flow.

## Sistema operacional do repo

- `AGENTS.md`: contrato operacional do laboratorio
- `.agents/skills/`: workflows reutilizaveis e pequenos
- `.codex/agents/`: agentes customizados estreitos, com baixo paralelismo
- `private-learning/`: interfaces locais e cockpit visual
- `shadow/`: regras operacionais, gates e pesquisa aplicada
- `playground/`: espaco para prototipos descartaveis
- `shadow/HYGIENE.md`: checklist de higiene para evitar sprawl

## Primeiro lote enxuto

- 3 skills: `digest-4p`, `study-track-done`, `promotion-gate`
- 3 agentes: `prometeus_explorer`, `promotion_reviewer`, `docs_researcher`
- Limite de paralelismo: `max_threads = 4`
- Profundidade de delegacao: `max_depth = 1`

## Fluxo diario recomendado

1. capturar materia-prima em `private-learning/`;
2. transformar com uma skill pequena;
3. classificar o artefato em `private`, `experiment` ou `candidate`;
4. so discutir migracao para `OLMO` depois do gate humano.

## Higiene do projeto

Ao final de sessoes com edicao, conferir `shadow/HYGIENE.md` antes de criar mais estrutura.

## Origem da primeira fatia

A base inicial veio de uma area de roadmap anterior que nao oferecia isolamento Git real. Este repo existe para manter a separacao segura em `OLMO_PROMETEUS`.


