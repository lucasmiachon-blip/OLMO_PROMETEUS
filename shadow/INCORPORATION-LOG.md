# Incorporation Log

Objetivo: registrar transicoes de estado entre lanes e decisoes de incorporacao antes que qualquer experimento tente migrar para `C:\Dev\Projetos\OLMO`.

Regra: nada migra para OLMO sem autorizacao humana explicita, evidencia registrada em `shadow/EVIDENCE-LOG.md` e status `candidate` ou `operational`.

Este arquivo nao redefine estados nem criterios: a fonte unica esta em `shadow/WORK-LANES.md`. Este e apenas o log das transicoes aplicadas.

## Registro

| Data | Item | De | Para | Trigger | Evidencia | Risco | Proxima acao |
|------|------|----|------|---------|-----------|-------|--------------|
| 2026-04-23 | SOTA agents/skills/team | — | experiment | Pesquisa SOTA para decidir incorporacoes | `shadow/SOTA-DECISIONS.md` | Inflar arquitetura cedo demais | Manter decisoes curtas e cortar relatorios longos |
| 2026-04-23 | Janitor editorial | — | experiment | Repo separado permite limpeza mais agressiva | `shadow/SOTA-DECISIONS.md` | Deletar material util por impulso | Cortar duplicacao, preservar contratos e dashboard |
| 2026-04-23 | Foundation + harness | — | experiment | Fortalecer base, infra, hooks, memoria, harness e orquestracao | `shadow/FOUNDATION.md`, `scripts/check.ps1` | Burocracia e falsa seguranca | Usar em 3 sessoes antes de promover para candidate |
| 2026-04-23 | Obsidian project wiki | — | experiment | Criar vault wiki para conhecimento duravel | `Prometeus/wiki/Home.md` | Virar deposito de captura crua | Usar em 3 ciclos e consolidar notas duplicadas |
| 2026-04-23 | Retirar scaffolds locais de agents/skills/hooks | experiment | candidate | Diretorios fantasmas confundiam memoria e contexto | `TREE.md`, `scripts/check.ps1` | Perder metodo util se apagar sem consolidar | Manter procedimentos em `shadow/` e wiki; harness bloqueia retorno sem gate |
| 2026-04-23 | SOTA research gate | experiment | candidate | Usuario exigiu pesquisa SOTA antes de mudancas estruturais | `AGENTS.md`, `PROJECT_CONTRACT.md`, `shadow/SOTA-DECISIONS.md`, `scripts/check.ps1` | Virar ritual burocratico se aplicado a tarefas simples | Aplicar so a arquitetura, agentes, skills, hooks, MCP, memoria e orquestracao |
| 2026-04-23 | Agent module encapsulation | — | experiment | Agente como modulo encapsulado parece fronteira util | `shadow/AGENT-MODULES.md`, `Prometeus/wiki/Notes/Agent Module Encapsulation.md` | Recriar sprawl de agentes por entusiasmo | Usar como contrato; nao criar runtime antes de 3 usos reais e eval |
| 2026-04-23 | EVIDENCE-LOG + rubricas (PLAN Bloco A+B) | — | experiment | Fechar gap entre "3 usos reais" e evidencia auditavel | `shadow/PLAN-2026-04-23.md`, `shadow/EVIDENCE-LOG.md` | Virar burocracia se nao rodar; vira teatro se nao for observado | Aguardar 4 semanas de uso; avaliar pelo proprio EVIDENCE-LOG |
| 2026-04-23 | CLAUDE.md Boris-style (Things that will bite you) | experiment | candidate | SOTA 2026: Boris Cherny + Anthropic padrao de pitfalls observados | `CLAUDE.md`, `GEMINI.md` | Pitfalls nao capturados ate surgirem | Iterar conforme novos erros forem vistos |
| 2026-04-23 | `.claude/settings.local.json` como state local | — | operational | Claude Code cria automaticamente; realidade do harness externo | `.gitignore`, `.claudeignore`, `scripts/check.ps1`, `CLAUDE.md`, `AGENTS.md` | Runtime scaffold (.claude/agents etc) confundido com state | Harness proibe apenas subdirs perigosos; state fica em .gitignore |
| 2026-04-23 | Harness upgrades (size, OLMO veto, wikilink count, evidence freshness) | experiment | candidate | Fechar silent miss e forcar audito quantitativo | `scripts/check.ps1` | Thresholds arbitrarios; falsos warns | Ajustar thresholds conforme uso revelar padrao |
| 2026-04-23 | Escada de estados expandida (operational, retired) | — | experiment | Sem transicao clara candidate -> operational antes | `shadow/WORK-LANES.md`, `AGENTS.md` | Inflar gate se ninguem usar | Revisar em 4 semanas se nenhum procedimento chegar a operational |
| 2026-04-23 | `.claude/skills/` local gate (C2 promocao parcial) | blocked (C3) | experiment | User pedido para permitir instalar skills (ex: skill-creator) e promover procedures; SOTA scan confirma casa | `shadow/SOTA-DECISIONS.md > Local skills gate`, `shadow/AGENT-USAGE.md > Local skills contract`, `scripts/check.ps1`, docs | Sprawl, redundancia com procedure, runtime scaffold reemergindo | Aguardar primeiro procedure `operational`; revisar em 60 dias (2026-06-22) |

Coautoria: Lucas + Claude Opus 4.7 (1M)
