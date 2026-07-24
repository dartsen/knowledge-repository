---
title: Power Platform VS Code Workspace
description: Reusable enterprise workspace for solution-aware Power Platform source control, validation, build preparation, and controlled deployment.
domain: Automation
subdomain: Power Platform
content_type: Overview
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Quarterly
tags:
  - power-platform
  - vscode
  - application-lifecycle-management
related:
  - ../README.md
  - workspace-setup.md
  - docs/architecture.md
---

# Power Platform VS Code Workspace

This folder is a reusable, Windows-first workspace for Power Platform solution development. It supports Power Apps, Power Automate cloud and child flows, Dataverse, connection references, environment variables, PCF, plug-ins, web resources, custom connectors, Git review, local solution synchronization, package builds, deployment settings, and human-controlled imports.

The operating model is:

```text
VS Code
  + Power Platform Tools
  + Power Platform CLI
  + named authentication profiles
  + local solution projects
  + Git repository
  + Power Platform Development environment
```

Use the maker portals as the primary visual designers for apps, flows, tables, AI Builder assets, and Copilot Studio configuration. Use VS Code for source review, scripts, custom code, builds, deployment configuration, documentation, and Git history.

## Safety Boundary

- Scripts do not store credentials or environment identifiers.
- Environment-facing scripts display the selected PAC context before action.
- Authentication creation, cloning, synchronization, settings export, and import require `-Execute`; without it they show the intended action.
- Production import is blocked unless `-AllowProduction`, `-Execute`, and typed confirmation are all supplied.
- The VS Code task list has no import or Production deployment task.
- Nothing in this workspace authenticates, deploys, publishes, deletes, or edits an environment automatically.

## Folder Map

| Path | Purpose |
|---|---|
| `solutions/` | One folder per cloned or initialized `.cdsproj` solution project. |
| `components/` | Source for PCF controls, plug-ins, web resources, and custom connectors. |
| `deployment-settings/` | Placeholder-only Dev, Test, UAT, and Production settings templates. |
| `scripts/` | Safe PowerShell wrappers for prerequisites, context, clone, sync, build, settings, import, and validation. |
| `docs/` | Architecture, inventories, contracts, design, runbook, and pull-request templates. |
| `tests/` | Human validation checklist and test guidance. |
| `examples/` | Local configuration example and an educational daily command sequence. |

## Getting Started

1. Open `power-platform.code-workspace` in VS Code.
2. Follow [workspace setup](workspace-setup.md).
3. Run `scripts/Test-PowerPlatformPrerequisites.ps1`.
4. Copy `examples/example.local-config.json` to `workspace.local.json`; replace placeholders but never add credentials.
5. Create named PAC profiles manually, for example `IA-DEV`, `IA-TEST`, `IA-UAT`, and `IA-PROD`.
6. Run `scripts/Show-PowerPlatformContext.ps1` before any environment-facing command.
7. Preview a clone command, review it, then rerun with `-Execute` only for the intended Development environment.

Microsoft documents Power Platform Tools as providing PAC CLI in the VS Code terminal, and the current CLI reference documents `pac solution clone`, `sync`, `create-settings`, and `import`: [developer tools](https://learn.microsoft.com/power-platform/developer/tools), [solution command reference](https://learn.microsoft.com/power-platform/developer/cli/reference/solution).

## Daily Development

Follow [daily development workflow](daily-development-workflow.md):

```text
pull -> branch -> select Development profile -> verify context
-> make maker changes -> sync -> review -> validate -> build -> commit -> PR
```

Cloud flows must be solution-aware. Use connection references for connector bindings and environment variables for environment-specific configuration. Microsoft describes environment variables as solution components for ALM and distinguishes them from connection credentials: [environment variable guidance](https://learn.microsoft.com/power-apps/maker/data-platform/environmentvariables).

## Build and Deployment Reference

`Build-PowerPlatformSolution.ps1` runs restore and build only when a developer chooses to invoke it. It finds packages but never imports them. `Export-DeploymentSettings.ps1` generates a settings file from a chosen solution ZIP. `Import-PowerPlatformSolution.ps1` is intentionally gated and suitable only for an approved Test, UAT, or exceptional Production runbook.

Development uses unmanaged solutions. Downstream environments should receive managed solutions where organizationally supported. The same approved artifact should progress through Test and UAT before Production.

## Command Quick Reference

```powershell
.\scripts\Test-PowerPlatformPrerequisites.ps1
.\scripts\Show-PowerPlatformContext.ps1
.\scripts\Clone-PowerPlatformSolution.ps1 -SolutionUniqueName "ExampleSolution" -OutputDirectory ".\solutions\example-solution" -AuthProfileName "IA-DEV"
.\scripts\Sync-PowerPlatformSolution.ps1 -SolutionProjectPath ".\solutions\example-solution\example-solution.cdsproj" -AuthProfileName "IA-DEV"
.\scripts\Test-PowerPlatformWorkspace.ps1
.\scripts\Build-PowerPlatformSolution.ps1 -SolutionProjectPath ".\solutions\example-solution\example-solution.cdsproj" -Configuration Release
```

The clone and sync examples above are previews until `-Execute` is explicitly added.

## Continue Reading

- [Setup](workspace-setup.md)
- [Daily workflow](daily-development-workflow.md)
- [Architecture](docs/architecture.md)
- [Governance](governance.md)
- [Production readiness](production-readiness-checklist.md)
- [Troubleshooting](troubleshooting.md)
- [Solution project rules](solutions/README.md)
- [Custom component rules](components/README.md)
- [Deployment settings](deployment-settings/README.md)
- [Script reference](scripts/README.md)
- [Workspace tests](tests/README.md)
- [Safe examples](examples/README.md)
- [Solution design template](docs/solution-design-template.md)
- [Child-flow contract template](docs/child-flow-contract-template.md)
- [Deployment runbook template](docs/deployment-runbook-template.md)
- [Connection inventory template](docs/connection-inventory-template.md)
- [Environment-variable inventory template](docs/environment-variable-inventory-template.md)
- [Pull-request checklist](docs/pull-request-checklist.md)
