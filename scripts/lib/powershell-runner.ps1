function Get-RepoPowerShellInvocation {
  $executable = (Get-Process -Id $PID).Path
  if ([string]::IsNullOrWhiteSpace($executable)) {
    $command = Get-Command pwsh -ErrorAction SilentlyContinue
    if ($null -eq $command) {
      $command = Get-Command powershell -ErrorAction SilentlyContinue
    }
    if ($null -ne $command) {
      $executable = $command.Source
    }
  }

  if ([string]::IsNullOrWhiteSpace($executable)) {
    throw "Cannot locate current PowerShell executable"
  }

  $isCoreUnix = ($PSVersionTable.PSEdition -eq "Core") -and (-not $IsWindows)
  $baseArgs = @("-NoProfile")
  if (-not $isCoreUnix) {
    $baseArgs += @("-ExecutionPolicy", "Bypass")
  }

  [pscustomobject]@{
    Executable = $executable
    BaseArgs = $baseArgs
    IsCoreUnix = $isCoreUnix
  }
}

function Invoke-RepoPowerShell {
  param(
    [Parameter(Mandatory = $true)]
    [string]$File,
    [string[]]$Arguments = @(),
    [AllowEmptyString()]
    [string]$InputText
  )

  $invocation = Get-RepoPowerShellInvocation
  $commandArgs = @($invocation.BaseArgs + @("-File", $File) + $Arguments)

  if ($PSBoundParameters.ContainsKey("InputText")) {
    return [string]($InputText | & $invocation.Executable @commandArgs)
  }

  & $invocation.Executable @commandArgs
}

function Invoke-CurrentPowerShell {
  param(
    [string[]]$Arguments = @(),
    [AllowEmptyString()]
    [string]$InputText
  )

  $invocation = Get-RepoPowerShellInvocation
  $normalizedArgs = [System.Collections.Generic.List[string]]::new()

  for ($i = 0; $i -lt $Arguments.Count; $i++) {
    if ($invocation.IsCoreUnix -and $Arguments[$i] -eq "-ExecutionPolicy") {
      $i++
      continue
    }
    $normalizedArgs.Add($Arguments[$i]) | Out-Null
  }

  if (($normalizedArgs | Where-Object { $_ -eq "-NoProfile" }).Count -eq 0) {
    $normalizedArgs.Insert(0, "-NoProfile")
  }

  if ($PSBoundParameters.ContainsKey("InputText")) {
    return [string]($InputText | & $invocation.Executable @($normalizedArgs.ToArray()))
  }

  & $invocation.Executable @($normalizedArgs.ToArray())
}
