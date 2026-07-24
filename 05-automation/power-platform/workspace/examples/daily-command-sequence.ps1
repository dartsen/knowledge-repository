<#
.SYNOPSIS
Educational daily Power Platform command sequence.
.DESCRIPTION
The sequence runs only when -RunExample is supplied. PAC synchronization remains a preview because -Execute is intentionally omitted.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [switch]$RunExample
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $RunExample) {
    Write-Host 'Educational example only. Read this file and replace every placeholder before running individual commands.'
    exit 0
}

# Start from an up-to-date protected branch.
git switch main
git pull --ff-only

# Create a short-lived feature branch; never work directly on main.
git switch -c feature/example-change

# Select and verify the named Development profile.
pac auth select --name 'IA-DEV'
pac auth who

# Synchronize only after maker changes are saved/published and local work is protected.
# This wrapper call is intentionally preview-only because -Execute is omitted.
$workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$syncScript = Join-Path $workspaceRoot 'scripts\Sync-PowerPlatformSolution.ps1'
& $syncScript `
    -SolutionProjectPath '.\solutions\example-solution\example-solution.cdsproj' `
    -AuthProfileName 'IA-DEV'

# Review all generated changes before staging.
git status
git diff

# Run static workspace validation.
$validationScript = Join-Path $workspaceRoot 'scripts\Test-PowerPlatformWorkspace.ps1'
& $validationScript

# Build only when a real local package is required; this example leaves it commented.
# $buildScript = Join-Path $workspaceRoot 'scripts\Build-PowerPlatformSolution.ps1'
# & $buildScript -SolutionProjectPath '.\solutions\example-solution\example-solution.cdsproj' -Configuration Release

# After review and validation, stage, commit, and push deliberately.
git add .
git commit -m 'Add example Power Platform change'
git push -u origin feature/example-change
