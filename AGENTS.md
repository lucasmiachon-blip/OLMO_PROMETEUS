# AGENTS.md - open OLMO_PROMETEUS

> Consumer: Codex app/CLI e outros agentes que trabalhem neste repo isolado.

## Intent

`open OLMO_PROMETEUS` e um laboratorio paralelo, pequeno e de baixo risco.

- Pode editar arquivos dentro deste repositorio.
- Nao deve editar `C:\Dev\Projetos\OLMO` nem `C:\Dev\Projetos\OLMO_COWORK` sem autorizacao humana explicita.
- O foco e validar fluxo, digest, estudo, dashboards locais e gates de promocao.

## Fundamental Boundary

Regra fundamental: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

- Nao editar, mover, deletar, criar, arquivar, sincronizar ou gerar artefatos fora deste repo.
- Nao executar automacao, hook, script ou ferramenta que faca write externo.
- Nao tocar `C:\Dev\Projetos\OLMO`, `C:\Dev\Projetos\OLMO_COWORK` ou outros siblings.
- Se uma tarefa exigir write fora daqui, parar e pedir autorizacao explicita na conversa.
- A autorizacao precisa citar o caminho externo e a acao exata.

## Operating Principles

- Prefira artefatos reversiveis: Markdown, HTML simples, JSON e scripts pequenos.
- Mantenha o blast radius baixo: faca a menor mudanca util.
- Use pesquisa e docs para reduzir incerteza antes de aumentar estrutura.
- Consolide antes de criar documento novo; pesquisa vira decisao curta.
- Trate migracao para `OLMO` como evento humano, nao como reflexo.

## Daily Loop

1. Capture materia-prima em `private-learning/` ou em uma nota temporaria.
2. Converta a materia com uma skill pequena e especifica.
3. Classifique o resultado como `private`, `experiment` ou `candidate`.
4. So discuta migracao para `OLMO` quando houver trigger, evidencia e rollback.

## Lanes

| Lane | Uso | Pode migrar? | Gate minimo |
|------|-----|--------------|--------------|
| `private` | notas pessoais, digests, estudo e checkpoints | nao | fica local |
| `experiment` | prototipos e fluxos ainda instaveis | talvez, depois | repetir em alguns ciclos |
| `candidate` | padrao reutilizavel, ja com artefato claro | sim, com humano | trigger + evidencia + rollback |

## Layout

- `private-learning/`: cockpit visual, digests, progresso e uso diario.
- `shadow/`: contratos, trilhas, gates, pesquisa e arquitetura operacional.
- `Prometeus/README.md`: entrada documental do vault Obsidian.
- `Prometeus/.obsidian/`: configuracao do vault Obsidian `Prometeus`.
- `Prometeus/wiki/`: notas Obsidian versionadas para conhecimento duravel do projeto.
- `playground/`: testes locais e prototipos descartaveis.
- `.agents/skills/`: workflows reutilizaveis deste laboratorio.
- `.codex/agents/`: agentes customizados estreitos para delegacao.

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
- marcar `done` sem evidencia de entendimento ou aplicacao;
- misturar material pessoal com runtime do projeto;
- colocar captura privada/crua no vault versionado;
- inflar o repo com agentes e skills sem uso recorrente.
- manter relatorios longos quando uma decisao curta resolve.

## Validation Before Finish

- Se editar docs ou HTML, cheque nomes, titulos e links locais.
- Se editar skill, mantenha a descricao clara sobre quando ela dispara.
- Se editar base, memoria, harness ou orquestracao, atualize `shadow/FOUNDATION.md`.
- Se editar a wiki, preserve links Obsidian e a separacao entre conhecimento duravel e captura privada.
- Quando houver mudanca persistente, rode `powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1`.
- Se um artefato virar `candidate`, atualize `shadow/WORK-LANES.md`.
- Se a sessao criar varios artefatos, confira `shadow/HYGIENE.md`.
- Se a tarefa esbarrar no repo principal, pare e peca autorizacao explicita.

## Coauthorship

- Codex: `Coautoria: Lucas + GPT-5.4 (Codex)`
- Outros modelos: registrar papel, trigger, artefato, custo e risco antes de adotar no fluxo.
