param(
  [switch]$DryRun,
  [ValidateSet("All", "Random", "CASE_edges", "ProtectedRepoWrite", "LegacyWorkspaceWrite", "InvalidHookJson", "MissingBaselineCandidate", "MissingRollbackCandidate", "MissingLearningEvidence", "MissingRegressionCase", "PrometeusLookalikeAllowed", "ForwardSlashProtectedRepo", "CaseInsensitiveProtectedRepo", "SiblingCoworkWrite", "RelativeSiblingCoworkWrite")]
  [string]$Scenario = "All",
  [int]$Seed = 42
)

$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $Root

. (Join-Path $PSScriptRoot "lib/powershell-runner.ps1")

$Failures = [System.Collections.Generic.List[string]]::new()
$EdgeScenarioCatalog = @(
  "PrometeusLookalikeAllowed",
  "ForwardSlashProtectedRepo",
  "CaseInsensitiveProtectedRepo",
  "SiblingCoworkWrite",
  "RelativeSiblingCoworkWrite"
)

$ScenarioCatalog = @(
  "ProtectedRepoWrite",
  "LegacyWorkspaceWrite",
  "InvalidHookJson",
  "MissingBaselineCandidate",
  "MissingRollbackCandidate",
  "MissingLearningEvidence",
  "MissingRegressionCase"
) + $EdgeScenarioCatalog

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

function Invoke-Guard {
  param([object]$Payload)

  $guardScript = ".\scripts\guard-olmo-write-hook.ps1"
  if ($Payload -is [string]) {
    $json = $Payload
  } else {
    $json = $Payload | ConvertTo-Json -Depth 10
  }

  return [string](Invoke-RepoPowerShell -File $guardScript -InputText $json)
}

function Assert-GuardBlocks {
  param(
    [string]$Name,
    [object]$Payload,
    [string]$ReasonPattern
  )

  $output = Invoke-Guard -Payload $Payload
  if ([string]::IsNullOrWhiteSpace($output)) {
    Add-Failure "$Name expected guard block, got allow"
    return
  }

  try {
    $parsed = $output | ConvertFrom-Json
  } catch {
    Add-Failure "$Name expected JSON guard output, got: $output"
    return
  }

  if ($parsed.hookSpecificOutput.permissionDecision -ne "deny") {
    Add-Failure "$Name expected permissionDecision=deny, got: $($parsed.hookSpecificOutput.permissionDecision)"
  }

  $reason = [string]$parsed.hookSpecificOutput.permissionDecisionReason
  if ($reason -notmatch $ReasonPattern) {
    Add-Failure "$Name expected reason matching '$ReasonPattern', got: $reason"
  }
}

function Assert-GuardAllows {
  param(
    [string]$Name,
    [object]$Payload
  )

  $output = Invoke-Guard -Payload $Payload
  if (-not [string]::IsNullOrWhiteSpace($output)) {
    Add-Failure "$Name expected guard allow, got: $output"
  }
}

function Assert-CommandPasses {
  param(
    [string]$Name,
    [string[]]$CommandArgs
  )

  Invoke-CurrentPowerShell -Arguments $CommandArgs
  if ($LASTEXITCODE -ne 0) {
    Add-Failure "$Name failed with exit code $LASTEXITCODE"
  }
}

function Test-GateCandidate {
  param([hashtable]$Candidate)

  foreach ($field in @("baseline", "contract", "artifact", "test", "failure", "observability", "blast_radius", "rollback")) {
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

function Assert-GateRejects {
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

function New-ValidCandidate {
  return @{
    baseline = "single procedure insufficient"
    contract = "trigger, non-trigger, tools"
    artifact = "shadow/example.md"
    test = "positive and negative case"
    failure = "fail-closed"
    observability = "EVIDENCE-LOG entry"
    blast_radius = "only C:\Dev\Projetos\OLMO_PROMETEUS"
    rollback = "delete artifact"
  }
}

function Invoke-FaultScenario {
  param([string]$Name)

  Write-Host "[INFO] scenario=$Name" -ForegroundColor Cyan

  switch ($Name) {
    "ProtectedRepoWrite" {
      $protectedRepoPath = "C:\Dev\Projetos\" + "OLMO" + "\HANDOFF.md"
      Assert-GuardBlocks "detect protected repo write injection" @{
        tool_name = "Write"
        tool_input = @{ file_path = $protectedRepoPath }
      } "Write externo|sibling OLMO externo|nao pode tocar"
    }
    "LegacyWorkspaceWrite" {
      $legacyWorkspacePath = "C:\Dev\Projetos\" + "OLMO" + "_ROADMAP\README.md"
      Assert-GuardBlocks "detect stale workspace write injection" @{
        tool_name = "Write"
        tool_input = @{ file_path = $legacyWorkspacePath }
      } "Write externo|Workspace legado|stale"
    }
    "InvalidHookJson" {
      Assert-GuardBlocks "detect invalid hook JSON injection" "{not-json" "JSON invalido|fail-closed"
    }
    "MissingBaselineCandidate" {
      $candidate = New-ValidCandidate
      $candidate.Remove("baseline")
      Assert-GateRejects "detect missing baseline candidate" $candidate "missing baseline"
    }
    "MissingRollbackCandidate" {
      $candidate = New-ValidCandidate
      $candidate.Remove("rollback")
      Assert-GateRejects "detect missing rollback candidate" $candidate "missing rollback"
    }
    "MissingLearningEvidence" {
      Require-Text "shadow/EVIDENCE-LOG.md" "boundary-guard" "failure evidence log"
      Require-Text "shadow/EVIDENCE-LOG.md" "antifragile-learning" "learning-loop evidence log"
    }
    "MissingRegressionCase" {
      Require-Text "scripts/check.ps1" "legacyWorkspaceRoot" "future stale workspace detector"
      Require-Text "scripts/test-olmo-boundary-guard.ps1" "absolute legacy workspace read path" "regression case for stale workspace"
      Require-Text "scripts/test-antifragile-learning.ps1" "ScenarioCatalog" "fault catalog regression case"
      Require-Text "scripts/test-antifragile-learning.ps1" "CASE_edges" "edge-case catalog regression case"
    }
    "PrometeusLookalikeAllowed" {
      Assert-GuardAllows "allow canonical Prometeus lookalike path" @{
        tool_name = "Write"
        tool_input = @{ file_path = "C:/Dev/Projetos/OLMO_PROMETEUS/README.md" }
      }
    }
    "ForwardSlashProtectedRepo" {
      Assert-GuardBlocks "detect forward slash protected repo path" @{
        tool_name = "Write"
        tool_input = @{ file_path = "C:/Dev/Projetos/OLMO/HANDOFF.md" }
      } "Write externo|sibling OLMO externo|nao pode tocar"
    }
    "CaseInsensitiveProtectedRepo" {
      Assert-GuardBlocks "detect case-insensitive protected repo path" @{
        tool_name = "Write"
        tool_input = @{ file_path = "c:\dev\projetos\olmo\HANDOFF.md" }
      } "Write externo|sibling OLMO externo|nao pode tocar"
    }
    "SiblingCoworkWrite" {
      $coworkPath = "C:\Dev\Projetos\" + "OLMO" + "_COWORK\README.md"
      Assert-GuardBlocks "detect sibling cowork write" @{
        tool_name = "Write"
        tool_input = @{ file_path = $coworkPath }
      } "Write externo|sibling OLMO"
    }
    "RelativeSiblingCoworkWrite" {
      Assert-GuardBlocks "detect relative sibling cowork write" @{
        tool_name = "PowerShell"
        tool_input = @{ command = ("Set-Content ..\OLMO" + "_COWORK\probe.txt test") }
      } "Write externo|sibling OLMO"
    }
    "CASE_edges" {
      foreach ($edgeScenario in $EdgeScenarioCatalog) {
        Invoke-FaultScenario -Name $edgeScenario
      }
    }
    default {
      Add-Failure "unknown scenario: $Name"
    }
  }
}

if ($Scenario -eq "All") {
  $selectedScenarios = @($ScenarioCatalog)
} elseif ($Scenario -eq "CASE_edges") {
  $selectedScenarios = @("CASE_edges")
} elseif ($Scenario -eq "Random") {
  $random = [System.Random]::new($Seed)
  $selectedScenarios = @($ScenarioCatalog[$random.Next(0, $ScenarioCatalog.Count)])
} else {
  $selectedScenarios = @($Scenario)
}

Write-Host "[INFO] antifragile seed=$Seed scenario=$Scenario selected=$($selectedScenarios -join ',')" -ForegroundColor Cyan

foreach ($selectedScenario in $selectedScenarios) {
  Invoke-FaultScenario -Name $selectedScenario
}

Assert-CommandPasses "boundary regression test" @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", ".\scripts\test-olmo-boundary-guard.ps1")
Assert-CommandPasses "orchestration dry-run regression test" @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", ".\scripts\test-orchestration-e2e.ps1", "-DryRun")
Assert-CommandPasses "maturity executable learning check" @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", ".\scripts\maturity.ps1", "-Mode", "check")
Assert-CommandPasses "self-evolution learning check" @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", ".\scripts\evolve.ps1", "-Mode", "check")

Require-Text "AGENTS.md" "workspace legado ROADMAP" "operator learning rule"
Require-Text "CLAUDE.md" "Workspace stale" "Claude adapter learning rule"
Require-Text "GEMINI.md" "Workspace stale" "Gemini adapter learning rule"
Require-Text "shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md" "Learn from failure" "antifragile learning mechanism"
Require-Text "shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md" "Reduce repeat risk" "antifragile repeat-risk mechanism"
Require-Text "shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md" "Scenario Random" "documented random seeded scenario"
Require-Text "shadow/ORCHESTRATION-HARNESS-ANTIFRAGILE.md" "CASE_edges" "documented edge-case scenario"
Require-Text "internal/evolution/backlog.json" '"negative_criterion"' "backlog negative criteria"
Require-Text "internal/evolution/risk-register.json" '"R-PHI"' "risk register carries open critical risk"

if ($Failures.Count -gt 0) {
  foreach ($failure in $Failures) {
    Write-Host "[FAIL] $failure" -ForegroundColor Red
  }
  exit 1
}

$mode = if ($DryRun) { "dry-run" } else { "test" }
Write-Host "[OK] antifragile learning-loop $mode pass scenario=$Scenario seed=$Seed selected=$($selectedScenarios -join ',')" -ForegroundColor Green
exit 0