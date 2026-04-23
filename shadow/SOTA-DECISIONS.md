# SOTA Decisions

Data: 2026-04-23
Escopo: open OLMO_PROMETEUS
Status: decisao operacional, nao arquitetura aspiracional

## Decisao central

O melhor do SOTA para este projeto pequeno e manter pouca estrutura, bem nomeada e verificavel.

Manter:

- `AGENTS.md` como contrato central e portavel.
- Skills pequenas com trigger claro e eval minima.
- Subagentes read-only, estreitos e com `max_depth = 1`.
- Gmail como fila simples: `Processar`, `Alta`, `Ruido`, `Digerido`.
- `Digerido` somente depois de artefato persistente.
- `shadow/INCORPORATION-LOG.md` como gate antes de qualquer conversa sobre OLMO.
- `scripts/check.ps1` como harness leve antes de commit.
- Boundary absoluta: nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

Nao incorporar agora:

- hooks como base da arquitetura;
- MCP proprio;
- A2A local;
- agentes demais;
- skills especulativas;
- relatorios SOTA longos que viram museu.
- hooks reais antes de um comando manual provar utilidade.

## Regras praticas

1. Criar skill nova apenas depois de uso recorrente ou dor repetida.
2. Criar agente novo apenas se ele tiver dono claro, output claro e ferramenta limitada.
3. Pesquisa externa vira decisao curta, nao biblioteca grande.
4. Qualquer coisa que pareca migravel passa por `private -> experiment -> candidate`.
5. Nada toca `C:\Dev\Projetos\OLMO` sem autorizacao humana explicita.

## Time minimo

| Papel | Modelo/ferramenta | Uso | Risco controlado |
|------|--------------------|-----|------------------|
| Orquestrador | Codex | integrar, editar, decidir proximo passo | nao delegar por reflexo |
| Explorer | custom agent read-only | mapear estado local | sem edicao |
| Promotion reviewer | custom agent read-only | classificar private/experiment/candidate | sem promocao automatica |
| Docs researcher | custom agent read-only | verificar docs primarias | fontes antes de opiniao |
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
