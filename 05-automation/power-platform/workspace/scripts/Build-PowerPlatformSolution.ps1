<#
.SYNOPSIS
Restores and builds a selected local Power Platform solution project.
.DESCRIPTION
This local-only script never imports a generated package.
.PARAMETER SolutionProjectPath
Path to the solution `.cdsproj`.
.PARAMETER Configuration
Build configuration: Debug or Release.
.PARAMETER Clean
Runs `dotnet clean` before restore and build.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$SolutionProjectPath,

    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [Parameter()]
    [switch]$Clean
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $modulePath = Join-Path $PSScriptRoot 'PowerPlatformWorkspace.Common.psm1'
    Import-Module -Name $modulePath -Force
    if (-not (Get-Command -Name 'dotnet' -ErrorAction SilentlyContinue)) {
        throw '.NET SDK is required. Install an approved supported SDK; this script does not install software.'
    }

    $workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
    $projectPath = if ([System.IO.Path]::IsPathRooted($SolutionProjectPath)) {
        [System.IO.Path]::GetFullPath($SolutionProjectPath)
    }
    else {
        [System.IO.Path]::GetFullPath((Join-Path $workspaceRoot $SolutionProjectPath))
    }

    if (-not (Test-Path -LiteralPath $projectPath -PathType Leaf) -or [System.IO.Path]::GetExtension($projectPath) -ne '.cdsproj') {
        throw "Solution project does not exist or is not a .cdsproj: $projectPath"
    }

    Write-Host "Solution project: $projectPath"
    Write-Host "Configuration: $Configuration"
    if ($Clean) {
        Invoke-WorkspaceNativeCommand -Command 'dotnet' -Arguments @('clean', $projectPath, '--configuration', $Configuration)
    }
    Invoke-WorkspaceNativeCommand -Command 'dotnet' -Arguments @('restore', $projectPath)
    Invoke-WorkspaceNativeCommand -Command 'dotnet' -Arguments @('build', $projectPath, '--configuration', $Configuration, '--no-restore')

    $projectDirectory = Split-Path -Parent $projectPath
    $packages = @(Get-ChildItem -LiteralPath $projectDirectory -Recurse -File -Filter '*.zip' |
            Where-Object { $_.FullName -match '[\\/]bin[\\/]' } |
            Sort-Object FullName)
    if ($packages.Count -eq 0) {
        Write-Warning 'Build completed, but no ZIP package was discovered under a bin directory.'
    }
    else {
        Write-Host 'Generated solution packages:'
        $packages | ForEach-Object {
            Write-Host ("  {0} ({1:N0} bytes)" -f $_.FullName, $_.Length)
        }
    }

    Write-Host 'Build completed. No package was imported.'
    exit 0
}
catch {
    Write-Error "Solution build failed: $($_.Exception.Message)"
    exit 1
}
