<#
.SYNOPSIS
Previews or explicitly synchronizes a local solution project from its selected Power Platform environment.
.PARAMETER SolutionProjectPath
Path to the solution `.cdsproj`.
.PARAMETER AuthProfileName
Named PAC profile, normally the Development profile.
.PARAMETER AllowDirty
Allows synchronization while leaving current changes in place.
.PARAMETER AutoStash
Stashes tracked and untracked changes before sync and restores them afterward.
.PARAMETER AllowProductionSource
Exceptional override for a Production-like source context.
.PARAMETER Execute
Required before profile selection or synchronization.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$SolutionProjectPath,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$AuthProfileName,

    [Parameter()]
    [switch]$AllowDirty,

    [Parameter()]
    [switch]$AutoStash,

    [Parameter()]
    [switch]$AllowProductionSource,

    [Parameter()]
    [switch]$Execute
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $modulePath = Join-Path $PSScriptRoot 'PowerPlatformWorkspace.Common.psm1'
    Import-Module -Name $modulePath -Force
    $workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
    $gitRoot = Get-WorkspaceGitRoot -StartPath $workspaceRoot
    $projectPath = if ([System.IO.Path]::IsPathRooted($SolutionProjectPath)) {
        [System.IO.Path]::GetFullPath($SolutionProjectPath)
    }
    else {
        [System.IO.Path]::GetFullPath((Join-Path $workspaceRoot $SolutionProjectPath))
    }

    if (-not (Test-Path -LiteralPath $projectPath -PathType Leaf) -or [System.IO.Path]::GetExtension($projectPath) -ne '.cdsproj') {
        throw "Solution project does not exist or is not a .cdsproj: $projectPath"
    }

    $projectDirectory = Split-Path -Parent $projectPath
    $branch = (Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'branch', '--show-current') -CaptureOutput) -join ''
    $status = Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'status', '--porcelain', '--untracked-files=all') -CaptureOutput
    $isDirty = $status.Count -gt 0

    if ($isDirty -and -not $AllowDirty -and -not $AutoStash) {
        throw 'Git has uncommitted changes. Commit them, pass -AutoStash, or deliberately pass -AllowDirty.'
    }

    Write-Host "Git branch: $branch"
    Write-Host "Git working tree: $(if ($isDirty) { 'has changes' } else { 'clean' })"
    Write-Host "Selected profile: $AuthProfileName"
    Write-Host "Solution project: $projectPath"
    Write-Host 'Intended command (from project directory): pac solution sync'

    if (-not $Execute) {
        Write-Warning 'Preview only. Add -Execute after verifying the Development profile and protected Git state.'
        exit 0
    }

    if (-not $PSCmdlet.ShouldProcess($projectPath, "Synchronize solution from profile '$AuthProfileName'")) {
        exit 0
    }

    $context = Select-WorkspacePacProfile -ProfileName $AuthProfileName
    if ((Test-ProductionLike -Text "$AuthProfileName`n$context") -and -not $AllowProductionSource) {
        throw 'Production-like context detected. Synchronization is blocked unless -AllowProductionSource is explicitly supplied.'
    }

    $stashCreated = $false
    $stashName = "power-platform-sync-$([DateTime]::UtcNow.ToString('yyyyMMddTHHmmssZ'))"
    try {
        if ($isDirty -and $AutoStash) {
            Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'stash', 'push', '--include-untracked', '--message', $stashName)
            $stashCreated = $true
            Write-Host "Created named stash: $stashName"
        }

        Push-Location -LiteralPath $projectDirectory
        try {
            Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments @('solution', 'sync')
        }
        finally {
            Pop-Location
        }
    }
    finally {
        if ($stashCreated) {
            Write-Host "Attempting to restore stash: $stashName"
            & git -C $gitRoot stash pop --index
            if ($LASTEXITCODE -ne 0) {
                Write-Warning "Stash restoration conflicted. The stash is preserved; resolve deliberately: $stashName"
            }
            else {
                Write-Host 'Stashed changes restored successfully.'
            }
        }
    }

    Write-Host 'Git status after synchronization:'
    Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'status', '--short')
    Write-Host 'Synchronization completed. Review the diff; no commit was created.'
    exit 0
}
catch {
    Write-Error "Solution synchronization failed: $($_.Exception.Message)"
    exit 1
}
