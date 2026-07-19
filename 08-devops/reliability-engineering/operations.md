---
title: Reliability Operations
description: Operating model for SLOs, on-call, incidents, capacity, recovery, and continuous improvement.
domain: DevOps
subdomain: Reliability Engineering
content_type: SOP
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - on-call
  - incident-management
  - error-budgets
related:
  - README.md
  - troubleshooting.md
  - ../observability/operations.md
---

# Reliability Operations

## Operating Cadence

| Cadence | Review |
|---|---|
| Continuous | SLO status, urgent alerts, release health, security signals |
| Daily or shift | Open incidents, risky changes, dependency advisories, capacity anomalies |
| Weekly | Error-budget burn, noisy alerts, unresolved actions, queue/backlog, on-call load |
| Monthly | Objective fitness, capacity forecast, restore/failover evidence, toil, recurring failures |
| Quarterly or risk-based | Service tier, recovery exercise, dependency review, access review, lifecycle risks |

## On-Call Readiness

An on-call rotation needs a service inventory, severity model, actionable alerts, current runbooks, safe diagnostic access, escalation paths, communication templates, and a handoff process. Measure after-hours pages, false positives, repeated manual steps, and unresolved ownership as reliability work.

## Incident Flow

```text
Detect -> validate user impact -> assign incident command
  -> contain and communicate -> mitigate or recover
  -> verify the user journey -> monitor stability
  -> learn, assign actions, and improve controls
```

Preserve an event timeline, decisions, changes, and evidence. During response, optimize for safe restoration of the user outcome. Root-cause depth and permanent remediation follow after stabilization.

## Error-Budget Decisions

The approved policy should define thresholds and consequences before an objective is missed. Possible actions include tighter release gates, reduced change volume, focused reliability work, dependency remediation, or executive risk acceptance. Apply the policy consistently, but allow documented exceptions for security emergencies or other explicitly approved conditions.

## Recovery Exercises

Run exercises with a declared scenario, observer, expected outcomes, abort conditions, and evidence plan. Verify restoration, identity and network dependencies, business validation, backlog drain, data reconciliation, failback, and stakeholder communication. Record actual RTO/RPO and convert gaps into owned backlog items.

## Toil and Improvement

Track repetitive, manual, automatable, tactical work that scales with service growth. Automate only after the safe decision boundary is understood. A runbook step that requires judgment remains human-controlled; a deterministic, frequent, well-tested step is an automation candidate.

## Service Review Questions

1. Is the SLO still aligned to the user and business risk?
2. Which failure class consumed the most error budget?
3. Which alert or runbook failed to accelerate recovery?
4. Are capacity and dependency assumptions still valid?
5. Which repeated task should be eliminated, automated, or shifted left?
6. Has access, recovery evidence, and ownership been reviewed on schedule?
