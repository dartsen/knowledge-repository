---
title: Power Platform Daily Development Workflow
description: Controlled daily flow from Git update through maker changes, solution synchronization, review, validation, build preparation, and pull request.
domain: Automation
subdomain: Power Platform
content_type: SOP
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Quarterly
tags:
  - power-platform-alm
  - git-workflow
  - solution-sync
related:
  - README.md
  - docs/pull-request-checklist.md
---

# Power Platform Daily Development Workflow

```text
Pull latest Git changes
  -> Create a short-lived branch
  -> Select the Development PAC profile
  -> Verify the active environment
  -> Make maker-portal changes
  -> Save and publish where required
  -> Commit or stash local changes
  -> Run solution synchronization
  -> Review Git diff
  -> Run workspace validation
  -> Build solution when needed
  -> Commit and push
  -> Open pull request
```

## Copy-Ready Sequence

Replace every example value before use. The clone and sync wrappers remain previews unless `-Execute` is added deliberately.

```powershell
git switch main
git pull --ff-only
git switch -c feature/example-change

pac auth select --name "IA-DEV"
pac auth who
.\scripts\Show-PowerPlatformContext.ps1

# Make and publish intended changes in the maker portal.

git status
.\scripts\Sync-PowerPlatformSolution.ps1 `
    -SolutionProjectPath ".\solutions\example-solution\example-solution.cdsproj" `
    -AuthProfileName "IA-DEV"

# After reviewing the preview, rerun the preceding command with -Execute.

git status
git diff
.\scripts\Test-PowerPlatformWorkspace.ps1

# Build only when a local package is required.
.\scripts\Build-PowerPlatformSolution.ps1 `
    -SolutionProjectPath ".\solutions\example-solution\example-solution.cdsproj" `
    -Configuration Release

git add .
git commit -m "Add example Power Platform change"
git push -u origin feature/example-change
```

## Review Rules

- Synchronize only against Development.
- Stop when the selected environment is ambiguous or Production-like.
- Treat unexpectedly large generated diffs as a signal to verify the solution, profile, and maker changes.
- Review component additions, deletions, environment variable definitions, connection references, flow definitions, and solution version changes.
- Do not commit generated ZIP packages, local deployment settings, credentials, or personal connection data.
- Require a pull request with testing, risk, deployment settings, support, and rollback evidence.
