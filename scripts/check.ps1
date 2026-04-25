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

function Invoke-TextCheck {
  param(
    [string]$Label,
    [string]$Pattern,
    [string[]]$ExtraArgs = @(),
    [switch]$RedactLine
  )

  $excludePatterns = New-Object System.Collections.Generic.List[string]
  $excludePatterns.Add(".git/*") | Out-Null

  for ($i = 0; $i -lt $ExtraArgs.Count; $i++) {
    if ($ExtraArgs[$i] -eq "-g" -and ($i + 1) -lt $ExtraArgs.Count) {
      $glob = $ExtraArgs[$i + 1]
      if ($glob.StartsWith("!")) {
        $excludePatterns.Add($glob.Substring(1)) | Out-Null
      }
      $i++
    }
  }

  $matches = New-Object System.Collections.Generic.List[string]
  $rootPath = $Root.Path
  $files = Get-ChildItem -LiteralPath "." -Recurse -File -Force -ErrorAction SilentlyContinue

  foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($rootPath.Length).TrimStart("\", "/").Replace("\", "/")
    $excluded = $false
    foreach ($excludePattern in $excludePatterns) {
      if ($relativePath -like $excludePattern) {
        $excluded = $true
        break
      }
    }

    if ($excluded) {
      continue
    }

    & git check-ignore -q -- $relativePath
    if ($LASTEXITCODE -eq 0) {
      continue
    }

    $results = Select-String -LiteralPath $file.FullName -Pattern $Pattern -CaseSensitive -ErrorAction SilentlyContinue
    foreach ($result in @($results)) {
      if ($RedactLine) {
        $matches.Add("${relativePath}:$($result.LineNumber):<redacted>") | Out-Null
      } else {
        $matches.Add("${relativePath}:$($result.LineNumber):$($result.Line)") | Out-Null
      }
    }
  }

  if ($matches.Count -gt 0) {
    Write-Fail "$Label found:`n$($matches -join "`n")"
  } else {
    Write-Ok $Label
  }
}

if ((Split-Path -Leaf $Root) -ne "OLMO_PROMETEUS") {
  Write-Fail "unexpected repo root: $Root"
} else {
  Write-Ok "repo root is OLMO_PROMETEUS"
}

$requiredFiles = @(
  "AGENTS.md",
  "CLAUDE.md",
  "GEMINI.md",
  "PROJECT_CONTRACT.md",
  "README.md",
  "TREE.md",
  "shadow/FOUNDATION.md",
  "shadow/AGENT-MODULES.md",
  "shadow/HYGIENE.md",
  "shadow/SOTA-DECISIONS.md",
  "shadow/INCORPORATION-LOG.md",
  "scripts/maturity.ps1",
  "scripts/evolve.ps1",
  "internal/evolution/backlog.json",
  "internal/evolution/risk-register.json",
  "internal/evolution/review.json",
  ".github/workflows/self-evolution.yml",
  "shadow/WORK-LANES.md",
  "shadow/EMAIL-DIGEST-4P.md",
  "shadow/STUDY-TRACK-DONE.md",
  "shadow/EVIDENCE-LOG.md",
  "shadow/AGENT-USAGE.md",
  "Prometeus/README.md",
  "Prometeus/wiki/Home.md",
  "Prometeus/wiki/Atlas/Second Brain Atlas.md",
  "Prometeus/wiki/Atlas/Graph Operating System.md",
  "Prometeus/wiki/Atlas/Knowledge Lifecycle.md",
  "Prometeus/wiki/Maps/Prometeus.canvas",
  "Prometeus/wiki/Categories/Prometeus Wiki.md",
  "Prometeus/wiki/Notes/Workspace Boundary.md",
  "Prometeus/wiki/Notes/Foundation Harness.md",
  "Prometeus/wiki/Notes/SOTA Research Gate.md",
  "Prometeus/wiki/Notes/Agent Module Encapsulation.md",
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
  "CLAUDE.md",
  "GEMINI.md",
  "PROJECT_CONTRACT.md",
  "TREE.md",
  "shadow/FOUNDATION.md"
)

foreach ($file in $boundaryFiles) {
  $text = Get-Content -LiteralPath $file -Raw
  if ($text -match "(?i)nunca escrever fora.{0,5}C:\\Dev\\Projetos\\OLMO_PROMETEUS") {
    Write-Ok "fundamental boundary present: $file"
  } else {
    Write-Fail "missing fundamental boundary in: $file"
  }
}

$sizeThresholds = @{
  "scripts/maturity.ps1" = 20000
  "AGENTS.md" = 12000
  "scripts/evolve.ps1" = 20000
  "internal/evolution/backlog.json" = 10000
  "shadow/SOTA-DECISIONS.md" = 16000
  "shadow/AGENT-MODULES.md" = 12000
  "shadow/FOUNDATION.md" = 10000
  "shadow/WORK-LANES.md" = 10000
  "shadow/INCORPORATION-LOG.md" = 8000
  "shadow/HYGIENE.md" = 6000
  "shadow/EMAIL-DIGEST-4P.md" = 10000
  "internal/evolution/risk-register.json" = 8000
  "internal/evolution/review.json" = 5000
  ".github/workflows/self-evolution.yml" = 5000
  "shadow/STUDY-TRACK-DONE.md" = 10000
}

foreach ($entry in $sizeThresholds.GetEnumerator()) {
  if (Test-Path -LiteralPath $entry.Key -PathType Leaf) {
    $sizeBytes = (Get-Item -LiteralPath $entry.Key).Length
    if ($sizeBytes -gt $entry.Value) {
      Write-Warn "sprawl: $($entry.Key) is $sizeBytes bytes (threshold $($entry.Value))"
    } else {
      Write-Ok "size ok: $($entry.Key) $sizeBytes <= $($entry.Value)"
    }
  }
}

$olmoFailures = New-Object System.Collections.Generic.List[string]
$olmoContextPattern = "(?i)(leitura|auditoria|inspeca|read-?only|protegido|proibi|autoriza|aprova|humana|humano|externo|apenas|nunca|antes|fora|regra\s+fundamental|write\s+externo|\bsem\b|\bnao\b|\bnada\b|\bnenhum\b)"
$olmoPathPattern = "C:\\Dev\\Projetos\\OLMO(?![_A-Za-z0-9])"
$olmoScanExtensions = @(".md", ".ps1")
$olmoScanExcluded = @("scripts/check.ps1")

$olmoScanTargets = Get-ChildItem -LiteralPath "." -Recurse -File -Force -ErrorAction SilentlyContinue |
  Where-Object { $olmoScanExtensions -contains $_.Extension.ToLowerInvariant() }

foreach ($olmoFile in $olmoScanTargets) {
  $olmoRel = $olmoFile.FullName.Substring($Root.Path.Length).TrimStart("\","/").Replace("\","/")
  if ($olmoRel -like ".git/*") { continue }
  if ($olmoScanExcluded -contains $olmoRel) { continue }
  & git check-ignore -q -- $olmoRel
  if ($LASTEXITCODE -eq 0) { continue }

  $olmoLines = Get-Content -LiteralPath $olmoFile.FullName
  for ($i = 0; $i -lt $olmoLines.Count; $i++) {
    if ($olmoLines[$i] -match $olmoPathPattern) {
      $startIdx = [Math]::Max(0, $i - 4)
      $endIdx = [Math]::Min($olmoLines.Count - 1, $i + 4)
      $window = ($olmoLines[$startIdx..$endIdx]) -join "`n"
      if ($window -notmatch $olmoContextPattern) {
        $olmoFailures.Add("${olmoRel}:$($i+1):$($olmoLines[$i])") | Out-Null
      }
    }
  }
}

if ($olmoFailures.Count -gt 0) {
  Write-Fail "OLMO path referenced outside read/audit context:`n$($olmoFailures -join "`n")"
} else {
  Write-Ok "OLMO path references stay read-only"
}

$evidenceLog = "shadow/EVIDENCE-LOG.md"
if (Test-Path -LiteralPath $evidenceLog -PathType Leaf) {
  $evidenceLastWrite = (Get-Item -LiteralPath $evidenceLog).LastWriteTime
  $evidenceDays = ([DateTime]::Now - $evidenceLastWrite).Days
  if ($evidenceDays -gt 21) {
    if ($Strict) {
      Write-Fail "EVIDENCE-LOG.md not updated in $evidenceDays days (>21); -Strict requires fresh evidence"
    } else {
      Write-Warn "EVIDENCE-LOG.md not updated in $evidenceDays days (>21)"
    }
  } else {
    Write-Ok "EVIDENCE-LOG.md freshness: $evidenceDays days"
  }
}

$forbiddenRootDirs = @(
  ".agents",
  ".codex",
  ".gemini",
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

$forbiddenClaudeSubdirs = @(
  ".claude/agents",
  ".claude/hooks",
  ".claude/commands"
)

foreach ($claudeDir in $forbiddenClaudeSubdirs) {
  if (Test-Path -LiteralPath $claudeDir -PathType Container) {
    Write-Fail "forbidden claude scaffold exists: $claudeDir"
  } else {
    Write-Ok "forbidden claude scaffold absent: $claudeDir"
  }
}

$skillsRoot = ".claude/skills"
$requiredSkillFields = @("name", "description", "trigger", "non-trigger", "source", "status", "owner")
$allowedSkillStatuses = @("candidate", "operational")
if (Test-Path -LiteralPath $skillsRoot -PathType Container) {
  $skillDirs = Get-ChildItem -LiteralPath $skillsRoot -Directory -ErrorAction SilentlyContinue
  if ($skillDirs.Count -eq 0) {
    Write-Ok ".claude/skills/ exists but empty"
  } else {
    foreach ($skillDir in $skillDirs) {
      $skillLabel = ".claude/skills/$($skillDir.Name)/"
      $skillManifest = Join-Path $skillDir.FullName "SKILL.md"
      if (-not (Test-Path -LiteralPath $skillManifest -PathType Leaf)) {
        Write-Fail "skill missing SKILL.md: $skillLabel"
        continue
      }

      $manifestText = Get-Content -LiteralPath $skillManifest -Raw
      if ($manifestText -notmatch "(?s)^---\r?\n(.*?)\r?\n---") {
        Write-Fail "skill SKILL.md missing YAML frontmatter: $skillLabel"
        continue
      }
      $skillFrontmatter = $Matches[1]

      $missingSkillFields = New-Object System.Collections.Generic.List[string]
      foreach ($field in $requiredSkillFields) {
        $escapedField = [regex]::Escape($field)
        if ($skillFrontmatter -notmatch "(?m)^$($escapedField):\s*\S") {
          $missingSkillFields.Add($field) | Out-Null
        }
      }
      if ($missingSkillFields.Count -gt 0) {
        Write-Fail "skill SKILL.md missing required fields in ${skillLabel}: $($missingSkillFields -join ', ')"
        continue
      }

      if ($skillFrontmatter -match "(?m)^status:\s*(\S+)") {
        $skillStatus = $Matches[1].Trim().Trim('"').Trim("'")
        if ($allowedSkillStatuses -notcontains $skillStatus) {
          Write-Fail "skill status must be one of [$($allowedSkillStatuses -join ', ')] in ${skillLabel}: got '$skillStatus'"
          continue
        }
      }

      if ($skillFrontmatter -match "(?m)^source:\s*(.+)$") {
        $skillSource = $Matches[1].Trim().Trim('"').Trim("'")
        if (-not $skillSource.StartsWith("shadow/")) {
          Write-Fail "skill source must point under shadow/ in ${skillLabel}: got '$skillSource'"
          continue
        }
        if (-not (Test-Path -LiteralPath $skillSource -PathType Leaf)) {
          Write-Fail "skill source file missing in ${skillLabel}: $skillSource"
          continue
        }
      }

      Write-Ok "skill manifest valid: ${skillLabel}SKILL.md"
    }
  }
} else {
  Write-Ok ".claude/skills/ gate open; no skills installed yet"
}

$agentAdapters = @{
  "CLAUDE.md" = "@AGENTS.md"
  "GEMINI.md" = "@AGENTS.md"
}

foreach ($entry in $agentAdapters.GetEnumerator()) {
  $text = Get-Content -LiteralPath $entry.Key -Raw
  if ($text.Contains($entry.Value)) {
    Write-Ok "agent adapter imports AGENTS.md: $($entry.Key)"
  } else {
    Write-Fail "agent adapter must import AGENTS.md: $($entry.Key)"
  }
}

$requiredIgnorePatterns = @(
  ".claude/settings.local.json",
  "private-learning/",
  "Prometeus/.obsidian/workspace*.json",
  "Prometeus/.obsidian/cache/",
  "Prometeus/.obsidian/plugins/",
  "Prometeus/wiki/Clippings/*",
  "!Prometeus/wiki/Clippings/README.md",
  "Prometeus/wiki/Daily/*",
  "!Prometeus/wiki/Daily/README.md",
  "Prometeus/wiki/Attachments/*",
  "!Prometeus/wiki/Attachments/README.md",
  "node_modules/",
  ".venv/"
)

foreach ($ignoreFile in @(".gitignore", ".claudeignore")) {
  $ignoreText = Get-Content -LiteralPath $ignoreFile -Raw
  foreach ($ignorePattern in $requiredIgnorePatterns) {
    $escapedPattern = [regex]::Escape($ignorePattern)
    if ($ignoreText -match "(?m)^$escapedPattern$") {
      Write-Ok "ignore pattern present in ${ignoreFile}: $ignorePattern"
    } else {
      Write-Fail "missing ignore pattern in ${ignoreFile}: $ignorePattern"
    }
  }
}

$procedureContracts = @{
  "AGENTS.md" = @("## SOTA Research Gate", "## Memoria")
  "PROJECT_CONTRACT.md" = @("## SOTA research gate")
  "shadow/AGENT-MODULES.md" = @("## Trigger", "## Contract", "## Evaluation", "## Mini-evals")
  "shadow/EMAIL-DIGEST-4P.md" = @("## Trigger", "## Contrato de entrada", "## Workflow", "## Rubric", "## Mini-evals")
  "shadow/STUDY-TRACK-DONE.md" = @("## Trigger", "## Saida padrao", "## Workflow", "## Rubric", "## Mini-evals")
  "shadow/WORK-LANES.md" = @("## Trigger", "## Promotion gate", "## Decisao", "## Transicao candidate -> operational", "## Mini-evals")
  "shadow/SOTA-DECISIONS.md" = @("## SOTA research gate", "## Agent module frontier", "## Padrao SOTA para procedimentos", "## Big Three scan", "## Claude Code e GEMINI.md adapters", "## Applied when", "## Blocked ate evidencia")
  "shadow/AGENT-USAGE.md" = @("## Purpose", "## SOTA agent contract", "## Guardrails", "## Non-triggers")
  "shadow/EVIDENCE-LOG.md" = @("## Schema", "## Entradas")
}

foreach ($entry in $procedureContracts.GetEnumerator()) {
  $text = Get-Content -LiteralPath $entry.Key -Raw
  foreach ($section in $entry.Value) {
    if ($text.Contains($section)) {
      Write-Ok "procedure section present: $($entry.Key) -> $section"
    } else {
      Write-Fail "missing procedure section: $($entry.Key) -> $section"
    }
  }
}

$maturityScript = "scripts/maturity.ps1"
if (Test-Path -LiteralPath $maturityScript -PathType Leaf) {
  & powershell -NoProfile -ExecutionPolicy Bypass -File $maturityScript -Mode check
  if ($LASTEXITCODE -eq 0) {
    Write-Ok "maturity executable passes"
  } else {
    Write-Fail "maturity executable failed"
  }
}

$obsidianJsonFiles = Get-ChildItem -LiteralPath "Prometeus/.obsidian" -Filter "*.json"
$evolveScript = "scripts/evolve.ps1"
if (Test-Path -LiteralPath $evolveScript -PathType Leaf) {
  & powershell -NoProfile -ExecutionPolicy Bypass -File $evolveScript -Mode check
  if ($LASTEXITCODE -eq 0) {
    Write-Ok "self-evolution executable passes"
  } else {
    Write-Fail "self-evolution executable failed"
  }
}

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

$wikiNotesPath = Join-Path $vaultRoot.Path "wiki/Notes"
if (Test-Path -LiteralPath $wikiNotesPath -PathType Container) {
  foreach ($noteFile in (Get-ChildItem -LiteralPath $wikiNotesPath -File -Filter "*.md")) {
    $noteText = Get-Content -LiteralPath $noteFile.FullName -Raw
    $noteLinkCount = ([regex]::Matches($noteText, "\[\[([^\]]*)\]\]")).Count
    if ($noteLinkCount -lt 2) {
      Write-Warn "wiki note has <2 wikilinks: wiki/Notes/$($noteFile.Name) ($noteLinkCount)"
    }
  }
}

Invoke-TextCheck "no old roadmap/SOTA references" "OLMO_ROADMAP|SOTA-AGENTS|SOTA-INCORPORATION" @("-g", "!scripts/check.ps1")
Invoke-TextCheck "no obvious secret strings" "API_KEY|SECRET|TOKEN|password" @("-g", "!scripts/check.ps1") -RedactLine

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
