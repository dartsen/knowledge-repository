---
title: FinOps
description: Production guidance for technology-value visibility, allocation, forecasting, optimization, and financial accountability.
domain: Security and Governance
subdomain: FinOps
content_type: Overview
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - finops
  - cost-management
  - technology-value
related:
  - architecture.md
  - ../../14-learning-paths/security-governance/finops.md
---

# FinOps

FinOps is an operating framework and cultural practice for maximizing business value from technology through timely data, explicit accountability, and collaboration among engineering, finance, procurement, product, and business teams. It is broader than reducing a cloud bill: decisions must preserve required reliability, security, performance, sustainability, and delivery outcomes.

## Use This Family For

- Establishing scopes, ownership, allocation, and reporting
- Designing trustworthy cost-and-usage data products
- Forecasting and explaining actual-versus-plan variance
- Evaluating usage and rate optimization opportunities
- Operating budgets, anomaly response, commitments, and chargeback/showback
- Connecting unit economics and technology investment to business outcomes

## Lifecycle

```text
Business strategy and scope
 -> ingest and reconcile cost, usage, contract, and business data
 -> allocate and report with confidence and freshness
 -> forecast, budget, and identify anomalies/opportunities
 -> approve and implement value-improving actions
 -> validate outcomes and repeat Inform -> Optimize -> Operate
```

## Guide Map

1. [Architecture](architecture.md) - operating model, data flow, scopes, and decision rights
2. [Implementation](implementation.md) - contracts, allocation rules, metrics, budgets, and automation
3. [Operations](operations.md) - recurring cadence, anomaly response, commitments, and evidence
4. [Security and governance](security-governance.md) - access, policy, audit, and guardrails
5. [Troubleshooting](troubleshooting.md) - reconciliation, allocation, freshness, and alert failures
6. [Official references](official-references.md) - maintained primary sources and checked assumptions

Use the [central learning path](../../14-learning-paths/security-governance/finops.md) and the [technology cost-allocation example](../../15-examples/security-governance/technology-cost-allocation.md) for a complete progression.

## Definition of Done

A production FinOps scope has an accountable business owner, reconciled data, documented allocation and metric definitions, freshness/confidence indicators, a decision cadence, approved action boundaries, measurable value outcomes, and a path for exceptions and disputes. A dashboard alone is not a FinOps operating model.
