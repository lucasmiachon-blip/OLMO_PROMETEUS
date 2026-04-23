# Project Contract

## Objetivo

Validar um laboratorio paralelo, guiado por orquestracao de baixo risco, para dashboard, digest e study flow.

## Limites

- Nao editar `C:\Dev\Projetos\OLMO` a partir daqui.
- Nao copiar infraestrutura sensivel, hooks ou config de MCP.
- Nao criar sincronizacao automatica com o repo principal.
- Nao promover artefatos sem trigger, evidencia e rollback.

## Faixas operacionais

| Faixa | Significado | Acao padrao |
|-------|-------------|-------------|
| `private` | material pessoal ou dependente de contexto | permanece local |
| `experiment` | artefato promissor, mas ainda instavel | repetir e medir |
| `candidate` | padrao reutilizavel e com gate claro | pode entrar em conversa de migracao |

## Criterio de promocao

Um artefato daqui so entra em conversa de migracao quando:

1. funcionou localmente em ciclos repetidos;
2. tem artefato claro;
3. tem trigger de uso;
4. tem risco e rollback explicitos;
5. nao depende demais de contexto pessoal.

## Estrutura minima racional

- `AGENTS.md` define o contrato do repo.
- `.agents/skills/` guarda workflows reutilizaveis pequenos.
- `.codex/agents/` guarda papeis estreitos para delegacao.
- `shadow/WORK-LANES.md` registra a classificacao dos artefatos.
- `shadow/FOUNDATION.md` define infra, hooks, memoria, harness e orquestracao.
- `scripts/check.ps1` valida regressao leve antes de commit.


