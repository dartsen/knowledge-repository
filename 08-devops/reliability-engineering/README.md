---
title: Reliability Engineering
description: Production guidance for designing, operating, and improving services against explicit reliability objectives.
domain: DevOps
subdomain: Reliability Engineering
content_type: Overview
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - reliability-engineering
  - site-reliability-engineering
  - service-level-objectives
related:
  - ../observability/README.md
  - ../../14-learning-paths/devops/reliability-observability.md
  - ../../15-examples/devops/reliable-order-status-service.md
---

# Reliability Engineering

Reliability engineering turns business expectations into measurable service behavior, resilient design, safe operations, and prioritized improvement. It applies whether or not an organization has a team named SRE.

## Start Here

1. [Architecture](architecture.md) - define critical user journeys, objectives, dependencies, and failure boundaries.
2. [Implementation](implementation.md) - build resilience, test failure paths, and make releases safe.
3. [Operations](operations.md) - run on-call, incident, recovery, capacity, and improvement practices.
4. [Security and governance](security-governance.md) - assign accountability and protect operational controls and evidence.
5. [Troubleshooting](troubleshooting.md) - investigate from user impact to the smallest failing boundary.
6. [Official references](official-references.md) - review the primary sources used for current claims.

Follow the centralized [reliability and observability learning path](../../14-learning-paths/devops/reliability-observability.md), then apply the [reliable order-status service worked example](../../15-examples/devops/reliable-order-status-service.md).

The [SLI and telemetry implementation supplement](implementation-guide.md) and [combined incident runbook](operations-runbook.md) join reliability and observability when one service team owns both disciplines.

## Reliability Contract

A production service needs an explicit contract:

| Element | Decision |
|---|---|
| Critical user journey | The user-visible outcome being protected |
| Service-level indicator (SLI) | How good and total events are measured |
| Service-level objective (SLO) | Target over a defined window |
| Error budget | Tolerated unreliability and the actions it governs |
| Recovery objectives | RTO, RPO, restore point, and degraded-mode expectations |
| Ownership | Product, engineering, operations, dependency, and escalation owners |
| Evidence | Telemetry, tests, incident records, recovery exercises, and review dates |

Do not copy a provider SLA into a workload SLO. A provider commitment covers one dependency; a workload objective covers an end-to-end user outcome and the architecture that delivers it.

## Core Practices

- Prefer user-journey SLIs over infrastructure availability alone.
- Set realistic objectives below 100 percent and approve an error-budget policy with product and engineering stakeholders.
- Assume dependencies and individual components will fail; isolate faults and define degraded behavior.
- Make retries bounded, delayed, observable, and safe through idempotency.
- Test backup restoration, failover, load, dependency loss, and rollback before they are needed.
- Page only for urgent, actionable conditions tied to user impact; route lower-urgency work to tickets or reports.
- Use blameless learning reviews with owned, time-bound actions.

## Definition of Production Ready

A service is not production ready until its critical journeys, SLOs, dependency behavior, capacity assumptions, observability, incident ownership, rollback, restoration, and security controls have been exercised in a production-like environment.

## Organization-Specific Adoption Notes

> **Scope: Organization-Specific.** Record local severity names, paging rotations, service tiers, objective approval authorities, change-freeze rules, crisis communications, regulatory evidence, and recovery-test cadence in Project Delivery. Do not place real endpoint names, personal contact details, tenant identifiers, credentials, or sensitive incident evidence in this public guide.
