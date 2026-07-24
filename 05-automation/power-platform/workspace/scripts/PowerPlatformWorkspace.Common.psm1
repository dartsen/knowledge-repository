Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Invoke-WorkspaceNativeCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Command,

        [Parameter()]
        [string[]]$Arguments = @(),

        [Parameter()]
        [switch]$CaptureOutput
    )

    $commandInfo = Get-Command -Name $Command -ErrorAction Stop
    $output = & $commandInfo.Source @Arguments 2>&1
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        throw "'$Command' failed with exit code $exitCode."
    }

    if ($CaptureOutput) {
        return @($output | ForEach-Object { $_.ToString() })
    }

    $output | ForEach-Object { Write-Host $_ }
}

function Get-WorkspaceGitRoot {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$StartPath = (Get-Location).Path
    )

    Push-Location -LiteralPath $StartPath
    try {
        $rootOutput = @(Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('rev-parse', '--show-toplevel') -CaptureOutput)
        if ($rootOutput.Count -eq 0) {
            throw 'Git did not return a repository root.'
        }
        return [System.IO.Path]::GetFullPath($rootOutput[0])
    }
    finally {
        Pop-Location
    }
}

function Test-ProductionLike {
    [CmdletBinding()]
    param(
        [Parameter()]
        [AllowEmptyString()]
        [string]$Text
    )

    return $Text -match '(?i)(^|[^a-z])(prod|production)([^a-z]|$)'
}

function Test-UatLike {
    [CmdletBinding()]
    param(
        [Parameter()]
        [AllowEmptyString()]
        [string]$Text
    )

    return $Text -match '(?i)(^|[^a-z])uat([^a-z]|$)'
}

function Format-WorkspaceCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Command,

        [Parameter()]
        [string[]]$Arguments = @()
    )

    $quoted = foreach ($argument in $Arguments) {
        if ($argument -match '[\s"]') {
            '"{0}"' -f ($argument -replace '"', '\"')
        }
        else {
            $argument
        }
    }

    return (@($Command) + $quoted) -join ' '
}

function Select-WorkspacePacProfile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ProfileName
    )

    Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments @('auth', 'select', '--name', $ProfileName)
    $context = Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments @('auth', 'who') -CaptureOutput
    $context | ForEach-Object { Write-Host $_ }
    return ($context -join [Environment]::NewLine)
}

Export-ModuleMember -Function @(
    'Invoke-WorkspaceNativeCommand',
    'Get-WorkspaceGitRoot',
    'Test-ProductionLike',
    'Test-UatLike',
    'Format-WorkspaceCommand',
    'Select-WorkspacePacProfile'
)
