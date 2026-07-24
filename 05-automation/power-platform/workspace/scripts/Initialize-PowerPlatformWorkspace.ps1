<#
.SYNOPSIS
Verifies the workspace structure and optionally creates an ignored local configuration file.
.DESCRIPTION
This idempotent local setup does not install tools, authenticate, or contact Power Platform.
.PARAMETER CreateLocalConfig
Copies the placeholder example to workspace.local.json when that file does not exist.
.EXAMPLE
.\Initialize-PowerPlatformWorkspace.ps1 -CreateLocalConfig
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter()]
    [switch]$CreateLocalConfig
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
    $requiredDirectories = @(
        'solutions',
        'components',
        'deployment-settings',
        'scripts',
        'docs',
        'tests',
        'examples'
    )

    foreach ($directory in $requiredDirectories) {
        $path = Join-Path $workspaceRoot $directory
        if (-not (Test-Path -LiteralPath $path -PathType Container)) {
            throw "Required workspace directory is missing: $path"
        }
    }

    if ($CreateLocalConfig) {
        $examplePath = Join-Path $workspaceRoot 'examples\example.local-config.json'
        $localPath = Join-Path $workspaceRoot 'workspace.local.json'
        if (Test-Path -LiteralPath $localPath) {
            Write-Host "Local configuration already exists; leaving it unchanged: $localPath"
        }
        elseif ($PSCmdlet.ShouldProcess($localPath, 'Copy placeholder local configuration')) {
            Copy-Item -LiteralPath $examplePath -Destination $localPath
            Write-Host "Created ignored local configuration: $localPath"
        }
    }

    Write-Host "Power Platform workspace structure is ready: $workspaceRoot"
    exit 0
}
catch {
    Write-Error "Workspace initialization failed: $($_.Exception.Message)"
    exit 1
}
