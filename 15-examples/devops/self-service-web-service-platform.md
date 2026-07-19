---
title: Worked Example - Self-Service Web Service Platform
description: End-to-end platform engineering example for a governed self-service application golden path.
domain: DevOps
subdomain: Platform Engineering
content_type: Example
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - platform-engineering-example
  - golden-path
  - self-service
related:
  - ../../08-devops/platform-engineering/README.md
  - ../../14-learning-paths/devops/platform-engineering.md
---

# Worked Example - Self-Service Web Service Platform

The organization, controls, and targets are illustrative. Real account, cluster, identity, contact, and cost information stays in controlled Project Delivery documentation.

## Problem and Outcome

Delivery teams need weeks and several tickets to obtain a repository, pipeline, nonproduction runtime, identity, observability, and ownership registration for a standard web API. A platform team targets a repeatable nonproduction service in under one hour while preserving review, policy, artifact integrity, and team ownership.

## User Journey

```text
Developer selects Web Service golden path
  -> supplies service name, owner, data class, region, and cost center
  -> platform validates identity and policy
  -> creates a reviewed source change from template
  -> pipeline builds, tests, scans, and records artifact provenance
  -> environment controller provisions identity, network, runtime, and telemetry
  -> catalog registers owner, docs, API, dashboard, and support
  -> developer verifies a synthetic request and accepts ownership
```

## Responsibility Boundary

| Platform owns | Delivery team owns | Provider owns |
|---|---|---|
| template, platform API, policy integration, orchestration, docs, platform SLO | application code, dependencies, data, service SLO, on-call, cost use | underlying managed service availability and documented control plane |

## Architecture and Implementation

- Version-controlled catalog metadata is the source of ownership and lifecycle.
- Template version pins reusable actions and base image by reviewed version or digest.
- Long-running provisioning uses a durable request ID and idempotent state machine.
- Policy validates approved region, data class, identity, network, resource limits, cost tags, and ownership before execution.
- Build produces one immutable artifact, vulnerability evidence, SBOM if policy requires it, and verifiable provenance.
- Deployment verifies the approved artifact and emits default metrics, logs, traces, SLO starter, and synthetic health.
- Generated pull request makes changes reviewable; platform stores no application secret.

## Security and Governance

Portal authentication and platform authorization are configured explicitly. Provider identities are scoped per operation and environment. Template input is treated as untrusted. Namespaces, RBAC, quotas, network policy, workload security controls, and secret isolation protect shared nonproduction runtime; higher-risk workloads use a stronger isolation tier. Exceptions expire and identify approver and owner.

## Failure Modes

| Failure | Response |
|---|---|
| User lacks cost-center authorization | deny with remediation; no side effect |
| Provider times out after resource creation | query by durable request ID/tags and reconcile before retry |
| Template dependency changed | compatibility test fails; keep current pinned version |
| Artifact provenance missing | block deployment and retain build evidence |
| Catalog registration fails | workload remains marked incomplete; reconcile after catalog recovery |
| Shared runtime quota exhausted | stop new requests, preserve existing workloads, execute capacity runbook |
| Generated service fails synthetic test | rollback/repair generated change; assign template or application owner from defect boundary |

## Operations and Measures

Platform SLOs cover API availability and successful provisioning within the declared window. Product measures include eligible teams completing the path, time to first successful deployment, repeated voluntary use, support contacts, policy findings caught early, and partner-team feedback. Service operations include provider quota, request age, template versions, vulnerability lifecycle, access, cost, and recovery.

## Validation

1. Complete the path with a partner team and verify ownership handoff.
2. Exercise invalid policy input, duplicate request, provider timeout after success, quota exhaustion, catalog outage, and tampered artifact.
3. Restore platform desired state and verify completed operations are not repeated.
4. Upgrade the template with an existing generated service and prove compatibility or migration.
5. Confirm all generated telemetry and audit evidence are free of credentials and prohibited data.

The platform is ready for broader adoption only after both user-outcome and service-control evidence pass.
