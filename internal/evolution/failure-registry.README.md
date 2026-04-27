# failure-registry.jsonl

JSONL append-only de falhas de tool/comando para alimentar self-improvement futuro (cf. plano `cuddly-beaming-wind` §3.1 Insights skill).

## Schema (cada linha)

```json
{
  "ts": "2026-04-26T21:30:00Z",
  "session": "<short id>",
  "tool": "Bash|Write|Edit|Read|...",
  "command": "<sanitized; sem args contendo PHI/secrets>",
  "exit_code": 1,
  "stderr_excerpt": "<150 chars max>",
  "hypothesis": "<por que falhou — 1 frase>",
  "fix": "<acao tomada — 1 frase>",
  "kbp_ref": "KBP-NN ou null"
}
```

## Regras

- Sem PHI. Sem secrets. Sem path com paciente. Sanitize antes de gravar.
- `command` truncado: args > 50 chars elididos com `...`; tokens mascarados (`***`).
- Append-only: nao editar entries existentes; correcao = nova entry com `kbp_ref` apontando para a anterior.
- Hook automatico futuro (defer ate Round 3 trigger): `scripts/trace-bash-fail.sh` PostToolUse Bash exit!=0.
- Ate la, escrita manual apos incidente.

Status: experiment (schema-only). Primeira entry real -> validar formato em uso e ajustar README se preciso.

Coautoria: Lucas + Claude Opus 4.7 (1M)
