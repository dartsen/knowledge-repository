---
title: Power Platform Production Readiness Checklist
description: Release gate for a supportable, secure, observable, and reproducible Power Platform workload.
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
  - production-readiness
  - release-gate
  - power-platform
related:
  - governance.md
  - docs/deployment-runbook-template.md
---

# Power Platform Production Readiness Checklist

## Solution and Source

- [ ] Workload has an owned solution boundary and organization-owned publisher.
- [ ] Development source is synchronized and the Git diff is reviewed.
- [ ] `.cdsproj` restore/build and applicable tests pass.
- [ ] Managed package is versioned and traceable to the approved commit.
- [ ] The same artifact passed Test and UAT.
- [ ] Dependencies, upgrade behavior, and rollback/forward-fix approach are documented.

## Configuration and Identity

- [ ] Connection references are included, inventoried, and bound to approved target connections.
- [ ] Environment variables are included, inventoried, validated, and contain no secrets in source.
- [ ] Production connections do not depend on personal developer identities.
- [ ] Service identity ownership, rotation, access, and break-glass procedures are documented.
- [ ] Deployment settings were reviewed without committing live IDs or values.

## Security and Governance

- [ ] Dataverse roles, teams, sharing, field access, and least privilege are tested by persona.
- [ ] DLP and connector classifications are approved.
- [ ] Data classification, retention, audit, privacy, licensing, and capacity impacts are accepted.
- [ ] No credentials, tokens, private keys, certificates, or Production identifiers are tracked.
- [ ] Direct Production editing is prohibited and change approvals are recorded.

## Reliability and Support

- [ ] Flows use correlation IDs, bounded retries, timeouts, idempotency, and explicit terminal failure handling.
- [ ] Child-flow contracts and backward compatibility are documented.
- [ ] Business outcome, failure, backlog, latency, connection, and dependency telemetry exist.
- [ ] Alert ownership, support hours, runbook, escalation, recovery, and reconciliation are tested.
- [ ] Business owner, technical owner, support owner, and platform owner accept the release.
