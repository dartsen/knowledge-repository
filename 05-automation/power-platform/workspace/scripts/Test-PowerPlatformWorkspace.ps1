<#
.SYNOPSIS
Runs static, non-writing validation of the Power Platform workspace.
.DESCRIPTION
Validates required content, PowerShell syntax, JSON, ignore protections, tracked-file safety,
explicit execution gates, and VS Code task safety. It does not authenticate, build, import, or deploy.
.EXAMPLE
.\Test-PowerPlatformWorkspace.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $modulePath = Join-Path $PSScriptRoot 'PowerPlatformWorkspace.Common.psm1'
    Import-Module -Name $modulePath -Force
    $workspaceRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
    $repositoryRoot = Get-WorkspaceGitRoot -StartPath $workspaceRoot
    $results = [System.Collections.Generic.List[object]]::new()

    function Add-ValidationResult {
        param(
            [ValidateSet('PASS', 'WARN', 'FAIL')]
            [string]$Status,
            [string]$Check,
            [string]$Details
        )

        $results.Add([pscustomobject]@{
                Status  = $Status
                Check   = $Check
                Details = $Details
            })
    }

    $requiredDirectories = @(
        'solutions',
        'components',
        'components\pcf',
        'components\plugins',
        'components\web-resources',
        'components\custom-connectors',
        'deployment-settings\dev',
        'deployment-settings\test',
        'deployment-settings\uat',
        'deployment-settings\prod',
        'scripts',
        'docs',
        'tests',
        'examples'
    )
    $missingDirectories = @($requiredDirectories | Where-Object {
            -not (Test-Path -LiteralPath (Join-Path $workspaceRoot $_) -PathType Container)
        })
    Add-ValidationResult -Status $(if ($missingDirectories.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'Required folders' `
        -Details $(if ($missingDirectories.Count -eq 0) { 'All required folders exist.' } else { "Missing: $($missingDirectories -join ', ')" })

    $requiredFiles = @(
        'README.md',
        'workspace-setup.md',
        'daily-development-workflow.md',
        'troubleshooting.md',
        'governance.md',
        'production-readiness-checklist.md',
        'power-platform.code-workspace',
        'solutions\README.md',
        'components\README.md',
        'deployment-settings\README.md',
        'scripts\README.md',
        'docs\architecture.md',
        'docs\solution-design-template.md',
        'docs\child-flow-contract-template.md',
        'docs\deployment-runbook-template.md',
        'docs\connection-inventory-template.md',
        'docs\environment-variable-inventory-template.md',
        'docs\pull-request-checklist.md',
        'tests\README.md',
        'tests\workspace-validation-checklist.md',
        'examples\README.md',
        'examples\example.local-config.json',
        'examples\daily-command-sequence.ps1'
    )
    $missingFiles = @($requiredFiles | Where-Object {
            -not (Test-Path -LiteralPath (Join-Path $workspaceRoot $_) -PathType Leaf)
        })
    Add-ValidationResult -Status $(if ($missingFiles.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'Required files' `
        -Details $(if ($missingFiles.Count -eq 0) { 'All required workspace files exist.' } else { "Missing: $($missingFiles -join ', ')" })

    $requiredScripts = @(
        'Initialize-PowerPlatformWorkspace.ps1',
        'Test-PowerPlatformPrerequisites.ps1',
        'Show-PowerPlatformContext.ps1',
        'Connect-PowerPlatformEnvironment.ps1',
        'Clone-PowerPlatformSolution.ps1',
        'Sync-PowerPlatformSolution.ps1',
        'Build-PowerPlatformSolution.ps1',
        'Export-DeploymentSettings.ps1',
        'Import-PowerPlatformSolution.ps1',
        'Test-PowerPlatformWorkspace.ps1'
    )
    $missingScripts = @($requiredScripts | Where-Object {
            -not (Test-Path -LiteralPath (Join-Path $PSScriptRoot $_) -PathType Leaf)
        })
    Add-ValidationResult -Status $(if ($missingScripts.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'Required scripts' `
        -Details $(if ($missingScripts.Count -eq 0) { 'All required scripts exist.' } else { "Missing: $($missingScripts -join ', ')" })

    $parseErrors = [System.Collections.Generic.List[string]]::new()
    $powerShellFiles = @(Get-ChildItem -LiteralPath $workspaceRoot -Recurse -File |
            Where-Object { $_.Extension -in @('.ps1', '.psm1') })
    foreach ($file in $powerShellFiles) {
        $tokens = $null
        $errors = $null
        [void][System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$errors)
        foreach ($parseError in @($errors)) {
            $parseErrors.Add("$($file.FullName):$($parseError.Extent.StartLineNumber): $($parseError.Message)")
        }
    }
    Add-ValidationResult -Status $(if ($parseErrors.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'PowerShell syntax' `
        -Details $(if ($parseErrors.Count -eq 0) { "$($powerShellFiles.Count) PowerShell files parsed." } else { $parseErrors -join ' | ' })

    $jsonErrors = [System.Collections.Generic.List[string]]::new()
    $jsonFiles = @(Get-ChildItem -LiteralPath $workspaceRoot -Recurse -File |
            Where-Object { $_.Extension -eq '.json' -or $_.Name -like '*.code-workspace' })
    foreach ($file in $jsonFiles) {
        try {
            Get-Content -Raw -LiteralPath $file.FullName | ConvertFrom-Json | Out-Null
        }
        catch {
            $jsonErrors.Add("$($file.FullName): $($_.Exception.Message)")
        }
    }
    $vscodeDirectory = Join-Path $repositoryRoot '.vscode'
    if (Test-Path -LiteralPath $vscodeDirectory) {
        $rootJsonFiles = @(Get-ChildItem -LiteralPath $vscodeDirectory -File -Filter '*.json')
        foreach ($file in $rootJsonFiles) {
            try {
                Get-Content -Raw -LiteralPath $file.FullName | ConvertFrom-Json | Out-Null
            }
            catch {
                $jsonErrors.Add("$($file.FullName): $($_.Exception.Message)")
            }
        }
        $jsonFiles += $rootJsonFiles
    }
    Add-ValidationResult -Status $(if ($jsonErrors.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'JSON syntax' `
        -Details $(if ($jsonErrors.Count -eq 0) { "$($jsonFiles.Count) JSON/workspace files parsed." } else { $jsonErrors -join ' | ' })

    $gitIgnorePath = Join-Path $repositoryRoot '.gitignore'
    $gitIgnoreText = Get-Content -Raw -LiteralPath $gitIgnorePath
    $requiredIgnorePatterns = @(
        '**/bin/',
        '**/obj/',
        '*.zip',
        '*.local.json',
        'secrets.json',
        'node_modules/',
        '*.pfx',
        '*.pem',
        '*.key',
        '**/deployment-settings/**/settings.local.json'
    )
    $missingIgnorePatterns = @($requiredIgnorePatterns | Where-Object { $gitIgnoreText -notmatch [regex]::Escape($_) })
    Add-ValidationResult -Status $(if ($missingIgnorePatterns.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check '.gitignore protections' `
        -Details $(if ($missingIgnorePatterns.Count -eq 0) { 'Required Power Platform and secret-file protections are present.' } else { "Missing: $($missingIgnorePatterns -join ', ')" })

    $trackedFiles = @(Invoke-WorkspaceNativeCommand -Command 'git' -Arguments @('-C', $repositoryRoot, 'ls-files') -CaptureOutput)
    $dangerousTracked = @($trackedFiles | Where-Object {
            $_ -match '(?i)\.(pfx|p12|pem|key)$' -or
            $_ -match '(?i)(^|/)secrets\.json$' -or
            $_ -match '(?i)settings\.local\.json$' -or
            $_ -match '(?i)workspace\.local\.json$'
        })
    Add-ValidationResult -Status $(if ($dangerousTracked.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'Tracked secret-file types' `
        -Details $(if ($dangerousTracked.Count -eq 0) { 'No certificate, private-key, secret, or live local settings files are tracked.' } else { "Tracked prohibited paths: $($dangerousTracked -join ', ')" })

    $likelySecretFiles = [System.Collections.Generic.List[string]]::new()
    $textExtensions = @('.ps1', '.psm1', '.json', '.md', '.yml', '.yaml', '.xml', '.cs')
    $secretPatterns = @(
        '-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----',
        '(?i)\bBearer\s+[A-Za-z0-9._~+/-]{24,}=*',
        '(?i)[?&]sig=[A-Za-z0-9%/+_-]{24,}'
    )
    foreach ($relativePath in $trackedFiles) {
        $fullPath = Join-Path $repositoryRoot ($relativePath -replace '/', '\')
        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            continue
        }
        if ([System.IO.Path]::GetExtension($fullPath) -notin $textExtensions) {
            continue
        }
        $content = Get-Content -Raw -LiteralPath $fullPath
        if ($secretPatterns | Where-Object { $content -match $_ }) {
            $likelySecretFiles.Add($relativePath)
        }
    }
    Add-ValidationResult -Status $(if ($likelySecretFiles.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'Likely sensitive values' `
        -Details $(if ($likelySecretFiles.Count -eq 0) { 'No high-confidence private key, bearer token, or signed URL pattern was found.' } else { "Review files without printing matched values: $($likelySecretFiles -join ', ')" })

    $environmentScripts = @(
        'Connect-PowerPlatformEnvironment.ps1',
        'Clone-PowerPlatformSolution.ps1',
        'Sync-PowerPlatformSolution.ps1',
        'Export-DeploymentSettings.ps1',
        'Import-PowerPlatformSolution.ps1'
    )
    $ungatedScripts = @($environmentScripts | Where-Object {
            $text = Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot $_)
            $text -notmatch '\[switch\]\$Execute' -or $text -notmatch 'if \(-not \$Execute\)'
        })
    Add-ValidationResult -Status $(if ($ungatedScripts.Count -eq 0) { 'PASS' } else { 'FAIL' }) `
        -Check 'Explicit environment execution' `
        -Details $(if ($ungatedScripts.Count -eq 0) { 'Every environment-facing wrapper requires -Execute.' } else { "Missing gate: $($ungatedScripts -join ', ')" })

    $tasksPath = Join-Path $repositoryRoot '.vscode\tasks.json'
    $tasksText = Get-Content -Raw -LiteralPath $tasksPath
    $productionTaskExposed = $tasksText -match '(?i)Import-PowerPlatformSolution|AllowProduction|IA-PROD|deploy.+production'
    Add-ValidationResult -Status $(if ($productionTaskExposed) { 'FAIL' } else { 'PASS' }) `
        -Check 'VS Code Production task safety' `
        -Details $(if ($productionTaskExposed) { 'A Production import/deployment indicator is present in tasks.json.' } else { 'No one-click import or Production deployment task is present.' })

    $projects = @(Get-ChildItem -LiteralPath (Join-Path $workspaceRoot 'solutions') -Recurse -File -Filter '*.cdsproj' -ErrorAction SilentlyContinue)
    Add-ValidationResult -Status $(if ($projects.Count -gt 0) { 'PASS' } else { 'WARN' }) `
        -Check 'Solution project discovery' `
        -Details $(if ($projects.Count -gt 0) { "$($projects.Count) .cdsproj project(s) discovered." } else { 'No .cdsproj exists yet; clone an unmanaged Development solution when ready.' })

    $results | Format-Table -AutoSize -Wrap
    $failures = @($results | Where-Object Status -eq 'FAIL')
    $warnings = @($results | Where-Object Status -eq 'WARN')
    Write-Host "Summary: $($results.Count - $failures.Count - $warnings.Count) pass, $($warnings.Count) warning, $($failures.Count) failure."
    if ($failures.Count -gt 0) {
        exit 1
    }
    exit 0
}
catch {
    Write-Error "Workspace validation failed: $($_.Exception.Message)"
    exit 1
}
