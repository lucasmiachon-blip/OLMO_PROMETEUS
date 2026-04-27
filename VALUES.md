# Prometeus Values

> Decision filter: toda mudanca relevante precisa servir estes valores ou declarar excecao curta com evidencia, risco e rollback.

Status: active
Fonte adaptada: `OLMO/VALUES.md` e plans ativos/arquivados do `OLMO` lidos read-only em 2026-04-27. OLMO e o primeiro projeto decente e vira piso, nao teto. Prometeus precisa ser maior em rigor verificavel: boundary mais estrita, evidencia mais curta, privacidade mais defensiva, rollback mais simples e menos teatro.

## Identidade

Prometeus e um laboratorio seguro para validar fluxo, estudo, digest, wiki operacional, gates de promocao, maturidade e orquestracao de LLMs antes de qualquer conversa de migracao para `OLMO`.

Nao e SaaS, repositorio clinico, vault privado, produto multiusuario ou espelho do `OLMO`. Runtime agentico persistente continua bloqueado ate provar ganho em tarefas bem definidas.

E um ambiente de prova com padrao superior ao `OLMO` para boundary, evidencia, reversibilidade, maturidade executavel, privacidade e qualidade de auxilio. A diferenca e o metodo: aqui tudo entra primeiro como experimento verificavel antes de poder contaminar o sistema principal.

## Objetivos

1. Validar procedimentos que reduzem retrabalho real com rigor maior que o `OLMO`.
2. Transformar erros observados em detector, regra, teste ou decisao curta antes de chamar aprendizado.
3. Separar captura privada de conhecimento duravel e operacional.
4. Minerar `OLMO` e `OLMO_GENESIS` como ramos paralelos sem bulk copy.
5. Criar gates de promocao que protejam o `OLMO` principal de contaminacao.
6. Manter harness local que prove claims do repo e exponha gaps de maturidade.
7. Desenvolver, com baixo risco e evidencia, um sistema de LLMs orquestrados para educacao, pesquisa, EBM e auxilio direto que iguale ou supere humanos em tarefas delimitadas.
8. Usar os melhores modelos e combinacoes multimodel disponiveis da OpenAI, Anthropic, Google e, quando fizer sentido, modelos locais, priorizando SOTA verificavel e eficacia em tarefa delimitada; custo entra como constraint de viabilidade, nao como criterio principal.

## OLMO como piso

Padroes observados no `OLMO` que Prometeus precisa exceder antes de T3:

| Frente | Piso do OLMO | Exigencia Prometeus |
|---|---|---|
| Valores | North Star, anti-teatro, antifragilidade, evidence-based e reproducibilidade | Valores viram contrato testado pelo harness e lente obrigatoria de gaps. |
| Plans | Plan ativo unico, arquivo historico grande e auditoria adversarial | Plan so entra com trigger, consumer, rollback e criterio negativo; se virar museu, consolida. |
| Hooks/gates | Producer-consumer, mock tests, scope e KBP | Gate novo sem producer-consumer explicito e evidencia fica bloqueado. |
| Maturidade | Auditorias de contexto/integridade e purge de aspiracional | Maturidade precisa detectar regressao real ou sair em 30 dias. |
| Self-evolution | Loop disciplinado com revisao e risco | Self-evolution permanece read-only ate prova repetida; sem auto-write, commit, issue ou PR. |
| Privacidade | Projeto medico solo com EBM e disciplina operacional | Sem PHI por padrao; qualquer excecao exige workflow privado aprovado antes do arquivo existir. |

Regra: copiar forma do `OLMO` sem superar o controle correspondente e regressao. Se o `OLMO` tem uma pratica madura, Prometeus precisa adaptar a intencao e adicionar uma protecao local mensuravel.

## Valores

| ID | Valor | Aplicacao operacional |
|---|---|---|
| V1 | Boundary absoluta | Nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`; read externo so com autorizacao explicita. |
| V2 | Evidence-based | Claim relevante cita arquivo, commit, fonte primaria ou output de harness; memoria de modelo nao conta. |
| V3 | Humildade epistemica | Marcar incerteza e bloquear promocao quando faltam ciclos reais. |
| V4 | Anti-teatro | Todo gate, hook, procedure ou agente precisa trigger, artefato e consumer; sem isso fica `experiment` ou sai. |
| V5 | Antifragile verificavel | Falha so vira aprendizado quando reduz repeticao via teste, detector, regra ou backlog com criterio negativo. |
| V6 | Signal > noise | Decisao curta vence relatorio longo; consolidar antes de criar documento novo. |
| V7 | Reversibilidade | Preferir Markdown, JSON, Bash e commits pequenos com rollback claro. |
| V8 | Privacidade medica | Sem PHI, dado sensivel ou captura privada em repo, prompt externo ou automacao sem workflow aprovado. |
| V9 | Orquestracao frontier com utilidade humana | LLMs e modelos locais entram para superar baseline humano/procedural em educacao, pesquisa, EBM e auxilio direto, com SOTA atual, eval local, eficacia, privacidade, HITL e rollback. Multimodel e a hipotese operacional preferida ate prova contraria. |

## Anti-valores

| Anti-valor | Rejeicao operacional |
|---|---|
| Cargo cult | Copiar hook, skill, agent, MCP ou runtime porque outro repo tem. |
| Ceremony bloat | Adicionar governanca que nao muda comportamento verificavel, mesmo com linguagem de maturidade. |
| Runtime antes de procedimento | Criar agente/framework antes de 3 evidencias reais de retrabalho. |
| SOTA museu | Guardar pesquisa longa sem decisao curta, trigger e criterio negativo. |
| Bulk legacy import | Copiar diretorios de `OLMO`/`OLMO_GENESIS` sem triagem `incorporar/nao incorporar`. |
| Build-and-break | Mudar harness/base sem rodar `./scripts/check.sh --strict`. |
| Sycophancy | Concordar com promocao/arquitetura sem apontar eficacia, risco, privacidade, viabilidade e rollback. |
| Dado sensivel por conveniencia | Usar dado clinico real para acelerar teste. |

## Gap Lens

Use estes campos para identificar gaps antes de criar estrutura nova:

| Campo | Pergunta |
|---|---|
| Valor | Qual V1-V9 a mudanca melhora? |
| Dor real | Que falha, retrabalho ou risco ja ocorreu? |
| Trigger | Quando entra sem depender de memoria do Lucas? |
| Artefato | Que arquivo, output ou detector fica depois? |
| Consumer | Quem ou que comando usa esse artefato? |
| Evidencia | Onde esta o uso real ou teste? |
| Eficacia | Que baseline humano/procedural/modelo precisa superar e como medir? |
| Viabilidade | Quanto contexto, manutencao, latencia ou custo adiciona? |
| Risco | O que pode contaminar, confundir ou quebrar? |
| Rollback | Como remover sem tocar no `OLMO` principal? |
| Criterio negativo | Quando simplificar, aposentar ou remover? |

Se `Valor`, `Dor real`, `Artefato` e `Consumer` nao estiverem claros, o gap ainda nao justifica automacao.

## Versioning

- v1.4 2026-04-27: multimodel assumido como caminho preferido; SOTA e eficacia ficam acima de custo, que vira constraint de viabilidade.
- v1.3 2026-04-27: objetivo frontier explicitado — LLMs orquestrados para educacao, pesquisa, EBM e auxilio direto, com melhores modelos por eval e nao por hype.
- v1.2 2026-04-27: OLMO definido como piso, nao teto; Prometeus deve exceder em rigor verificavel antes de T3.
- v1.1 2026-04-27: corrigida premissa — Prometeus tem barra igual ou maior que OLMO; escopo experimental nao reduz rigor.
- v1.0 2026-04-27: adaptado de `OLMO/VALUES.md` para Prometeus.
- Mudanca de valor V1-V9 exige entrada em `shadow/SOTA-DECISIONS.md`.
