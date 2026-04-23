param(
  [switch]$Strict
)

$ErrorActionPreference = "Stop"

$Root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $Root

$Failures = New-Object System.Collections.Generic.List[string]
$Warnings = New-Object System.Collections.Generic.List[string]

function Write-Ok {
  param([string]$Message)
  Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-Warn {
  param([string]$Message)
  $Warnings.Add($Message) | Out-Null
  Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Write-Fail {
  param([string]$Message)
  $Failures.Add($Message) | Out-Null
  Write-Host "[FAIL] $Message" -ForegroundColor Red
}

function Require-File {
  param([string]$Path)
  if (Test-Path -LiteralPath $Path -PathType Leaf) {
    Write-Ok "file exists: $Path"
  } else {
    Write-Fail "missing file: $Path"
  }
}

function Invoke-RgCheck {
  param(
    [string]$Label,
    [string]$Pattern,
    [string[]]$ExtraArgs = @()
  )

  if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Warn "rg unavailable; skipped: $Label"
    return
  }

  $args = @("--hidden", $Pattern, ".", "-g", "!.git/**") + $ExtraArgs
  $output = & rg @args 2>$null
  $code = $LASTEXITCODE

  if ($code -eq 0) {
    Write-Fail "$Label found:`n$output"
  } elseif ($code -eq 1) {
    Write-Ok $Label
  } else {
    Write-Fail "rg failed for: $Label"
  }
}

if ((Split-Path -Leaf $Root) -ne "OLMO_PROMETEUS") {
  Write-Fail "unexpected repo root: $Root"
} else {
  Write-Ok "repo root is OLMO_PROMETEUS"
}

$requiredFiles = @(
  "AGENTS.md",
  "PROJECT_CONTRACT.md",
  "README.md",
  "shadow/FOUNDATION.md",
  "shadow/HYGIENE.md",
  "shadow/SOTA-DECISIONS.md",
  "shadow/INCORPORATION-LOG.md",
  "shadow/WORK-LANES.md",
  "Prometeus/wiki/Home.md",
  "Prometeus/wiki/Atlas/Second Brain Atlas.md",
  "Prometeus/wiki/Atlas/Graph Operating System.md",
  "Prometeus/wiki/Atlas/Knowledge Lifecycle.md",
  "Prometeus/wiki/Maps/Prometeus.canvas",
  "Prometeus/wiki/Categories/Prometeus Wiki.md",
  "Prometeus/wiki/Notes/Workspace Boundary.md",
  "Prometeus/wiki/Notes/Foundation Harness.md",
  "Prometeus/wiki/References/Kepano and Karpathy Principles.md",
  "Prometeus/.obsidian/app.json",
  "Prometeus/.obsidian/core-plugins.json",
  "Prometeus/.obsidian/graph.json",
  "Prometeus/.obsidian/snippets/prometeus-visuals.css",
  "private-learning/dashboard.html",
  ".codex/config.toml"
)

foreach ($file in $requiredFiles) {
  Require-File $file
}

$boundaryFiles = @(
  "AGENTS.md",
  "PROJECT_CONTRACT.md",
  "shadow/FOUNDATION.md"
)

foreach ($file in $boundaryFiles) {
  $text = Get-Content -LiteralPath $file -Raw
  if ($text -match "nunca escrever fora de ``?C:\\Dev\\Projetos\\OLMO_PROMETEUS``?") {
    Write-Ok "fundamental boundary present: $file"
  } else {
    Write-Fail "missing fundamental boundary in: $file"
  }
}

$config = Get-Content -LiteralPath ".codex/config.toml" -Raw
if ($config -match "max_depth\s*=\s*1") {
  Write-Ok "subagent max_depth is 1"
} else {
  Write-Fail "subagent max_depth must stay at 1"
}

$evalFiles = Get-ChildItem -LiteralPath ".agents/skills" -Recurse -Filter "evals.json"
if ($evalFiles.Count -eq 0) {
  Write-Fail "no skill eval files found"
} else {
  foreach ($eval in $evalFiles) {
    try {
      $json = Get-Content -LiteralPath $eval.FullName -Raw | ConvertFrom-Json
      if ($json.skill_name) {
        Write-Ok "eval JSON parses: $($eval.FullName)"
      } else {
        Write-Fail "eval JSON missing skill_name: $($eval.FullName)"
      }
    } catch {
      Write-Fail "eval JSON invalid: $($eval.FullName)"
    }
  }
}

$obsidianJsonFiles = Get-ChildItem -LiteralPath "Prometeus/.obsidian" -Filter "*.json"
foreach ($jsonFile in $obsidianJsonFiles) {
  try {
    Get-Content -LiteralPath $jsonFile.FullName -Raw | ConvertFrom-Json | Out-Null
    Write-Ok "obsidian JSON parses: $($jsonFile.FullName)"
  } catch {
    Write-Fail "obsidian JSON invalid: $($jsonFile.FullName)"
  }
}

try {
  $graphConfig = Get-Content -LiteralPath "Prometeus/.obsidian/graph.json" -Raw | ConvertFrom-Json
  if ($graphConfig.search -eq "path:wiki") {
    Write-Ok "graph search is graph-first: path:wiki"
  } else {
    Write-Fail "graph search must stay graph-first: path:wiki"
  }

  if ($graphConfig.showTags -eq $true) {
    Write-Ok "graph tags are enabled"
  } else {
    Write-Fail "graph tags must stay enabled"
  }

  if ($graphConfig.showOrphans -eq $true) {
    Write-Ok "graph orphans are visible"
  } else {
    Write-Fail "graph orphans must stay visible"
  }

  if ($graphConfig.colorGroups.Count -ge 6) {
    Write-Ok "graph color groups are configured"
  } else {
    Write-Fail "graph color groups missing or too small"
  }
} catch {
  Write-Fail "graph configuration invalid"
}

$canvasFiles = Get-ChildItem -LiteralPath "Prometeus/wiki" -Recurse -Filter "*.canvas"
foreach ($canvasFile in $canvasFiles) {
  try {
    $canvas = Get-Content -LiteralPath $canvasFile.FullName -Raw | ConvertFrom-Json
    if ($canvas.nodes -and $canvas.edges) {
      Write-Ok "canvas JSON parses: $($canvasFile.FullName)"
    } else {
      Write-Fail "canvas missing nodes or edges: $($canvasFile.FullName)"
    }
  } catch {
    Write-Fail "canvas JSON invalid: $($canvasFile.FullName)"
  }
}

Invoke-RgCheck "no old roadmap/SOTA references" "OLMO_ROADMAP|SOTA-AGENTS|SOTA-INCORPORATION" @("-g", "!scripts/check.ps1")
Invoke-RgCheck "no obvious secret strings" "API_KEY|SECRET|TOKEN|password" @("-g", "!scripts/check.ps1")

$ignoreTargets = @(
  "private-learning/checkpoints/probe.txt",
  "private-learning/exports/probe.json",
  "private-learning/state.local.json",
  "Prometeus/wiki/Clippings/probe.md",
  "Prometeus/wiki/Daily/probe.md",
  "Prometeus/wiki/Attachments/probe.png",
  "Prometeus/.obsidian/workspace.json"
)

foreach ($target in $ignoreTargets) {
  & git check-ignore -q $target
  if ($LASTEXITCODE -eq 0) {
    Write-Ok "ignored private generated path: $target"
  } else {
    Write-Fail "private generated path is not ignored: $target"
  }
}

$trackedPrivateGenerated = & git ls-files private-learning | Where-Object {
  $_ -match "\.json$|\.local\.|exports/|checkpoints/"
}

if ($trackedPrivateGenerated) {
  Write-Fail "generated private-learning files are tracked:`n$trackedPrivateGenerated"
} else {
  Write-Ok "no generated private-learning files are tracked"
}

$status = & git status --short
if ($status) {
  if ($Strict) {
    Write-Fail "git working tree is not clean:`n$status"
  } else {
    Write-Warn "git working tree has changes"
  }
} else {
  Write-Ok "git working tree is clean"
}

if ($Failures.Count -gt 0) {
  Write-Host ""
  Write-Host "Harness failed with $($Failures.Count) issue(s)." -ForegroundColor Red
  exit 1
}

Write-Host ""
if ($Warnings.Count -gt 0) {
  Write-Host "Harness passed with $($Warnings.Count) warning(s)." -ForegroundColor Yellow
} else {
  Write-Host "Harness passed." -ForegroundColor Green
}
