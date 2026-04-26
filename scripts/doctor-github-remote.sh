#!/usr/bin/env bash
set -u

apply=0
if [[ "${1:-}" == "--apply" ]]; then
  apply=1
fi

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$root" || exit 1

ok() { printf '[OK] %s\n' "$1"; }
warn() { printf '[WARN] %s\n' "$1"; }
fail() { printf '[FAIL] %s\n' "$1"; }
info() { printf '[INFO] %s\n' "$1"; }

current_branch="$(git branch --show-current)"
origin_url="$(git remote get-url origin 2>/dev/null || true)"
helper="$(git config --local --get credential.helper || true)"

printf 'branch=%s\n' "$current_branch"
printf 'origin=%s\n' "${origin_url:-missing}"
printf 'credential.helper=%s\n' "${helper:-unset}"

if [[ "$current_branch" != "feat/ubuntu-runtime-prometeus" ]]; then
  warn "expected feature branch feat/ubuntu-runtime-prometeus"
else
  ok "on feature branch"
fi

if [[ "$origin_url" == "https://github.com/lucasmiachon-bip/OLMO_PROMETEUS.git" ]]; then
  warn "origin uses HTTPS; WSL is currently coupled to credential helper behavior"
elif [[ "$origin_url" == "git@github.com:lucasmiachon-bip/OLMO_PROMETEUS.git" ]]; then
  ok "origin uses SSH"
else
  warn "origin URL is unexpected: ${origin_url:-missing}"
fi

if [[ "$helper" == *"/mnt/c/Program Files/"* ]]; then
  fail "local credential.helper points to Windows Git Credential Manager path with spaces; this breaks in WSL"
  if [[ "$apply" -eq 1 ]]; then
    git config --local --unset credential.helper || true
    ok "removed local credential.helper"
  else
    info "run ./scripts/doctor-github-remote.sh --apply to remove the local broken helper"
  fi
elif [[ -n "$helper" ]]; then
  warn "local credential.helper is set: $helper"
else
  ok "no local credential.helper override"
fi

ssh_ready=0
if [[ -d "$HOME/.ssh" ]] && compgen -G "$HOME/.ssh/*.pub" >/dev/null; then
  ok "SSH public key exists in WSL"
  ssh_ready=1
else
  warn "no SSH public key found in WSL"
fi

if [[ "$apply" -eq 1 && "$ssh_ready" -eq 1 ]]; then
  git remote set-url origin git@github.com:lucasmiachon-bip/OLMO_PROMETEUS.git
  ok "origin switched to SSH"
elif [[ "$apply" -eq 1 ]]; then
  warn "origin not switched to SSH because no WSL SSH public key was found"
fi

ahead_behind="$(git rev-list --left-right --count main...HEAD)"
printf 'main...HEAD=%s\n' "$ahead_behind"
if [[ "$ahead_behind" == "0	"* ]]; then
  ok "local merge into main is fast-forward relative to local main"
else
  warn "local main and feature branch diverged; inspect before merge"
fi

if git status --short --untracked-files=no | grep -q .; then
  warn "tracked working tree has changes"
else
  ok "tracked working tree is clean"
fi

cat <<'EOF'

Robust WSL GitHub path:

1. Create or reuse an SSH key inside WSL:
   ssh-keygen -t ed25519 -C "lucasmiachon87@gmail.com"

2. Add the public key to GitHub:
   cat ~/.ssh/id_ed25519.pub
   GitHub -> Settings -> SSH and GPG keys -> New SSH key

3. Trust GitHub host key and test:
   ssh -T git@github.com

4. Apply repo-local Git cleanup and SSH remote:
   ./scripts/doctor-github-remote.sh --apply

5. Push the feature branch:
   git push -u origin feat/ubuntu-runtime-prometeus

6. After remote CI passes, merge:
   git switch main
   git merge --ff-only feat/ubuntu-runtime-prometeus
   ./scripts/check.sh --strict
EOF
