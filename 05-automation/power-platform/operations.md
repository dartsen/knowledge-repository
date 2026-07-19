---
title: Power Platform Operations Runbook
description: Operating model for Power Platform inventory, ownership, monitoring, incidents, capacity, licensing, change, and retirement.
domain: Automation
subdomain: Power Platform
content_type: Runbook
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - power-platform-operations
  - admin-center
  - support
related:
  - README.md
  - troubleshooting.md
---

# Power Platform Operations Runbook

## Inventory and Ownership

Maintain environment, solution, app, flow, agent, site, Dataverse table/data product, connector, custom code, connection/identity, pipeline, dependency, license/capacity, business owner, technical owner, support owner, criticality, classification, and lifecycle. Use current Power Platform admin center Inventory, Usage, Monitor, and Actions capabilities as the native baseline; validate API/connector coverage before automating a control.

## Monitor

- User-critical app/site/agent journey success, latency, abandonment, and availability.
- Flow trigger, run outcome, duration, retry, throttle, backlog/state, terminal failure, and business completion/reconciliation.
- Dataverse API errors, service protection, plug-in/custom API failures, storage/capacity, data growth, audit, and asynchronous operations.
- Connection and gateway health, identity/certificate/secret lifecycle, connector/API dependency, and data-policy enforcement.
- Solution/pipeline deployment, version drift, unmanaged customization/layers, environment health, owner inactivity, usage, and licenses.
- AI/agent evaluation, fallback, unsafe/tool errors, human escalation, token/message/capacity cost, and knowledge freshness.

## Incident Flow

1. Identify environment, solution/component and version, user/operation/run/correlation ID, data window, connection/identity, recent change, and business impact.
2. Stop unsafe automation, agent tools, external site path, or deployment when continued work could leak data, duplicate actions, or corrupt state.
3. Classify platform health, licensing/capacity/limit, identity/connection, data policy, Dataverse security/data, app/formula, flow, site, agent/knowledge, custom code, external dependency, or deployment/configuration.
4. Mitigate with rollback/redeploy, feature disablement, connection/identity repair, corrected permission, bounded rerun, scale/schedule, or user fallback.
5. Reconcile business outcomes and restore ownership/monitoring. A green flow run is not sufficient when downstream business state is wrong.

## Cadence

- Daily: critical failures, unhealthy connections/gateways, suspended/quarantined resources, agent/site alerts, platform health.
- Weekly: recurring errors, throttling, terminal backlog, deployment failures, support demand, owner gaps.
- Monthly: inventory/usage, licenses and Dataverse/AI/storage capacity, dormant/orphaned assets, cost, environment policy drift.
- Quarterly: access/data policies, Managed Environment/group rules, recovery, connector/custom code, solution/source alignment, lifecycle and retirement.

## Recovery and Retirement

Recovery selects exact operation IDs/records and uses idempotency, backups, solution artifact, source, and reconciliation. Retirement disables entry points, preserves required data/evidence, removes sharing/connections/identities/licenses, resolves dependencies, deletes only after approval/retention, and updates inventory and communications.
