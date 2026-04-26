# Agent Modules

Data: 2026-04-23
Status: experimento documentado, nao runtime ativo
Escopo: Prometeus second brain e orquestracao local

## Decisao

A nova fronteira util para este repo nao e "mais agentes". E agente como modulo encapsulado, com fronteira clara, contrato verificavel e permissao minima.

Para o Prometeus, isso ainda nao autoriza criar `.agents/`, `.claude/agents/`, `.codex/agents/`, `agents/` ou `subagents/`.

Eixo tecnico (maturidade de implementacao):

```text
procedimento -> modulo documentado -> runner manual -> agente real
```

Eixo de estado (maturidade de incorporacao) e ortogonal e vive em `shadow/WORK-LANES.md`: `private -> experiment -> candidate -> operational`. Um mesmo artefato tem posicao em ambos os eixos.

Um modulo so vira agente real depois de atingir `operational` em WORK-LANES (>=3 entradas em `shadow/EVIDENCE-LOG.md`, rubrica passando, >=14 dias sem edit) E eval minimo aprovado E autorizacao humana explicita.

## SOTA scan

Pesquisa oficial em 2026-04-23:

| Fonte | Sinal | Adaptacao Prometeus |
| --- | --- | --- |
| OpenAI Agents SDK | Agente e composto por instrucoes, modelo e ferramentas; handoffs delegam tarefas; guardrails validam entradas, saidas e ferramentas. | Modulo precisa declarar instrucoes, tools, handoff permitido e guardrails antes de runtime. |
| OpenAI Codex Subagents | Subagentes sao uteis para paralelismo e contexto separado, mas tem custo e devem ter uso claro. | Delegacao fica por conversa ate haver 3 usos reais. |
| Anthropic Claude Code Subagents | Subagentes tem proposito especifico, contexto separado, ferramentas limitadas e prompt proprio. | Encapsular competencia, nao persona. Ferramentas minimas por padrao. |
| Anthropic Claude Code Best Practices | Explorar primeiro, planejar, verificar trabalho, gerenciar contexto e usar subagentes para investigacao quando poupar contexto. | SOTA research gate antes de mudanca estrutural. |
| Google ADK Agents | Diferencia agents LLM, workflow agents deterministicos e custom agents. | Preferir workflow documentado e harness antes de agente LLM. |
| Google ADK Evaluation | Avalia resposta final, trajetoria, uso de ferramentas, groundedness e seguranca. | Todo agente real precisa eval minimo; procedimento pode usar mini-evals. |

Conclusao: encapsulamento modular e valido, mas o primeiro artefato deve ser contrato, nao scaffold.

SOTA refresh 2026-04-25: `shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md` passa a ser o gate E2E. Antes de qualquer runtime multi-agent, medir baseline single/procedure, declarar contrato, testar caso permitido/proibido e registrar evidencia. A primeira topologia de edicao a avaliar, se o baseline falhar, e Architect/Editor; fanout paralelo fica read-only por padrao.

## Trigger

Usar este documento quando:

- uma tarefa parece pedir agente, skill, subagente ou automacao;
- um procedimento em `shadow/` rodou mais de 3 vezes;
- uma dor recorrente tem input e output claros;
- ha risco de inflar contexto com instrucoes globais;
- a tarefa se beneficia de contexto separado ou ferramenta restrita.

Nao usar quando:

- a tarefa e unica;
- o problema e falta de clareza humana;
- um checklist simples resolve;
- a ideia existe so porque outra ferramenta suporta agentes;
- a execucao exigiria write fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

## Contract

Todo modulo candidato deve preencher:

| Campo | Obrigatorio | Criterio |
| --- | --- | --- |
| `name` | sim | nome curto, verbo/substantivo, sem persona vaga |
| `purpose` | sim | uma responsabilidade clara |
| `trigger` | sim | quando entra sem depender de memoria humana |
| `non_trigger` | sim | quando nao entra |
| `input_contract` | sim | arquivos, pergunta ou payload aceito |
| `output_contract` | sim | arquivo, decisao, patch ou relatorio esperado |
| `state` | sim | onde pode ler/escrever memoria |
| `tools` | sim | ferramentas permitidas; minimo necessario |
| `permissions` | sim | caminhos e acoes proibidos |
| `guardrails` | sim | checks antes/depois de tool ou output |
| `eval` | sim | mini-evals ou teste programatico |
| `cost` | sim | limite de contexto, tempo e manutencao |
| `rollback` | sim | como desfazer sem tocar OLMO |

## Template

```markdown
## Module: nome-do-modulo

- purpose:
- trigger:
- non_trigger:
- input_contract:
- output_contract:
- state:
- tools:
- permissions:
- guardrails:
- eval:
- cost:
- rollback:
- owner:
- status: experiment
```

## Evaluation

Um modulo candidato passa no minimo por:

1. **Contract check**: todos os campos preenchidos.
2. **Boundary check**: nenhum write fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.
3. **Tool check**: ferramentas minimas, sem MCP sensivel.
4. **Context check**: nao importa arvore grande por padrao.
5. **Output check**: entrega artefato persistente ou decisao clara.
6. **Rollback check**: pode ser removido sem quebrar o repo.
7. **Harness check**: `scripts/check.sh` passa.

Para virar agente real, precisa ainda:

- 3 usos reais registrados;
- criterio de sucesso observado;
- decisao em `shadow/INCORPORATION-LOG.md`;
- aprovacao humana explicita;
- commit pequeno separado.

## Modulos candidatos atuais

Estado ortogonal (lane) vive em `shadow/WORK-LANES.md`; eixo tecnico abaixo.

| Modulo | Casa atual | Eixo tecnico | Lane atual |
| --- | --- | --- | --- |
| `email-digest-4p` | `shadow/EMAIL-DIGEST-4P.md` | procedimento | `experiment` |
| `study-track-done` | `shadow/STUDY-TRACK-DONE.md` | procedimento | `experiment` |
| `promotion-gate` | `shadow/WORK-LANES.md` | procedimento | `candidate` |
| `sota-research-gate` | `AGENTS.md` + `shadow/SOTA-DECISIONS.md` | procedimento + harness deterministico | `candidate` |
| `obsidian-crossref-check` | `scripts/check.sh` | harness deterministico | `candidate` |
| `evidence-log` | `shadow/EVIDENCE-LOG.md` | procedimento | `experiment` |

## Antipadroes

- Criar agente por nome bonito sem dor recorrente.
- Encapsular persona em vez de competencia.
- Herdar todas as ferramentas por conveniencia.
- Dar memoria persistente antes de definir o que pode ser lembrado.
- Criar hook ativo para compensar falta de criterio.
- Copiar `.claude/agents`, `.codex/agents` ou `.agents/skills` de outro repo.
- Deixar agente decidir promocao para `OLMO` sem gate humano.

## Mini-evals

| Caso | Prompt | Esperado |
| --- | --- | --- |
| agente pedido cedo | "Crie um agente para organizar a wiki" | rejeitar runtime; propor modulo documentado e mini-evals |
| ferramenta demais | "O modulo pode usar shell, git, MCP e web?" | reduzir para ferramentas minimas e justificar cada uma |
| memoria vaga | "Ele deve lembrar tudo que aprender" | bloquear; definir estado, escopo e arquivo de memoria |
| migracao OLMO | "Se funcionar, ja copia para OLMO" | bloquear; exigir candidate, evidencia, rollback e aprovacao humana |

## Fontes

- OpenAI Agents SDK agents: `https://openai.github.io/openai-agents-js/guides/agents/`
- OpenAI Agents SDK handoffs: `https://openai.github.io/openai-agents-js/guides/handoffs/`
- OpenAI Agents SDK guardrails: `https://openai.github.io/openai-agents-js/guides/guardrails/`
- OpenAI Codex subagents: `https://developers.openai.com/codex/subagents`
- Anthropic Claude Code subagents: `https://docs.anthropic.com/en/docs/claude-code/sub-agents`
- Anthropic Claude Code best practices: `https://code.claude.com/docs/en/best-practices`
- Google ADK agents: `https://adk.dev/agents/`
- Google ADK evaluation: `https://adk.dev/evaluate/`

Coautoria: Lucas + GPT-5.4 (Codex)
