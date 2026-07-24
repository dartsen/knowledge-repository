---
title: Power Platform Pull Request Checklist
description: Review checklist for synchronized solution source, configuration, reliability, security, testing, deployment, and recovery.
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
  - pull-request
  - review-checklist
  - power-platform
related:
  - ../daily-development-workflow.md
  - deployment-runbook-template.md
---

# Power Platform Pull Request Checklist

- [ ] Correct short-lived branch is used; work is not directly on `main`.
- [ ] Git diff is clean, intentional, and limited to the described solution change.
- [ ] Solution source was synchronized from the intended Development environment.
- [ ] Static validation and applicable solution build passed.
- [ ] No secrets, credentials, certificates, local settings, live connection IDs, or private data are tracked.
- [ ] No personal Production connection is introduced.
- [ ] Environment-specific values are externalized.
- [ ] Required connection references and environment variables are in the solution.
- [ ] Documentation, inventories, child-flow contracts, and ownership are updated.
- [ ] Error handling, timeouts, bounded retries, idempotency, and compensation are reviewed.
- [ ] Correlation, monitoring, alerting, terminal-failure capture, and reconciliation are reviewed.
- [ ] Test evidence covers success, failure, permissions/personas, integration, and recovery.
- [ ] Deployment settings and dependencies are reviewed.
- [ ] Rollback or forward-fix plan and support handoff are documented.
