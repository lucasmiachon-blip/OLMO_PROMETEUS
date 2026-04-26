#!/usr/bin/env bash
set -u

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$root" || exit 1

ok() { printf '[OK] %s\n' "$1"; }
warn() { printf '[WARN] %s\n' "$1"; }
fail() { printf '[FAIL] %s\n' "$1"; }
info() { printf '[INFO] %s\n' "$1"; }

current_branch="$(git branch --show-current)"
origin_url="$(git remote get-url origin 2>/dev/null || true)"
helper="$(git config --local --get credential.helper || true)"
expected_origin="https://github.com/lucasmiachon-blip/OLMO_PROMETEUS.git"

printf 'branch=%s\n' "$current_branch"
printf 'origin=%s\n' "${origin_url:-missing}"
printf 'credential.helper=%s\n' "${helper:-unset}"

if [[ "$current_branch" == "main" ]]; then
  ok "on main"
else
  warn "expected main"
fi

if [[ "$origin_url" == "$expected_origin" ]]; then
  ok "origin points to canonical OLMO_PROMETEUS remote"
else
  warn "origin URL is unexpected: ${origin_url:-missing}"
fi

if command -v gh >/dev/null 2>&1; then
  if gh auth status >/tmp/prometeus-gh-auth.txt 2>&1; then
    ok "gh auth status passes"
  else
    warn "gh is installed but not authenticated"
    sed -n '1,6p' /tmp/prometeus-gh-auth.txt
  fi
else
  warn "gh CLI not found"
fi

if [[ "$helper" == *"/mnt/c/Program Files/"* ]]; then
  fail "local credential.helper points to Windows Git Credential Manager path with spaces; this breaks in WSL"
elif [[ -n "$helper" ]]; then
  warn "local credential.helper is set: $helper"
else
  ok "no local credential.helper override"
fi

if git status --short --untracked-files=no | grep -q .; then
  warn "tracked working tree has changes"
else
  ok "tracked working tree is clean"
fi

cat <<'EOF'

Canonical GitHub path:

1. Authenticate gh if needed:
   gh auth login --hostname github.com --web --git-protocol https

2. If browser does not open in WSL:
   cmd.exe /c start "" "https://github.com/login/device"

3. Configure Git to use gh credentials:
   gh auth setup-git

4. If a push changes .github/workflows, add workflow scope:
   gh auth refresh --hostname github.com --scopes workflow

5. Publish canonical main:
   git push origin main
EOF
