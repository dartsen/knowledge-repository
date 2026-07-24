---
title: Power Platform Workspace Troubleshooting
description: Symptom-driven troubleshooting for PAC, authentication, solution source, builds, configuration, policies, and Git synchronization.
domain: Automation
subdomain: Power Platform
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Quarterly
tags:
  - troubleshooting
  - power-platform-cli
  - solutions
related:
  - README.md
  - workspace-setup.md
---

# Power Platform Workspace Troubleshooting

| Symptom | Likely cause | Investigation | Corrective action |
|---|---|---|---|
| `pac` is not recognized | CLI not installed or not on `PATH` | Run `Get-Command pac`; check the VS Code terminal | Install Power Platform Tools or an approved PAC distribution; reopen the terminal. |
| PAC works only in VS Code PowerShell | Extension-scoped PAC installation | Compare `Get-Command pac` inside and outside VS Code | Use the VS Code terminal or install PAC through an approved system-wide method. |
| No PAC authentication profile | No interactive profile exists | Run `pac auth list` | Create a named profile manually with the connection wrapper and `-Execute`. |
| Wrong environment selected | Stale or misnamed profile | Run `pac auth who` and context script | Stop; select the intended named profile and verify again. |
| Solution not found | Display name used, wrong environment, or access | Run `pac solution list` in Development | Use the solution unique name and confirm permissions/environment. |
| Permission denied | Missing role, license, or tenant policy | Capture command, profile, environment, and platform error | Request least-privilege access; do not bypass policy. |
| `pac solution clone` fails | Profile, solution, output, dependency, or CLI issue | Verify context, unique name, empty output folder, PAC version | Correct the failing prerequisite and rerun the preview before `-Execute`. |
| `pac solution sync` fails | Wrong project folder, remote change, or solution issue | Verify `.cdsproj`, profile, Git state, and PAC output | Correct context; preserve local work; rerun only against Development. |
| `.cdsproj` cannot be found | Wrong path or clone incomplete | Search `solutions/` recursively | Supply the exact project path or repeat an approved clone into an empty folder. |
| Build fails | SDK/package restore, component compile, or project issue | Run `dotnet --info`; inspect first error | Restore access/dependencies and fix the source; do not import a failed artifact. |
| Connection references fail after import | Missing target connection or binding | Compare inventory, settings, owner, connector, and DLP | Create/approve the target connection and apply the correct untracked settings. |
| Environment variables are empty | Value omitted or wrong definition | Review target value and deployment settings | Add the approved target value; do not hardcode it in app/flow source. |
| Flow is disabled after deployment | Connection, owner, policy, or activation issue | Check import result, connections, owner, DLP, and flow errors | Repair approved bindings/ownership, test, then enable through the controlled process. |
| DLP blocks a connector | Policy classifies connector combination as disallowed | Review environment policy and flow connectors | Redesign or obtain governance approval; do not evade DLP. |
| Production connection belongs to a developer | Personal connection was bound downstream | Inspect connection owner and inventory | Replace it with an approved service/workload identity and retest. |
| Git diff is unexpectedly large | Wrong environment/solution, platform normalization, or unrelated maker edits | Stop; compare profile, solution version, component list, and prior commit | Reconcile intentionally; do not bulk accept generated changes without review. |
| Local changes conflict with synchronized source | Sync ran over uncommitted work | Check Git status and named stash | Restore/merge deliberately; preserve a conflicting stash until resolved. |
| Deployment settings have missing references | Solution/configuration drift | Compare settings file with connection and environment variable inventories | Regenerate from the approved package and supply target bindings outside Git. |
| Solution dependencies are missing | Required managed/base solution absent or incompatible | Review import dependency report and solution layering | Deploy approved prerequisites first or correct the solution boundary/version. |

For CLI syntax, use the current [PAC solution command reference](https://learn.microsoft.com/power-platform/developer/cli/reference/solution).
