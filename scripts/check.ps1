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
  "TREE.md",
  "shadow/FOUNDATION.md",
  "shadow/HYGIENE.md",
  "shadow/SOTA-DECISIONS.md",
  "shadow/INCORPORATION-LOG.md",
  "shadow/WORK-LANES.md",
  "Prometeus/README.md",
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
  ".gitignore",
  ".claudeignore"
)

foreach ($file in $requiredFiles) {
  Require-File $file
}

$boundaryFiles = @(
  "AGENTS.md",
  "PROJECT_CONTRACT.md",
  "TREE.md",
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

$forbiddenRootDirs = @(
  ".agents",
  ".codex",
  "agents",
  "subagents",
  "skills",
  "hooks",
  "playground"
)

foreach ($dir in $forbiddenRootDirs) {
  if (Test-Path -LiteralPath $dir -PathType Container) {
    Write-Fail "forbidden root scaffold exists: $dir"
  } else {
    Write-Ok "forbidden root scaffold absent: $dir"
  }
}

foreach ($ignoreFile in @(".gitignore", ".claudeignore")) {
  $ignoreText = Get-Content -LiteralPath $ignoreFile -Raw
  if ($ignoreText -match "(?m)^private-learning/$") {
    Write-Ok "private-learning fully ignored in: $ignoreFile"
  } else {
    Write-Fail "private-learning must be fully ignored in: $ignoreFile"
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

    foreach ($node in @($canvas.nodes)) {
      if ($node.type -eq "file" -and $node.file) {
        $canvasTarget = Join-Path "Prometeus" $node.file
        if (Test-Path -LiteralPath $canvasTarget -PathType Leaf) {
          Write-Ok "canvas file reference resolves: $($node.file)"
        } else {
          Write-Fail "canvas file reference is broken: $($node.file) in $($canvasFile.FullName)"
        }
      }
    }
  } catch {
    Write-Fail "canvas JSON invalid: $($canvasFile.FullName)"
  }
}

function Add-LinkTarget {
  param(
    [hashtable]$Targets,
    [string]$Key,
    [string]$Path
  )

  if ([string]::IsNullOrWhiteSpace($Key)) {
    return
  }

  $cleanKey = $Key.Trim()
  if (-not $Targets.ContainsKey($cleanKey)) {
    $Targets[$cleanKey] = New-Object System.Collections.Generic.List[string]
  }
  $Targets[$cleanKey].Add($Path)
}

function Get-FrontmatterAliases {
  param([string]$Text)

  $aliases = New-Object System.Collections.Generic.List[string]
  if ($Text -notmatch "(?s)^---\r?\n(.*?)\r?\n---") {
    return $aliases
  }

  $frontmatter = $Matches[1]
  $inAliases = $false
  foreach ($line in ($frontmatter -split "\r?\n")) {
    if ($line -match "^\s*aliases:\s*\[(.*)\]\s*$") {
      foreach ($alias in ($Matches[1] -split ",")) {
        $cleanAlias = $alias.Trim().Trim('"').Trim("'")
        if (-not [string]::IsNullOrWhiteSpace($cleanAlias)) {
          $aliases.Add($cleanAlias)
        }
      }
      $inAliases = $false
      continue
    }

    if ($line -match "^\s*aliases:\s*$") {
      $inAliases = $true
      continue
    }

    if ($inAliases) {
      if ($line -match "^\s*-\s*(.+?)\s*$") {
        $cleanAlias = $Matches[1].Trim().Trim('"').Trim("'")
        if (-not [string]::IsNullOrWhiteSpace($cleanAlias)) {
          $aliases.Add($cleanAlias)
        }
      } elseif ($line -match "^\S") {
        $inAliases = $false
      }
    }
  }

  return $aliases
}

function Get-VaultRelativePath {
  param(
    [string]$VaultPath,
    [string]$FullPath
  )

  return $FullPath.Substring($VaultPath.Length).TrimStart("\", "/").Replace("\", "/")
}

$vaultRoot = Resolve-Path -LiteralPath "Prometeus"
$linkTargets = @{}
$vaultLinkFiles = Get-ChildItem -LiteralPath $vaultRoot -Recurse -File | Where-Object {
  $_.Extension -in @(".md", ".canvas")
}

foreach ($file in $vaultLinkFiles) {
  $relativePath = Get-VaultRelativePath $vaultRoot.Path $file.FullName
  $relativeWithoutExtension = $relativePath -replace "\.[^./]+$", ""
  $basename = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

  Add-LinkTarget $linkTargets $relativePath $relativePath
  Add-LinkTarget $linkTargets $relativeWithoutExtension $relativePath
  Add-LinkTarget $linkTargets $file.Name $relativePath
  Add-LinkTarget $linkTargets $basename $relativePath

  if ($file.Extension -eq ".md") {
    $text = Get-Content -LiteralPath $file.FullName -Raw
    foreach ($alias in (Get-FrontmatterAliases $text)) {
      Add-LinkTarget $linkTargets $alias $relativePath
    }
  }
}

$wikilinkIssueCount = 0
$markdownFiles = Get-ChildItem -LiteralPath $vaultRoot -Recurse -File -Filter "*.md"
foreach ($mdFile in $markdownFiles) {
  $text = Get-Content -LiteralPath $mdFile.FullName -Raw
  $relativePath = Get-VaultRelativePath $vaultRoot.Path $mdFile.FullName
  $wikilinks = [regex]::Matches($text, "\[\[([^\]]*)\]\]")

  foreach ($link in $wikilinks) {
    $rawTarget = $link.Groups[1].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($rawTarget)) {
      Write-Fail "empty wikilink in: $relativePath"
      $wikilinkIssueCount++
      continue
    }

    $target = ($rawTarget -split "\|", 2)[0].Trim()
    $target = ($target -split "#", 2)[0].Trim()
    $target = ($target -split "\^", 2)[0].Trim()

    if ([string]::IsNullOrWhiteSpace($target)) {
      Write-Fail "wikilink missing target in: $relativePath -> [[$rawTarget]]"
      $wikilinkIssueCount++
      continue
    }

    if (-not $linkTargets.ContainsKey($target)) {
      Write-Fail "wikilink target missing in $relativePath -> [[$rawTarget]]"
      $wikilinkIssueCount++
      continue
    }

    if ($linkTargets[$target].Count -gt 1 -and $target -notmatch "/") {
      Write-Fail "ambiguous wikilink target in $relativePath -> [[$rawTarget]] resolves to: $($linkTargets[$target] -join ', ')"
      $wikilinkIssueCount++
    }
  }
}

if ($wikilinkIssueCount -eq 0) {
  Write-Ok "obsidian wikilinks resolve"
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

$trackedPrivateGenerated = & git ls-files private-learning

if ($trackedPrivateGenerated) {
  Write-Fail "private-learning files are tracked:`n$trackedPrivateGenerated"
} else {
  Write-Ok "no private-learning files are tracked"
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
