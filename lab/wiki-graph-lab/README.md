# Wiki Graph Lab

Experimento reversivel para responder uma pergunta real:

> conseguimos deixar a leitura da wiki mais bonita e mais util do que o graph cru, com preview perto do no e Markdown mais legivel?

## Pergunta concreta

Como transformar as notas do `Prometeus/wiki/` em uma interface mais bonita e navegavel, com:

- grafo com cores melhores;
- clusters por dominio;
- card contextual perto do no;
- leitura de Markdown com tipografia melhor;
- navegacao por wikilinks sem depender do graph view cru.

## Artefato esperado

- `index.html` aberto localmente;
- `graph-data.js` gerado a partir das notas reais do vault `Prometeus`;
- preview card ancorado ao no;
- painel lateral com conteudo renderizado do Markdown.

## Custo maximo

- HTML/CSS/JS vanilla;
- Python stdlib para gerar dataset;
- zero dependencia nova.

## Risco e blast radius

- baixo;
- fica isolado em `lab/wiki-graph-lab/`;
- nao vira dependencia do repo principal sem validacao humana.

## Criterio de descarte ou promocao

- descartar se o preview nao melhorar navegacao real;
- manter em `lab/wiki-graph-lab/` enquanto reduzir friccao de leitura; qualquer promocao precisa continuar dentro do Prometeus.

## Como usar

```powershell
python .\build_graph_data.py
start .\index.html
```

Se o dataset mudar, rode o script de novo.

Coautoria: Lucas + GPT-5.4 (Codex)

