param()

$ErrorActionPreference = "Stop"

function New-BlockResponse {
  param([string]$Reason)

  @{
    hookSpecificOutput = @{
      hookEventName = "PreToolUse"
      permissionDecision = "block"
      permissionDecisionReason = $Reason
    }
  } | ConvertTo-Json -Compress
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

# Proibido: qualquer ferramenta que mencione OLMO ou siblings OLMO*, exceto o workspace canonico.
# Permitido: OLMO_PROMETEUS, que e o workspace deste projeto.
$canonicalName = "OLMO_PROMETEUS"
$canonicalRoot = "C:\Dev\Projetos\$canonicalName"
$legacyName = "OLMO" + "_ROADMAP"
$olmoFamilyRootPattern = "(?i)C:\\Dev\\Projetos\\OLMO[A-Za-z0-9_-]*"
$relativeOlmoFamilyPattern = "(?i)(^|[\s`"'])\.\.[\\/]+(OLMO[A-Za-z0-9_-]*)"

foreach ($text in $scanTexts) {
  $normalized = $text.Replace("/", "\")

  foreach ($match in [regex]::Matches($normalized, $olmoFamilyRootPattern)) {
    $matchedRoot = $match.Value
    if ($matchedRoot -ieq $canonicalRoot) {
      continue
    }

    if ((Split-Path -Leaf $matchedRoot) -ieq $legacyName) {
      New-BlockResponse "OLMO boundary guard: bloqueado. Workspace legado/stale detectado; use apenas $canonicalRoot."
      exit 0
    }

    New-BlockResponse "OLMO boundary guard: bloqueado. Este agente nao pode tocar sibling OLMO externo; use apenas $canonicalRoot."
    exit 0
  }

  foreach ($match in [regex]::Matches($normalized, $relativeOlmoFamilyPattern)) {
    $matchedName = $match.Groups[2].Value
    if ($matchedName -ieq $canonicalName) {
      continue
    }

    if ($matchedName -ieq $legacyName) {
      New-BlockResponse "OLMO boundary guard: bloqueado. Workspace legado/stale detectado; use apenas $canonicalRoot."
      exit 0
    }

    New-BlockResponse "OLMO boundary guard: bloqueado. Este agente nao pode tocar sibling OLMO externo; use apenas $canonicalRoot."
    exit 0
  }
}

exit 0
