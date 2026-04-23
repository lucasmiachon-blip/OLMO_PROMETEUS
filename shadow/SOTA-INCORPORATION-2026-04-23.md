# SOTA incorporation map

Data: 2026-04-23
Escopo: open OLMO_PROMETEUS
Status: pesquisa aplicada, baixo risco

## TL;DR

O SOTA ate hoje reforca a arquitetura pequena que ja estamos montando:

- `AGENTS.md` como contrato portavel e vivo.
- Skills pequenas, com trigger claro, progressive disclosure e eval minima.
- Subagentes estreitos, `max_depth = 1`, sem fan-out automatico.
- MCP e conectores com consentimento humano e output estruturado quando possivel.
- Hooks somente como opcional; no Codex em Windows nao devem ser fundacao.
- Gmail como fila simples; classificacao rica mora no Vault/artefato persistente.

Conclusao operacional: incorporar pouco, medir rapido e manter promocao para OLMO como decisao humana.

## Fontes verificadas

- OpenAI Codex AGENTS.md: `https://developers.openai.com/codex/guides/agents-md`
- OpenAI Codex Skills: `https://developers.openai.com/codex/skills`
- OpenAI Codex Rules: `https://developers.openai.com/codex/rules`
- OpenAI Codex Hooks: `https://developers.openai.com/codex/hooks`
- OpenAI Codex Subagents: `https://developers.openai.com/codex/subagents`
- OpenAI Agents SDK: `https://developers.openai.com/api/docs/guides/agents`
- OpenAI Agent evals: `https://developers.openai.com/api/docs/guides/agent-evals`
- OpenAI Trace grading: `https://developers.openai.com/api/docs/guides/trace-grading`
- AGENTS.md convention: `https://agents.md/`
- GitHub Copilot repository instructions: `https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions`
- GitHub Copilot org instructions GA: `https://github.blog/changelog/2026-04-02-copilot-organization-custom-instructions-are-generally-available/`
- Anthropic Claude Code subagents: `https://docs.anthropic.com/en/docs/claude-code/sub-agents`
- Anthropic Claude Code hooks: `https://docs.anthropic.com/en/docs/claude-code/hooks`
- Google Gemini models: `https://ai.google.dev/gemini-api/docs/models`
- Google Gemini long context: `https://ai.google.dev/gemini-api/docs/long-context`
- Google Gemini URL context: `https://ai.google.dev/gemini-api/docs/url-context`
- Google Agent2Agent announcement: `https://developers.googleblog.com/en/a2a-a-new-era-of-agent-interoperability/`
- MCP specification: `https://modelcontextprotocol.io/specification/2025-03-26`
- MCP tools specification: `https://modelcontextprotocol.io/specification/2025-11-25/server/tools`

## SOTA observado

### 1. Instrucoes portaveis venceram memoria implicita

OpenAI, GitHub Copilot e agents.md convergem para instrucoes de repositorio em Markdown. O ponto importante nao e o nome por si so; e a previsibilidade: um agente novo precisa encontrar rapidamente objetivos, comandos, validacoes e limites.

Aplicacao aqui:

- Manter `AGENTS.md` enxuto e normativo.
- Evitar duplicar README.
- Adicionar AGENTS aninhado so se `private-learning/`, `shadow/` ou `playground/` passarem a ter regras realmente diferentes.

Decisao: nao criar AGENTS aninhado agora.

### 2. Skills sao melhor que prompts gigantes

O padrao de progressive disclosure e central: metadata sempre visivel, `SKILL.md` apenas quando dispara, referencias/scripts/assets so quando necessario. A qualidade do trigger depende mais da descricao do que do tamanho do corpo.

Aplicacao aqui:

- Manter skills em numero pequeno.
- Exigir `evals/evals.json` simples para cada skill.
- Criar nova skill apenas apos 3 usos reais ou dor recorrente.

Decisao: nao criar skill generica "super-orquestrador". Se criarmos algo novo, deve ser `research-synthesis` ou `gmail-digest-intake`, ambos estreitos.

### 3. Subagentes devem ser estreitos e rasos

OpenAI e Anthropic convergem no valor de especialistas com contexto separado, ferramenta limitada e prompt proprio. O risco tambem e claro: fan-out aumenta custo, latencia e imprevisibilidade.

Aplicacao aqui:

- Preservar `.codex/config.toml` com `max_depth = 1`.
- Preservar `max_threads = 4` por enquanto.
- Delegar somente tarefas paralelas e autocontidas.
- Nao criar agentes para papeis que ainda nao tiveram uso recorrente.

Decisao: nenhum novo subagente agora.

### 4. Hooks e rules sao guardrails, nao produto

Rules controlam comandos fora do sandbox. Hooks sao extensibilidade deterministica, mas a propria documentacao do Codex marca hooks como experimentais e desabilitados no Windows. Anthropic tem hooks maduros em Claude Code, mas isso nao justifica copiar a infraestrutura para este repo.

Aplicacao aqui:

- Nao basear o laboratorio em hooks.
- Preferir comandos manuais claros, skills e documentos de gate.
- Se um dia houver hook, ele entra como experimento isolado e removivel.

Decisao: hooks ficam fora do core.

### 5. Evals e trace grading viraram disciplina basica

O SOTA de agentes nao e "parece bom"; e ter criterio repetivel. Para este tamanho de projeto, nao precisamos de plataforma pesada, mas precisamos de exemplos de aceitacao por skill e checks pequenos.

Aplicacao aqui:

- Manter `evals/evals.json` por skill.
- Adicionar exemplos negativos quando uma skill falhar.
- Criar um log simples de decisoes de incorporacao quando algo vira candidate.

Decisao: proxima melhoria pratica deve ser um `shadow/INCORPORATION-LOG.md`.

### 6. MCP e conectores devem ser tratados como superficie de risco

MCP padroniza recursos, prompts e ferramentas, mas a especificacao tambem deixa claro que ferramentas sao caminho para execucao/acesso externo e precisam de consentimento, privacidade, controle e validacao. A especificacao de tools reforca schema, output estruturado e confirmacao humana para operacoes sensiveis.

Aplicacao aqui:

- Gmail pode ser fonte e fila, mas write actions continuam com confirmacao.
- Nada de MCP proprio ate termos uso real.
- Para qualquer ferramenta nova: objetivo, trigger, artefato, custo e risco.

Decisao: MCP/A2A ficam como radar, nao incorporacao imediata.

### 7. Gemini ganhou papel claro: pesquisa longa e multimodal

Gemini 3.1 Pro/Flash aparecem como familia atual com foco forte em agente, codigo, long context, URL context, multimodalidade e Deep Research preview. A vantagem pratica para Lucas e analisar PDFs, paginas, imagens e grandes pacotes de contexto quando o Codex nao deve carregar tudo no loop principal.

Aplicacao aqui:

- Gemini entra como pesquisador/QA externo, nao como executor de repo.
- Artefato esperado: resumo citavel em `shadow/` ou nota privada em `private-learning/`.
- Custo limitado: usar quando o contexto for grande, multimodal ou quando precisarmos de segunda leitura.

Decisao: manter papel de Gemini como "pesquisar", nao ampliar autonomia.

### 8. A2A e interoperabilidade ainda sao radar

O protocolo Agent2Agent aponta uma direcao relevante: agentes de fornecedores diferentes colaborando por contratos. Para este laboratorio, incorporar A2A agora seria premature optimization.

Aplicacao aqui:

- Registrar criterios de papel, trigger, artefato, custo e risco para todo modelo novo.
- Nao implementar camada A2A local.
- Observar se ferramentas locais passam a suportar A2A de forma nativa.

Decisao: sem implementacao A2A.

## O que incorporar agora

### Alta prioridade

1. `shadow/INCORPORATION-LOG.md`
   - Objetivo: registrar toda decisao "private -> experiment -> candidate".
   - Motivo: evita migracao por impulso para OLMO.
   - Tamanho: 1 Markdown com tabela.
   - Risco: baixo.

2. Atualizar `digest-4p` para a taxonomia Gmail real
   - Labels: `Prometeus/Processar`, `Prometeus/Alta`, `Prometeus/Ruido`, `Prometeus/Digerido`.
   - Regra: `Digerido` so depois de artefato persistente.
   - Motivo: corrige o erro operacional recente.
   - Risco: baixo.

3. Criar criterio de "digest persistido"
   - Um email so conta como digerido se houver nota/digest com data, origem e 4 paragrafos.
   - Motivo: separa conversa de artefato.
   - Risco: baixo.

### Media prioridade

4. Criar skill `research-synthesis`
   - Trigger: "pesquisa ate hoje", "SOTA", "fontes atuais", "state of the art".
   - Output: briefing com fontes, achados, decisoes e candidatos.
   - Motivo: esta tarefa vai repetir.
   - Gate: criar apenas se fizermos mais 2 pesquisas desse tipo.

5. Criar dashboard card "fila de incorporacao"
   - Mostrar: inbox, em teste, candidate, bloqueado.
   - Motivo: Lucas precisa de interface visual.
   - Gate: so se nao poluir `private-learning/dashboard.html`.

6. Criar smoke checks locais
   - Checar se `private-learning/` esta ignorado.
   - Checar se docs falam OLMO apenas como destino protegido.
   - Checar se nao ha "Digerido" sem artefato.

### Baixa prioridade / radar

7. MCP local
   - Nao fazer agora.
   - So considerar se houver dado local recorrente que valha virar ferramenta.

8. A2A
   - Nao fazer agora.
   - So acompanhar suporte nativo em Codex/Gemini/Claude/Copilot.

9. Hooks
   - Nao fazer agora em Windows.
   - Se necessario, simular com scripts manuais primeiro.

## Decisao final de arquitetura

O tamanho certo do open OLMO_PROMETEUS hoje:

- 1 contrato: `AGENTS.md`.
- 3 skills reais: digest, estudo, promotion gate.
- 3 agentes customizados no maximo: explorer, promotion reviewer, docs researcher.
- 1 cockpit visual em `private-learning/`.
- 1 log de incorporacao em `shadow/`.
- 0 hooks core.
- 0 MCP proprio.
- 0 mudanca no `C:\Dev\Projetos\OLMO` sem autorizacao explicita.

## Proximo passo recomendado

Implementar somente dois ajustes:

1. Criar `shadow/INCORPORATION-LOG.md`.
2. Atualizar `digest-4p` para codificar a regra: `Digerido` exige artefato persistente.

Coautoria: Lucas + GPT-5.4 (Codex)
