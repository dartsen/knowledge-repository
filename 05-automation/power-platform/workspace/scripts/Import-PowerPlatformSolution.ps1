<#
.SYNOPSIS
Previews or explicitly imports a selected solution ZIP through a safety-gated PAC profile.
.PARAMETER SolutionZipPath
Existing solution ZIP path.
.PARAMETER AuthProfileName
Named PAC profile for the target environment.
.PARAMETER SettingsFile
Optional deployment settings JSON file.
.PARAMETER PublishChanges
Adds `--publish-changes` only when explicitly selected.
.PARAMETER Execute
Required before profile selection or import.
.PARAMETER AllowProduction
Additional required switch for a Production-like context.
#>
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$SolutionZipPath,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$AuthProfileName,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SettingsFile,

    [Parameter()]
    [switch]$PublishChanges,

    [Parameter()]
    [switch]$Execute,

    [Parameter()]
    [switch]$AllowProduction
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $modulePath = Join-Path $PSScriptRoot 'PowerPlatformWorkspace.Common.psm1'
    Import-Module -Name $modulePath -Force
    $workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
    $zipPath = if ([System.IO.Path]::IsPathRooted($SolutionZipPath)) {
        [System.IO.Path]::GetFullPath($SolutionZipPath)
    }
    else {
        [System.IO.Path]::GetFullPath((Join-Path $workspaceRoot $SolutionZipPath))
    }
    if (-not (Test-Path -LiteralPath $zipPath -PathType Leaf) -or [System.IO.Path]::GetExtension($zipPath) -ne '.zip') {
        throw "Solution ZIP does not exist: $zipPath"
    }

    $settingsPath = $null
    if ($PSBoundParameters.ContainsKey('SettingsFile')) {
        $settingsPath = if ([System.IO.Path]::IsPathRooted($SettingsFile)) {
            [System.IO.Path]::GetFullPath($SettingsFile)
        }
        else {
            [System.IO.Path]::GetFullPath((Join-Path $workspaceRoot $SettingsFile))
        }
        if (-not (Test-Path -LiteralPath $settingsPath -PathType Leaf) -or [System.IO.Path]::GetExtension($settingsPath) -ne '.json') {
            throw "Deployment settings JSON does not exist: $settingsPath"
        }
        Get-Content -Raw -LiteralPath $settingsPath | ConvertFrom-Json | Out-Null
    }

    $arguments = @('solution', 'import', '--path', $zipPath)
    if ($settingsPath) {
        $arguments += @('--settings-file', $settingsPath)
    }
    if ($PublishChanges) {
        $arguments += '--publish-changes'
    }

    Write-Host "Target profile: $AuthProfileName"
    Write-Host "Solution ZIP: $zipPath"
    Write-Host "Settings file: $(if ($settingsPath) { $settingsPath } else { '(none)' })"
    Write-Host "Publish changes: $($PublishChanges.IsPresent)"
    Write-Host "Intended command: $(Format-WorkspaceCommand -Command 'pac' -Arguments $arguments)"

    if (-not $Execute) {
        Write-Warning 'Preview only. Add -Execute only for an approved Test or UAT import. Production remains blocked by default.'
        exit 0
    }
    if (-not $PSCmdlet.ShouldProcess($AuthProfileName, "Import solution package '$zipPath'")) {
        exit 0
    }

    $context = Select-WorkspacePacProfile -ProfileName $AuthProfileName
    $classificationText = "$AuthProfileName`n$context"
    $isProduction = Test-ProductionLike -Text $classificationText
    $isUat = Test-UatLike -Text $classificationText

    if ($isProduction -and -not $AllowProduction) {
        throw 'Production-like context detected. Import is blocked unless -AllowProduction is explicitly supplied.'
    }
    if ($isProduction) {
        Write-Warning 'PRODUCTION IMPORT REQUESTED. Confirm approvals, artifact identity, settings, recovery plan, and change window.'
        $confirmation = Read-Host 'Type IMPORT TO PRODUCTION to continue'
        if ($confirmation -cne 'IMPORT TO PRODUCTION') {
            throw 'Production confirmation did not match. No import was run.'
        }
    }
    elseif ($isUat) {
        $confirmation = Read-Host 'Type IMPORT TO UAT to continue'
        if ($confirmation -cne 'IMPORT TO UAT') {
            throw 'UAT confirmation did not match. No import was run.'
        }
    }

    Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments $arguments
    Write-Host 'Solution import completed. Validate import results, bindings, component state, security, telemetry, and business smoke tests.'
    exit 0
}
catch {
    Write-Error "Solution import failed: $($_.Exception.Message)"
    exit 1
}
