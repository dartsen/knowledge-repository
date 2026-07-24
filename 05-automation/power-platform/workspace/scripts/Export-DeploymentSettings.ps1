<#
.SYNOPSIS
Previews or explicitly creates a deployment settings JSON file from a solution ZIP.
.PARAMETER SolutionZipPath
Existing solution ZIP path.
.PARAMETER OutputPath
New deployment settings JSON path.
.PARAMETER AuthProfileName
Named PAC profile shown and confirmed for operator context.
.PARAMETER Force
Allows replacement of an existing output file.
.PARAMETER Execute
Required before PAC is invoked.
#>
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$SolutionZipPath,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputPath,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$AuthProfileName,

    [Parameter()]
    [switch]$Force,

    [Parameter()]
    [switch]$Execute
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
    $settingsPath = if ([System.IO.Path]::IsPathRooted($OutputPath)) {
        [System.IO.Path]::GetFullPath($OutputPath)
    }
    else {
        [System.IO.Path]::GetFullPath((Join-Path $workspaceRoot $OutputPath))
    }

    if (-not (Test-Path -LiteralPath $zipPath -PathType Leaf) -or [System.IO.Path]::GetExtension($zipPath) -ne '.zip') {
        throw "Solution ZIP does not exist: $zipPath"
    }
    if (Test-Path -LiteralPath $settingsPath -PathType Container) {
        throw "OutputPath must be a JSON file path: $settingsPath"
    }
    if ([System.IO.Path]::GetExtension($settingsPath) -ne '.json') {
        throw 'OutputPath must use the .json extension.'
    }
    if ((Test-Path -LiteralPath $settingsPath) -and -not $Force) {
        throw 'Output settings file already exists. Review it and pass -Force only when replacement is intended.'
    }

    $arguments = @('solution', 'create-settings', '--solution-zip', $zipPath, '--settings-file', $settingsPath)
    Write-Host "Selected profile: $AuthProfileName"
    Write-Host "Solution ZIP: $zipPath"
    Write-Host "Output settings: $settingsPath"
    Write-Host "Intended command: $(Format-WorkspaceCommand -Command 'pac' -Arguments $arguments)"

    if (-not $Execute) {
        Write-Warning 'Preview only. Add -Execute after reviewing the paths and selected context.'
        exit 0
    }
    if (-not $PSCmdlet.ShouldProcess($settingsPath, 'Create deployment settings from solution ZIP')) {
        exit 0
    }

    Select-WorkspacePacProfile -ProfileName $AuthProfileName | Out-Null
    $parent = Split-Path -Parent $settingsPath
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    if ($Force -and (Test-Path -LiteralPath $settingsPath)) {
        Remove-Item -LiteralPath $settingsPath
    }
    Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments $arguments
    if (-not (Test-Path -LiteralPath $settingsPath -PathType Leaf)) {
        throw 'PAC completed but the deployment settings file was not created.'
    }

    Write-Host 'Deployment settings created. Review environment-variable values and connection-reference bindings without logging sensitive values.'
    exit 0
}
catch {
    Write-Error "Deployment settings generation failed: $($_.Exception.Message)"
    exit 1
}
