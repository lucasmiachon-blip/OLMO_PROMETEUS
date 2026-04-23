# Hooks

Este diretorio e intencionalmente inativo.

Ele existe para documentar ideias de lifecycle e scripts manuais antes de qualquer hook ser registrado. A referencia veio da disciplina do `OLMO`, mas sem copiar os hooks ativos, settings, logs ou guardas sensiveis.

## Estado Atual

- Nenhum hook ativo.
- Nenhum script aqui roda automaticamente.
- Nenhum arquivo daqui deve escrever fora de `C:\Dev\Projetos\OLMO_PROMETEUS`.
- Scripts futuros com comportamento destrutivo, externo ou automatico exigem aprovacao humana explicita.

## Gate Para Promover Um Hook

Antes de um hook deixar de ser documentacao ou script manual, registrar:

| Criterio | Regra minima |
| --- | --- |
| objetivo | que falha recorrente ele evita |
| trigger | em qual evento ele roda |
| artefato | qual arquivo ou saida produz |
| custo | limite de tempo, ruido e manutencao |
| risco | quais writes, bloqueios ou falsos positivos pode causar |
| rollback | como desativar sem dano |

## Ordem Segura

1. Documentar a ideia.
2. Criar comando manual pequeno, se necessario.
3. Rodar manualmente em algumas sessoes.
4. Colocar no harness se for estavel.
5. So entao discutir hook ativo.

## Proibido Por Padrao

- Escrever em `C:\Dev\Projetos\OLMO`.
- Arquivar, mover ou marcar email.
- Gravar segredos, tokens ou configs locais.
- Registrar hook automaticamente.
- Depender de MCP sensivel ou settings locais.

Coautoria: Lucas + GPT-5.4 (Codex)
