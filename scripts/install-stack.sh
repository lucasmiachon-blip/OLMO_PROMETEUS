#!/usr/bin/env bash
# install-stack.sh - Stack diagnostic for OLMO_PROMETEUS.
# Idempotente, sem sudo, sem auto-install. Reporta status de cada tool.
# Uso: ./scripts/install-stack.sh

set -u

ok() { printf "  [OK]   %-12s %s\n" "$1" "$2"; }
miss() { printf "  [MISS] %-12s %s\n" "$1" "$2"; }

check_tool() {
  local tool="$1" version_flag="$2" install_hint="$3"
  local path version
  path="$(command -v "$tool" 2>/dev/null || true)"
  if [[ -n "$path" ]]; then
    version="$("$tool" $version_flag 2>&1 | head -1 | tr -d '\r')"
    ok "$tool" "$version  ($path)"
  else
    miss "$tool" "install: $install_hint"
  fi
}

printf "Stack check: OLMO_PROMETEUS\n\n"

printf "Core shell + git:\n"
check_tool bash    "--version" "system; should be 5.x"
check_tool git     "--version" "sudo apt install -y git"
check_tool jq      "--version" "sudo apt install -y jq"
check_tool rg      "--version" "https://github.com/BurntSushi/ripgrep/releases (user-space tar)"
check_tool gh      "--version" "https://cli.github.com/"

printf "\nAgent CLIs:\n"
check_tool claude  "--version" "npm install -g @anthropic-ai/claude-code"
check_tool codex   "--version" "npm install -g @openai/codex-cli"
check_tool gemini  "--version" "npm install -g @google/gemini-cli"

printf "\nPython (uv + ruff):\n"
check_tool uv      "--version" "curl -LsSf https://astral.sh/uv/install.sh | sh"
check_tool ruff    "--version" "uv tool install ruff"
check_tool python3 "--version" "system"

printf "\nNode/JS (pnpm + biome + bun):\n"
check_tool node    "--version" "system or volta/fnm"
check_tool pnpm    "--version" "npm install -g pnpm"
check_tool biome   "--version" "npm install -g @biomejs/biome"
check_tool bun     "--version" "curl -fsSL https://bun.sh/install | bash  (precisa unzip)"

printf "\nTerminal/UX:\n"
check_tool zellij  "--version" "https://github.com/zellij-org/zellij/releases (user-space tar)"

printf "\nManifests no repo:\n"
[[ -f biome.json ]]                       && ok "biome.json" "raiz" || miss "biome.json" "novo manifesto"
[[ -f lab/wiki-graph-lab/pyproject.toml ]] && ok "pyproject"  "lab/wiki-graph-lab/" || miss "pyproject" "novo manifesto"
[[ -f lab/wiki-graph-lab/uv.lock ]]       && ok "uv.lock"    "lab/wiki-graph-lab/" || miss "uv.lock"   "uv pip compile pyproject.toml -o uv.lock"

printf "\nDone.\n"
