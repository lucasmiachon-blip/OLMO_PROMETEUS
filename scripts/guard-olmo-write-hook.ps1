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
$canonicalName = "OLMO_PROMETEUS"
$canonicalRoot = "C:\Dev\Projetos\$canonicalName"
$olmoFamilyRootPattern = "(?i)C:\\Dev\\Projetos\\OLMO[A-Za-z0-9_-]*"
$relativeOlmoFamilyPattern = "(?i)(^|[\s`"'])\.\.[\\/]+(OLMO[A-Za-z0-9_-]*)"

foreach ($text in $scanTexts) {
  $normalized = $text.Replace("/", "\")

  foreach ($match in [regex]::Matches($normalized, $olmoFamilyRootPattern)) {
    $matchedRoot = $match.Value
    if ($matchedRoot -ieq $canonicalRoot) {
      continue
    }

    $matchedName = Split-Path -Leaf $matchedRoot
    New-ExternalOlmoResponse -IsWrite $isWrite -CanonicalRoot $canonicalRoot -MatchedName $matchedName
    exit 0
  }

  foreach ($match in [regex]::Matches($normalized, $relativeOlmoFamilyPattern)) {
    $matchedName = $match.Groups[2].Value
    if ($matchedName -ieq $canonicalName) {
      continue
    }

    New-ExternalOlmoResponse -IsWrite $isWrite -CanonicalRoot $canonicalRoot -MatchedName $matchedName
    exit 0
  }
}

exit 0
