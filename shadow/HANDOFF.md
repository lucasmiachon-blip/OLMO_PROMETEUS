# Handoff

Status: active
Updated: 2026-04-27 (pos EV-B5 T1-T5; OLMO definido como piso, nao teto)
Scope: hidratacao para retomar `OLMO_PROMETEUS` apos `/clear` ou nova conversa.

> Este arquivo e a fonte rapida de hidratacao. `session-start.sh` cola o topo no inicio da sessao. Manter denso, operacional e sem relatorio longo.

---

## 1. Identidade

`open OLMO_PROMETEUS` e um laboratorio paralelo solo para validar fluxo, digest, estudo, wiki operacional, gates de promocao, maturidade executavel e self-evolution read-only antes de qualquer conversa de promocao para `OLMO`.

Workspace canonico unico: `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4. Caminhos Windows e `/mnt/c` sao referencia historica, archive ou UI humana, nao fonte operacional.

Perfil: medico solo dev. Padrao de ouro: auditavel, reversivel, humano-no-loop, sem PHI versionada, baixo atrito e rigor maior que o `OLMO` em boundary, evidencia, privacidade, rollback e anti-teatro.

Regra de direcao: `OLMO` e o primeiro projeto decente e vira piso profissional, nao teto. Prometeus nao copia a forma; adapta a intencao e adiciona protecao local mensuravel.

## 2. Boundaries duras

1. Nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.
2. Read externo de sibling/legado exige autorizacao humana explicita citando caminho e motivo.
3. `OLMO`, `OLMO_GENESIS`, `OLMO_COWORK`, typos como `OLMO_COWOR` e qualquer sibling `OLMO*`: read-only caso-a-caso; write externo bloqueado.
4. Nao bulk-import de legacy, hooks, skills, agents, MCP, runtime, caches, `.env`, agent-memory ou conteudo clinico.
5. Nao criar scaffolds locais (`.claude/agents/`, `.claude/hooks/`, `.claude/commands/`, `.gemini/`, `agents/`, `skills/`, `hooks/`) sem gate e aprovacao humana.
6. Push em `origin/main` exige confirmacao humana explicita por rodada.
7. Sem `--no-verify`, `--no-gpg-sign`, skip de hook ou workaround sem diagnostico.
8. Sem PHI/dado sensivel versionado, em prompt externo ou automacao sem workflow privado aprovado.

## 3. Estado atual

Branch: `main` local. Push remoto nao foi feito nesta rodada sem confirmacao humana explicita.

Harness:

- `./scripts/check.sh --strict` passa com `0 warning(s)`.
- `scripts/integrity.sh` passa e valida contratos vivos: valores, OLMO como piso, EV-B5, producer-consumer, backlog sync, antifragile verificavel, hook targets e ausencia de writes externos.
- `scripts/simulate-ci.sh` passa no leg Linux/WSL e reproduz localmente o workflow read-only (`check.sh` + `evolve.sh next`); Windows continua leg remoto.
- `scripts/test-olmo-boundary-guard.sh` passa.
- `ruff` e `biome` estao wired no harness quando manifestos existem.
- Git working tree limpo no fechamento desta janela.

Stack principal:

- Bash + Markdown + JSON como core.
- `uv` + `ruff` wired em `lab/wiki-graph-lab/`.
- `biome` wired em `biome.json`.
- Codex e Claude Code podem executar edicoes, mas nunca juntos no mesmo escopo. Gemini e pesquisa/contraponto sem write.

Hooks locais ativos em `.claude/settings.local.json` (gitignored):

- `guard-olmo-write-hook.sh`: bloqueia write externo e pede permissao para read externo protegido.
- `guard-read-secrets.sh`: bloqueia leitura/grep de segredos e paths PHI obvios.
- `guard-secrets.sh`: bloqueia commit/add com segredo em staged blob.
- `ask-bash-write.sh`: pede confirmacao para Bash com write-intent.
- `trace-edits.sh`: mostra diff/stat de edits em stderr.
- `pre-compact-checkpoint.sh`: gera checkpoint local antes de compactar.
- `session-start.sh`: injeta topo do handoff no inicio da sessao.

## 4. Contratos que mandam

- `AGENTS.md`: fonte unica de verdade para agentes.
- `VALUES.md`: valores, objetivos, `OLMO como piso` e Gap Lens. Mudanca relevante deve declarar valor, dor real, trigger, artefato, consumer, evidencia, eficacia, viabilidade, risco, rollback e criterio negativo.
- `shadow/SOTA-DECISIONS.md`: decisoes curtas apos SOTA gate.
- `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`: gate E2E, matriz producer-consumer e antifragile verificavel.
- `shadow/WORK-LANES.md`: lanes e promotion gate.
- `shadow/EVIDENCE-LOG.md`: evidencia real; sem evidencia, sem promocao.
- `shadow/BACKLOG.md` + `internal/evolution/backlog.json`: backlog humano + canonical JSON.
- `shadow/KBP.md`: Known Bad Patterns pointer-only.

## 5. Commits recentes importantes

Linha de maturidade OLMO/Prometeus:

- `6f9deae` `docs: record olmo lineage adaptation gate` — OLMO/OLMO_GENESIS como ramos paralelos; OLMO mais maduro; sem bulk copy.
- `4ae959c` `feat(harness): add local integrity gate` — `scripts/integrity.sh` integrado ao `check.sh`.
- `08ee8b8` `docs: add prometeus values and gap lens` — `VALUES.md` criado.
- `0431a3f` `docs: make olmo the prometeus maturity floor` — OLMO virou piso, nao teto.
- `6ae390d` `docs: require producer consumer for gates` — T3: hook/gate novo exige matriz producer-consumer.
- `0aefd20` `feat(harness): enforce backlog and antifragile contracts` — T4/T5: sync backlog e antifragile verificavel no harness.

Validacao final conhecida: `./scripts/check.sh --strict` passou com `0 warning(s)` apos `0aefd20`.

## 6. EV-B5 status

Objetivo EV-B5: comparar `OLMO` e `OLMO_GENESIS` como ramos paralelos e adaptar gates maduros/convergentes sem copiar runtime, hooks, skills ou dados clinicos.

Aplicado:

- T1 applied: gate read-only de integridade/maturidade local.
- T2 applied: wiring do gate em `scripts/check.sh`.
- T3 applied: matriz producer-consumer obrigatoria para hook/gate novo.
- T4 applied: sync leve entre `internal/evolution/backlog.json` e `shadow/BACKLOG.md`.
- T5 applied: erro observado precisa virar detector/teste antes de claim antifragile.

Pendente:

- T6: revisar em 2026-05-27 se os checks detectaram regressao real. Se nao detectarem, simplificar ou remover.

## 7. Licoes incorporadas do OLMO

Lidos read-only em 2026-04-27:

- `OLMO/VALUES.md`.
- indice de plans do OLMO.
- plan ativo Conductor 2026.
- amostras arquivadas S232, S253, S258 e S248.
- OLMO_GENESIS como ramo paralelo com ideias uteis, mas mais ruido.

Incorporado como principio, nao como copia:

- anti-teatro;
- evidence-based;
- humildade epistemica;
- auditoria adversarial;
- producer-consumer para hooks/gates;
- purge de aspiracional;
- criterio de eficacia antes de debug-team/runtime;
- self-evolution com risco, rollback e humano no loop.

Nao incorporar sem novo gate:

- `.claude/agents`, `.claude/skills`, `.claude/hooks`;
- APL, agent-memory, telemetry, MCP proprio;
- runtime multiagente;
- conteudo clinico cru;
- caches, `.env`, `node_modules`, `.venv`, zips, dumps.

## 8. Proxima sessao: ordem recomendada

1. Rodar `git status --short` e `./scripts/check.sh --strict`.
2. Se o user quiser push, pedir confirmacao explicita e entao executar `git push`.
3. Se continuar T6/EV-B5: criar criterio de revisao 2026-05-27 sem adicionar runtime.
4. Se for PR-2: ADRs 0002-0005 ja existem; proximo passo e decidir se privacy docs viram `docs/threat-model.md` ou ficam em `shadow/`.
5. Se for EV-B2: rodar `scripts/simulate-ci.sh`; depois verificar CI remoto (`gh run list`) e documentar bloqueio; branch protection so depois de workflow verde.
6. Se for digest/study: rodar uso real e registrar em `EVIDENCE-LOG.md`; senao aposentar/simplificar.

P0 atual:

- `EV-B2`: CI remoto verde; depende de auth/permissao.
- `PR-2`: ADRs 0002-0005 criados; pendente consolidar privacy/procedures sem quebrar harness.
- `EV-DIGEST`: promover ou aposentar `email-digest-4p` e `study-track-done`.
- `LEGACY-MINE`: inventarios legacy bloqueados, sempre caso-a-caso.

P1 atual:

- `EV-B4`: ADR index 0001-0007 existe; pendente reduzir `SOTA-DECISIONS.md` sem perder historico operacional.
- `EV-B6`: SOTA alignment triage aplicado; CI local read-only e stale evidence warning entraram, PHI prompt hook/handoff JSON/value commit gate/issues:write ficaram bloqueados ate consumer real.
- `EV-B5`: concluir T6 na data certa.
- `WIKI-PROMO`: decidir destino das 4 notas wiki incorporadas apos uso real.

## 9. Arquivos para hidratar contexto

Leia nesta ordem:

1. `AGENTS.md`
2. `VALUES.md`
3. `shadow/HANDOFF.md`
4. `shadow/BACKLOG.md`
5. `shadow/SOTA-DECISIONS.md`
6. `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`
7. `scripts/integrity.sh`
8. `shadow/EVIDENCE-LOG.md`

Para contexto visual/wiki:

- `Prometeus/wiki/Home.md`
- `Prometeus/wiki/Maps/Prometeus.canvas`

## Migration Readiness

Ainda nao migrar nada para `OLMO` como padrao operacional.

Pronto localmente: workspace canonico Linux/WSL, valores e objetivos versionados, `OLMO` como piso, EV-B5 T1-T5 aplicadas, producer-consumer exigido para gates, antifragile verificavel no harness, privacy guards minimos e `./scripts/check.sh --strict` verde.

Falta antes de promocao: CI remoto verde (`EV-B2`), evidencia real por procedure, T6 em 2026-05-27, criterio de rollback por artefato e confirmacao humana explicita para qualquer push/migracao.

## 10. Stop conditions

- Cwd diferente do workspace canonico: parar antes de editar.
- Tarefa exige write externo: parar e pedir autorizacao explicita.
- Mudanca estrutural sem trigger, consumidor, risco, rollback e criterio negativo: manter em `experiment` ou rejeitar.
- Hook/gate novo sem linha producer-consumer: bloqueado.
- Claim antifragile sem detector/regra/teste: bloquear via KBP-11.
- Dado sensivel/PHI real: bloquear ate workflow privado aprovado.
- CI/remoto exige permissao admin: registrar bloqueio, nao contornar.

Coautoria: Lucas + GPT-5.x-Codex (xhigh)
