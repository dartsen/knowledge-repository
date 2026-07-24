---
title: Power Platform Workspace Script Reference
description: Safe invocation model and command reference for Power Platform workspace PowerShell scripts.
domain: Automation
subdomain: Power Platform
content_type: Quick Reference
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Quarterly
tags:
  - powershell
  - power-platform-cli
  - automation-safety
related:
  - ../README.md
  - ../workspace-setup.md
---

# Power Platform Workspace Script Reference

| Script | Purpose | Default behavior |
|---|---|---|
| `Initialize-PowerPlatformWorkspace.ps1` | Verify structure and optionally copy local config example | Local, idempotent |
| `Test-PowerPlatformPrerequisites.ps1` | Report required/recommended/optional tools and repository state | Read-only |
| `Show-PowerPlatformContext.ps1` | Show Git and PAC context with Production warning | Read-only |
| `Connect-PowerPlatformEnvironment.ps1` | Create a named interactive PAC auth profile | Preview; requires `-Execute` |
| `Clone-PowerPlatformSolution.ps1` | Clone an unmanaged solution project | Preview; requires `-Execute` |
| `Sync-PowerPlatformSolution.ps1` | Synchronize maker changes into local source | Preview; requires `-Execute` |
| `Build-PowerPlatformSolution.ps1` | Restore/build a chosen `.cdsproj` and list packages | Runs only when directly invoked |
| `Export-DeploymentSettings.ps1` | Generate settings from a chosen solution ZIP | Preview; requires `-Execute` |
| `Import-PowerPlatformSolution.ps1` | Controlled import to an explicitly selected environment | Preview; requires `-Execute`; Production blocked |
| `Test-PowerPlatformWorkspace.ps1` | Validate structure, syntax, JSON, ignore rules, tracked files, and task safety | Read-only |

Use `Get-Help .\scripts\<script>.ps1 -Full` for parameters and examples. Review every preview, then add `-Execute` only for an approved environment action. `-WhatIf` is available on environment-changing wrappers through `SupportsShouldProcess`.
