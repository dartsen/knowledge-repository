---
title: Worked Example - Technology Cost Allocation
description: End-to-end FinOps example for allocating a shared application platform while preserving reconciliation and decision evidence.
domain: Security and Governance
subdomain: FinOps
content_type: Example
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - finops
  - cost-allocation
  - worked-example
related:
  - ../../09-security-governance/finops/README.md
---

# Worked Example: Technology Cost Allocation

## Problem and Assumptions

A fictional company operates a shared application platform for three products. It needs showback by product and environment, a unit-cost trend, and a defensible optimization backlog. All names, amounts, account identifiers, contracts, and usage values are synthetic.

## Architecture

```text
Provider cost export + platform request counts + product ownership map
 -> immutable dated landing with delivery manifest
 -> normalized charges with billed/effective cost and completeness state
 -> direct ownership -> shared platform allocation -> residual
 -> product/environment showback + cost per successful request
 -> monthly decision review and controlled engineering actions
```

The reporting month remains provisional until the provider statement is available. The pipeline reconciles raw totals, normalized totals, and allocated totals separately.

## Allocation Policy

Directly attributable resources go to their effective-dated product owner. Shared production runtime cost is allocated by validated successful requests; shared nonproduction tooling is split by active product environments. Security, control-plane, and unused-capacity costs remain visible in a shared-platform bucket owned by the platform product manager. Each row records rule version, driver period, confidence, and source/target amounts.

```text
source shared cost = product allocations + shared-platform residual
```

No allocation is based on a tag that failed freshness or ownership validation.

## Operations and Failure Injection

The team runs daily delivery checks, weekly driver/anomaly review, and monthly reconciliation. Test scenarios include a missing product mapping, duplicated usage join, late credit, provider correction, partial request telemetry, and unexpected capacity change. Publication stops on conservation failure; incomplete drivers move affected cost to the visible residual rather than inventing precision.

## Security and Governance

Finance can approve reconciliation and allocation policy but cannot alter raw deliveries. Engineering can validate usage and propose changes but cannot edit financial results. Negotiated rates and account identifiers are restricted. A proposed nonproduction shutdown uses an allowlist, owner approval, maintenance window, health verification, rollback, and audit record; production is excluded.

## Acceptance

Demonstrate exact reconciliation, effective-dated ownership, a documented residual, actual/forecast/budget on the same basis, cost per successful request, anomaly triage, a reversible optimization, and before/after service and financial evidence. The result must remain reproducible after a late correction.
