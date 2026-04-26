# Data Classification

Status: operational guard

Objetivo: impedir que dado sensivel entre no repo, em prompts externos, em agentes ou em automacoes por acidente.

## Classes

| Classe | Pode versionar | Pode enviar a LLM externa | Exemplo permitido | Exemplo proibido |
| --- | --- | --- | --- | --- |
| `public` | sim | sim | links de docs oficiais, README publico | segredo, token, dado pessoal |
| `project` | sim | sim, se nao tiver dado sensivel | contrato do repo, harness, wiki operacional | export privado ou credencial |
| `synthetic` | sim | sim | caso clinico ficticio marcado como sintetico | caso real "anonimizado" sem revisao |
| `personal` | nao | nao por padrao | notas pessoais em `private-learning/` ignorado | documento pessoal versionado |
| `sensitive` | nao | nao | n/a | CPF, telefone, endereco, agenda, login, token |
| `phi` | nao | nao | n/a | dado de paciente, atendimento, exame, imagem, audio, PDF clinico |

## Regra

Se houver duvida entre duas classes, usar a mais restritiva.

`phi`, `sensitive` e `personal` nao entram em Git, wiki versionada, prompt externo, agente, log, issue, PR, workflow ou artefato de teste. A unica excecao possivel exige aprovacao humana explicita, caminho, dado minimo, destino, retencao e rollback.

## Workflow

1. Classificar a entrada antes de salvar.
2. Se for `public`, `project` ou `synthetic`, pode virar artefato versionado.
3. Se for `personal`, manter em `private-learning/` ou fora do repo.
4. Se for `sensitive` ou `phi`, parar e nao processar no repo.
5. Se for necessario estudar um padrao clinico, criar exemplo `synthetic` sem identificadores reais.

## Criterio negativo

Se um fluxo exigir dado real de paciente, ele fica `blocked` ate existir ambiente privado aprovado, sem prompt externo, com retencao definida e revisao humana.

## Fontes

- HHS HIPAA Minimum Necessary Requirement: `https://www.hhs.gov/hipaa/for-professionals/privacy/guidance/minimum-necessary-requirement/index.html`
- HHS HIPAA Minimum Necessary FAQ: `https://www.hhs.gov/hipaa/for-professionals/faq/minimum-necessary/index.html`

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
