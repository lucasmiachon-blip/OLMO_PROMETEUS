# GitHub Remote WSL

Status: operational procedure

Objetivo: publicar `feat/ubuntu-runtime-prometeus` no remoto sem depender do Git Credential Manager do Windows.

## Diagnostico atual

- Branch local pronto: `feat/ubuntu-runtime-prometeus`.
- `main...HEAD` local: `0 6`, ou seja, o branch esta 6 commits a frente do `main` local sem divergencia local.
- `origin` usa HTTPS.
- `credential.helper` local aponta para `/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe`, que quebra no WSL por caminho com espaco e falta de credencial interativa.
- `gh` nao esta logado no WSL.

## Decisao

Usar SSH nativo do WSL para Git remoto. Nao usar Credential Manager do Windows dentro deste repo.

Motivo: SSH no WSL evita dependencia de GUI, browser, helper Windows e path `/mnt/c/Program Files/...`.

## Procedimento

1. Rodar diagnostico:

```bash
./scripts/doctor-github-remote.sh
```

2. Criar chave SSH no WSL, se ainda nao existir:

```bash
ssh-keygen -t ed25519 -C "lucas.miachon@fm.usp.br"
```

3. Adicionar a chave publica no GitHub:

```bash
cat ~/.ssh/id_ed25519.pub
```

GitHub: Settings -> SSH and GPG keys -> New SSH key.

4. Testar SSH:

```bash
ssh -T git@github.com
```

5. Aplicar ajuste local do repo:

```bash
./scripts/doctor-github-remote.sh --apply
```

Isso remove o helper quebrado do config local e troca `origin` para:

```text
git@github.com:lucasmiachon-bip/OLMO_PROMETEUS.git
```

6. Publicar branch:

```bash
git push -u origin feat/ubuntu-runtime-prometeus
```

## Merge depois do remoto

Quando o branch remoto existir e o workflow passar:

```bash
git switch main
git merge --ff-only feat/ubuntu-runtime-prometeus
./scripts/check.sh --strict
```

## Criterio negativo

Nao fazer merge se:

- branch remoto nao existe;
- workflow remoto falhou;
- `main...HEAD` deixou de ser fast-forward;
- `./scripts/check.sh --strict` falha;
- houver dado sensivel, PHI ou arquivo local ignorado sendo versionado.

Coautoria: Lucas + GPT-5.4 xhigh (Codex)
