# Handoff

Status: active
Updated: 2026-04-28 (rodada `happy-drifting-naur` aplicada: B1-B5 commits locais; cluster doctrine + Windows CI retired)
Scope: hidratacao para retomar `OLMO_PROMETEUS` apos `/clear`, nova conversa ou restart em casa.

> Este arquivo e a fonte rapida de hidratacao. `session-start.sh` cola o topo no inicio da sessao. Manter denso, operacional, sem relatorio longo.

---

## 1. Identidade

`open OLMO_PROMETEUS` e laboratorio paralelo solo para validar fluxo, digest, estudo, wiki operacional, gates de promocao, maturidade executavel e self-evolution read-only antes de qualquer conversa de promocao.

Workspace canonico unico: `/home/lucasmiachon/projects/OLMO_PROMETEUS` em Linux/WSL ext4. Caminhos Windows e `/mnt/c` sao referencia historica, archive ou UI humana, nao fonte operacional.

Perfil: medico solo dev. Padrao de ouro: auditavel, reversivel, humano-no-loop, sem PHI versionada, baixo atrito, anti-teatro.

Direcao: **OLMO e precedente, nao autoridade** (foi vibe-coded com retrabalho — confirmado pelo usuario 2026-04-28). Cherrypicks exigem evidencia independente + adaptacao lean, nunca porte literal. Caminho OLMO -> Prometeus e merge gradual: cada batch valida 1 peca contra SOTA atual + adapta + registra. Anseio: Prometeus virar projeto principal por acumulo, nao substituicao. Humildade simetrica: Prometeus pode ser superseded um dia pelos mesmos criterios.

## 2. Boundaries duras

1. Nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`.
2. Read externo de sibling/legado exige autorizacao humana explicita citando caminho e motivo. (Autorizacao 2026-04-28 para `/mnt/c/Dev/Projetos/OLMO` foi escopada a essa sessao; renovar para futuras.)
3. `OLMO`, `OLMO_GENESIS`, `OLMO_COWORK`, typos e siblings `OLMO*`: read caso-a-caso; write externo bloqueado. Lucas roda PowerShell em OLMO independentemente — nao tocar.
4. Nao bulk-import de legacy, hooks, skills, agents, MCP, runtime, caches, `.env`, agent-memory ou conteudo clinico.
5. **Cluster contract:** `.claude/agents/<cluster>/` e `.claude/skills/<cluster>/` aceitos em 4 clusters fixos (`harness`/`research`/`study`/`wiki`), cap 2 por tipo, gate >=3 evidencias, frontmatter 8 campos. Fora disso = bloqueado por `integrity.sh > check_cluster_contract`.
6. Push em `origin/main` exige confirmacao humana explicita por rodada.
7. Sem `--no-verify`, `--no-gpg-sign`, skip de hook ou workaround sem diagnostico.
8. Sem PHI/dado sensivel versionado, em prompt externo ou automacao sem workflow privado aprovado.

## 3. Estado atual (2026-04-28 fim de janela)

Branch: `main` local. **Push pendente** (sera feito apos commit B5 + HANDOFF) com confirmacao explicita do usuario.

Harness:

- `./scripts/check.sh --strict` passa com `0 warning(s)`.
- `scripts/integrity.sh` passa (2 warnings: stale evidence em `obsidian-crossref-check` e `promotion-gate` — sem entradas em EVIDENCE-LOG).
- `scripts/simulate-ci.sh linux` passa; `windows` aposentado (formal 2026-04-28).
- `scripts/test-olmo-boundary-guard.sh` passa.
- `scripts/test-guard-secrets.sh` passa (16 patterns: 15 secret OLMO + CPF formatado; e2e em temp git).
- `ruff` e `biome` wired no harness quando manifestos existem.

CI remoto:

- `.github/workflows/self-evolution.yml` ubuntu-latest only (windows-latest **retirado** 2026-04-28 apos audit `gh run list`).
- gh auth WSL **funciona** (token gho_, scopes repo+workflow). R-CI-DRIFT controlled.

Stack:

- Bash + Markdown + JSON core.
- `uv` + `ruff` em `lab/wiki-graph-lab/`. `biome` em `biome.json`.
- Codex e Claude Code podem editar (nunca juntos no mesmo escopo). Gemini para pesquisa/contraponto, sem write.

Hooks ativos (`.claude/settings.local.json`, gitignored):

- `guard-olmo-write-hook.sh`: bloqueia write externo / pede permissao read externo protegido.
- `guard-read-secrets.sh`: bloqueia leitura/grep de segredos e PHI obvios.
- `guard-secrets.sh`: bloqueia commit/add com 16 patterns (15 secret + CPF formatado).
- `ask-bash-write.sh`: confirmacao Bash com write-intent.
- `trace-edits.sh`: diff/stat de edits em stderr.
- `pre-compact-checkpoint.sh`: checkpoint antes de compactar.
- `session-start.sh`: cola topo do handoff.

`.claude/agents/{harness,research,study,wiki}/` e `.claude/skills/{harness,research,study,wiki}/`: 8 pastas vazias com `.gitkeep` (Phase 0 cluster seed).

## 4. Contratos que mandam

- `AGENTS.md`: fonte unica de verdade.
- `VALUES.md`: V1-V9 + Gap Lens. Mudanca declara valor, dor, trigger, artefato, consumer, evidencia, eficacia, viabilidade, risco, rollback, criterio negativo.
- `shadow/CLUSTER-CONTRACT.md` **(novo 2026-04-28)**: cluster doctrine + path-to-principal (8 criterios para Prometeus suceder OLMO). Fonte unica.
- `shadow/SOTA-DECISIONS.md`: decisoes curtas pos-SOTA gate.
- `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`: gate E2E, producer-consumer, antifragile verificavel.
- `shadow/WORK-LANES.md`: lanes + promotion gate.
- `shadow/EVIDENCE-LOG.md`: evidencia real; sem evidencia, sem promocao.
- `shadow/BACKLOG.md` + `internal/evolution/backlog.json`: backlog humano + canonical JSON (sync 2026-04-28).
- `shadow/KBP.md`: Known Bad Patterns pointer-only. KBP-04 reescrito (cluster + cap + gate).
- `shadow/GITHUB-REMOTE-WSL.md`: procedimento gh auth + decisao CI legs (ubuntu-only remoto desde 2026-04-28).
- `shadow/PHI-CHECKLIST.md`: regex e suplemento, nao substituto. Stop checklist humana primaria.

## 5. Commits recentes (rodada 2026-04-28 happy-drifting-naur)

- `b3a35dc` `feat(security): add PHI CPF detector + test fixtures (16 patterns)` — B4: guard-secrets +CPF, test-guard-secrets.sh wired, PHI-CHECKLIST atualizado.
- `62d0aca` `feat(harness): add check_cluster_contract enforcer (44 lines)` — B3: 4 negativos validados (cluster invalido, cap, frontmatter, mismatch).
- `563c14f` `feat(cluster): seed 4-cluster architecture with cap 2 and gate doctrine` — B2: 8 .gitkeep + CLUSTER-CONTRACT.md + KBP-04 rewrite + cross-refs.
- `2e97075` `feat(harness): emit acceptance in evolve.sh next; gate against invalid backlog` — B1: evolve.sh next imprime acceptance + gate failures.
- `ced03a5` (anterior) `docs: prioritize multimodel SOTA efficacy`.

Pendente nesta janela: commit B5 (Windows CI retire) + commit HANDOFF + **push origin main** (autorizado pelo usuario).

## 6. EV-B5 status (mantido)

Aplicado: T1-T5 (gate read-only, wiring, producer-consumer, sync backlog, antifragile verificavel).

Pendente: T6 — revisar 2026-05-27 se checks detectaram regressao real. Se nao, simplificar ou remover.

## 7. Licoes 2026-04-28 (rodada B1-B5)

**Validar Explore subagent reports antes de agir.** Explore reportou "evolve.sh next mudo" e "ADR orfao"; ambos errados na verificacao. Doutrina "OLMO is precedent, not authority" se aplica recursivamente aos meus proprios subagents.

**Cluster doctrine substitui "mantem zero".** 4 clusters fixos + cap 2 + gate >=3 evidencias. Phase 0 = pastas vazias com .gitkeep. Skills/agents entram um por vez apos gate.

**OLMO CI nao manteve dual-OS.** OLMO `ci.yml` e Linux-only ubuntu-latest. Confirma decisao de aposentar Windows leg em Prometeus.

**Bugs corrigidos durante implementacao:** `grep -v '\$\{'` em BRE estava quebrado (Unmatched `\{`); patterns iniciando com `-` (ex: `-----BEGIN`) eram interpretados como flags. Trocado por `grep -vF '${'` e `grep -E -- "$pat"`.

## 8. Proxima sessao: ordem recomendada

1. Rodar `git status --short` e `./scripts/check.sh --strict`.
2. Se push pendente: confirmar e `git push origin main` (esta janela ja fez se autorizado).
3. EV-B6 (next): SOTA alignment triage — manter ou rejeitar PHI prompt hook, handoff JSON, value commit gate. Sem mudanca proativa: deferidos ate consumer real.
4. PR-2 (P0): ADRs 0002-0005 criados; decidir se privacy docs viram `docs/threat-model.md` ou ficam em `shadow/`.
5. EV-DIGEST (P0): rodar `email-digest-4p` ou `study-track-done` em uso real e registrar em `EVIDENCE-LOG.md`; senao aposentar/simplificar.
6. EV-B5 T6: marcar 2026-05-27 para revisao (sem adicionar runtime).
7. Cluster contract revisao 2026-06-27: se 0 skill/agent entrar via gate, considerar reverter para "mantem zero".
8. Guard-secrets PHI: revisar 4 semanas; se CPF false-positive bloquear edicao 2x, downgrade.

P0 atual:

- `PR-2`: ADRs ja criados; consolidar privacy/procedures sem quebrar harness.
- `EV-DIGEST`: promover ou aposentar `email-digest-4p` e `study-track-done`.
- `LEGACY-MINE`: inventarios legacy bloqueados, caso-a-caso.

P1 atual:

- `EV-B4`: ADR index existe; pendente reduzir `SOTA-DECISIONS.md` sem perder historico (hoje 460+ linhas).
- `EV-B6` **(next)**: SOTA alignment triage; CI local + stale warning aplicados; resto deferido/rejeitado.
- `EV-B5`: concluir T6 em 2026-05-27.
- `WIKI-PROMO`: 4 notas wiki — promover se citadas em decisao em 30d, senao HYGIENE delete.
- `PR-3`: AGENTS.md SOTA + retire scaffolds (XL, high-risk).

## 9. Arquivos para hidratar contexto

Leia nesta ordem:

1. `AGENTS.md`
2. `VALUES.md`
3. `shadow/HANDOFF.md` (este arquivo)
4. `shadow/CLUSTER-CONTRACT.md` **(novo)**
5. `shadow/BACKLOG.md`
6. `shadow/SOTA-DECISIONS.md` (especialmente entradas 2026-04-28: cluster seed, cluster enforcer, guard-secrets PHI, retire windows, evidence-first subagent)
7. `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md`
8. `scripts/integrity.sh`
9. `scripts/check.sh`
10. `shadow/EVIDENCE-LOG.md`

Plano da rodada (referencia, fora do repo): `~/.claude/plans/happy-drifting-naur.md`.

Memoria do projeto (fora do repo): `~/.claude/projects/-home-lucasmiachon-projects-OLMO-PROMETEUS/memory/MEMORY.md`. 5 entries: cluster doctrine, OLMO precedent not authority, gradual merge intent, symmetric humility, OLMO read auth 2026-04-28.

Para contexto visual/wiki:

- `Prometeus/wiki/Home.md`
- `Prometeus/wiki/Maps/Prometeus.canvas`

## 10. Migration Readiness — Path to principal

Caminho para Prometeus virar projeto principal: 8 criterios absolutos em `shadow/CLUSTER-CONTRACT.md > Path to principal`. Hoje **0/8** atingidos. Estimativa 12-18 meses. Nao acelerar artificialmente. Nenhum criterio satisfeito por "OLMO esta pior" — barra absoluta.

Pronto localmente: workspace canonico, valores V1-V9, `OLMO` como piso, EV-B5 T1-T5, producer-consumer obrigatorio, antifragile verificavel, privacy guards, cluster seed Phase 0, guard-secrets com PHI lite, Windows CI retirado, gh auth WSL ok.

Falta antes de promocao: >=3 procedures `operational` em EVIDENCE-LOG, >=4 batches `applied` com uso real (atualmente 4 batches B1/B2/B3/B5 + EV-B6 em queue — proximo a `applied` apos uso real), CI remoto verde 30d consecutivos, >=1 PHI catch real, decisao humana em SOTA-DECISIONS na semana da promocao.

## 11. Stop conditions

- Cwd diferente do workspace canonico: parar antes de editar.
- Tarefa exige write externo: parar e pedir autorizacao explicita.
- Mudanca estrutural sem trigger, consumidor, risco, rollback e criterio negativo: manter `experiment` ou rejeitar.
- Hook/gate novo sem linha producer-consumer: bloqueado.
- Claim antifragile sem detector/regra/teste: bloquear via KBP-11.
- Cluster scaffold fora dos 4 clusters fixos ou cap excedido: bloqueado por `check_cluster_contract`.
- Dado sensivel/PHI real: bloquear ate workflow privado aprovado.
- Subagent claim sobre repo state: validar antes de agir destrutivo.

Coautoria: Lucas + Claude Opus 4.7 (1M)
