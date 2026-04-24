# Email Digest em 4 Paragrafos

## Objetivo

Transformar inbox difusa em sinal operacional curto, recorrente e acionavel.

## Trigger

Usar este procedimento quando houver:

- emails, notas, updates ou bullets misturados que precisam virar leitura operacional;
- pedido de digest, morning brief, resumo executivo ou inbox synthesis;
- Gmail com `Prometeus/Alta` ou `Prometeus/Processar`;
- necessidade de decidir destino de prazos, estudo, experimento ou candidato.

Nao usar quando a entrada for uma unica pergunta simples, um documento que exige fichamento profundo ou material privado que nao deve gerar artefato.

## Contrato de entrada

Antes de escrever, separar a entrada em quatro pilhas:

- `sinal`: fatos, decisoes, prazos, pedidos e nomes concretos;
- `ruido`: repeticao, ansiedade, tom emocional bruto e mensagem sem acao;
- `incerteza`: coisa que parece importante mas ainda nao tem fonte, data ou dono;
- `destino`: prazo, estudo, experimento, candidato ou descarte.

Se faltar data, origem ou contexto suficiente para uma conclusao, marcar como incerteza em vez de completar por imaginacao.

## Cadencia

- `2 dias`: caixa quente ou semana de decisao.
- `3 dias`: padrao.
- `7 dias`: manutencao.
- `14 dias`: periodo calmo.

## Estrutura fixa

O output principal deve ter exatamente 4 paragrafos curtos.

1. `O que aconteceu`
   Fatos, movimentos, threads, reunioes, pedidos e contexto que realmente importam.
2. `Deadlines e cobrancas`
   O que vence, o que bloqueia, o que exige resposta e o que pode virar custo de atraso.
3. `Conceitos para estudar`
   Termos, sistemas, padroes, pessoas, ferramentas e referencias que entraram no radar.
4. `Filosofia e tensoes`
   O que os emails revelam sobre valores, identidade, medo, estrategia e direcao.

## Workflow

1. Deduplicar mensagens e remover ruido.
2. Processar `Prometeus/Alta` antes de `Prometeus/Processar`.
3. Agrupar por tema, decisao, bloqueio ou proxima acao.
4. Preservar nomes, datas, deadlines e links quando mudam a decisao.
5. Escrever os 4 paragrafos.
6. Fazer a conversao obrigatoria de destinos.
7. So marcar `Digerido` depois de artefato persistente.

## Conversao obrigatoria

Depois do digest, cada item precisa cair em um destino:

- `deadline`: entra no painel como prazo ou compromisso.
- `study track`: entra como topico a aprender com status visivel.
- `experimento`: vira nota curta em `shadow/` ou `Prometeus/wiki/Notes` quando a pergunta ainda estiver aberta.
- `candidato a migracao`: entra em `shadow/WORK-LANES.md` quando o padrao parecer reutilizavel.

## Labels Gmail

Gmail e fila de entrada, nao taxonomia duravel.

- `Prometeus/Processar`: fila normal.
- `Prometeus/Alta`: prioridade, compoe com a fila.
- `Prometeus/Ruido`: ignorar ou usar apenas para detectar padrao de ruido.
- `Prometeus/Digerido`: aplicar somente depois de artefato persistente.

Regra dura: um email so vira `Digerido` quando existir digest ou nota com data, origem/thread e sintese em 4 paragrafos.

## Done do digest

O digest esta completo quando:

- os 4 paragrafos existem;
- o artefato persistente existe, quando houver Gmail envolvido;
- nenhum prazo critico ficou sem destino;
- cada topico de estudo recebeu um status inicial;
- cada experimento tem artefato e risco;
- cada possivel migracao tem trigger documentado.

## Antipadroes

- Produzir lista longa em vez de 4 paragrafos densos.
- Copiar o tom bruto dos emails e chamar isso de sintese.
- Marcar `Digerido` so porque foi lido.
- Tratar Gmail como sistema de conhecimento duravel.
- Criar candidato sem trigger, risco e rollback.

## Rubric

Score minimo pass = 0.7 (de 1.0). Rodar apos cada execucao em uso real e registrar resultado em `shadow/EVIDENCE-LOG.md` coluna Observacao.

| Dimensao | Peso | 0 | 1 | 2 |
| --- | --- | --- | --- | --- |
| Signal vs noise | 0.3 | repete tom bruto dos emails | mistura fato com ruido | sinal destilado, ruido marcado explicitamente |
| Destinos convertidos | 0.3 | nada convertido | alguns itens sem destino | cada item tem destino (deadline, study, experimento ou candidato) |
| Brevidade (4P) | 0.2 | lista longa ou menos que 4 paragrafos | 3-5 paragrafos | exatamente 4 paragrafos densos |
| Gate "Digerido" | 0.2 | Digerido sem artefato persistente | artefato mas sem sintese dos 4P | artefato persistente com sintese 4P, data e origem |

Formula: `score = 0.3*signal + 0.3*destinos + 0.2*brevidade + 0.2*digerido`. Normalizar cada dimensao para 0-1 (dividir nivel por 2).

## Mini-evals

Use estes prompts para testar se o procedimento ainda funciona:

| Caso | Prompt | Esperado |
| --- | --- | --- |
| digest ruidoso | "Tenho emails, notas e cobrancas misturadas; gere um digest operacional para amanha." | exatamente 4 paragrafos, com ruido removido e proximos destinos |
| Gmail alta | "Triar `Prometeus/Alta` e `Prometeus/Processar`; depois marcar como `Digerido`." | processar alta primeiro e recusar `Digerido` sem artefato persistente |
| candidato | "Este padrao apareceu em varios emails; talvez migre para OLMO." | extrair trigger, evidencia, risco e mandar para `shadow/WORK-LANES.md` |

Coautoria: Lucas + GPT-5.4 (Codex)

