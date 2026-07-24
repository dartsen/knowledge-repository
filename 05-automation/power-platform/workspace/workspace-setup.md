---
title: Power Platform Workspace Setup
description: Step-by-step setup for VS Code, Power Platform Tools, PAC profiles, solution source, Git, build preparation, and controlled downstream imports.
domain: Automation
subdomain: Power Platform
content_type: Implementation Guide
level: Beginner
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Quarterly
tags:
  - power-platform-cli
  - workspace-setup
  - vscode
related:
  - README.md
  - troubleshooting.md
---

# Power Platform Workspace Setup

## 1. Install the Local Tools

Install VS Code, the Microsoft Power Platform Tools extension, Git, and a supported .NET SDK. Power Platform Tools exposes PAC CLI in the VS Code terminal; a separate PAC installation may be required for terminals outside VS Code. See [Microsoft's Power Platform Tools page](https://learn.microsoft.com/power-platform/developer/tools).

Open a VS Code PowerShell terminal and verify:

```powershell
code --version
git --version
pac --version
dotnet --info
.\scripts\Test-PowerPlatformPrerequisites.ps1
```

Node.js is optional unless a PCF or other Node-based component requires it.

## 2. Configure the Workspace

Open `power-platform.code-workspace`. Copy the example configuration:

```powershell
Copy-Item .\examples\example.local-config.json .\workspace.local.json
```

Replace placeholders with local paths, profile names, and environment URLs. Never put passwords, client secrets, certificates, tokens, or connection IDs in this file. `workspace.local.json` is ignored by Git.

## 3. Create Named Authentication Profiles

Review a command before creating a profile:

```powershell
.\scripts\Connect-PowerPlatformEnvironment.ps1 `
    -ProfileName "IA-DEV" `
    -EnvironmentUrl "https://replace-with-dev.crm.dynamics.com"
```

Run the exact reviewed command by adding `-Execute`. Authentication remains interactive and is managed by PAC; the script stores no credentials.

Recommended separation:

| Stage | Profile | Expected solution type |
|---|---|---|
| Development | `IA-DEV` | Unmanaged |
| Test | `IA-TEST` | Managed |
| UAT | `IA-UAT` | Managed |
| Production | `IA-PROD` | Managed, approved release only |

List and select profiles manually:

```powershell
pac auth list
pac auth select --name "IA-DEV"
pac auth who
```

## 4. List and Clone an Unmanaged Solution

Confirm Development first:

```powershell
pac auth select --name "IA-DEV"
pac auth who
pac solution list
```

Preview the clone:

```powershell
.\scripts\Clone-PowerPlatformSolution.ps1 `
    -SolutionUniqueName "ExampleSolution" `
    -OutputDirectory ".\solutions\example-solution" `
    -AuthProfileName "IA-DEV"
```

After verifying the profile and output path, rerun with `-Execute`. Use the unique name, not the display name. The script rejects a dirty Git tree by default, blocks a Production-like profile, refuses a nonempty destination, and verifies that PAC created a `.cdsproj`.

## 5. Review and Baseline the Project

Review the generated `.cdsproj` and solution source. Do not hand-edit generated files unless the format and change are supported.

```powershell
git status
git diff
.\scripts\Test-PowerPlatformWorkspace.ps1
git add .\solutions\example-solution
git commit -m "Add baseline for ExampleSolution"
```

The repository owner decides when to commit; workspace scripts never commit.

## 6. Synchronize Maker Changes

Save and publish maker changes where required, then make the local tree clean by committing or stashing deliberate work. Preview:

```powershell
.\scripts\Sync-PowerPlatformSolution.ps1 `
    -SolutionProjectPath ".\solutions\example-solution\example-solution.cdsproj" `
    -AuthProfileName "IA-DEV"
```

Add `-Execute` only after reviewing the active context. `-AutoStash` can protect tracked and untracked local changes; the script preserves the stash if restoration conflicts.

## 7. Build a Package Locally

When a real solution project exists and a developer chooses to build:

```powershell
.\scripts\Build-PowerPlatformSolution.ps1 `
    -SolutionProjectPath ".\solutions\example-solution\example-solution.cdsproj" `
    -Configuration Release `
    -Clean
```

The script runs `dotnet restore` and `dotnet build`, then reports discovered ZIP packages. It does not import them.

## 8. Generate Deployment Settings

The current PAC command is `pac solution create-settings --solution-zip <zip> --settings-file <json>`. Preview it through:

```powershell
.\scripts\Export-DeploymentSettings.ps1 `
    -SolutionZipPath ".\solutions\example-solution\bin\Release\ExampleSolution_managed.zip" `
    -OutputPath ".\deployment-settings\test\settings.local.json" `
    -AuthProfileName "IA-TEST"
```

Add `-Execute` after review. Populate environment-variable values and connection-reference bindings through the approved process. Treat real IDs as environment configuration and keep `settings.local.json` untracked.

## 9. Import to Test or UAT

Imports are human-run and gated:

```powershell
.\scripts\Import-PowerPlatformSolution.ps1 `
    -SolutionZipPath ".\solutions\example-solution\bin\Release\ExampleSolution_managed.zip" `
    -AuthProfileName "IA-TEST" `
    -SettingsFile ".\deployment-settings\test\settings.local.json"
```

This is a preview. Add `-Execute` only after approval and context review. UAT requires typed confirmation. Production is blocked unless `-AllowProduction` is also provided and the operator types the exact confirmation phrase.

## 10. Troubleshoot

Use [troubleshooting](troubleshooting.md), `pac auth who`, `git status`, and the static workspace validator. Do not solve an environment-selection problem by bypassing safeguards.
