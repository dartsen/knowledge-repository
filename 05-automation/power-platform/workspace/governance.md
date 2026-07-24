---
title: Power Platform Workspace Governance
description: Minimum engineering, identity, configuration, security, support, and change-control standards for solution delivery.
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
  - power-platform-governance
  - alm
  - security
related:
  - README.md
  - production-readiness-checklist.md
---

# Power Platform Workspace Governance

## Minimum Standards

- Develop in unmanaged solutions. Deploy managed solutions to Test, UAT, and Production where organizationally supported.
- Put cloud flows, apps, Dataverse components, connection references, and environment variable definitions inside deliberate solution boundaries.
- Externalize environment-specific configuration. Never copy Development values blindly into Production.
- Use approved secret-management methods; do not place credentials in source, environment variable examples, flow definitions, logs, or local configuration.
- Production connections must use approved service or workload identities where supported, not personal developer identities.
- Apply DLP, least privilege, Dataverse roles/teams, environment access controls, auditing, and retention appropriate to the data classification.
- Prohibit direct Production editing. Production must be reproducible from source and approved deployment configuration.
- Store every change in Git on a short-lived branch. Protect `main`, require pull requests, validate builds, scan for secrets, and avoid force pushes to shared branches.
- Trace each release to a commit, versioned artifact, approvals, settings record, test evidence, and support owner.
- Reverse a bad Production change with an approved rollback, forward fix, or Git revert commit; never rewrite shared history.

## Flow Engineering

Reusable child flows require a narrow responsibility, stable request/response contract, bounded retries, timeout behavior, idempotency decision, supported outcome codes, correlation ID, telemetry, owner, and backward-compatibility policy.

Production flows require explicit error handling, terminal-failure capture, business-outcome reconciliation, runbook, support ownership, and service-level expectations. A technically successful run is not proof that the business outcome completed.

## Environment Separation

| Environment | Purpose | Change method | Identity expectation |
|---|---|---|---|
| Development | Maker and engineering changes | Unmanaged solution | Named developer profile |
| Test | Technical and integration verification | Managed artifact import | Controlled test identities |
| UAT | Business acceptance | Same managed artifact | Representative approved identities |
| Production | Approved business operation | Controlled managed release | Service/workload-owned connections |

## Pull-Request Evidence

Document scope, solution unique name/version, diff review, tests, security/DLP impact, connection references, environment variables, dependency changes, monitoring, deployment settings, failure recovery, rollback, owners, and approvals. Use the [pull-request checklist](docs/pull-request-checklist.md).
