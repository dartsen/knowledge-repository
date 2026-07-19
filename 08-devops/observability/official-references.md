---
title: Observability Official References
description: Current primary standards and project documentation supporting repository observability guidance.
domain: DevOps
subdomain: Observability
content_type: Research Note
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - official-documentation
  - open-telemetry
  - w3c
related:
  - README.md
  - ../reliability-engineering/official-references.md
---

# Observability Official References

Verified against active primary-source pages on **2026-07-18**. Recheck signal maturity, semantic conventions, and backend-specific behavior before an implementation decision.

| Primary source | Guidance supported |
|---|---|
| [OpenTelemetry concepts](https://opentelemetry.io/docs/concepts/) | Signals, context propagation, instrumentation, components, sampling, resources, and semantic conventions |
| [OpenTelemetry components](https://opentelemetry.io/docs/concepts/components/) | API, SDK, OTLP data model, semantic conventions, and Collector responsibilities |
| [OpenTelemetry metrics](https://opentelemetry.io/docs/concepts/signals/metrics/) | Instruments, aggregation, views, and the operational risk of high-cardinality attributes |
| [OpenTelemetry logs specification](https://opentelemetry.io/docs/specs/otel/logs/) | Log data model, correlation, and Collector pipeline support |
| [W3C Trace Context](https://www.w3.org/TR/trace-context/) | Standard `traceparent` and `tracestate` propagation plus privacy and security considerations |
| [Prometheus alerting practices](https://prometheus.io/docs/practices/alerting/) | Alert design centered on user symptoms, actionable pages, and tolerance for small transient failures |
| [Google SRE: Monitoring Distributed Systems](https://sre.google/sre-book/monitoring-distributed-systems/) | Monitoring purposes, golden signals, and robust high-signal paging |

## Verification Notes

- W3C Trace Context is a W3C Recommendation dated 2021-11-23; use the stable recommendation URL.
- OpenTelemetry signal and language SDK maturity can differ and change. Confirm the status page for the chosen language and signal during implementation.
- Prometheus guidance is applied as vendor-neutral alerting practice; query syntax and backend behavior still require platform-specific validation.
