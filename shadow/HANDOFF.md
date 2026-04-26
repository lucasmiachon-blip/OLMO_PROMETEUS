# Handoff

Status: active
Updated: 2026-04-26
Scope: janela hidratada para retomar `OLMO_PROMETEUS` sem reler docs longos.

## Read First

1. Este repo e `OLMO_PROMETEUS`, nao `OLMO`: ver `../PROJECT_CONTRACT.md`.
2. A regra fundamental e nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`: ver `../AGENTS.md` e `FOUNDATION.md`.
3. O workspace canonico unico e `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4.
4. O objetivo atual e validar laboratorio paralelo de baixo risco para vault, digest, study flow, wiki operacional e gates: ver `../README.md` e `WORK-LANES.md`.
5. O proximo batch oficial vem de `../internal/evolution/backlog.json`; nao inventar fila paralela.
6. Riscos vivos vem de `../internal/evolution/risk-register.json`; nao esconder warning critico.

## Current Objective

Validar se a fatia Prometeus realmente merece promocao futura:

- Branch ativo: `main` local alinhado com `origin/main`.
- `Prometeus/` precisa funcionar como vault e wiki operacional, nao deposito.
- `shadow/EMAIL-DIGEST-4P.md` e `shadow/STUDY-TRACK-DONE.md` precisam de uso real registrado em `EVIDENCE-LOG.md`.
- `scripts/check.sh` e `scripts/evolve.sh` sao o gate operacional local.
- Qualquer conversa sobre `OLMO` exige evidencia, rollback e aprovacao humana explicita.

## Migration Readiness

Ainda nao migrar para `OLMO` como padrao operacional.

O que ja esta pronto:

- repo canonico consolidado em `/home/lucasmiachon/projects/OLMO_PROMETEUS`;
- `main` publicado no GitHub e alinhado com `origin/main`;
- harness local passa via Bash;
- runtime antigo removido do caminho operacional versionado;
- decisao SOTA registrada para `xhigh` e workspace Linux/WSL ext4 canonico;
- controles minimos de privacidade/PHI criados e exigidos pelo harness: `DATA-CLASSIFICATION.md`, `PHI-CHECKLIST.md`, `THREAT-MODEL.md`, `INCIDENT-LOG.md`.

O que falta antes de promocao:

- confirmar workflow remoto apos o push em `main`;
- aplicar `PHI-CHECKLIST.md` no primeiro fluxo real com saude ou dado pessoal;
- registrar pelo menos 3 usos reais de digest/study/wiki/harness em `EVIDENCE-LOG.md` antes de promover procedimento para `candidate` ou `operational`;
- escolher explicitamente quais artefatos sao migraveis, com trigger, risco, custo e rollback;
- manter rollback simples: revert de commit, sem sync automatico, hook ativo, MCP sensivel ou write externo.

## Top Gaps

| Rank | Gap | Source | Next |
| --- | --- | --- | --- |
| P0 | Objetivo ainda nao tem metricas de valor para medico solo dev | `internal/evolution/backlog.json` e `scripts/evolve.sh` | definir 3 a 5 outcomes mensais antes de promover fluxo |
| P0 | CI remoto precisa ser confirmado depois do push em `main` | `../internal/evolution/backlog.json` id `EV-B2`; `INCIDENT-LOG.md` | rodar `gh run list`/`gh run view` e documentar resultado |
| P1 | PHI/dado sensivel tem controle minimo, mas precisa uso real | `../internal/evolution/risk-register.json` id `R-PHI`; `DATA-CLASSIFICATION.md` | aplicar checklist no primeiro fluxo com saude/dado pessoal |
| P1 | Digest e study ainda nao provaram 3 usos reais | `EVIDENCE-LOG.md` e `WORK-LANES.md` | rodar em ciclos reais e registrar output |
| P1 | Foundation, wiki e antifragile gate ainda estao em `experiment` | `WORK-LANES.md` | escolher 1 fluxo para virar `candidate`, nao varios |
| P1 | Arquitetura ainda depende de TREE + contexto humano | `../internal/evolution/backlog.json` id `EV-B4` | criar nota curta de arquitetura so depois de `EV-B2` |


## Local Runtime Verified

Verificado em 2026-04-26 no workspace `/home/lucasmiachon/projects/OLMO_PROMETEUS`:

| Ferramenta | Estado | Observacao |
|---|---|---|
| Claude Code | `2.1.119` | `claude` aponta para `~/.npm-global/bin/claude` via symlink em `~/.local/bin` |
| Codex CLI | `0.125.0` | versao publicada atual no npm no momento da verificacao |
| Gemini CLI | `0.39.1` | instalado globalmente via npm |
| Zellij | `0.44.1` | instalado em `~/.local/bin/zellij`; `/usr/local/bin/zellij` antigo estava em uso |
| WSL | `2.6.3.0` | `wsl.exe --update` informou que ja era a versao mais recente |
| Ubuntu WSL | `24.04.4 LTS` | linha LTS atual; upgrade para 26.04 e decisao estrutural, nao update comum |

Pendencia: existem pacotes `apt` atualizaveis, mas exigem senha humana: rodar `sudo apt update && sudo apt upgrade` no terminal.

## Next Session

Sequencia obrigatoria:

1. Confirmar `git status --short --branch` em `/home/lucasmiachon/projects/OLMO_PROMETEUS`.
2. Rodar `./scripts/check.sh`.
3. Rodar `./scripts/evolve.sh next`.
4. Abrir `SOTA-STACK-2026-04-26.md` como dossie central.
5. Confrontar as tres pernas: relatorio Opus do usuario, pesquisa independente Codex/ChatGPT 5.5, e resposta Gemini em `SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md`.
6. Julgamento: Lucas + Codex/ChatGPT 5.5 decidem o caminho profissional, sem concordancia automatica com Opus, Gemini ou Codex.
7. Manter Ubuntu 24.04 e workspace Linux/WSL ext4; qualquer Fedora, Ubuntu 26.04 ou mudanca de OS exige novo trigger, metrica, rollback e criterio negativo.
8. Atacar `EV-B2`: confirmar workflow remoto do `main` com `gh run list` e, se falhar, `gh run view --log-failed`.
9. Se o log remoto continuar bloqueado, documentar bloqueio e reproduzir o mais perto possivel com Bash local.
10. Nao aplicar branch protection ate haver workflow verde ou bloqueio documentado.
11. `EV-B3` ja tem controle minimo aplicado; antes de qualquer fluxo clinico/dado pessoal, usar `PHI-CHECKLIST.md`.

## Cross References

- Contrato e boundary: `../PROJECT_CONTRACT.md`, `../AGENTS.md`, `FOUNDATION.md`
- Estado e promocao: `WORK-LANES.md`, `INCORPORATION-LOG.md`, `EVIDENCE-LOG.md`
- Evolucao: `../internal/evolution/backlog.json`, `../internal/evolution/review.json`, `../internal/evolution/risk-register.json`
- Orquestracao, antifragile e `CASE_edges`: `ORCHESTRATION-HARNESS-ANTIFRAGILE.md`
- SOTA compacto: `SOTA-DECISIONS.md`, `AGENT-MODULES.md`, `AGENT-USAGE.md`
- GitHub remoto: `GITHUB-REMOTE-WSL.md`
- SOTA stack 2026-04-26: `SOTA-STACK-2026-04-26.md`
- CLI prompt set 2026-04-27: `SOTA-STACK-CLI-PROMPTS-2026-04-27.md`
- Gemini prompt SOTA: `SOTA-STACK-GEMINI-PROMPT-2026-04-26.md`
- Gemini response SOTA: `SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md`
- Mapa da arvore: `../TREE.md`

## Stop Conditions

- Se o cwd nao for `/home/lucasmiachon/projects/OLMO_PROMETEUS`, parar antes de editar.
- Se a tarefa exigir write em `C:\Dev\Projetos\OLMO`, parar e pedir autorizacao explicita.
- Se a mudanca estrutural nao tiver trigger, aceite, risco e rollback, manter em `experiment`.
- Se a correcao do CI exigir permissao admin, registrar bloqueio em vez de contornar com automacao insegura.
