# open OLMO_PROMETEUS

Laboratorio paralelo e independente para validar fluxo, digest, estudo e wiki operacional sem qualquer contaminacao do repo principal.

## Regra principal

- Este repositorio nao e o `OLMO`.
- Nada daqui sincroniza automaticamente com `C:\Dev\Projetos\OLMO`.
- Toda promocao para o repo principal depende de validacao humana explicita.
- O foco inicial continua sendo a fatia: Prometeus vault + shadow decisions + harness.

## Sistema operacional do repo

- `AGENTS.md`: contrato operacional do laboratorio
- `CLAUDE.md`: adaptador para Claude Code, importando `AGENTS.md`
- `GEMINI.md`: adaptador para Gemini CLI, importando `AGENTS.md`
- `TREE.md`: mapa profissional da arvore e politica de incorporacao segura
- `shadow/`: regras operacionais, gates e pesquisa aplicada
- `private-learning/`: area local ignorada para cockpit e material pessoal
- `shadow/HYGIENE.md`: checklist de higiene para evitar sprawl
- `shadow/SOTA-DECISIONS.md`: decisoes SOTA consolidadas, sem relatorio longo
- `shadow/FOUNDATION.md`: base de infra, memoria, harness e orquestracao
- `scripts/check.ps1`: harness local de regressao leve
- `Prometeus/.obsidian/`: configuracao do Obsidian para abrir o vault `Prometeus`
- `Prometeus/wiki/`: wiki operacional versionada do projeto

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
3. classificar o artefato em `private`, `experiment` ou `candidate`;
4. so discutir migracao para `OLMO` depois do gate humano.

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



