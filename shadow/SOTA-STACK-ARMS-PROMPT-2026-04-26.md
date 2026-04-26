# SOTA Stack Arms Prompt 2026-04-26

Status: active

Purpose: prompt unico para Claude, Codex, Gemini e ChatGPT avaliarem o stack ideal do OLMO_PROMETEUS como pernas independentes, com carimbo obrigatorio de identidade e pesquisa atual quando houver duvida factual.

## Como usar

1. Copiar o prompt abaixo sem alterar o conteudo central.
2. Rodar em cada braco com o melhor modelo disponivel e o maior nivel de raciocinio/thinking permitido.
3. Salvar cada resposta em Markdown separado, se for persistir:
   - `shadow/SOTA-STACK-CLAUDE-RESPONSE-2026-04-26.md`
   - `shadow/SOTA-STACK-CODEX-RESPONSE-2026-04-26.md`
   - `shadow/SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md`
   - `shadow/SOTA-STACK-CHATGPT-RESPONSE-2026-04-26.md`
4. Comparar as respostas como evidencia adversarial. Nenhum braco decide sozinho.

## Prompt unico

~~~text
Data de referencia: 2026-04-26.

CARIMBO OBRIGATORIO NO TOPO DA RESPOSTA

Antes de qualquer analise, escreva exatamente este bloco preenchido:

```yaml
avaliador: "<Claude | Codex | Gemini | ChatGPT | outro>"
superficie: "<Claude Code | Codex CLI | Gemini CLI | ChatGPT Web | API | outro>"
modelo: "<modelo efetivo usado>"
nivel_raciocinio: "<maximo disponivel usado; ex: xhigh, high, thinking high, extended thinking, nao disponivel>"
versao_cli: "<versao da CLI se aplicavel; senao N/A>"
data_referencia: "2026-04-26"
browsing_pesquisa: "<sim | nao>"
fontes_externas_usadas: "<sim | nao>"
limitacoes: "<limites de acesso/contexto/modelo>"
```

Se voce nao souber o modelo efetivo, escreva `[NAO INFORMADO PELA FERRAMENTA]`.
Se nao tiver browsing/pesquisa externa, escreva `nao` e marque qualquer claim instavel como `[NAO VERIFICADO]`.

Use o melhor modelo disponivel nesta ferramenta e o maior nivel de reasoning/thinking permitido.

Voce e uma perna independente de avaliacao SOTA para o repo OLMO_PROMETEUS.

Contexto atual:
- Repo ativo: /home/lucasmiachon/projects/OLMO_PROMETEUS
- Remote: https://github.com/lucasmiachon-blip/OLMO_PROMETEUS.git
- Caminhos antigos /mnt/c/Dev/Projetos/OLMO_PROMETEUS e C:\Dev\Projetos\OLMO_PROMETEUS podem aparecer nos docs como contexto historico; nao trate como verdade atual sem verificar.
- O objetivo e definir o stack ideal para um laboratorio profissional solo dev medico, com baixo risco, alta auditabilidade, sem PHI/dados sensiveis, humano-no-loop, e sem inflar runtime agentico.

Leia primeiro estes arquivos:
- AGENTS.md
- README.md
- shadow/HANDOFF.md
- shadow/SOTA-DECISIONS.md
- shadow/SOTA-STACK-2026-04-26.md
- shadow/SOTA-STACK-CLI-PROMPTS-2026-04-27.md
- shadow/SOTA-STACK-GEMINI-PROMPT-2026-04-26.md
- shadow/SOTA-STACK-GEMINI-RESPONSE-2026-04-26.md
- shadow/AGENT-USAGE.md
- shadow/AGENT-MODULES.md
- shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md
- shadow/FOUNDATION.md

Tarefa:
Avalie o stack ideal para:
- Claude Code;
- Codex CLI;
- Gemini CLI/API;
- ChatGPT/API;
- Linux/WSL/Windows;
- shell;
- Python/uv/ruff;
- TypeScript/pnpm/bun/biome/vite/esbuild;
- Obsidian/vault workflow;
- harness, gates, pesquisa, logs e promocao de artefatos.

Se houver qualquer duvida factual, claim instavel, versao de modelo/CLI, limite de contexto, precificacao, feature recente, ou recomendacao baseada em informacao que possa ter mudado, pesquise fontes primarias/oficiais atuais ate 2026-04-26 antes de concluir.

Regras:
- Nao proponha migracao automatica.
- Nao proponha hook, MCP, skill, subagent, runtime agentico, daemon ou scaffold persistente sem trigger claro, evidencia, custo, risco, rollback e criterio negativo.
- Separe fato, inferencia e decisao.
- Trate Opus, Claude, Codex, Gemini e ChatGPT como evidencias/adversarios, nao como autoridade.
- Se uma recomendacao conflitar com AGENTS.md, marque como conflito.
- Se uma fonte nao for primaria/oficial, marque como secundaria.
- Se algo nao puder ser verificado, marque [NAO VERIFICADO].
- Nao altere arquivos. Produza apenas diagnostico e recomendacao.
- Toda recomendacao precisa de justificativa. Para cada decisao proposta, cite:
  - evidencia local: arquivo e linha/secao lida neste repo;
  - evidencia externa: fonte primaria/oficial quando o claim depender de estado atual;
  - custo;
  - risco;
  - rollback;
  - criterio negativo para abortar.
- Se nao houver evidencia suficiente, nao recomende como decisao; marque como hipotese ou decisao bloqueada.

Entregue em Markdown:

1. Identidade da avaliacao
   - repita o carimbo obrigatorio;
   - explique em uma frase qualquer limitacao relevante.

2. Tese principal
   - qual stack voce adotaria se fosse responsavel tecnico pelo laboratorio.

3. Fatos verificados
   - com fontes ou arquivos locais citados.

4. Claims incertos ou incorretos
   - especialmente sobre modelos, contexto, CLI, WSL, sandbox, MCP, agents e custos.

5. Stack recomendado
   - agente principal;
   - agentes auxiliares;
   - shell;
   - filesystem;
   - Python;
   - TypeScript;
   - harness;
   - wiki/Obsidian;
   - pesquisa externa.

6. Decisoes para tomar agora
   - apenas as que tenham baixo risco e alto valor.

7. Decisoes bloqueadas
   - o que nao deve ser feito ainda e qual evidencia destravaria.

8. Plano experimental de 7 dias
   - metricas;
   - rollback;
   - criterio negativo para abortar.

9. Riscos
   - privacidade/PHI;
   - perda de dados;
   - drift de docs;
   - custo;
   - complexidade agentica.

10. Veredito final
   - 5 a 10 linhas, direto, profissional, sem entusiasmo.
~~~

## Comandos ou uso sugerido

Opcoes seguras:

1. Abrir este arquivo e colar o bloco `Prompt unico` em cada ferramenta.
2. Se a CLI aceitar stdin ou prompt por arquivo, passar este arquivo como contexto e pedir para executar apenas o bloco `Prompt unico`.

Comandos orientativos, ajustando ao CLI local:

```bash
claude
```

Depois cole o prompt.

```bash
codex
```

Depois cole o prompt e selecione o maior reasoning effort disponivel.

```bash
gemini
```

Depois cole o prompt e selecione o melhor modelo disponivel.

Para ChatGPT, usar Web/API e colar o mesmo prompt.

## Criterio de comparacao

Ao receber as respostas, classificar cada recomendacao como:

- fato verificado;
- inferencia forte;
- preferencia operacional;
- claim nao verificado;
- conflito com boundary/anti-sprawl;
- decisao bloqueada.

Veredito final continua humano: Lucas + Codex/ChatGPT como integradores, usando Claude e Gemini como adversarios/evidencias.

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
