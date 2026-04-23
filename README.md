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
- `shadow/SOTA-DECISIONS.md`: decisoes SOTA consolidadas, sem relatorio longo
- `shadow/FOUNDATION.md`: base de infra, hooks, memoria, harness e orquestracao
- `scripts/check.ps1`: harness local de regressao leve
- `Prometeus/.obsidian/`: configuracao do Obsidian para abrir o vault `Prometeus`
- `Prometeus/wiki/`: wiki operacional versionada do projeto

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

## Harness local

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1
```

Use antes de commit quando a sessao mexer em docs, skills, agentes ou dashboard.

## Obsidian

Abra no Obsidian esta pasta:

```text
C:\Dev\Projetos\OLMO_PROMETEUS\Prometeus
```

Use `wiki/Home.md` como entrada. Assim o nome do vault aparece como `Prometeus`, enquanto o repo continua isolado em `OLMO_PROMETEUS`. A wiki segue a ideia bottom-up do Kepano e o minimalismo do Karpathy: notas pequenas, links claros, escopo limitado e harness simples. Captura crua, diaria ou privada fica ignorada pelo Git em `Prometeus/wiki/Clippings/`, `Prometeus/wiki/Daily/` e `Prometeus/wiki/Attachments/`.

O second brain e Graph-first. No Graph View, use `path:wiki`, tags ligadas e orfaos visiveis. O grafo deve crescer; a qualidade vem de hubs como `Prometeus/wiki/Atlas/Second Brain Atlas.md`, nao de esconder nos.

O Canvas `Prometeus/wiki/Maps/Prometeus.canvas` continua como vitrine curada. Ele mostra uma narrativa bonita; o Graph View mostra o second brain real.

## Origem da primeira fatia

A base inicial veio de uma area de roadmap anterior que nao oferecia isolamento Git real. Este repo existe para manter a separacao segura em `OLMO_PROMETEUS`.


