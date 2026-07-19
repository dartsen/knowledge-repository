---
title: Power Platform Architecture
description: Architecture method for Power Platform workload, data, integration, identity, environment, ALM, reliability, and experience decisions.
domain: Automation
subdomain: Power Platform
content_type: Architecture Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - power-platform-architecture
  - dataverse
  - well-architected
related:
  - README.md
  - product-capabilities.md
---

# Power Platform Architecture

Use Power Platform Well-Architected's current pillars—Reliability, Security, Operational Excellence, Performance Efficiency, and Experience Optimization—as quality lenses. They are not a substitute for requirements or tradeoffs.

## Reference Flow

```text
Internal users -> canvas/model-driven app -> Dataverse / approved connectors
External users -> Power Pages -----------> Dataverse
Events/schedules -> Power Automate ------> Dataverse, APIs, queues, files
Users/channels -> Copilot Studio --------> approved knowledge and bounded tools
Professional extensions -> PCF / plug-ins / custom APIs / Azure services

Admin center + environments + data policies + Managed Environments
Solutions + Git/build + pipelines -> development -> test/UAT -> production
Telemetry, inventory, support, security, licensing, and cost span every layer
```

## Architecture Decisions

1. **Process and experience:** users, critical journey, accessibility, device/channel, offline, latency, volume, failure and human decision.
2. **Data:** authoritative system, Dataverse table grain, GUID primary identifier, business alternate keys, relationships, ownership, status/state, audit, retention, files, and reporting.
3. **Integration:** connector/API/event/queue/file boundary, identity, timeout, retry, idempotency, throttling, pagination, concurrency, eventual consistency, and reconciliation.
4. **Identity and authorization:** maker/admin/user/workload/external-user roles, Dataverse security roles/teams, table and row access, Power Pages web roles/table permissions, and tool/action permissions.
5. **Environment:** personal/developer, shared development where justified, test/UAT, production, default-environment boundary, region, Dataverse, Managed Environments, groups, data policies, and recovery.
6. **ALM:** custom solution ownership, publishers, dependencies, versioning, environment variables, connection references, source format/repository, build/check/test, managed downstream release, configuration and rollback.
7. **Operations:** business/technical telemetry, inventory, owner continuity, support tier, limits/licensing/capacity, dependency health, runbook, and retirement.

## Data Modeling Rules

Keep the platform GUID as the table's primary identifier and define unique business identity with alternate keys where supported; do not conflate them. Model a stable record grain, normalized relationships where appropriate, choice/status semantics, ownership, audit, and optimistic concurrency. Avoid using Excel or a SharePoint list as an implicit high-scale transactional database.

## Reliability Boundary

Cloud flows and connectors can retry or be throttled; design business idempotency and classify transient versus terminal errors. Long-running processes need durable state, timeout/escalation, compensation, and reconciliation. Apps need error, loading, offline/conflict, and degraded-state behavior. External sites and agents need safe fallback when Dataverse, knowledge, a connector, or model is unavailable.
