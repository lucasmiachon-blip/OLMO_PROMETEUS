@AGENTS.md

## Gemini CLI

Regra fundamental: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

### What this is

Laboratorio paralelo solo. Gemini entra para pesquisa externa, multimodalidade e sintese de PDFs longos quando houver objetivo, trigger, artefato, custo e risco. `AGENTS.md` e a fonte de verdade; este arquivo e um adaptador fino.

### Things that will bite you

- Write externo nao autorizado: qualquer edit fora de `C:\Dev\Projetos\OLMO_PROMETEUS` e proibido e deve ser bloqueado. Read externo de sibling/legado exige pergunta previa citando caminho e motivo exatos.
- Workspace stale: se a sessao apontar para ROADMAP legado, `OLMO_COWORK`, typo `OLMO_COWOR` ou cwd diferente, corrija para `C:\Dev\Projetos\OLMO_PROMETEUS` antes de editar; write externo e block, read externo e ask.
- Runtime scaffolds: `.gemini/`, extensoes, MCP config, comandos ativos ou automacao ativa sao proibidos sem gate em `shadow/INCORPORATION-LOG.md`.
- Output volumoso no repo: saidas duraveis devem virar decisao curta em `shadow/` ou nota linkavel em `Prometeus/wiki/`. Relatorios longos morrem cedo (regra anti-sprawl).
- Duplicar politica: se precisar de regra nova, va para `AGENTS.md`, `PROJECT_CONTRACT.md`, `TREE.md`, `shadow/` ou `Prometeus/wiki/` — nao aqui.
- Usar Gemini por reflexo: entra quando Claude/Codex nao cobrem o caso (pesquisa longa, multimodal, PDF grande). Declarar custo e artefato antes.
- Uso real sem log: toda vez que Gemini gerar artefato no repo, registre linha em `shadow/EVIDENCE-LOG.md`.

### Iteracao

Se Gemini CLI errar padrao do repo, adicione o caso a `Things that will bite you` em vez de explicar dentro da conversa.
