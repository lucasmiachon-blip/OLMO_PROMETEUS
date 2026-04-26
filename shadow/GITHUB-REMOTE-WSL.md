# GitHub Remote WSL

Status: operational procedure

Objetivo: diagnosticar e manter o Git remoto do `OLMO_PROMETEUS` no WSL sem depender de prompt interativo quebrado.

## Estado atual

- Branch ativo: `main`.
- Remoto esperado: `https://github.com/lucasmiachon-blip/OLMO_PROMETEUS.git`.
- Autenticacao funcional: GitHub CLI (`gh`) com `repo` e `workflow`, aplicado ao Git por `gh auth setup-git`.
- Push canonico: `git push origin main`.

## Diagnostico

```bash
./scripts/doctor-github-remote.sh
```

O diagnostico deve responder:

- branch atual;
- URL do `origin`;
- credential helper local;
- status de autenticacao do `gh` quando disponivel;
- status do working tree.

## Procedimento

1. Iniciar login OAuth:

```bash
gh auth login --hostname github.com --web --git-protocol https
```

2. Se o browser nao abrir no WSL, abrir manualmente pelo Windows:

```bash
cmd.exe /c start "" "https://github.com/login/device"
```

3. Depois de autorizar, configurar Git para usar o `gh`:

```bash
gh auth setup-git
```

4. Se o push alterar workflow, garantir escopo `workflow`:

```bash
gh auth refresh --hostname github.com --scopes workflow
```

5. Publicar `main`:

```bash
git push origin main
```

## Criterio negativo

Nao publicar se:

- `git status --short --branch` nao estiver entendido;
- `./scripts/check.sh` falhar;
- houver dado sensivel, PHI ou arquivo local ignorado sendo versionado;
- a mudanca tocar workflow e o token nao tiver escopo `workflow`.

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
