# Handoff

Status: active
Updated: 2026-04-25
Scope: janela hidratada para retomar `OLMO_PROMETEUS` sem reler docs longos.

## Read First

1. Este repo e `OLMO_PROMETEUS`, nao `OLMO`: ver `../PROJECT_CONTRACT.md`.
2. A regra fundamental e nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`: ver `../AGENTS.md` e `FOUNDATION.md`.
3. O objetivo atual e validar laboratorio paralelo de baixo risco para vault, digest, study flow, wiki operacional e gates: ver `../README.md` e `WORK-LANES.md`.
4. O proximo batch oficial vem de `../internal/evolution/backlog.json`; nao inventar fila paralela.
5. Riscos vivos vem de `../internal/evolution/risk-register.json`; nao esconder warning critico.

## Current Objective

Validar se a fatia Prometeus realmente merece promocao futura:

- `Prometeus/` precisa funcionar como vault e wiki operacional, nao deposito.
- `shadow/EMAIL-DIGEST-4P.md` e `shadow/STUDY-TRACK-DONE.md` precisam de uso real registrado em `EVIDENCE-LOG.md`.
- `scripts/check.ps1`, `scripts/maturity.ps1` e `scripts/evolve.ps1` precisam passar localmente e, depois, no GitHub Actions.
- Qualquer conversa sobre `OLMO` exige evidencia, rollback e aprovacao humana explicita.

## Top Gaps

| Rank | Gap | Source | Next |
| --- | --- | --- | --- |
| P0 | Objetivo ainda nao tem metricas de valor para medico solo dev | `scripts/maturity.ps1` area `Produto e valor` | definir 3 a 5 outcomes mensais antes de promover fluxo |
| P0 | PHI/dado sensivel continua risco critico aberto | `../internal/evolution/risk-register.json` id `R-PHI` | executar `EV-B3`: data classification, PHI checklist, threat model, incident log |
| P0 | CI remoto falha no passo `Harness` | GitHub run `24940721189` e `24938611376` | executar `EV-B2`: obter log/admin ou reproduzir ambiente `windows-latest` |
| P1 | Digest e study ainda nao provaram 3 usos reais | `EVIDENCE-LOG.md` e `WORK-LANES.md` | rodar em ciclos reais e registrar output |
| P1 | Foundation, wiki e antifragile gate ainda estao em `experiment` | `WORK-LANES.md` | escolher 1 fluxo para virar `candidate`, nao varios |
| P1 | Arquitetura ainda depende de TREE + contexto humano | `../internal/evolution/backlog.json` id `EV-B4` | criar nota curta de arquitetura so depois de `EV-B2` |

## Next Session

Sequencia obrigatoria:

1. Confirmar `git status --short --branch`.
2. Rodar `powershell -ExecutionPolicy Bypass -File .\scripts\evolve.ps1 -Mode next`.
3. Atacar `EV-B2`: workflow remoto falha no passo `Harness`; `gh run view --log-failed` retornou HTTP 403 por falta de admin.
4. Se o log remoto continuar bloqueado, documentar bloqueio e reproduzir o mais perto possivel com `pwsh` local.
5. Nao aplicar branch protection ate haver workflow verde ou bloqueio documentado.
6. Depois de `EV-B2`, atacar `EV-B3` porque `R-PHI` e critico e aberto.

## Cross References

- Contrato e boundary: `../PROJECT_CONTRACT.md`, `../AGENTS.md`, `FOUNDATION.md`
- Estado e promocao: `WORK-LANES.md`, `INCORPORATION-LOG.md`, `EVIDENCE-LOG.md`
- Evolucao: `../internal/evolution/backlog.json`, `../internal/evolution/review.json`, `../internal/evolution/risk-register.json`
- Orquestracao, antifragile e `CASE_edges`: `ORCHESTRATION-HARNESS-ANTIFRAGILE.md`
- SOTA compacto: `SOTA-DECISIONS.md`, `AGENT-MODULES.md`, `AGENT-USAGE.md`
- Mapa da arvore: `../TREE.md`

## Stop Conditions

- Se o cwd nao for `C:\Dev\Projetos\OLMO_PROMETEUS`, parar antes de editar.
- Se a tarefa exigir write em `C:\Dev\Projetos\OLMO`, parar e pedir autorizacao explicita.
- Se a mudanca estrutural nao tiver trigger, aceite, risco e rollback, manter em `experiment`.
- Se a correcao do CI exigir permissao admin, registrar bloqueio em vez de contornar com automacao insegura.

