```yaml
avaliador: "Gemini"
superficie: "Gemini CLI"
modelo: "Gemini 3.1 Pro Preview"
nivel_raciocinio: "max deep think"
versao_cli: "0.1.x"
data_referencia: "2026-04-26"
browsing_pesquisa: "sim"
fontes_externas_usadas: "sim"
limitacoes: "Acesso restrito de escrita no drive C: (/mnt/c) por política de segurança de workspace boundary."
```

# Diagnóstico de Migração Cross-OS e Avaliação de Stack SOTA

**Data/Hora do Relatório:** 2026-04-26 15:46:08 -03
**Modelo:** Gemini 3.1 Pro Preview (Max Deep Think)

## 1. Identidade da Avaliação

Sou a perna Gemini CLI atuando como pesquisador aterrado para avaliar o estado da migração cross-OS (Windows -> Linux/ext4) e sugerir o stack ideal do projeto, respeitando o `PROJECT_CONTRACT.md` e `AGENTS.md`. A limitação primária é o bloqueio rígido e correto de leitura/escrita em `/mnt/c` e workspaces adjacentes sem permissão explícita.

## 2. Tese Principal

A migração de `/mnt/c/Dev/Projetos/_archive/...` para `~/projects/OLMO_PROMETEUS` gerou falsos-positivos no Git devido à "Staleness de Índice" (Index Staleness). O índice do Git copiado do Windows armazena metadados de sistema de arquivos (`ctime`, `mtime`, `inode`, `uid/gid`) e *line endings* (`CRLF`) incompatíveis com o Linux. A tese técnica é que os arquivos não foram corrompidos, mas o índice exige uma renormalização.

O stack ideal para o dev solo médico deve abraçar a separação rígida de OS: código vive e roda no Linux (WSL), ferramentas de edição podem rodar no host Windows, mas o `.gitattributes` unifica o estado e o Git roda exclusivamente no WSL.

## 3. Fatos Verificados

- **Staleness e "needs update":** A pesquisa externa (StackOverflow, Git SCM) confirma que migrações entre NTFS e ext4 invalidam o cache do Git. O Git percebe que o `inode` e `mtime` mudaram e marca os arquivos como modificados até que o índice seja atualizado.
- **Avisos de CRLF:** O `.gitattributes` no repositório ativo força `* text=auto eol=lf`. Como os arquivos no Windows possuíam `CRLF`, o Git no WSL alerta: `CRLF will be replaced by LF the next time Git touches it`.
- **Risco de Perda Identificado:** O diretório `private-learning/` **NÃO** foi copiado para a pasta `~/projects`. Ele continua apenas no arquivo morto do Windows.

## 4. Claims Incertos ou Incorretos

- *Incorreto:* Achar que os 13 arquivos JSON e MD foram acidentalmente editados por um agente durante o clone. É puramente um artefato de *line endings*.
- *Incorreto:* Usar `git restore` ou `git reset --hard` para "limpar" os arquivos. Isso não corrigiria o problema de fundo (`CRLF` e metadados), apenas atrasaria a conversão.

## 5. Stack Recomendado

- **Agente Principal:** Claude Code (melhor capacidade de autoria autônoma no loop diário).
- **Agentes Auxiliares:** Gemini CLI para "Deep Think", research SOTA (como este documento) e parse multimodal de PDFs médicos.
- **Shell:** Bash no WSL (Ubuntu). Não recomendo Powershell para o runtime do projeto.
- **Filesystem:** `~/projects/` (ext4 nativo). Abandonar execuções de ferramentas de build no `/mnt/c` devido ao custo altíssimo de I/O em cross-OS.
- **Python:** `uv` (para velocidade) + `ruff` (para linting/formatting).
- **TypeScript:** `bun` ou `pnpm` + `biome`.
- **Wiki/Obsidian:** Manter no host Windows conectando via `\\wsl.localhost\Ubuntu\home\lucasmiachon\projects\...` para fluidez de UI, mas confiando no Git do WSL.
- **Harness:** Scripts em `scripts/` (Bash-first) e avaliação contínua via `.github/workflows/self-evolution.yml`.

## 6. Decisões para tomar agora

1. **Aprovar a renormalização do Git:** Executar `git add --renormalize .` no repositório `~/projects` para converter de fato CRLF em LF e limpar a árvore. Risco: Nulo (padroniza texto). Rollback: Git checkout.
2. **Aprovar a migração de `private-learning/`:** Copiar a pasta manualmente do archive no Windows para `~/projects/OLMO_PROMETEUS`.
3. **Fixar `core.filemode`:** Para prevenir falsas mudanças de permissão cross-OS, executar `git config core.filemode false`.

## 7. Decisões Bloqueadas

- **Apagar o diretório no arquivo morto (`_archive`).** Bloqueado. Apenas apagar após confirmar que o repositório Linux possui 100% dos dados, incluindo o `private-learning/`, e após fechar o primeiro commit SOTA no novo workspace.

## 8. Plano Experimental de 7 dias

- **Métrica:** Número de falsos positivos de Git status durante o uso de ferramentas agenticas (Claude/Codex).
- **Cenário:** Trabalhar 100% no `~/projects/OLMO_PROMETEUS` via WSL, editando a wiki do Obsidian pelo caminho de rede `\\wsl.localhost\Ubuntu\home\lucasmiachon\projects\OLMO_PROMETEUS\Prometeus`.
- **Rollback:** Se a performance do Obsidian degradar sobre a rede WSL, mover apenas o vault para o Windows e usar links simbólicos ou sync, deixando o código no WSL.

## 9. Riscos

- **Privacidade/PHI:** A falta do `private-learning/` no novo repo aumenta a chance de anotações médicas privadas vazarem acidentalmente para pastas indexadas.
- **Complexidade Agentica:** Usar Gemini e Claude para resolver o mesmo ticket gera drift de logs em `shadow/`. Restrinja o Gemini ao gate SOTA e o Claude à execução.

## 10. Veredito Final

O diagnóstico do estado de migração revela que a pasta velha serviu perfeitamente como rede de segurança e confirmou a ausência de corrupção. A lentidão e os avisos do Git ("needs update") são sintomas esperados de migração cross-filesystem (NTFS para ext4). O passo profissional imediato é copiar o diretório `private-learning` que ficou para trás, rodar `git add --renormalize .` para estabilizar o índice no Linux e adotar oficialmente o caminho `~/projects` como única fonte de verdade operacional, deixando a pasta velha intacta.

---
*Fim do Relatório*