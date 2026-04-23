# SOTA Decisions

Data: 2026-04-23
Escopo: open OLMO_PROMETEUS
Status: decisao operacional, nao arquitetura aspiracional

## Decisao central

O melhor do SOTA para este projeto pequeno e manter pouca estrutura, bem nomeada e verificavel.

Manter:

- `AGENTS.md` como contrato central e portavel.
- Procedimentos pequenos como docs em `shadow/` ou notas em `Prometeus/wiki/`.
- Gmail como fila simples: `Processar`, `Alta`, `Ruido`, `Digerido`.
- `Digerido` somente depois de artefato persistente.
- `shadow/INCORPORATION-LOG.md` como gate antes de qualquer conversa sobre OLMO.
- `scripts/check.ps1` como harness leve antes de commit.
- `C:\Dev\Projetos\OLMO_PROMETEUS\Prometeus` como vault Obsidian, com notas em `wiki/`, nao como inbox privado permanente.
- Boundary absoluta: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Raiz sem scaffolds fantasmas: nada de `.agents`, `.codex`, `agents`, `subagents`, `skills`, `hooks` ou `playground` sem gate.

Nao incorporar agora:

- hooks como base da arquitetura;
- MCP proprio;
- A2A local;
- agentes demais;
- skills especulativas;
- registry local de agentes ou skills;
- relatorios SOTA longos que viram museu.
- hooks reais antes de um comando manual provar utilidade.

## Regras praticas

1. Criar skill/agente novo apenas depois de uso recorrente, dor repetida e aprovacao explicita.
2. Antes disso, manter o procedimento em `shadow/` ou na wiki.
3. Pesquisa externa vira decisao curta, nao biblioteca grande.
4. Qualquer coisa que pareca migravel passa por `private -> experiment -> candidate`.
5. Nada toca `C:\Dev\Projetos\OLMO` sem autorizacao humana explicita.

## Time minimo

| Papel | Modelo/ferramenta | Uso | Risco controlado |
|------|--------------------|-----|------------------|
| Orquestrador | Codex | integrar, editar, decidir proximo passo | nao delegar por reflexo |
| Gemini | externo/manual | pesquisa longa, multimodal, PDFs | artefato curto em `shadow/` |

## Fontes base

- OpenAI Codex AGENTS.md: `https://developers.openai.com/codex/guides/agents-md`
- OpenAI Codex Skills: `https://developers.openai.com/codex/skills`
- OpenAI Codex Subagents: `https://developers.openai.com/codex/subagents`
- OpenAI Agent evals: `https://developers.openai.com/api/docs/guides/agent-evals`
- AGENTS.md convention: `https://agents.md/`
- GitHub Copilot repository instructions: `https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions`
- Anthropic Claude Code subagents: `https://docs.anthropic.com/en/docs/claude-code/sub-agents`
- Google Gemini models: `https://ai.google.dev/gemini-api/docs/models`
- Google Gemini long context: `https://ai.google.dev/gemini-api/docs/long-context`
- Google Agent2Agent announcement: `https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/`
- MCP specification: `https://modelcontextprotocol.io/specification/2025-03-26`

## O que foi cortado

- Relatorio SOTA longo de 2026-04-22: bom para exploracao, ruim como documento operacional.
- Mapa SOTA intermediario de 2026-04-23: substituido por esta decisao curta.
- Recomendacoes especulativas de skills/agentes que ainda nao tiveram uso real.

Coautoria: Lucas + GPT-5.4 (Codex)
