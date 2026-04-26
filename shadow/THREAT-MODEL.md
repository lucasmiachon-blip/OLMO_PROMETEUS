# Threat Model

Status: operational guard

Escopo: `OLMO_PROMETEUS` como laboratorio solo dev com vault, wiki, harness, shadow docs, scripts e automacao read-only.

## Ativos

| Ativo | Risco | Controle |
| --- | --- | --- |
| Boundary do repo | write externo para `OLMO` ou sibling | `AGENTS.md`, guard, harness |
| Wiki versionada | dado pessoal ou PHI em Markdown | data classification + PHI checklist |
| `shadow/` | decisao sensivel virar memoria permanente | criterio negativo e fontes curtas |
| Scripts | automacao escrever fora ou esconder erro | harness e workflow read-only |
| GitHub remoto | CI/branch protection sem visibilidade | `EV-B2` bloqueado ate auth/logs |
| Prompts externos | vazamento de PHI ou segredo | bloquear `phi`, `sensitive`, `personal` |

## Ameacas

| Ameaca | Sinal | Resposta |
| --- | --- | --- |
| Workspace stale | cwd fora de `OLMO_PROMETEUS` | parar antes de editar |
| Dado clinico cru | arquivo/email/PDF real | classificar `phi` e nao processar |
| Segredo acidental | token, key, credential | nao versionar; registrar incidente sem segredo |
| Automacao excessiva | hook, MCP, agent runtime novo | SOTA gate + evidencia + rollback |
| CI sem visibilidade | `gh` sem auth, log remoto inacessivel | documentar bloqueio; manter check local |
| Falso anonimato | caso real "sem nome" | tratar como `phi` salvo aprovacao explicita |

## Controles minimos

- Harness local antes de commit.
- Workflow remoto read-only.
- `private-learning/` ignorado para material pessoal.
- Nenhum dado de paciente em Git ou prompt externo.
- Incidente registra metadado, nunca o conteudo sensivel.
- Migração para `OLMO` depende de trigger, evidencia e rollback.

## Fontes

- NIST SP 800-61 Rev. 3: `https://csrc.nist.gov/pubs/sp/800/61/r3/final`
- NIST incident response announcement: `https://www.nist.gov/news-events/news/2025/04/nist-revises-sp-800-61-incident-response-recommendations-and-considerations`

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
