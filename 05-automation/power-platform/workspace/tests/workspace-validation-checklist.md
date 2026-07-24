---
title: Power Platform Workspace Validation Checklist
description: Human validation checklist for local tools, safe environment selection, solution source, configuration, and downstream readiness.
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
  - validation
  - checklist
  - power-platform
related:
  - README.md
  - ../production-readiness-checklist.md
---

# Power Platform Workspace Validation Checklist

- [ ] Prerequisite script reports required tools accurately.
- [ ] PAC profile names map unambiguously to Development, Test, UAT, and Production.
- [ ] Context script warns on a Production-like profile or URL.
- [ ] Preview mode renders environment-facing commands without executing them.
- [ ] Clone rejects a dirty tree and nonempty target unless an explicit override is chosen.
- [ ] Sync protects local changes and preserves a stash when restoration conflicts.
- [ ] Import requires `-Execute`, respects `-WhatIf`, and blocks Production by default.
- [ ] Static validator parses every PowerShell and JSON file.
- [ ] No certificate, key, live local settings, credentials, or connection IDs are tracked.
- [ ] No VS Code task imports or deploys to Production.
- [ ] Documentation describes maker-portal and VS Code responsibilities.
- [ ] Test/UAT deployment is performed only through an approved runbook.
