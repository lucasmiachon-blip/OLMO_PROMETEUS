---
type: values
status: active
version: 2.5
updated: 2026-04-28
purpose: filtro operacional para decisoes em Prometeus
audience: human, llm, harness
related: Ignis Animi (axiomas filosoficos pessoais), Flammula of uncertainty (postura critica EBM)
notes: sistemas relacionados residem em Notion ate migracao planejada para este repo
---

# Prometeus Values

Laboratorio solo medico-dev. Escopo: apoiar pratica clinica, estudo, EBM e desenvolvimento de fluxos LLM-assistidos. Fora de escopo: SaaS, produto multiusuario, sistema de prontuario.

## Valores

Quatro raizes. Todos os principios operacionais abaixo derivam delas.

### Amizade

- Repositorio e oferta, nao marca. Sem hierarquia performativa.
- Critica e cuidado, nao agressao. Atribuicao explicita de credito.
- Respeito pela pessoa por tras de qualquer obra auditada.

### Autenticidade

- Separar dado, interpretacao e juizo de valor explicitamente.
- Marcar incerteza. Recusar promessa que o artefato nao cumpre.
- Sem cargo cult. Nao adotar padrao por reputacao isolada.

### Lealdade

- Ao paciente, a pratica, ao colega — nao ao sistema.
- Boundary absoluta: nenhum write fora do repositorio.
- Privacidade primeiro: sem PHI ou dado sensivel em repo, prompt externo ou automacao sem workflow privado aprovado.
- Servir, nao promover.

### Dedicacao

- Trabalho lento, rigoroso, repetivel. Iteracao acima de retorica.
- Erro so vira aprendizado quando produz detector, regra ou teste.
- Artefatos sao mortais: cada mudanca tem rollback explicito.

## Principios operacionais

Cada principio e a codificacao tecnica de uma ou mais raizes.

| ID | Principio | Aplicacao | Raizes |
|---|---|---|---|
| V1 | Boundary | Nenhum write fora do repositorio; read externo requer autorizacao explicita. | Lealdade |
| V2 | Evidence-based | Citar arquivo, commit, fonte primaria ou output do harness. Memoria do modelo nao conta. | Autenticidade |
| V3 | Humildade epistemica | Marcar incerteza; nao prometer o que nao se cumpre. | Autenticidade |
| V4 | Anti-teatro | Todo gate, hook, procedure ou agente declara trigger, artefato e consumer; senao e removido. | Autenticidade, Dedicacao |
| V5 | Antifragile verificavel | Falha so vira aprendizado quando reduz repeticao via teste, detector, regra ou backlog com criterio negativo. | Dedicacao |
| V6 | Reversibilidade | Markdown, JSON, Bash, commits pequenos, rollback explicito. | Dedicacao |
| V7 | Privacidade medica | Sem PHI ou dado sensivel em repo, prompt externo ou automacao sem workflow privado aprovado. | Lealdade |

## Objetivos

1. Reduzir retrabalho real em pratica clinica, estudo e EBM.
2. Converter erros observados em detector, regra ou teste antes de declarar aprendizado.
3. Manter harness local que prove claims, nao retorica.

## Cross-references

- Promotion gate: [`shadow/WORK-LANES.md`](shadow/WORK-LANES.md)
- Anti-padroes: [`shadow/KBP.md`](shadow/KBP.md), [`AGENTS.md > Do Not`](AGENTS.md)
- Multimodel SOTA: [`docs/adr/0007-multimodel-sota-efficacy.md`](docs/adr/0007-multimodel-sota-efficacy.md)
- Sistemas pessoais relacionados (Notion): **Ignis Animi**, **Flammula of uncertainty**.

## Criterio negativo

Se as raizes ou os principios operacionais nao forem citados em decisao concreta ate 2026-05-28, colapsar em secao curta em `PROJECT_CONTRACT.md` e remover este arquivo.

## Versioning

- v2.5 2026-04-28: campo `related` no frontmatter cita Ignis Animi e Flammula of uncertainty (sistemas pessoais que serao usados em decisoes futuras).
- v2.4 2026-04-28: nota Notion no frontmatter (migracao planejada).
- v2.3 2026-04-28: tom profissional; frontmatter YAML; coluna Raizes ligando V1-V7 as raizes; secao Criterio negativo explicita.
- v2.2 2026-04-28: 4 raizes destacadas em H3; V1-V7 derivados.
- v2.0/v2.1 2026-04-28: drift correction.
- v1.0-v1.4 (2026-04-27): em git log.
