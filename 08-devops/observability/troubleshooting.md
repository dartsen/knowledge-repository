---
title: Observability Troubleshooting
description: Troubleshooting guide for missing, misleading, delayed, or unexpectedly expensive telemetry.
domain: DevOps
subdomain: Observability
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - telemetry-troubleshooting
  - diagnostics
related:
  - README.md
  - operations.md
  - ../reliability-engineering/troubleshooting.md
---

# Observability Troubleshooting

## Investigation Order

Trace one known synthetic operation from instrumentation to SDK, local queue, collector receiver, processor, exporter, backend ingestion, query, dashboard, and alert. Compare expected counts and timestamps at each boundary. This separates signal-generation failure from collection, storage, or presentation failure.

| Symptom | Likely cause | Evidence | Action |
|---|---|---|---|
| No data after release | missing SDK/exporter config, identity, network, or resource fields | application startup, exporter, collector logs | restore known config; validate with synthetic operation |
| Broken trace | context not injected/extracted, proxy strips headers, new root created | adjacent span IDs and request/message metadata | fix propagation and boundary tests |
| SLO shows perfect health | empty denominator, excluded failures, delayed data | raw good/total events and freshness | fail query closed and correct classification |
| Duplicate metrics or spans | duplicate instrumentation or collector fan-out loop | resource identity and exporter path | remove duplicate provider/path |
| High metric cost | unbounded attributes | top series by label and instrument | drop/aggregate unsafe label; add contract test |
| Collector memory growth | queue pressure, batch size, exporter failure, cardinality | queue, refusal, retry, memory-limiter signals | reduce intake safely, restore backend, tune bounded queues |
| Alert storm | correlated dependency failure or bad routing | alert labels, topology, recent rule changes | group/inhibit carefully; fix root rule and ownership |
| Missing sensitive field redaction | processor order or new application field | controlled test event and pipeline config | stop unsafe export, restrict access, remediate exposure process |

## Guardrails

Do not enable unrestricted debug logging in production without scope, duration, owner, and data review. Do not lower sampling or retention globally to solve one investigation. Do not copy sensitive telemetry into tickets or public repositories. Preserve evidence and involve security immediately when exposure is possible.

## Verify Recovery

Confirm signal completeness, latency, correlation, query correctness, alert evaluation, pipeline capacity, and cost. Remove temporary debug settings and emergency access, then add a regression test for the failed boundary.
