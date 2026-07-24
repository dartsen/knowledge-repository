<#
.SYNOPSIS
Previews or explicitly creates a named PAC authentication profile.
.PARAMETER ProfileName
Distinct profile name such as IA-DEV, IA-TEST, IA-UAT, or IA-PROD.
.PARAMETER EnvironmentUrl
Absolute HTTPS Power Platform environment URL.
.PARAMETER Execute
Required before PAC authentication creation is invoked.
.EXAMPLE
.\Connect-PowerPlatformEnvironment.ps1 -ProfileName IA-DEV -EnvironmentUrl https://replace-with-dev.crm.dynamics.com
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9._-]{1,63}$')]
    [string]$ProfileName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [uri]$EnvironmentUrl,

    [Parameter()]
    [switch]$Execute
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $modulePath = Join-Path $PSScriptRoot 'PowerPlatformWorkspace.Common.psm1'
    Import-Module -Name $modulePath -Force

    if ($EnvironmentUrl.Scheme -ne 'https' -or -not $EnvironmentUrl.IsAbsoluteUri) {
        throw 'EnvironmentUrl must be an absolute HTTPS URL.'
    }

    $arguments = @('auth', 'create', '--name', $ProfileName, '--environment', $EnvironmentUrl.AbsoluteUri)
    Write-Host "Selected profile: $ProfileName"
    Write-Host "Selected environment: $($EnvironmentUrl.AbsoluteUri)"
    Write-Host "Intended command: $(Format-WorkspaceCommand -Command 'pac' -Arguments $arguments)"

    if (-not $Execute) {
        Write-Warning 'Preview only. Add -Execute to start PAC interactive authentication.'
        exit 0
    }

    if ($PSCmdlet.ShouldProcess($EnvironmentUrl.AbsoluteUri, "Create PAC authentication profile '$ProfileName'")) {
        Invoke-WorkspaceNativeCommand -Command 'pac' -Arguments $arguments
        Write-Host "PAC authentication profile created: $ProfileName"
    }

    exit 0
}
catch {
    Write-Error "PAC profile creation failed: $($_.Exception.Message)"
    exit 1
}
