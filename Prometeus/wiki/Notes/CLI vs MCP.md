---
type: note
status: experiment
source: legacy/2026-04-26/devmentor/vault/wiki/cli-vs-mcp.md
incorporated: 2026-04-26
tags:
  - prometeus/concept
  - prometeus/llmops
---

# CLI vs MCP

Quando o agent deve usar tool via CLI (`bash`, `grep`) versus MCP (Model Context Protocol).

## Resposta curta

Para dev solo local com tools maduras, CLI ganha em quase todos os eixos: token cost (10-32x menor), reliability, familiaridade do modelo (treinado em milhoes de exemplos CLI).

Para enterprise multi-user com OAuth, ou servicos sem CLI, MCP continua necessario.

Setups de producao misturam: CLI para Unix/git/docker, MCP para Figma/Slack/Supabase.

## O problema estrutural do MCP

MCP carrega schema JSON de todas as tools no startup. Um server tipico (GitHub MCP) tem ~93 tools, ~55K tokens de schema. Tres servers consomem ~72% de um context window de 200K antes do agent fazer qualquer acao.

Quanto mais MCP ligado, menos espaco pra raciocinio real. Multi-step reasoning degrada porque o attention fica saturado.

## Por que CLI nao tem esse problema

Agent escreve `git log --oneline` direto. Zero schema carregado. O modelo ja sabe git de training. Output vem como texto simples, compoe com pipe Unix. Token cost por operacao: 200-500 vs 2.000-8.000 do equivalente MCP.

## Decisao Prometeus

CLI + filesystem direto. Vault Obsidian e pasta de markdown — Claude Code acessa via Bash, grep, find, cat. Sem MCP proprio (ver [[SOTA Dev Solo]]: "sem MCP proprio" e regra explicita). MCP externo entra so com gate (`shadow/SOTA-DECISIONS.md > Blocked ate evidencia > C3`).

## Conexoes

- [[Skills vs MCP]] — skills como alternativa estrutural
- [[Foundation Harness]] — harness Bash-first
- [[SOTA Dev Solo]] — principios solo
- [[Workspace Boundary]] — boundary canonico

## Fontes

Scalekit benchmark; Anthropic code execution benchmark; Perplexity CTO (ASK 2026).
