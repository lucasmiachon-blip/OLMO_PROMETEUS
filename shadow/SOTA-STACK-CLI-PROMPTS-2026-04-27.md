# SOTA Stack CLI Prompts 2026-04-27

Status: active
Purpose: rodar avaliacoes independentes em CLIs/modelos diferentes e depois julgar com Lucas + Codex/ChatGPT 5.5.

## Regra de uso

Este arquivo nao decide o stack. Ele padroniza as perguntas para gerar respostas comparaveis.

Veredito final: Lucas + Codex/ChatGPT 5.5.

As respostas de Opus, Gemini, Codex ou outro CLI sao evidencias, nao autoridade. Se houver claim factual duvidoso, rodar pesquisa adicional com fonte primaria antes de decidir.

## Arquivos de saida sugeridos

Salvar cada resposta em Markdown:

```text
shadow/SOTA-STACK-OPUS-CLI-2026-04-27.md
shadow/SOTA-STACK-GEMINI-CLI-2026-04-27.md
shadow/SOTA-STACK-CODEX-CLI-2026-04-27.md
shadow/SOTA-STACK-EXTRA-RESEARCH-2026-04-27.md
```

Use o quarto arquivo apenas se surgir duvida factual que precise pesquisa extra.

## Prompt unico

Copiar exatamente este prompt em cada CLI/modelo:

```text
Data de referencia: 2026-04-26.

Voce e uma perna independente de avaliacao SOTA. Contexto: Prometeus e um laboratorio profissional de estado da arte, nao uma trilha iniciante. O objetivo e decidir amanha, com Lucas + Codex/ChatGPT 5.5 como juizes finais, o caminho mais profissional para stack agentico, Linux, shell e toolchain.

Avalie:

- Claude Code, Codex CLI, Gemini CLI/API e ChatGPT 5.5.
- TypeScript, Python, uv, ruff, pnpm, bun, biome, vite, esbuild.
- Windows 11 + WSL2, Ubuntu 24.04, Ubuntu 26.04, Fedora.
- bash, zsh, fish, nushell.
- Workspace atual: C:\Dev\Projetos\OLMO_PROMETEUS, acessado no WSL via /mnt/c/Dev/Projetos/OLMO_PROMETEUS.
- Hipotese a confrontar: /mnt/c nao e ideal para trabalho Linux-heavy; talvez migrar para ext4 WSL seja melhor, mas so com experimento, metrica e rollback.
- Restricoes: nao propor migracao automatica; nao criar runtime, hook, MCP, skill ou scaffold sem trigger, evidencia e rollback; preservar Obsidian/Windows; nao assumir que Lucas e iniciante.

Entregue em Markdown:

1. Tese principal.
2. Claims que voce considera corretos, parcialmente corretos ou nao verificados.
3. Recomendacao profissional de stack.
4. Decisoes que devem ser tomadas agora.
5. Decisoes que devem ficar bloqueadas.
6. Riscos e custos.
7. Plano experimental de 7 dias com metricas.
8. Criterios negativos para abortar.
9. Veredito: o que voce faria se fosse responsavel tecnico pelo laboratorio.
```

## Protocolo de confronto

Depois de gerar os arquivos:

1. Abrir `shadow/HANDOFF.md`.
2. Abrir `shadow/SOTA-STACK-2026-04-26.md`.
3. Abrir `shadow/SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md`.
4. Abrir as novas respostas CLI salvas em `shadow/SOTA-STACK-*-CLI-2026-04-27.md`.
5. Classificar cada recomendacao como:
   - fato verificado;
   - inferencia forte;
   - preferencia operacional;
   - claim nao verificado;
   - conflito com boundary/anti-sprawl;
   - decisao bloqueada.
6. Se houver divergencia factual relevante, criar ou atualizar `shadow/SOTA-STACK-EXTRA-RESEARCH-2026-04-27.md` com fontes primarias.
7. Fechar veredito curto com:
   - decisao;
   - nao-decisao;
   - experimento de 7 dias;
   - rollback;
   - criterio negativo.

## Claims que exigem cuidado

Validar antes de aceitar:

- `gemini-3.1-pro-preview` versus `gemini-3-pro-preview` em fonte oficial.
- 1M versus 2M context window.
- Ubuntu 26.04 no WSL agora versus esperar 26.04.1.
- Fedora como ganho real versus custo de suporte/WSL.
- migracao para ext4 WSL preservando Obsidian e Windows.
- criar skills locais agora versus manter regra anti-sprawl do Prometeus.
- `bun` como default versus `pnpm` + Node/Vite como default conservador.
- `nushell`/fish como shell humano versus Bash como contrato para agentes/scripts.

## Criterio negativo global

Abortar ou bloquear qualquer recomendacao que:

- dependa de mover o repo canonico sem backup, metrica e rollback;
- quebre Obsidian/Windows;
- instale toolchain global sem projeto que precise dela;
- crie scaffold local de agentes/skills/hooks sem tres evidencias reais;
- misture PHI/dado sensivel em prompts externos;
- use benchmark sem fonte primaria para justificar migracao estrutural.

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
