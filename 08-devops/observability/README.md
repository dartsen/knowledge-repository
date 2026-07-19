---
title: Observability
description: Production guidance for telemetry architecture, instrumentation, detection, diagnosis, and evidence governance.
domain: DevOps
subdomain: Observability
content_type: Overview
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - observability
  - telemetry
  - open-telemetry
related:
  - ../reliability-engineering/README.md
  - ../../14-learning-paths/devops/reliability-observability.md
  - ../../15-examples/devops/reliable-order-status-service.md
---

# Observability

Observability is the ability to understand a system's internal behavior from the signals it exposes. It supports reliability, security, performance, and business operations, but collecting more data is not itself an observability strategy.

## Start Here

1. [Architecture](architecture.md) - design signal flow, correlation, boundaries, and retention.
2. [Implementation](implementation.md) - instrument consistent logs, metrics, traces, and business events.
3. [Operations](operations.md) - manage dashboards, alerts, telemetry pipelines, cost, and lifecycle.
4. [Security and governance](security-governance.md) - protect sensitive telemetry and evidence.
5. [Troubleshooting](troubleshooting.md) - diagnose missing, misleading, delayed, or expensive signals.
6. [Official references](official-references.md) - primary standards and current project documentation.

Use the centralized [reliability and observability learning path](../../14-learning-paths/devops/reliability-observability.md) and [reliable order-status service example](../../15-examples/devops/reliable-order-status-service.md).

## Signal Strategy

| Signal | Best for | Common failure |
|---|---|---|
| Metrics | Aggregated rates, distributions, saturation, SLO calculation | Unbounded label cardinality or averages hiding tails |
| Logs | Discrete events and diagnostic context | Secrets, personal data, inconsistent fields, or unbounded volume |
| Traces | Request path, timing, causality, and dependency analysis | Broken context propagation or biased sampling |
| Profiles | Code-path resource consumption over time | High overhead or access to sensitive runtime detail |
| Business events | Completion and correctness of user outcomes | Treating technical success as business success |

Correlate signals with stable service, environment, version, operation, and trace identifiers. Do not use customer names, email addresses, access tokens, full payloads, or other high-risk values as metric attributes.

## Observability Contract

Every production service should identify critical journeys and their signals, telemetry owners, schema and semantic conventions, collection and routing, sampling, retention, access, cost limits, health of the telemetry pipeline, and fallback behavior if telemetry is unavailable.

## Organization-Specific Adoption Notes

> **Scope: Organization-Specific.** Store local workspace names, account identifiers, tenant routing, alert destinations, retention schedules, approved fields, and escalation contacts in Project Delivery. Public material should use placeholders and sanitized examples.
