---
type: note
status: experiment
source: shadow/AGENT-MODULES.md
aliases:
  - Agent Module Contract
  - Modular Agent Encapsulation
tags:
  - prometeus/concept
  - prometeus/agent
  - prometeus/sota
---

# Agent Module Encapsulation

Agente util e modulo encapsulado, nao personagem solto.

No Prometeus, a fronteira correta e:

```text
procedimento -> modulo documentado -> runner manual -> agente real
```

Isso preserva contexto, reduz sprawl e impede que o repo volte a ter pastas fantasmas de agents, subagents, skills e hooks.

## Contrato minimo

Um modulo candidato precisa declarar:

- `purpose`: uma responsabilidade;
- `trigger`: quando entra;
- `non_trigger`: quando nao entra;
- `input_contract`: o que recebe;
- `output_contract`: o que entrega;
- `state`: onde pode lembrar;
- `tools`: ferramentas permitidas;
- `permissions`: caminhos e acoes proibidas;
- `guardrails`: validacoes antes/depois;
- `eval`: como saber se funcionou;
- `cost`: contexto, tempo e manutencao;
- `rollback`: como desfazer.

## Regra Prometeus

Nao criar runtime de agente so porque a ideia parece boa.

Criar primeiro um contrato em [[SOTA Research Gate]], `shadow/AGENT-MODULES.md` ou no procedimento certo. Se houver 3 usos reais, evidencia e rollback, entao avaliar promocao com [[Promotion Gate]].

## Candidatos atuais

- [[Email Digest System]] pode virar `email-digest-4p` se provar uso recorrente.
- [[Study Track System]] pode virar `study-track-done` se reduzir retrabalho.
- [[Promotion Gate]] ja funciona como modulo decisorio documentado.
- [[Foundation Harness]] continua deterministico; nao precisa virar agente.
- [[SOTA Research Gate]] e gate de arquitetura, nao automacao.

## Links

- [[Second Brain Atlas]]
- [[SOTA Dev Solo]]
- [[Foundation Harness]]
- [[Promotion Gate]]
- [[Candidate]]

