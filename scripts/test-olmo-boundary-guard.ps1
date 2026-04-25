param()

$ErrorActionPreference = "Stop"

$GuardScript = Join-Path $PSScriptRoot "guard-olmo-write-hook.ps1"
$Failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure {
  param([string]$Message)
  $Failures.Add($Message) | Out-Null
}

function Invoke-Guard {
  param([object]$Payload)

  if ($Payload -is [string]) {
    $json = $Payload
  } else {
    $json = $Payload | ConvertTo-Json -Depth 10
  }

  return [string]($json | powershell -NoProfile -ExecutionPolicy Bypass -File $GuardScript)
}

function Assert-Decision {
  param(
    [string]$Name,
    [object]$Payload,
    [string]$ExpectedDecision
  )

  $output = Invoke-Guard -Payload $Payload
  if ([string]::IsNullOrWhiteSpace($output)) {
    Add-Failure "$Name expected $ExpectedDecision output, got empty output"
    return
  }

  try {
    $parsed = $output | ConvertFrom-Json
  } catch {
    Add-Failure "$Name expected valid JSON output, got: $output"
    return
  }

  if ($parsed.hookSpecificOutput.permissionDecision -ne $ExpectedDecision) {
    Add-Failure "$Name expected permissionDecision=$ExpectedDecision, got: $($parsed.hookSpecificOutput.permissionDecision)"
  }
}

function Assert-Blocked {
  param(
    [string]$Name,
    [object]$Payload
  )

  Assert-Decision -Name $Name -Payload $Payload -ExpectedDecision "deny"
}

function Assert-Asked {
  param(
    [string]$Name,
    [object]$Payload
  )

  Assert-Decision -Name $Name -Payload $Payload -ExpectedDecision "ask"
}

function Assert-Allowed {
  param(
    [string]$Name,
    [object]$Payload
  )

  $output = Invoke-Guard -Payload $Payload
  if (-not [string]::IsNullOrWhiteSpace($output)) {
    Add-Failure "$Name expected empty allow output, got: $output"
  }
}

# Caminhos OLMO e workspace legado abaixo sao casos proibidos/de-permissao de teste; nao sao alvo de escrita.
Assert-Blocked "absolute OLMO write path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = "C:\Dev\Projetos\OLMO\HANDOFF.md"
  }
}

# read externo de sibling OLMO deve virar ask/permissao, nao leitura automatica.
Assert-Asked "absolute OLMO read path" @{
  tool_name = "Read"
  tool_input = @{
    file_path = "C:\Dev\Projetos\OLMO\README.md"
  }
}

Assert-Blocked "relative sibling OLMO write path" @{
  tool_name = "PowerShell"
  tool_input = @{
    command = "Set-Content ..\OLMO\probe.txt test"
  }
}

Assert-Asked "relative sibling OLMO read path" @{
  tool_name = "PowerShell"
  tool_input = @{
    command = "Get-Content ..\OLMO\README.md"
  }
}

Assert-Blocked "forward slash OLMO write path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = "C:/Dev/Projetos/OLMO/HANDOFF.md"
  }
}

Assert-Blocked "case-insensitive OLMO write path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = ("c:\dev\projetos\" + "olmo" + "\HANDOFF.md")
  }
}

$CoworkWorkspace = "C:\Dev\Projetos\" + "OLMO" + "_COWORK"

Assert-Blocked "absolute OLMO sibling cowork write path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = (Join-Path $CoworkWorkspace "README.md")
  }
}

Assert-Blocked "relative OLMO sibling cowork write path" @{
  tool_name = "PowerShell"
  tool_input = @{
    command = ("Set-Content ..\OLMO" + "_COWORK\probe.txt test")
  }
}

Assert-Asked "workdir OLMO sibling cowork read path" @{
  tool_name = "PowerShell"
  tool_input = @{
    command = "Get-Content .\HANDOFF.md"
    workdir = $CoworkWorkspace
  }
}

Assert-Blocked "workdir OLMO sibling cowork write path" @{
  tool_name = "PowerShell"
  tool_input = @{
    command = "Set-Content .\probe.txt test"
    workdir = $CoworkWorkspace
  }
}

$CoworkTypoWorkspace = "C:\Dev\Projetos\" + "OLMO" + "_COWOR"

Assert-Asked "absolute OLMO sibling cowork typo read path" @{
  tool_name = "Read"
  tool_input = @{
    file_path = (Join-Path $CoworkTypoWorkspace "README.md")
  }
}

Assert-Blocked "absolute OLMO sibling cowork typo write path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = (Join-Path $CoworkTypoWorkspace "README.md")
  }
}

$LegacyWorkspace = "C:\Dev\Projetos\" + "OLMO" + "_ROADMAP"

Assert-Asked "absolute legacy workspace read path" @{
  tool_name = "Read"
  tool_input = @{
    file_path = (Join-Path $LegacyWorkspace "README.md")
  }
}

Assert-Blocked "absolute legacy workspace write path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = (Join-Path $LegacyWorkspace "README.md")
  }
}

Assert-Blocked "relative legacy workspace write path" @{
  tool_name = "PowerShell"
  tool_input = @{
    command = ("Set-Content ..\OLMO" + "_ROADMAP\probe.txt test")
  }
}

Assert-Blocked "invalid JSON fail-closed" "{not-json"

Assert-Allowed "absolute OLMO_PROMETEUS path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = "C:\Dev\Projetos\OLMO_PROMETEUS\README.md"
  }
}

Assert-Allowed "OLMO_PROMETEUS read command" @{
  tool_name = "PowerShell"
  tool_input = @{
    command = "Get-Content C:\Dev\Projetos\OLMO_PROMETEUS\README.md"
  }
}

Assert-Allowed "forward slash OLMO_PROMETEUS path" @{
  tool_name = "Write"
  tool_input = @{
    file_path = "C:/Dev/Projetos/OLMO_PROMETEUS/README.md"
  }
}

if ($Failures.Count -gt 0) {
  foreach ($failure in $Failures) {
    Write-Host "[FAIL] $failure" -ForegroundColor Red
  }
  exit 1
}

Write-Host "[OK] OLMO boundary guard tests pass" -ForegroundColor Green
exit 0
