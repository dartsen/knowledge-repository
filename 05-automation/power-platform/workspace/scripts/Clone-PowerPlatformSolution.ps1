<#
.SYNOPSIS
Previews or explicitly clones an unmanaged Power Platform solution project.
.PARAMETER SolutionUniqueName
Dataverse solution unique name, not display name.
.PARAMETER OutputDirectory
New or empty destination directory.
.PARAMETER AuthProfileName
Named PAC authentication profile.
.PARAMETER AllowDirty
Allows execution with uncommitted Git changes.
.PARAMETER AllowProductionSource
Exceptional override for a Production-like source context.
.PARAMETER Execute
Required before profile selection or cloning.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[A-Za-z_][A-Za-z0-9_]*$')]
    [string]$SolutionUniqueName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$OutputDirectory,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$AuthProfileName,

    [Parameter()]
    [switch]$AllowDirty,

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
    $targetPath = if ([System.IO.Path]::IsPathRooted($OutputDirectory)) {
        [System.IO.Path]::GetFullPath($OutputDirectory)
    }
    else {
        [System.IO.Path]::GetFullPath((Join-Path $gitRoot $OutputDirectory))
    }

    $status = Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'status', '--porcelain', '--untracked-files=all') -CaptureOutput
    if ($status.Count -gt 0 -and -not $AllowDirty) {
        throw 'Git has uncommitted changes. Commit or stash them, or deliberately pass -AllowDirty.'
    }

    if (Test-Path -LiteralPath $targetPath) {
        $children = @(Get-ChildItem -LiteralPath $targetPath -Force)
        if ($children.Count -gt 0) {
            throw "Target solution folder is not empty: $targetPath"
        }
    }

    $arguments = @('solution', 'clone', '--name', $SolutionUniqueName, '--outputDirectory', $targetPath)
    Write-Host "Git branch: $((Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $gitRoot, 'branch', '--show-current') -CaptureOutput) -join '')"
    Write-Host "Selected profile: $AuthProfileName"
    Write-Host "Solution unique name: $SolutionUniqueName"
    Write-Host "Output directory: $targetPath"
    Write-Host "Intended command: $(Format-WorkspaceCommand -Command 'pac' -Arguments $arguments)"

    if (-not $Execute) {
        Write-Warning 'Preview only. Add -Execute after verifying the Development profile and output path.'
        exit 0
    }

    if (-not $PSCmdlet.ShouldProcess($targetPath, "Clone solution '$SolutionUniqueName' from profile '$AuthProfileName'")) {
        exit 0
    }

    $context = Select-WorkspacePacProfile -ProfileName $AuthProfileName
    if ((Test-ProductionLike -Text "$AuthProfileName`n$context") -and -not $AllowProductionSource) {
        throw 'Production-like source context detected. Cloning is blocked unless -AllowProductionSource is explicitly supplied.'
    }

    $parent = Split-Path -Parent $targetPath
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments $arguments

    $projects = @(Get-ChildItem -LiteralPath $targetPath -Recurse -File -Filter '*.cdsproj')
    if ($projects.Count -eq 0) {
        throw 'PAC completed but no .cdsproj was found in the target folder.'
    }

    Write-Host "Clone completed. Review these projects:"
    $projects | ForEach-Object { Write-Host "  $($_.FullName)" }
    Write-Host 'Next: review source, run workspace validation, and create an intentional Git baseline.'
    exit 0
}
catch {
    Write-Error "Solution clone failed: $($_.Exception.Message)"
    exit 1
}
