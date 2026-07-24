---
title: Power Platform Workspace Tests
description: Static validation scope and human verification guidance for the Power Platform workspace.
domain: Automation
subdomain: Power Platform
content_type: Quick Reference
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Annual
tags:
  - testing
  - workspace-validation
  - power-platform
related:
  - ../README.md
  - workspace-validation-checklist.md
---

# Power Platform Workspace Tests

Run `../scripts/Test-PowerPlatformWorkspace.ps1` for static structure, JSON, PowerShell parsing, ignore, tracked-file safety, and task checks. This does not authenticate, synchronize, build, import, or deploy.

Use [workspace validation checklist](workspace-validation-checklist.md) for the human checks that require an approved Development, Test, or UAT environment.
