# Foundation

Objetivo: fortalecer a base do open OLMO_PROMETEUS sem criar infraestrutura falsa.

Esta base cobre quatro camadas: infra, memoria, harness e orquestracao.

## Regra fundamental

Nunca escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.

Isso inclui scripts, hooks, automacoes, conectores, agentes, shell commands e edicoes manuais. Se uma tarefa exigir write externo, parar e pedir autorizacao explicita com caminho e acao exata.

## 1. Infra

O repo e um laboratorio isolado. A infraestrutura minima e:

- Git local limpo e commits pequenos.
- `AGENTS.md` como contrato operacional.
- `PROJECT_CONTRACT.md` como limite de risco.
- `TREE.md` como mapa profissional da arvore e da politica de incorporacao segura.
- `shadow/` para decisoes, gates e memoria operacional.
- `Prometeus/.obsidian/` para configurar o vault Obsidian `Prometeus`.
- `Prometeus/wiki/` para notas Obsidian e conhecimento duravel.
- `private-learning/` para interface e material pessoal.
- `scripts/check.ps1` como harness local.

Nao existe sincronizacao automatica com `C:\Dev\Projetos\OLMO`.

## 2. Sem scaffolds fantasmas

Diretorios locais de agents, subagents, skills, hooks e playground ficam fora do core.

Motivo: no nosso ambiente Windows e neste repo pequeno, scaffolds sem runtime real confundem memoria, contexto e decisao.

O caminho seguro e:

1. Primeiro, comando manual.
2. Depois, harness repetivel.
3. So depois de uso recorrente, considerar novo diretorio ou automacao.

Regra: nenhum hook pode tocar `C:\Dev\Projetos\OLMO`, arquivar email, mover arquivo sensivel ou fazer qualquer write externo sem autorizacao humana explicita.

## 3. Memoria

Memoria nao e conversa solta. Memoria operacional precisa morar em arquivo certo:

- contrato vivo: `AGENTS.md`;
- limites do projeto: `PROJECT_CONTRACT.md`;
- decisoes SOTA: `shadow/SOTA-DECISIONS.md`;
- incorporacoes: `shadow/INCORPORATION-LOG.md`;
- higiene: `shadow/HYGIENE.md`;
- entrada do vault: `Prometeus/README.md`;
- wiki navegavel: `Prometeus/wiki/Home.md`;
- material pessoal local e ignorado: `private-learning/`.

Regra: se uma memoria nao muda comportamento futuro, ela nao entra no repo.

## 4. Harness

O harness local e:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\check.ps1
```

Ele valida:

- arquivos essenciais;
- estrutura basica do Obsidian vault `Prometeus`;
- cross-references do Obsidian: `[[wikilinks]]`, aliases e arquivos referenciados em Canvas;
- evals JSON das skills;
- ausencia de referencias antigas;
- ausencia de tokens/segredos obvios;
- `private-learning` gerado continua ignorado;
- ausencia de scaffolds fantasmas na raiz;
- Git status legivel.

O harness nao substitui revisao humana. Ele evita regressao boba.

## 5. Orquestracao

Loop padrao:

1. Capturar materia-prima.
2. Escolher uma acao pequena.
3. Produzir artefato persistente.
4. Rodar harness.
5. Classificar em `private`, `experiment` ou `candidate`.
6. Comitar se a mudanca tiver valor.

Delegacao:

- Codex orquestra e edita.
- Leituras auxiliares podem ser feitas por subagentes externos apenas quando a conversa justificar.
- Gemini entra para pesquisa longa/multimodal somente com objetivo, trigger, artefato, custo e risco.

Sem fan-out automatico e sem registry local de agentes neste repo.

## Barra de promocao

Algo so sobe de nivel quando tem:

- uso repetido;
- trigger claro;
- artefato claro;
- rollback;
- risco conhecido;
- harness passando;
- aprovacao humana antes de qualquer conversa sobre OLMO.

Coautoria: Lucas + GPT-5.4 (Codex)
