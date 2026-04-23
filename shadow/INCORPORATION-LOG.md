# Incorporation Log

Objetivo: registrar decisoes de incorporacao antes que qualquer experimento tente migrar para `C:\Dev\Projetos\OLMO`.

Regra: nada migra para OLMO sem autorizacao humana explicita, evidencia, rollback e status `candidate`.

## Estados

- `private`: nota pessoal, digest, estudo ou checkpoint local. Nao migra.
- `experiment`: prototipo ou fluxo ainda instavel. Pode amadurecer.
- `candidate`: padrao validado, com trigger, evidencia, rollback e valor claro.
- `blocked`: ideia util, mas com risco, dependencia ou falta de evidencia.

## Registro

| Data | Item | Estado | Trigger | Evidencia | Risco | Proxima acao |
|------|------|--------|---------|-----------|-------|--------------|
| 2026-04-23 | SOTA agents/skills/team | experiment | Pesquisa SOTA ate hoje para decidir incorporacoes | `shadow/SOTA-INCORPORATION-2026-04-23.md` | Inflar arquitetura cedo demais | Aplicar apenas log e regra de Digerido persistido |

## Gate para virar candidate

Um item so pode virar `candidate` quando tiver:

- uso repetido ou dor recorrente;
- artefato local claro;
- criterio de sucesso;
- rollback simples;
- diferenca entre material privado e algo reutilizavel;
- aprovacao humana antes de tocar `C:\Dev\Projetos\OLMO`.

Coautoria: Lucas + GPT-5.4 (Codex)
