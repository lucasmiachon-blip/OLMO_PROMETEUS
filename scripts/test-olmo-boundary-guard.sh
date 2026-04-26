#!/usr/bin/env bash
set -u

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
guard="${root}/scripts/guard-olmo-write-hook.sh"
failures=()

fail() { failures+=("$1"); }

run_guard() {
  printf '%s' "$1" | "$guard"
}

decision() {
  jq -r '.hookSpecificOutput.permissionDecision // empty'
}

assert_decision() {
  local name="$1" payload="$2" expected="$3" output actual
  output="$(run_guard "$payload")"
  if [[ -z "$output" ]]; then
    fail "$name expected $expected output, got empty"
    return
  fi
  if ! jq empty >/dev/null 2>&1 <<<"$output"; then
    fail "$name expected valid JSON output, got: $output"
    return
  fi
  actual="$(decision <<<"$output")"
  [[ "$actual" == "$expected" ]] || fail "$name expected permissionDecision=$expected, got: $actual"
}

assert_blocked() { assert_decision "$1" "$2" "deny"; }
assert_asked() { assert_decision "$1" "$2" "ask"; }

assert_allowed() {
  local name="$1" payload="$2" output
  output="$(run_guard "$payload")"
  [[ -z "$output" ]] || fail "$name expected empty allow output, got: $output"
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
linux_sibling="$(dirname "$repo_root")/OLMO"

assert_blocked "absolute OLMO write path" '{"tool_name":"Write","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO\\HANDOFF.md"}}'
assert_asked "absolute OLMO read path" '{"tool_name":"Read","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO\\README.md"}}'
assert_blocked "relative sibling OLMO write path" '{"tool_name":"Shell","tool_input":{"command":"Set-Content ..\\OLMO\\probe.txt test"}}'
assert_asked "relative sibling OLMO read path" '{"tool_name":"Shell","tool_input":{"command":"Get-Content ..\\OLMO\\README.md"}}'
assert_blocked "forward slash OLMO write path" '{"tool_name":"Write","tool_input":{"file_path":"C:/Dev/Projetos/OLMO/HANDOFF.md"}}'
assert_blocked "case-insensitive OLMO write path" '{"tool_name":"Write","tool_input":{"file_path":"c:\\dev\\projetos\\olmo\\HANDOFF.md"}}'
assert_blocked "absolute OLMO sibling cowork write path" '{"tool_name":"Write","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO_COWORK\\README.md"}}'
assert_blocked "relative OLMO sibling cowork write path" '{"tool_name":"Shell","tool_input":{"command":"Set-Content ..\\OLMO_COWORK\\probe.txt test"}}'
assert_asked "workdir OLMO sibling cowork read path" '{"tool_name":"Shell","tool_input":{"command":"cat ./HANDOFF.md","workdir":"C:\\Dev\\Projetos\\OLMO_COWORK"}}'
assert_blocked "workdir OLMO sibling cowork write path" '{"tool_name":"Shell","tool_input":{"command":"echo test > ./probe.txt","workdir":"C:\\Dev\\Projetos\\OLMO_COWORK"}}'
assert_asked "absolute OLMO sibling cowork typo read path" '{"tool_name":"Read","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO_COWOR\\README.md"}}'
assert_blocked "absolute OLMO sibling cowork typo write path" '{"tool_name":"Write","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO_COWOR\\README.md"}}'
assert_asked "absolute legacy workspace read path" '{"tool_name":"Read","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO_ROADMAP\\README.md"}}'
assert_blocked "absolute legacy workspace write path" '{"tool_name":"Write","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO_ROADMAP\\README.md"}}'
assert_blocked "relative legacy workspace write path" '{"tool_name":"Shell","tool_input":{"command":"Set-Content ..\\OLMO_ROADMAP\\probe.txt test"}}'
assert_blocked "invalid JSON fail-closed" '{not-json'
assert_allowed "absolute OLMO_PROMETEUS path" '{"tool_name":"Write","tool_input":{"file_path":"C:\\Dev\\Projetos\\OLMO_PROMETEUS\\README.md"}}'
assert_allowed "forward slash OLMO_PROMETEUS path" '{"tool_name":"Write","tool_input":{"file_path":"C:/Dev/Projetos/OLMO_PROMETEUS/README.md"}}'
assert_asked "absolute Linux sibling OLMO read path" "{\"tool_name\":\"Read\",\"tool_input\":{\"file_path\":\"${linux_sibling}/README.md\"}}"
assert_blocked "absolute Linux sibling OLMO write path" "{\"tool_name\":\"Write\",\"tool_input\":{\"file_path\":\"${linux_sibling}/HANDOFF.md\"}}"
assert_allowed "absolute Linux OLMO_PROMETEUS path" "{\"tool_name\":\"Write\",\"tool_input\":{\"file_path\":\"${repo_root}/README.md\"}}"

if ((${#failures[@]} > 0)); then
  printf '[FAIL] %s\n' "${failures[@]}"
  exit 1
fi

printf '[OK] OLMO boundary guard tests pass\n'
