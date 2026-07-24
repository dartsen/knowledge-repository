<#
.SYNOPSIS
Reports local prerequisites for the Power Platform workspace.
.DESCRIPTION
Checks tools and repository state without installing software or changing authentication.
.EXAMPLE
.\Test-PowerPlatformPrerequisites.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $rows = [System.Collections.Generic.List[object]]::new()

    function Add-Check {
        param(
            [string]$Name,
            [string]$Classification,
            [bool]$Available,
            [string]$Details,
            [string]$Guidance
        )

        $rows.Add([pscustomobject]@{
                Check          = $Name
                Classification = $Classification
                Status         = if ($Available) { 'PASS' } else { 'MISSING' }
                Details        = $Details
                Guidance       = if ($Available) { '' } else { $Guidance }
            })
    }

    $toolChecks = @(
        @{ Name = 'git'; Classification = 'Required'; Guidance = 'Install Git for Windows and reopen the terminal.' },
        @{ Name = 'code'; Classification = 'Recommended'; Guidance = 'Install VS Code and enable the code command.' },
        @{ Name = 'pac'; Classification = 'Required'; Guidance = 'Install Microsoft Power Platform Tools or an approved PAC CLI distribution.' },
        @{ Name = 'dotnet'; Classification = 'Required'; Guidance = 'Install an organization-approved supported .NET SDK.' },
        @{ Name = 'node'; Classification = 'Optional'; Guidance = 'Install Node.js when PCF or Node-based components require it.' }
    )

    foreach ($tool in $toolChecks) {
        $command = Get-Command -Name $tool.Name -ErrorAction SilentlyContinue
        Add-Check -Name $tool.Name -Classification $tool.Classification -Available ($null -ne $command) `
            -Details $(if ($command) { $command.Source } else { 'Not found' }) -Guidance $tool.Guidance
    }

    $powerShellSupported = $PSVersionTable.PSVersion.Major -ge 7
    Add-Check -Name 'PowerShell 7+' -Classification 'Recommended' -Available $powerShellSupported `
        -Details $PSVersionTable.PSVersion.ToString() -Guidance 'Install PowerShell 7 for consistent local and CI behavior.'

    $gitCommand = Get-Command -Name 'git' -ErrorAction SilentlyContinue
    $gitRootOutput = $null
    $inGit = $false
    if ($gitCommand) {
        $gitRootOutput = & $gitCommand.Source rev-parse --show-toplevel 2>$null
        $inGit = $LASTEXITCODE -eq 0
    }
    Add-Check -Name 'Git repository' -Classification 'Required' -Available $inGit `
        -Details $(if ($inGit) { $gitRootOutput } else { 'Current path is not in a Git repository' }) `
        -Guidance 'Open the workspace from a Git checkout.'

    $workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
    $projects = @(Get-ChildItem -LiteralPath (Join-Path $workspaceRoot 'solutions') -Recurse -File -Filter '*.cdsproj' -ErrorAction SilentlyContinue)
    Add-Check -Name '.cdsproj projects' -Classification 'Recommended' -Available ($projects.Count -gt 0) `
        -Details "$($projects.Count) discovered" -Guidance 'Clone an unmanaged Development solution when ready.'

    $pac = Get-Command -Name 'pac' -ErrorAction SilentlyContinue
    if ($pac) {
        $authOutput = @(& pac auth list 2>&1 | ForEach-Object { $_.ToString() })
        $authAvailable = $LASTEXITCODE -eq 0 -and ($authOutput -join ' ') -notmatch '(?i)no auth|no profile'
        Add-Check -Name 'PAC authentication profiles' -Classification 'Recommended' -Available $authAvailable `
            -Details $(if ($authAvailable) { 'PAC returned an authentication profile list' } else { 'No usable profile detected' }) `
            -Guidance 'Create named profiles interactively; never store credentials in this repository.'
    }
    else {
        Add-Check -Name 'PAC authentication profiles' -Classification 'Recommended' -Available $false `
            -Details 'PAC unavailable' -Guidance 'Install PAC, then create named profiles interactively.'
    }

    $rows | Format-Table -AutoSize -Wrap
    $missingRequired = @($rows | Where-Object { $_.Classification -eq 'Required' -and $_.Status -ne 'PASS' })
    if ($missingRequired.Count -gt 0) {
        Write-Error "$($missingRequired.Count) required prerequisite(s) are missing."
        exit 1
    }

    Write-Host 'All required prerequisites passed. Recommended or optional items may still need attention.'
    exit 0
}
catch {
    Write-Error "Prerequisite validation failed: $($_.Exception.Message)"
    exit 1
}
