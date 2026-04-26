# Incident Log

Status: operational guard

Objetivo: registrar incidentes ou quase-incidentes sem copiar conteudo sensivel.

## Regra

Nunca colar segredo, PHI, dado pessoal, trecho de prontuario, email real, print, PDF ou identificador neste arquivo.

Registrar so metadado suficiente para auditoria e aprendizado.

## Schema

| Data | Classe | Origem geral | Evento | Acao tomada | Status | Proximo |
| --- | --- | --- | --- | --- | --- | --- |

## Entradas

| Data | Classe | Origem geral | Evento | Acao tomada | Status | Proximo |
| --- | --- | --- | --- | --- | --- | --- |
| 2026-04-26 | ci-auth | GitHub remoto | `EV-B2` nao validou runs remotos: `gh` sem login; `git ls-remote` no sandbox falhou DNS; fora do sandbox tentou Git Credential Manager Windows em `/mnt/c/Program Files/...` e nao obteve usuario | Bloqueio documentado; sem branch protection por enquanto | blocked | Autenticar `gh` com permissao read-only; repetir `gh run list` e decidir branch protection |

## Fontes

- NIST SP 800-61 Rev. 3: `https://csrc.nist.gov/pubs/sp/800/61/r3/final`

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
