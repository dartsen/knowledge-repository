---
title: Observability Architecture
description: Architecture for correlated, governed, resilient, and cost-aware telemetry.
domain: DevOps
subdomain: Observability
content_type: Architecture Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - telemetry-architecture
  - open-telemetry
  - distributed-tracing
related:
  - README.md
  - ../reliability-engineering/architecture.md
---

# Observability Architecture

## Reference Flow

```text
Application and platform instrumentation
  -> local buffering or agent
  -> collector gateway
  -> validation, enrichment, filtering, sampling, and redaction
  -> one or more governed backends
  -> SLOs, alerts, dashboards, investigations, and audit evidence
```

OpenTelemetry provides vendor-neutral APIs, SDKs, OTLP, semantic conventions, and a Collector that can receive, process, and export telemetry. It does not replace the need to select storage, visualization, alerting, retention, and operational ownership.

## Design Decisions

| Decision | Questions |
|---|---|
| User outcomes | Which critical journeys and correctness conditions must be visible? |
| Instrumentation | Automatic, manual, platform, synthetic, or business-event signals? |
| Correlation | How are trace, operation, service, version, and message identifiers propagated? |
| Collection | Agent, gateway, direct export, or hybrid? What happens during backpressure? |
| Processing | Where are fields normalized, redacted, sampled, aggregated, and routed? |
| Storage | Which backend supports the query, latency, residency, retention, and cost need? |
| Tenancy | How are teams, environments, and sensitive workloads isolated? |
| Continuity | How is telemetry-pipeline health observed independently? |

## Correlation and Boundaries

Use W3C Trace Context for HTTP trace propagation where supported and propagate equivalent context through messaging metadata. Treat incoming trace context as untrusted: validate format, prevent unbounded baggage, and do not grant authorization based on trace identifiers.

At trust boundaries, decide which attributes may cross, whether a new trace starts, and how evidence remains linkable without disclosing sensitive data. Record asynchronous producer, broker, consumer, delivery-attempt, and business-operation identifiers.

## Cardinality and Volume

Metric cost and memory grow with unique attribute combinations. Permit bounded dimensions such as route templates, status class, region, and version. Prohibit raw URLs, request IDs, user IDs, timestamps, exception text, and unconstrained payload values as metric attributes. Keep high-cardinality detail in sampled traces or governed logs when justified.

Set per-signal budgets for ingestion rate, cardinality, sampling, retention, query concurrency, and egress. Define reduction order before overload: discard low-value debug data before SLO and security-critical signals.

## Resilience

- Buffer locally within strict disk and memory bounds.
- Prefer nonblocking export so telemetry failure does not take down the workload.
- Monitor exporter drops, queue utilization, collector refusals, backend errors, and ingestion delay.
- Separate telemetry control-plane failure from actual service failure in alerts.
- Retain an independent external probe for critical user journeys.

## Architecture Acceptance

Accept the design when critical journeys are observable end to end, schemas and ownership are defined, high-risk fields are controlled, cardinality is bounded, pipeline failure is detectable, and retention/cost decisions meet business and regulatory needs.
