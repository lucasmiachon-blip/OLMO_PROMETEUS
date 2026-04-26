```yaml
avaliador: "Gemini 3.1 Pro Preview (Max Deep Think)"
superficie: "Gemini CLI"
modelo: "gemini-3.1-pro-preview"
nivel_raciocinio: "max (deep think + adversarial consolidation)"
versao_cli: "0.39.1"
data_referencia: "2026-04-26"
hora_carimbo: "2026-04-26 15:58:12 -03"
browsing_pesquisa: "sim"
fontes_externas_usadas: "sim"
limitacoes: "Acesso bloqueado a workspaces adjacentes (OLMO/OLMO_COWORK) conforme AGENTS.md."
```

# Diagnóstico Consolidado SOTA: Migração e Stack (2026-04-26)

## 1. Identidade e Veredito Técnico
Este relatório consolida a análise da tríade (Claude Code, Gemini CLI, e Codex). O veredito é de **estabilidade operacional**, mas com uma **divergência crítica de documentação vs realidade** no workspace canônico que precisa de resolução imediata.

## 2. A Crise do Git Index (Fatos)
- **Causa Real:** A migração de `/mnt/c` para `~/projects` (ext4) causou *Index Staleness*. O Git no Linux não confia nos metadados (`inode`, `ctime`, `mtime`) herdados do Windows (9p/NTFS).
- **CRLF Alert:** O `.gitattributes` está correto (`eol=lf`), mas o índice ainda aponta para arquivos que o Git "pensa" que são CRLF. 
- **Solução SOTA:** Não use `reset` ou `restore`. A única ação técnica profissional é `git add --renormalize .` seguida de `git config core.filemode false` para estabilizar o índice no Linux.

## 3. Riscos de Migração Identificados
- **DADO PERDIDO:** O diretório `private-learning/` **não foi migrado** para o Linux. Ele reside apenas no arquivo morto em `/mnt/c/Dev/Projetos/_archive/OLMO_PROMETEUS-archived-20260426-142912/`.
- **Divergência de Caminho:** `AGENTS.md` e `FOUNDATION.md` ainda citam o drive `C:` como canônico, enquanto a operação real já ocorre em `~/projects`. Isso cria um "drift de verdade" perigoso para agentes autônomos.

## 4. Stack Consolidado Recomendado (SOTA 2026)
- **Orquestração:** Codex CLI (integrador) + Claude Code Opus 4.7 (arquiteto).
- **Pesquisa/Deep Think:** Gemini 3.1 Pro Preview (1M context + Thinking Medium).
- **Filesystem:** Adotar formalmente o Linux nativo (ext4) para o repositório. O ganho de I/O de ~40-80% justifica a mudança.
- **Toolchain:** `uv`+`ruff` (Python) e `pnpm`+`biome` (TS). `bun` apenas como experimento.
- **OS:** Manter Ubuntu 24.04 LTS. **BLOQUEAR** upgrade para 26.04 por 8 semanas.

## 5. Plano de Ação Imediata (D1)
1.  **Reconciliação:** Atualizar `AGENTS.md` para refletir `~/projects/OLMO_PROMETEUS` como canônico.
2.  **Recuperação:** Copiar `private-learning/` do archive `/mnt/c` para o repositório ativo.
3.  **Estabilização:** Rodar `git add --renormalize .` no repositório Linux.
4.  **Remoto:** Confirmar `gh run list` para validar o workflow GitHub.

---
**Coautoria:** Lucas + Gemini 3.1 Pro (Deep Think) + Evidência Claude Opus 4.7.
