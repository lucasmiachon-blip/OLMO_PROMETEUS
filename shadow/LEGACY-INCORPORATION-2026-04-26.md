# Legacy Incorporation - 2026-04-26

> Regra: ler antes de mover. Cada item legado recebe decisao explicita `incorporar` ou `nao incorporar`, com justificativa, destino e risco. Sem bulk copy.

## Fontes lidas

- `/home/lucasmiachon/legacy/2026-04-26/devmentor/vault/wiki/vault-anti-poluicao.md`
- `/home/lucasmiachon/legacy/2026-04-26/devmentor/vault/wiki/karpathy-wiki-pattern.md`
- `/home/lucasmiachon/legacy/2026-04-26/devmentor/vault/wiki/cli-vs-mcp.md`
- `/home/lucasmiachon/legacy/2026-04-26/devmentor/vault/wiki/skills-vs-mcp.md`
- `/home/lucasmiachon/legacy/2026-04-26/devmentor/vault/zettel/202604220001-vault-e-espelho-do-pensamento.md`
- `/home/lucasmiachon/legacy/2026-04-26/devmentor/vault/zettel/202604220002-cli-vence-porque-modelo-nasceu-no-shell.md`
- `/home/lucasmiachon/legacy/2026-04-26/devmentor/vault/zettel/202604220003-obsidian-via-wslg-e-movimento-sutil.md`
- `/home/lucasmiachon/legacy/2026-04-26/devmentor/README.md`
- `/home/lucasmiachon/legacy/2026-04-26/dev/olmo-migration/OLMO/docs/research/sota-S248-D-synthesis.md`
- `/home/lucasmiachon/legacy/2026-04-26/dev/olmo-migration/OLMO/docs/mcp_safety_reference.md`
- `/home/lucasmiachon/legacy/2026-04-26/dev/olmo-migration/OLMO/docs/ARCHITECTURE.md`

## Matriz

| Item | Decisao | Justificativa | Destino | Risco | Acao |
|---|---|---|---|---|---|
| Vault anti-poluicao | incorporar | O principio "vault contem pensamento autentico" separa wiki/compilacao de autoria humana; isso apoia a divisao atual `shadow/` vs `Prometeus/wiki/` sem criar runtime novo. Fonte: `vault-anti-poluicao.md:13`, `:25-29`, `:33-41`. | `AGENTS.md`, `TREE.md`, wiki quando houver nota de conhecimento | Baixo | Ja refletido como regra de incorporacao seletiva; nao copiar texto bruto. |
| Karpathy wiki pattern | incorporar parcial | As camadas raw/wiki/zettel e o uso de confidence sao uteis como criterio, mas a fonte e secundarizada no legado e nao foi revalidada hoje. Fonte: `karpathy-wiki-pattern.md:14`, `:18-20`, `:24-31`. | `Prometeus/wiki/` como principio, nao como scaffold | Medio | Registrar como candidato conceitual; nao criar skills `ingest/lint/graduate`. |
| CLI vs MCP | incorporar parcial | A preferencia por CLI para ferramentas maduras combina com o contrato local e com o uso de `bash`, `rg`, `jq`; claims numericos do benchmark nao foram revalidados nesta rodada. Fonte: `cli-vs-mcp.md:18-22`, `:26-32`, `:36-38`. | `shadow/SOTA-DECISIONS.md` / `AGENT-USAGE.md` se precisar decidir tool | Medio | Usar como heuristica local; marcar numeros como nao verificados se reutilizados. |
| Skills vs MCP | incorporar parcial | A distincao skill/MCP/CLI e util; a criacao de skills conflita com o contrato local sem evidencia operacional. Fonte: `skills-vs-mcp.md:17-23`, `:38-44`; conflito com `AGENTS.md:30`. | `shadow/AGENT-USAGE.md` como criterio | Medio | Nao criar `.claude/skills`; usar so como taxonomia. |
| Zettel do DevMentor | nao incorporar | Os zettels estao marcados como "RASCUNHO LLM"; copiar violaria a propria regra de autoria humana. Fonte: `202604220001...md:12`, `202604220002...md:12`, `202604220003...md:12`. | legado | Baixo | Manter legado; Lucas pode reescrever manualmente se quiser. |
| Obsidian via WSLg/Linux-native | incorporar | A tese "Windows virou so a tela, nao o ambiente" reforca a decisao ja aplicada de raiz Linux canonica. Fonte: `202604220003...md:14-20`. | `README.md`, `AGENTS.md`, `TREE.md` | Baixo | Ja incorporado como workspace canonico Linux; nao copiar zettel. |
| DevMentor README | nao incorporar | Repo era sandbox pessoal e deletavel, com regras diferentes do Prometeus. Fonte: `README.md:25-29`. | legado | Baixo | Nao trazer estrutura `aulas/exercicios/anotacoes`. |
| SOTA S248 synthesis | incorporar parcial | Achados como triggers, schema-first e anti-overengineering reforcam contratos atuais; propostas de hooks, agents e FIXes pertencem ao OLMO legado e nao ao Prometeus. Fonte: `sota-S248-D-synthesis.md:15`, `:18-19`, `:137-147`, `:189-203`. | `shadow/SOTA-DECISIONS.md` quando houver decisao nova | Alto | Nao executar migracao; extrair so criterios. |
| Architect/Editor / tribunal | nao incorporar agora | Ha recomendacao legacy para Architect/Editor, mas este repo decidiu executor exclusivo Codex ou Claude Code, nunca juntos no mesmo escopo. Fonte: `sota-S248-D-synthesis.md:27`, `:57`, `:157-178`; regra local em `AGENTS.md` e `SOTA-DECISIONS.md`. | legado | Medio | Revisar so com caso real e baseline single. |
| Step counter / hook detector | nao incorporar agora | Legacy marca como gap de alto valor, mas hook novo exige trigger, evidencia, rollback e aprovacao humana. Fonte: `sota-S248-D-synthesis.md:145`, `:189`, `:203`. | `shadow/SOTA-DECISIONS.md` se virar pesquisa | Alto | Bloquear implementacao ate >=3 evidencias em `EVIDENCE-LOG.md`. |
| MCP safety reference | incorporar parcial | Regras de segredo, OAuth minimo, cache e checkpoint sao boas; o token unico read/write e incompatível com least privilege para este repo. Fonte: `mcp_safety_reference.md:7`, `:13-15`, `:21-22`. | `shadow/THREAT-MODEL.md` ou decisao MCP futura | Alto | Nao ativar MCP; aproveitar so guardrails se surgir trigger. |
| OLMO architecture hooks/agents/skills | nao incorporar | O legado registra 9 agents, 18 skills e 30 scripts/32 hooks; isso e grande demais para o laboratorio atual e conflita com "baixo atrito". Fonte: `ARCHITECTURE.md:9-15`, `:72`. | legado | Alto | Nao copiar `.claude/agents`, `.claude/hooks`, `.claude/skills`, packages ou locks. |
| OLMO MCP inventory | incorporar criterio, nao runtime | A regra "inventariado != callable" e boa para evitar confusao; conexoes e policies concretas sao do OLMO legado. Fonte: `ARCHITECTURE.md:137`, `:155-158`, `:166-173`. | `shadow/AGENT-USAGE.md` se houver MCP futuro | Alto | Nao importar configs MCP; manter criterio. |
| Conteudo medico/aulas/evidence | nao incorporar agora | Pode conter conteudo clinico, PMIDs, aulas e referencias extensas; fora do escopo imediato e exige PHI/data review antes de qualquer reaproveitamento. Fonte: inventario `rg` achou `content/aulas/metanalise/evidence/*` e changelog medico. | legado | Alto | Revisar caso a caso quando houver projeto de aula. |
| Raw email / Gmail digest legado | nao incorporar | Ha URL Gmail e captura HTML-only; risco de dado pessoal/tracking e baixa utilidade operacional. Fonte: `vault/raw/emails/2026-04-22-nejm-toc-april-23-2026.md:19`, `:23`; sessoes em `active-context.md:37-63`. | legado | Alto | Nao copiar raw; se usar, criar exemplo sintetico. |
| Graphify / plugins Obsidian | nao incorporar | O proprio legado rejeitou graphify por poluir vault e por falta de escala; plugins/themes sao peso sem trigger. Fonte: `active-context.md:27`, `:47`. | legado | Baixo | Reavaliar so se vault >=50 notas ou necessidade concreta. |

## Decisao da rodada

Incorporar apenas regras e criterios ja alinhados ao contrato: raiz Linux, leitura antes de movimento, CLI-first para ferramentas maduras, autoria humana no vault, e gate forte para skills/hooks/MCP. Nao incorporar scaffolds, raw data, medical content, agents, hooks, packages, locks ou zettels LLM.

## Parking lot profissional

Itens abaixo nao entram agora, mas nao devem ser esquecidos. Reabrir somente com trigger documentado, evidencia e destino claro.

| Item | Potencial | Trigger para reabrir | Condicao minima | Destino provavel |
|---|---|---|---|---|
| Architect/Editor ou tribunal de agentes | Pode melhorar tarefas de debug ou revisao complexa. | 1 caso real onde single-executor falhe ou gere retrabalho caro. | Baseline single medido, custo comparado, rollback definido. | `shadow/SOTA-DECISIONS.md` e plano `shadow/PLAN-*.md`. |
| Step counter / loop detector | Pode reduzir loops de ferramenta e retrabalho repetitivo. | >=3 ocorrencias em `shadow/EVIDENCE-LOG.md` de repeticao ou loop material. | Trigger, nao-trigger, modo read-only primeiro, teste local e aprovacao humana. | `scripts/` se for harness simples; nunca hook ativo direto. |
| MCP safety reference | Guardrails uteis para Notion/Gmail/servicos externos. | Uso real de MCP externo com write ou credencial. | Least privilege, OAuth escopo minimo, cache/checkpoint, rollback e threat model atualizado. | `shadow/THREAT-MODEL.md`, `shadow/AGENT-USAGE.md`, decisao SOTA. |
| OLMO MCP inventory | Boa regra de auditoria: inventariado nao significa callable. | Necessidade de mapear conectores reais deste repo. | Inventario separado de policy runtime; nenhum token/config copiado. | `shadow/AGENT-USAGE.md`. |
| Conteudo medico/aulas/evidence | Pode virar material educacional futuro. | Projeto explicito de aula, estudo ou slide medico. | PHI checklist, data classification, fonte primaria, escopo pequeno. | `Prometeus/wiki/References/` ou `shadow/PLAN-*.md`. |
| Raw email/Gmail digest legado | Pode informar desenho de digest. | Retomar digest com Gmail ou newsletter HTML-only. | Exemplo sintetico; nenhuma URL pessoal, thread id, tracking ou conteudo sensivel. | `shadow/EMAIL-DIGEST-4P.md` ou nota wiki sintetica. |
| Graphify / plugins Obsidian | Pode ajudar quando o vault crescer. | Vault >=50 notas ou necessidade concreta de bridge-node/graph analysis. | Prova em copia local ignorada; zero output LLM despejado no vault versionado. | `Prometeus/wiki/` apenas se o resultado for curado. |
| DevMentor trilhas de estudo | Pode reaproveitar pedagogia de auto-reporte vs verificado. | Retomar trilha de estudo dev dentro do Prometeus. | Separar habilidade autodeclarada de habilidade verificada por exercicio. | `shadow/STUDY-TRACK-DONE.md` ou wiki de estudo. |
| OLMO design/aula frontend | Pode conter padroes bons de slides e QA visual. | Construir app, aula, deck ou visual interativo real. | Ler arquivo alvo, extrair regra pequena, validar screenshot/harness. | Projeto especifico; nao importar assets em massa. |

Regra de saida do parking lot: todo item que reabrir vira decisao curta antes de virar arquivo, script, hook, skill, MCP ou runtime.

## Proximo passo seguro

Antes de tocar outros caminhos legados ou globais, repetir este formato: inventario pequeno, leitura com linha, decisao `incorporar/nao incorporar`, depois patch minimo dentro do repo.
