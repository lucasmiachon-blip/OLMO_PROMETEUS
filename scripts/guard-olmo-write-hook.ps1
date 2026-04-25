param()

$ErrorActionPreference = "Stop"

function New-PermissionResponse {
  param(
    [string]$Decision,
    [string]$Reason
  )

  @{
    hookSpecificOutput = @{
      hookEventName = "PreToolUse"
      permissionDecision = $Decision
      permissionDecisionReason = $Reason
    }
  } | ConvertTo-Json -Compress
}

function New-BlockResponse {
  param([string]$Reason)
  New-PermissionResponse -Decision "deny" -Reason $Reason
}

function New-AskResponse {
  param([string]$Reason)
  New-PermissionResponse -Decision "ask" -Reason $Reason
}

function Add-ScanText {
  param(
    [object]$Value,
    [System.Collections.Generic.List[string]]$Sink
  )

  if ($null -eq $Value) {
    return
  }

  if ($Value -is [string]) {
    $Sink.Add($Value) | Out-Null
    return
  }

  if ($Value -is [System.Management.Automation.PSCustomObject]) {
    foreach ($property in $Value.PSObject.Properties) {
      Add-ScanText -Value $property.Name -Sink $Sink
      Add-ScanText -Value $property.Value -Sink $Sink
    }
    return
  }

  if ($Value -is [System.Collections.IDictionary]) {
    foreach ($key in $Value.Keys) {
      Add-ScanText -Value $key -Sink $Sink
      Add-ScanText -Value $Value[$key] -Sink $Sink
    }
    return
  }

  if ($Value -is [System.Collections.IEnumerable] -and -not ($Value -is [string])) {
    foreach ($item in $Value) {
      Add-ScanText -Value $item -Sink $Sink
    }
    return
  }

  $Sink.Add([string]$Value) | Out-Null
}

function Get-ToolName {
  param([object]$Payload)

  foreach ($name in @($Payload.tool_name, $Payload.toolName, $Payload.name)) {
    if (-not [string]::IsNullOrWhiteSpace([string]$name)) {
      return [string]$name
    }
  }

  return ""
}

function Test-WriteIntent {
  param(
    [object]$Payload,
    [System.Collections.Generic.List[string]]$Texts
  )

  $toolName = Get-ToolName -Payload $Payload
  if ($toolName -match "(?i)^(Write|Edit|MultiEdit|NotebookEdit)$") {
    return $true
  }

  $writePattern = "(?i)(\b(Set-Content|Add-Content|Out-File|Remove-Item|Move-Item|Copy-Item|New-Item|Rename-Item|Clear-Content)\b|\b(git\s+(add|commit|push|checkout|reset|clean|mv|rm))\b|\b(mkdir|ni|rm|del|erase|rmdir|rd|move|copy)\b|>>|(?<![<])>)"
  foreach ($text in $Texts) {
    if ($text -match $writePattern) {
      return $true
    }
  }

  return $false
}

function New-ExternalOlmoResponse {
  param(
    [bool]$IsWrite,
    [string]$CanonicalRoot,
    [string]$MatchedName
  )

  if ($IsWrite) {
    New-BlockResponse "OLMO boundary guard: bloqueado. Write externo para sibling OLMO detectado ($MatchedName); use apenas $CanonicalRoot."
    return
  }

  New-AskResponse "OLMO boundary guard: leitura externa de sibling/legado OLMO detectada ($MatchedName). Peça permissao explicita do Lucas antes de ler; write continua bloqueado."
}

$inputJson = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($inputJson)) {
  exit 0
}

try {
  $payload = $inputJson | ConvertFrom-Json
} catch {
  New-BlockResponse "OLMO boundary guard: hook input JSON invalido; fail-closed para evitar write externo."
  exit 0
}

$scanTexts = [System.Collections.Generic.List[string]]::new()
Add-ScanText -Value $payload -Sink $scanTexts
$isWrite = Test-WriteIntent -Payload $payload -Texts $scanTexts

# Politica: no workspace canonico, permitir. Em siblings OLMO*, write = block; read = ask.
function Convert-ComparablePath {
  param([string]$Path)

  return $Path.TrimEnd("\", "/").Replace("\", "/").ToLowerInvariant()
}

function Test-IsCanonicalRoot {
  param([string]$Path)

  return $canonicalComparableRoots -contains (Convert-ComparablePath $Path)
}

$canonicalName = "OLMO_PROMETEUS"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$canonicalRoots = @(
  "C:\Dev\Projetos\$canonicalName",
  $repoRoot
)
$canonicalComparableRoots = @($canonicalRoots | ForEach-Object { Convert-ComparablePath $_ })
$windowsOlmoFamilyRootPattern = "(?i)" + [regex]::Escape("C:\Dev\Projetos\") + "OLMO[A-Za-z0-9_-]*"
$repoParent = Split-Path -Parent $repoRoot
$linuxOlmoFamilyRootPattern = $null
if (-not [string]::IsNullOrWhiteSpace($repoParent)) {
  $linuxParent = $repoParent.Replace("\", "/").TrimEnd("/")
  $linuxOlmoFamilyRootPattern = "(?i)" + [regex]::Escape($linuxParent) + "/OLMO[A-Za-z0-9_-]*"
}
$relativeOlmoFamilyPattern = '(?i)(^|[\s`"''])\.\.[\\/]+(OLMO[A-Za-z0-9_-]*)'

foreach ($text in $scanTexts) {
  $normalizedWindows = $text.Replace("/", "\")
  $normalizedUnix = $text.Replace("\", "/")

  foreach ($match in [regex]::Matches($normalizedWindows, $windowsOlmoFamilyRootPattern)) {
    $matchedRoot = $match.Value
    if (Test-IsCanonicalRoot $matchedRoot) {
      continue
    }

    $matchedName = Split-Path -Leaf $matchedRoot
    New-ExternalOlmoResponse -IsWrite $isWrite -CanonicalRoot $repoRoot -MatchedName $matchedName
    exit 0
  }

  if (-not [string]::IsNullOrWhiteSpace($linuxOlmoFamilyRootPattern)) {
    foreach ($match in [regex]::Matches($normalizedUnix, $linuxOlmoFamilyRootPattern)) {
      $matchedRoot = $match.Value
      if (Test-IsCanonicalRoot $matchedRoot) {
        continue
      }

      $matchedName = Split-Path -Leaf $matchedRoot
      New-ExternalOlmoResponse -IsWrite $isWrite -CanonicalRoot $repoRoot -MatchedName $matchedName
      exit 0
    }
  }

  foreach ($match in [regex]::Matches($normalizedWindows, $relativeOlmoFamilyPattern)) {
    $matchedName = $match.Groups[2].Value
    if ($matchedName -ieq $canonicalName) {
      continue
    }

    New-ExternalOlmoResponse -IsWrite $isWrite -CanonicalRoot $repoRoot -MatchedName $matchedName
    exit 0
  }
}

exit 0
