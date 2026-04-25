# AGENTS.md - open OLMO_PROMETEUS

> Consumer: Codex app/CLI e outros agentes que trabalhem neste repo isolado.

## Intent

`open OLMO_PROMETEUS` e um laboratorio paralelo, pequeno e de baixo risco.

- Pode editar arquivos dentro deste repositorio.
- Nao deve editar `C:\Dev\Projetos\OLMO` nem `C:\Dev\Projetos\OLMO_COWORK` sem autorizacao humana explicita.
- O foco e validar fluxo, digest, estudo, wiki operacional e gates de promocao.

## Fundamental Boundary

Regra fundamental: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

- Nao editar, mover, deletar, criar, arquivar, sincronizar ou gerar artefatos fora deste repo.
- Nao executar automacao, hook, script ou ferramenta que faca write externo.
- Nao tocar `C:\Dev\Projetos\OLMO`, `C:\Dev\Projetos\OLMO_COWORK` ou outros siblings.
- Se uma tarefa exigir write fora daqui, parar e pedir autorizacao explicita na conversa.
- Se a sessao iniciar em workspace legado ROADMAP ou cwd diferente, corrigir para `C:\Dev\Projetos\OLMO_PROMETEUS` antes de qualquer edit; se a ferramenta de patch estiver presa fora daqui, parar e relatar.
- A autorizacao precisa citar o caminho externo e a acao exata.

## Operating Principles

- Prefira artefatos reversiveis: Markdown, HTML simples, JSON e scripts pequenos.
- Mantenha o blast radius baixo: faca a menor mudanca util.
- Use pesquisa e docs para reduzir incerteza antes de aumentar estrutura.
- Consolide antes de criar documento novo; pesquisa vira decisao curta.
- Trate migracao para `OLMO` como evento humano, nao como reflexo.
- Mudanca de arquitetura, agente, skill, hook, MCP ou orquestracao exige SOTA research gate antes de editar.

## SOTA Research Gate

Antes de mudar arquitetura, agentes, skills, hooks, MCP, memoria ou orquestracao:

1. Auditar o estado local primeiro.
2. Pesquisar fontes primarias e atuais, preferindo docs oficiais.
3. Registrar uma decisao curta em `shadow/SOTA-DECISIONS.md` ou no arquivo operacional correto.
4. Explicitar trigger, nao-trigger, risco, custo, rollback e criterio negativo.
5. So entao editar.

Se a pesquisa nao justificar a mudanca, nao implementar. Sem bajulacao, sem arquitetura aspiracional e sem copiar moda.

## Solo Doctor Dev Standard

Este repo deve operar como laboratorio de um medico solo dev: alta utilidade, baixo atrito e risco clinico controlado.

- Nao colocar dados de paciente, PHI ou dados pessoais sensiveis em arquivos versionados, prompts externos, automacoes ou agentes, salvo workflow privado aprovado explicitamente.
- Usar exemplos sinteticos, anonimizados ou minimizados por padrao; quando pesquisa externa envolver saude, citar fonte e separar fato, inferencia e decisao.
- Agentes e automacoes podem preparar, auditar e resumir; decisao clinica, legal, financeira ou de privacidade fica humana.
- Preferir procedimento manual + harness + evidencia antes de framework de orquestracao.
- Runtime agentico novo so entra apos >=3 evidencias de retrabalho real em `shadow/EVIDENCE-LOG.md`, trigger claro, rollback e aprovacao humana.
- O padrao de ouro e: auditavel, reversivel, sem dados sensiveis, humano-no-loop e proporcional ao tamanho real do projeto.

## Daily Loop

1. Capture materia-prima em `private-learning/` ou em uma nota temporaria.
2. Converta a materia com um procedimento pequeno documentado em `shadow/` ou na wiki.
3. Classifique o resultado como `private`, `experiment` ou `candidate`.
4. So discuta migracao para `OLMO` quando houver trigger, evidencia e rollback.

## Lanes

Estados dos artefatos: `private`, `experiment`, `candidate`, `operational`, `retired`, `blocked`.

Fonte unica de verdade dos estados, criterios e gate minimo: `shadow/WORK-LANES.md`. Transicoes aplicadas ficam em `shadow/INCORPORATION-LOG.md`. Evidencia que sustenta promocao ate `operational` vive em `shadow/EVIDENCE-LOG.md`.

Regra: agentes que precisarem de criterio detalhado seguem o link acima. Duplicar a tabela aqui cria drift.

## Layout

- `private-learning/`: cockpit visual e material pessoal local, ignorado pelo Git e pelo contexto.
- `CLAUDE.md`: adaptador fino para Claude Code; importa `AGENTS.md`.
- `GEMINI.md`: adaptador fino para Gemini CLI; importa `AGENTS.md`.
- `.github/workflows/self-evolution.yml`: watchdog read-only que roda harness/evolucao sem write automatico.
- `internal/evolution/`: backlog, risk register e review cadence do loop self-evolving; nao guarda dado sensivel.
- `shadow/`: fonte operacional. Contratos, gates, rubricas, evidencia e mapas de uso.
  - `shadow/WORK-LANES.md`: fonte unica dos estados (private, experiment, candidate, operational, retired, blocked) e promotion gate.
  - `shadow/EVIDENCE-LOG.md`: registro de uso real dos procedimentos (gate para `operational`).
  - `shadow/SOTA-DECISIONS.md`: decisoes curtas apos SOTA research gate.
  - `shadow/AGENT-USAGE.md`: mapa de agentes/skills globais usados sem scaffold local.
  - `shadow/INCORPORATION-LOG.md`: log de transicoes de estado aplicadas.
  - `shadow/PLAN-*.md`: plans operacionais de mudancas estruturais (um por rodada).
- `TREE.md`: mapa da arvore raiz, casas dos artefatos e politica de incorporacao do `OLMO`.
- `Prometeus/README.md`: entrada documental do vault Obsidian.
- `Prometeus/.obsidian/`: configuracao do vault Obsidian `Prometeus`.
- `Prometeus/wiki/`: conhecimento duravel e navegavel via graph view. Complementa `shadow/`, nao substitui.
  - `Prometeus/wiki/Notes/`: notas conceituais com no minimo 2 wikilinks para outras notas. Notas com <2 wikilinks sao espelhos de `shadow/` e viram candidatas a delete em HYGIENE.
- `scripts/`: harness local pequeno, maturidade (`scripts/maturity.ps1`) e self-evolution (`scripts/evolve.ps1`).

## Memoria

Este projeto nao usa a memoria automatica do Claude Code. `C:\Users\lucas\.claude\projects\C--Dev-Projetos-OLMO-PROMETEUS\memory\` e intencionalmente vazio. A memoria do projeto vive em `AGENTS.md`, `shadow/` e `Prometeus/wiki/`. Memoria global do usuario fica em `~/.claude/CLAUDE.md` e e read-only por este repo.

## Error Reports and Self-Improvement

Quando ocorrer erro material (tool, shell, path, permissao, teste, pesquisa ou suposicao quebrada), parar antes de trocar a estrategia e reportar:

- Erro: o que falhou, comando/ferramenta e mensagem principal.
- Por que: hipotese tecnica mais provavel, sem inventar certeza.
- O que mudou: qual plano mudou por causa do erro.
- Impacto: o que ficou incompleto, arriscado ou sem validacao.
- O que um profissional faria: acao profissional para diagnosticar ou corrigir.
- Vamos fazer?: sim ou nao, com justificativa proporcional ao risco, custo e escopo.
- Regra nova: aprendizado pratico para evitar repeticao.

Se o erro indicar sandbox, permissao ou rede e o comando for essencial, repetir o mesmo comando com aprovacao conforme politica antes de mudar rota. A memoria desse aprendizado so entra no repo quando muda comportamento futuro.

## Do

- produzir digest em 4 paragrafos;
- manter trilha de estudo com criterio de `done`;
- atualizar gates de promocao e risco;
- explicitar o que e experimento e o que e candidato;
- citar fontes quando a resposta depender de pesquisa externa.

## Do Not

- tocar o repo principal por reflexo;
- escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`;
- copiar hooks, MCP ou infraestrutura sensivel do `OLMO`;
- ativar hook sem trigger, evidencia, rollback e aprovacao humana explicita;
- permitir self-evolution com write, commit, push, issue, PR ou dado sensivel sem aprovacao humana explicita;
- recriar diretorios locais de agents, subagents, skills, hooks, `.claude/agents/`, `.claude/hooks/`, `.claude/commands/` ou `.gemini/` sem necessidade repetida e aprovacao explicita;
- criar skill em `.claude/skills/<name>/` sem procedure operational em `shadow/` e sem frontmatter valido (`name`, `description`, `trigger`, `non-trigger`, `source`, `status`, `owner`) — ver `shadow/AGENT-USAGE.md > Local skills contract`;
- tratar `.claude/settings.local.json` como runtime ativo (e state local; fica em `.gitignore`/`.claudeignore`);
- marcar `done` sem evidencia de entendimento ou aplicacao;
- misturar material pessoal com runtime do projeto;
- colocar captura privada/crua no vault versionado;
- inflar o repo com agentes, skills ou scaffolds sem uso recorrente.
- manter relatorios longos quando uma decisao curta resolve.

## Validation Before Finish

- Se editar docs ou HTML, cheque nomes, titulos e links locais.
- Se editar base, memoria, harness ou orquestracao, atualize `shadow/FOUNDATION.md`.
- Se editar a wiki, preserve links Obsidian e a separacao entre conhecimento duravel e captura privada.
- Quando houver mudanca persistente, rode `powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1`.
- Se um artefato virar `candidate`, atualize `shadow/WORK-LANES.md`.
- Se a sessao criar varios artefatos, confira `shadow/HYGIENE.md`.
- Se rodou um procedimento (`email-digest-4p`, `study-track-done`, `sota-research-gate`) em uso real, registre linha em `shadow/EVIDENCE-LOG.md`.
- Se a tarefa esbarrar no repo principal, pare e peca autorizacao explicita.

## Coauthorship

- Codex: `Coautoria: Lucas + GPT-5.4 (Codex)`
- Outros modelos: registrar papel, trigger, artefato, custo e risco antes de adotar no fluxo.

