<#
.SYNOPSIS
Displays Git, local solution, PAC profile, and current environment context.
.DESCRIPTION
Runs read-only context commands and warns when any returned text appears Production-like.
.EXAMPLE
.\Show-PowerPlatformContext.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $modulePath = Join-Path $PSScriptRoot 'PowerPlatformWorkspace.Common.psm1'
    Import-Module -Name $modulePath -Force

    $workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
    $gitRoot = Get-WorkspaceGitRoot -StartPath $workspaceRoot
    $branch = Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'branch', '--show-current') -CaptureOutput
    $status = Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'status', '--short') -CaptureOutput
    $projects = @(Get-ChildItem -LiteralPath (Join-Path $workspaceRoot 'solutions') -Recurse -File -Filter '*.cdsproj' -ErrorAction SilentlyContinue)

    Write-Host "Current directory: $((Get-Location).Path)"
    Write-Host "Git repository: $gitRoot"
    Write-Host "Git branch: $($branch -join '')"
    Write-Host "Git working tree: $(if ($status.Count -eq 0) { 'clean' } else { 'has changes' })"
    Write-Host "Solution projects: $($projects.Count)"
    $projects | ForEach-Object { Write-Host "  $($_.FullName)" }

    if (-not (Get-Command -Name 'pac' -ErrorAction SilentlyContinue)) {
        Write-Warning 'PAC CLI is not available; authentication and environment context cannot be displayed.'
        exit 0
    }

    $authList = Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments @('auth', 'list') -CaptureOutput
    Write-Host 'PAC authentication profiles:'
    $authList | ForEach-Object { Write-Host $_ }

    try {
        $who = Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments @('auth', 'who') -CaptureOutput
        Write-Host 'Selected PAC context:'
        $who | ForEach-Object { Write-Host $_ }
        $contextText = (@($authList) + @($who)) -join [Environment]::NewLine
        if (Test-ProductionLike -Text $contextText) {
            Write-Warning 'PRODUCTION-LIKE POWER PLATFORM CONTEXT DETECTED. Do not clone, synchronize, import, publish, or modify without an approved Production runbook.'
        }
        elseif (Test-UatLike -Text $contextText) {
            Write-Warning 'UAT-like Power Platform context detected. Confirm the approved UAT procedure before any action.'
        }
        else {
            Write-Host 'Context classification: Development/Test/Unknown. Verify the environment explicitly.'
        }
    }
    catch {
        Write-Warning "No selected PAC context could be confirmed: $($_.Exception.Message)"
    }

    exit 0
}
catch {
    Write-Error "Context inspection failed: $($_.Exception.Message)"
    exit 1
}
