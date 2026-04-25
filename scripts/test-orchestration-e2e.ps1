param([switch]$DryRun)

$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $Root

. (Join-Path $PSScriptRoot "lib/powershell-runner.ps1")

$Failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure {
  param([string]$Message)
  $Failures.Add($Message) | Out-Null
}

function Require-Text {
  param(
    [string]$Path,
    [string]$Pattern,
    [string]$Label
  )

  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    Add-Failure "$Label missing file: $Path"
    return
  }

  $text = Get-Content -LiteralPath $Path -Raw
  if ($text -notmatch $Pattern) {
    Add-Failure "$Label missing pattern: $Pattern in $Path"
  }
}

function Test-GateCandidate {
  param([hashtable]$Candidate)

  $required = @(
    "baseline",
    "contract",
    "artifact",
    "test",
    "failure",
    "observability",
    "blast_radius",
    "rollback"
  )

  foreach ($field in $required) {
    if (-not $Candidate.ContainsKey($field) -or [string]::IsNullOrWhiteSpace([string]$Candidate[$field])) {
      return "missing $field"
    }
  }

  $blastRadius = [string]$Candidate["blast_radius"]
  if ($blastRadius -match "C:\\Dev\\Projetos\\OLMO(?![_A-Za-z0-9])") {
    return "writes protected OLMO"
  }

  if ($blastRadius -notmatch "C:\\Dev\\Projetos\\OLMO_PROMETEUS") {
    return "missing Prometeus-only blast radius"
  }

  return "pass"
}

function Assert-GateCase {
  param(
    [string]$Name,
    [hashtable]$Candidate,
    [string]$Expected
  )

  $actual = Test-GateCandidate -Candidate $Candidate
  if ($actual -ne $Expected) {
    Add-Failure "$Name expected '$Expected', got '$actual'"
  }
}

$gate = "shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md"

Require-Text $gate "## E2E Gate" "gate doc"
Require-Text $gate "Baseline" "gate baseline"
Require-Text $gate "Contrato" "gate contract"
Require-Text $gate "Artefato" "gate artifact"
Require-Text $gate "Teste" "gate test"
Require-Text $gate "Falha" "gate failure"
Require-Text $gate "Observabilidade" "gate observability"
Require-Text $gate "Blast radius" "gate blast radius"
Require-Text $gate "Rollback" "gate rollback"
Require-Text $gate "pedido de multi-agent cedo" "gate mini-eval multi-agent"
Require-Text $gate "harness como teatro" "gate mini-eval harness"
Require-Text $gate "antifragile narrativo" "gate mini-eval antifragile"
Require-Text $gate "migracao para OLMO" "gate mini-eval OLMO"

Require-Text "shadow/AGENT-MODULES.md" "ORCHESTRATION-HARNESS-ANTIFRAGILE" "agent modules link"
Require-Text "shadow/FOUNDATION.md" "ORCHESTRATION-HARNESS-ANTIFRAGILE" "foundation link"
Require-Text "shadow/WORK-LANES.md" "Orchestration/harness/antifragile gate" "work lanes link"
Require-Text "shadow/INCORPORATION-LOG.md" "Orchestration/harness/antifragile gate" "incorporation log link"
Require-Text "shadow/EVIDENCE-LOG.md" "orquestracao/harness/antifragile" "evidence log link"
Require-Text "scripts/check.ps1" "test-orchestration-e2e\.ps1" "harness invokes e2e"

Assert-GateCase "reject missing baseline" @{
  contract = "trigger, non-trigger, tools"
  artifact = "shadow/example.md"
  test = "positive and negative case"
  failure = "fail-closed"
  observability = "EVIDENCE-LOG entry"
  blast_radius = "only C:\Dev\Projetos\OLMO_PROMETEUS"
  rollback = "delete artifact"
} "missing baseline"

Assert-GateCase "reject protected OLMO write" @{
  baseline = "single procedure insufficient"
  contract = "trigger, non-trigger, tools"
  artifact = "shadow/example.md"
  test = "positive and negative case"
  failure = "fail-closed"
  observability = "EVIDENCE-LOG entry"
  blast_radius = "caso proibido: writes C:\Dev\Projetos\OLMO"
  rollback = "delete artifact"
} "writes protected OLMO"

Assert-GateCase "accept local guarded workflow" @{
  baseline = "single procedure insufficient"
  contract = "trigger, non-trigger, tools"
  artifact = "shadow/example.md"
  test = "positive and negative case"
  failure = "fail-closed"
  observability = "EVIDENCE-LOG entry"
  blast_radius = "only C:\Dev\Projetos\OLMO_PROMETEUS"
  rollback = "delete artifact"
} "pass"

Invoke-RepoPowerShell -File "./scripts/test-olmo-boundary-guard.ps1"
if ($LASTEXITCODE -ne 0) {
  Add-Failure "OLMO boundary guard e2e dependency failed"
}

if ($Failures.Count -gt 0) {
  foreach ($failure in $Failures) {
    Write-Host "[FAIL] $failure" -ForegroundColor Red
  }
  exit 1
}

$mode = if ($DryRun) { "dry-run" } else { "test" }
Write-Host "[OK] orchestration/harness/antifragile E2E $mode pass" -ForegroundColor Green
exit 0
