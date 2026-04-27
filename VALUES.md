# Prometeus Values

> Decision filter: toda mudanca relevante precisa servir estes valores ou declarar excecao curta com evidencia, risco e rollback.

Status: active
Fonte adaptada: `OLMO/VALUES.md` lido read-only em 2026-04-27. Esta versao e menor porque Prometeus e laboratorio, nao sistema principal.

## Identidade

Prometeus e um laboratorio seguro para validar fluxo, estudo, digest, wiki operacional, gates de promocao e maturidade antes de qualquer conversa de migracao para `OLMO`.

Nao e SaaS, runtime agentico, repositorio clinico, vault privado, produto multiusuario ou espelho do `OLMO`.

E um ambiente de prova para um medico solo dev: pequeno, auditavel, reversivel, humano-no-loop e sem dado sensivel versionado.

## Objetivos

1. Validar procedimentos pequenos que reduzem retrabalho real.
2. Transformar erros observados em detector, regra, teste ou decisao curta.
3. Separar captura privada de conhecimento duravel e operacional.
4. Minerar `OLMO` e `OLMO_GENESIS` como ramos paralelos sem bulk copy.
5. Criar gates de promocao que protejam o `OLMO` principal de contaminacao.
6. Manter harness local que prove claims basicos do repo.

## Valores

| ID | Valor | Aplicacao operacional |
|---|---|---|
| V1 | Boundary absoluta | Nunca escrever fora de `/home/lucasmiachon/projects/OLMO_PROMETEUS`; read externo so com autorizacao explicita. |
| V2 | Evidence-based | Claim relevante cita arquivo, commit, fonte primaria ou output de harness; memoria de modelo nao conta. |
| V3 | Humildade epistemica | Marcar incerteza e bloquear promocao quando faltam ciclos reais. |
| V4 | Anti-teatro | Todo gate, hook, procedure ou agente precisa trigger, artefato e consumer; sem isso fica `experiment` ou sai. |
| V5 | Antifragile lite | Falha so vira aprendizado quando reduz repeticao via teste, detector, regra ou backlog com criterio negativo. |
| V6 | Signal > noise | Decisao curta vence relatorio longo; consolidar antes de criar documento novo. |
| V7 | Reversibilidade | Preferir Markdown, JSON, Bash e commits pequenos com rollback claro. |
| V8 | Privacidade medica | Sem PHI, dado sensivel ou captura privada em repo, prompt externo ou automacao sem workflow aprovado. |

## Anti-valores

| Anti-valor | Rejeicao operacional |
|---|---|
| Cargo cult | Copiar hook, skill, agent, MCP ou runtime porque outro repo tem. |
| Ceremony bloat | Adicionar governanca que nao muda comportamento verificavel. |
| Runtime antes de procedimento | Criar agente/framework antes de 3 evidencias reais de retrabalho. |
| SOTA museu | Guardar pesquisa longa sem decisao curta, trigger e criterio negativo. |
| Bulk legacy import | Copiar diretorios de `OLMO`/`OLMO_GENESIS` sem triagem `incorporar/nao incorporar`. |
| Build-and-break | Mudar harness/base sem rodar `./scripts/check.sh --strict`. |
| Sycophancy | Concordar com promocao/arquitetura sem apontar custo, risco e rollback. |
| Dado sensivel por conveniencia | Usar dado clinico real para acelerar teste. |

## Gap Lens

Use estes campos para identificar gaps antes de criar estrutura nova:

| Campo | Pergunta |
|---|---|
| Valor | Qual V1-V8 a mudanca melhora? |
| Dor real | Que falha, retrabalho ou risco ja ocorreu? |
| Trigger | Quando entra sem depender de memoria do Lucas? |
| Artefato | Que arquivo, output ou detector fica depois? |
| Consumer | Quem ou que comando usa esse artefato? |
| Evidencia | Onde esta o uso real ou teste? |
| Custo | Quanto contexto/manutencao adiciona? |
| Risco | O que pode contaminar, confundir ou quebrar? |
| Rollback | Como remover sem tocar no `OLMO` principal? |
| Criterio negativo | Quando simplificar, aposentar ou remover? |

Se `Valor`, `Dor real`, `Artefato` e `Consumer` nao estiverem claros, o gap ainda nao justifica automacao.

## Versioning

- v1.0 2026-04-27: adaptado de `OLMO/VALUES.md` para Prometeus.
- Mudanca de valor V1-V8 exige entrada em `shadow/SOTA-DECISIONS.md`.
