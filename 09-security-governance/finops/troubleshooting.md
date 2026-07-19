---
title: FinOps Troubleshooting
description: Diagnostic runbook for reconciliation, allocation, freshness, forecast, anomaly, commitment, and automation failures.
domain: Security and Governance
subdomain: FinOps
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - finops-troubleshooting
  - reconciliation
  - cost-anomalies
related:
  - operations.md
  - official-references.md
---

# FinOps Troubleshooting

## First Capture

Record the scope, billing and usage periods, provider/account, currency, cost basis, report version, last complete delivery, rule/mapping version, expected result, actual result, materiality, and recent changes. Export a bounded evidence set under approved handling rules.

## Decision Table

| Symptom | Likely checks | Safe response |
|---|---|---|
| Dashboard does not match invoice | Incomplete period, excluded tax/support/credits, currency, corrections, billed vs effective cost | Reconcile layer by layer; label estimates; publish a variance explanation |
| Cost changed after close | Late charge, correction, refund, tiered price finalization | Preserve both versions, identify affected reports, follow restatement policy |
| Large unallocated residual | Missing/stale tags, unmapped account, shared platform, rule failure | Quarantine new mappings, assign residual owner, backfill with versioned rule |
| Allocation total exceeds source | Duplicate join, overlapping rules, many-to-many mapping | Stop publication, test conservation at each rule, correct and rerun idempotently |
| Forecast misses repeatedly | Partial data, growth/seasonality, price change, commitment expiration, scope drift | Rebaseline drivers and confidence ranges; document model/version change |
| Anomaly alert did not fire | Unsupported scope, delayed evaluation/data, threshold or recipient permission | Confirm documented feature behavior and test with a safe known signal |
| Budget was exceeded | Budget only alerted, delayed data, missing workflow, wrong scope | Triage impact; repair response path; add approved enforcement only if required |
| Commitment appears underused | Eligibility/coverage logic, shifted demand, shared benefit attribution | Reconcile eligible usage and terms before purchase, exchange, or cancellation |
| Optimization harmed service | Metric optimized in isolation, missing test/rollback, coupled capacity | Roll back, restore service objective, update decision criteria and guardrail |
| Automated action hit wrong resource | Stale ownership, broad scope, identity overprivilege | Disable automation, recover workload, audit blast radius, narrow policy/identity |

## Reconciliation Ladder

Compare, in order: provider statement to raw delivery; raw delivery to normalized rows; normalized rows to financial treatment; financial layer to allocation; allocation to report; report to exported snapshot. At each boundary compare row count, distinct keys, totals by currency/charge category, completeness, and correction state.

## Escalation Evidence

Provide the smallest reproducible data slice, source and transformation versions, exact query/filter, time zone, financial basis, observed variance, and whether production actions are paused. Redact commercial and account-identifying values from general support channels.
