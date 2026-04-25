param(
  [ValidateSet("check", "report", "json", "next")]
  [string]$Mode = "check",
  [switch]$Strict
)

$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $Root

. (Join-Path $PSScriptRoot "lib/powershell-runner.ps1")

$Failures = New-Object System.Collections.Generic.List[string]
$Warnings = New-Object System.Collections.Generic.List[string]

function Add-Failure {
  param([string]$Message)
  $Failures.Add($Message) | Out-Null
}

function Add-Warning {
  param([string]$Message)
  $Warnings.Add($Message) | Out-Null
}

function Read-JsonFile {
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    Add-Failure "missing file: $Path"
    return $null
  }

  try {
    return Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
  } catch {
    Add-Failure "invalid JSON: $Path - $($_.Exception.Message)"
    return $null
  }
}

function Has-TextValue {
  param($Object, [string]$Field)
  if ($null -eq $Object) { return $false }
  $value = $Object.$Field
  return -not [string]::IsNullOrWhiteSpace([string]$value)
}

function Has-ArrayValue {
  param($Object, [string]$Field)
  if ($null -eq $Object) { return $false }
  return @($Object.$Field).Count -gt 0
}

function Invoke-MaturityJson {
  $maturityScript = "scripts/maturity.ps1"
  if (-not (Test-Path -LiteralPath $maturityScript -PathType Leaf)) {
    Add-Failure "missing scripts/maturity.ps1"
    return $null
  }

  try {
    $jsonText = Invoke-RepoPowerShell -File $maturityScript -Arguments @("-Mode", "json") | Out-String
    if ($LASTEXITCODE -ne 0) {
      Add-Failure "scripts/maturity.ps1 -Mode json failed"
      return $null
    }
    return $jsonText | ConvertFrom-Json
  } catch {
    Add-Failure "cannot read maturity JSON: $($_.Exception.Message)"
    return $null
  }
}

function Test-Workflow {
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    Add-Failure "missing self-evolution workflow: $Path"
    return
  }

  $text = Get-Content -LiteralPath $Path -Raw
  if ($text -notmatch "(?m)^\s*schedule\s*:") {
    Add-Failure "self-evolution workflow must run on schedule"
  }
  if ($text -notmatch "(?m)^\s*workflow_dispatch\s*:") {
    Add-Failure "self-evolution workflow must support workflow_dispatch"
  }
  if ($text -notmatch "(?m)^\s*contents\s*:\s*read\s*$") {
    Add-Failure "self-evolution workflow must use permissions.contents: read"
  }
  if ($text -match "(?im)\b(git\s+push|git\s+commit|gh\s+issue|gh\s+pr|Remove-Item|Set-Content|Out-File)\b") {
    Add-Failure "self-evolution workflow must not write, commit, push, or create GitHub objects"
  }
}

$requiredFiles = @(
  "scripts/evolve.ps1",
  "scripts/maturity.ps1",
  "internal/evolution/backlog.json",
  "internal/evolution/risk-register.json",
  "internal/evolution/review.json",
  ".github/workflows/self-evolution.yml"
)

foreach ($file in $requiredFiles) {
  if (-not (Test-Path -LiteralPath $file -PathType Leaf)) {
    Add-Failure "missing file: $file"
  }
}

if ((Split-Path -Leaf $Root) -ne "OLMO_PROMETEUS") {
  Add-Failure "unexpected repo root: $Root"
}

if (Test-Path -LiteralPath "shadow/MATURITY-GAPS.md") {
  Add-Failure "maturity layers must be executable; remove shadow/MATURITY-GAPS.md"
}

$backlog = Read-JsonFile "internal/evolution/backlog.json"
$riskRegister = Read-JsonFile "internal/evolution/risk-register.json"
$review = Read-JsonFile "internal/evolution/review.json"
$maturity = Invoke-MaturityJson
Test-Workflow ".github/workflows/self-evolution.yml"

$allowedStatuses = @("applied", "next", "planned", "blocked", "retired")
$requiredItemFields = @("id", "batch", "status", "area", "problem", "trigger", "owner", "risk", "rollback", "negative_criterion", "next_action")

$items = @()
if ($null -ne $backlog) {
  if ($backlog.schema -ne "prometeus.evolution.backlog.v1") {
    Add-Failure "unexpected backlog schema: $($backlog.schema)"
  }
  $items = @($backlog.items)
  if ($items.Count -eq 0) {
    Add-Failure "backlog has no items"
  }

  foreach ($item in $items) {
    foreach ($field in $requiredItemFields) {
      if (-not (Has-TextValue $item $field)) {
        Add-Failure "backlog item missing field '$field': $($item.id)"
      }
    }
    if ($allowedStatuses -notcontains $item.status) {
      Add-Failure "backlog item has invalid status '$($item.status)': $($item.id)"
    }
    if (-not (Has-ArrayValue $item "acceptance")) {
      Add-Failure "backlog item missing acceptance: $($item.id)"
    }
  }
}

$nextItems = @($items | Where-Object { $_.status -eq "next" })
if ($nextItems.Count -eq 0) {
  Add-Failure "self-evolution backlog must declare exactly one next item"
} elseif ($nextItems.Count -gt 1) {
  Add-Failure "self-evolution backlog has more than one next item: $($nextItems.id -join ', ')"
}

if ($null -ne $riskRegister) {
  if ($riskRegister.schema -ne "prometeus.evolution.risk-register.v1") {
    Add-Failure "unexpected risk register schema: $($riskRegister.schema)"
  }
  foreach ($risk in @($riskRegister.risks)) {
    foreach ($field in @("id", "severity", "risk", "control", "owner", "status")) {
      if (-not (Has-TextValue $risk $field)) {
        Add-Failure "risk missing field '$field': $($risk.id)"
      }
    }
  }
  $criticalOpen = @($riskRegister.risks | Where-Object { $_.severity -eq "critical" -and $_.status -eq "open" })
  if ($criticalOpen.Count -gt 0) {
    Add-Warning "critical risk remains open: $($criticalOpen.id -join ', ')"
  }
}

if ($null -ne $review) {
  if ($review.schema -ne "prometeus.evolution.review.v1") {
    Add-Failure "unexpected review schema: $($review.schema)"
  }
  foreach ($field in @("cadence", "last_review", "next_review")) {
    if (-not (Has-TextValue $review $field)) {
      Add-Failure "review missing field '$field'"
    }
  }
  foreach ($field in @("triggers", "definition_of_ready", "definition_of_done")) {
    if (-not (Has-ArrayValue $review $field)) {
      Add-Failure "review missing array '$field'"
    }
  }
  try {
    $nextReview = [datetime]::ParseExact($review.next_review, "yyyy-MM-dd", [Globalization.CultureInfo]::InvariantCulture)
    if ($nextReview.Date -lt [datetime]::Today) {
      Add-Warning "next_review is in the past: $($review.next_review)"
    }
  } catch {
    Add-Failure "review.next_review must be yyyy-MM-dd"
  }
}

if ($null -ne $maturity -and $items.Count -gt 0) {
  $maturityNext = @($maturity.Batches | Where-Object { $_.Status -eq "next" })
  foreach ($batch in $maturityNext) {
    $matching = @($items | Where-Object { [int]$_.batch -eq [int]$batch.Batch -and $_.status -eq "next" })
    if ($matching.Count -eq 0) {
      Add-Failure "maturity next batch $($batch.Batch) is not the next internal backlog item"
    }
  }
}

$state = [pscustomobject]@{
  Backlog = $backlog
  RiskRegister = $riskRegister
  Review = $review
  MaturityNext = if ($null -ne $maturity) { @($maturity.Batches | Where-Object { $_.Status -eq "next" }) } else { @() }
  NextItems = $nextItems
  Warnings = @($Warnings)
  Failures = @($Failures)
}

if ($Mode -eq "json") {
  $state | ConvertTo-Json -Depth 8
  exit 0
}

if ($Mode -eq "next") {
  $nextItems | Select-Object id, batch, area, problem, trigger, acceptance, owner, risk, rollback, negative_criterion, next_action | Format-List
  exit 0
}

if ($Mode -eq "report") {
  Write-Host "Self-evolution state for OLMO_PROMETEUS"
  Write-Host ""
  $items | Sort-Object batch | Format-Table id, batch, status, area, next_action -Wrap
  Write-Host ""
  @($riskRegister.risks) | Format-Table id, severity, status, risk -Wrap
  exit 0
}

foreach ($warning in $Warnings) {
  Write-Host "[WARN] $warning" -ForegroundColor Yellow
}

foreach ($failure in $Failures) {
  Write-Host "[FAIL] $failure" -ForegroundColor Red
}

if ($Failures.Count -gt 0 -or ($Strict -and $Warnings.Count -gt 0)) {
  Write-Host "Self-evolution check failed with $($Failures.Count) issue(s), $($Warnings.Count) warning(s)." -ForegroundColor Red
  exit 1
}

Write-Host "[OK] self-evolution loop passes" -ForegroundColor Green
exit 0
