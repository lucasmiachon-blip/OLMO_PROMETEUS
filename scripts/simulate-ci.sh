#!/usr/bin/env bash
set -u

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$root" || exit 1

target_os="${1:-linux}"

case "$target_os" in
  linux|Linux|ubuntu|Ubuntu)
    runner_os="Linux"
    ;;
  windows|Windows)
    printf '[FAIL] local WSL CI simulation cannot execute the GitHub Windows runner.\n'
    printf '[INFO] run GitHub Actions for windows-latest, or keep this as a documented remote-only leg.\n'
    exit 1
    ;;
  *)
    printf '[FAIL] unknown simulate-ci target: %s\n' "$target_os"
    printf 'Usage: scripts/simulate-ci.sh [linux]\n'
    exit 1
    ;;
esac

printf '[INFO] Simulating Self Evolution workflow locally for RUNNER_OS=%s\n' "$runner_os"
printf '[INFO] Workflow remains read-only: checkout is represented by current working tree.\n'

export CI=true
export GITHUB_ACTIONS=true
export GITHUB_WORKFLOW="Self Evolution"
export GITHUB_EVENT_NAME="workflow_dispatch"
export RUNNER_OS="$runner_os"

printf '[STEP] Harness\n'
./scripts/check.sh
check_status=$?
if [[ "$check_status" -ne 0 ]]; then
  printf '[FAIL] Harness step failed with exit code %s\n' "$check_status"
  exit "$check_status"
fi

printf '[STEP] Next evolution batch\n'
./scripts/evolve.sh next
evolve_status=$?
if [[ "$evolve_status" -ne 0 ]]; then
  printf '[FAIL] Next evolution batch step failed with exit code %s\n' "$evolve_status"
  exit "$evolve_status"
fi

printf '[OK] Local CI simulation passed for RUNNER_OS=%s\n' "$runner_os"
