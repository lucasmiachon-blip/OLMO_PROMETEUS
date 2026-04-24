# Study Track com Done

## Trigger

Usar este procedimento quando houver:

- pedido de organizar estudo, progresso, trilha ou backlog de aprendizagem;
- topicos vindos de digest, email, conversa, erro ou documentacao;
- duvida sobre mover algo para `done`;
- risco de inflar progresso sem evidencia.

Nao usar para capturar curiosidade solta sem pergunta, nem para transformar tudo em backlog infinito.

## Status

- `capturado`: entrou via email, conversa, leitura ou problema real.
- `em-estudo`: ja tem perguntas abertas e material para revisar.
- `aplicando`: foi usado em um artefato pequeno neste workspace.
- `done`: voce consegue explicar, repetir e usar sem cola.

## Saida padrao

Quando apresentar a trilha, usar uma tabela compacta:

| Topico | Status | Evidencia | Proximo passo | Risco de falso done |
| --- | --- | --- | --- | --- |

Cada item deve ter exatamente um proximo passo. Se nao houver proximo passo concreto, o item volta para `capturado` ou e descartado.

## Done gate

Marque `done` so quando as tres respostas forem "sim":

- Eu consigo explicar em 3 a 5 frases sem abrir referencia?
- Eu consigo aplicar isso em um artefato pequeno aqui no workspace?
- Eu sei quando nao usar isso?

Se houver apenas explicacao sem aplicacao, fica em `em-estudo`.
Se houver aplicacao unica ainda fragil, fica em `aplicando`.
Se a evidencia depende de memoria contextual ou cockpit privado, nao vira candidato.

## Fontes validas

- digest de email;
- friccao real do workspace;
- experimento documentado em `shadow/` ou `Prometeus/wiki/Notes`;
- documentacao que respondeu uma pergunta concreta.

## Workflow

1. Capturar topico e origem.
2. Formular uma pergunta de aprendizagem em linguagem operacional.
3. Classificar no menor status honesto.
4. Registrar evidencia real, nao intencao.
5. Definir um unico proximo passo.
6. Revisar `done` com o gate de tres perguntas.

## Antipadroes

- acumular topico sem pergunta;
- marcar `done` so porque leu;
- mover para o repo principal antes de aplicar localmente;
- transformar curiosidade em backlog infinito.

## Rubric

Score minimo pass = 0.7 (de 1.0). Rodar apos cada execucao em uso real e registrar resultado em `shadow/EVIDENCE-LOG.md` coluna Observacao.

| Dimensao | Peso | 0 | 1 | 2 |
| --- | --- | --- | --- | --- |
| Tabela compacta | 0.25 | ausente ou mal formada | tabela incompleta | topico/status/evidencia/proximo/risco todos preenchidos |
| Status conservador | 0.25 | done sem evidencia | status otimista demais | menor status honesto (`capturado` ou `em-estudo`) preferido |
| Proximo passo unico | 0.25 | ausente ou multiplo | vago | um unico passo concreto e executavel |
| Done gate aplicado | 0.25 | done com 0-1 sim do gate | done com 2 sim | 3 sim do gate (explicar, aplicar, saber nao usar) |

Formula: `score = 0.25 * soma(niveis)/8`. Normalizar cada dimensao para 0-1 (dividir nivel por 2).

## Mini-evals

| Caso | Prompt | Esperado |
| --- | --- | --- |
| progresso inflado | "Li sobre MCP e quero marcar done." | negar `done` se nao houver explicacao, aplicacao e criterio de nao uso |
| topicos de digest | "Esses emails trouxeram 6 conceitos novos; organize a trilha." | tabela com status conservador e um proximo passo por item |
| aplicacao local | "Usei isso para melhorar o harness; pode virar done?" | aceitar apenas se a aplicacao for explicavel e repetivel |

Coautoria: Lucas + GPT-5.4 (Codex)

