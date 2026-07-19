---
title: FinOps Architecture
description: Architecture for scopes, financial data products, allocation, unit economics, forecasting, and cross-functional decisions.
domain: Security and Governance
subdomain: FinOps
content_type: Architecture Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - finops-architecture
  - allocation
  - unit-economics
related:
  - README.md
  - implementation.md
---

# FinOps Architecture

## Start with a Decision Scope

A FinOps scope is the business decision context for a defined segment of technology spending, such as a product, cost center, environment, portfolio, or AI service. Record the business questions, accountable owner, included technology categories and accounts, consumers, decision cadence, reporting currency, financial basis, and success measures before designing dashboards.

Do not assume organizational hierarchy, subscription/account hierarchy, and product ownership are identical. Model the mapping explicitly and retain its effective dates.

## Logical Architecture

```text
Provider billing/usage + contracts/rates + resource inventory/tags
        + budgets/forecasts + product/transaction/business measures
  -> immutable source landing with delivery and completeness metadata
  -> normalized cost-and-usage contract (FOCUS where supported)
  -> reconciliation, corrections, currency, commitment, and allocation layers
  -> governed actual, forecast, unit-cost, anomaly, and opportunity products
  -> role-appropriate views, decisions, approved actions, and outcome evidence
```

The invoice or provider statement remains the financial reconciliation authority. Analytical data may be estimated, delayed, corrected, amortized, or exclude taxes, support, and credits. Publish its basis and confidence rather than presenting a provisional figure as final.

## Data Products and Contracts

Define at least:

- billing and usage periods, event/usage time, ingestion time, and finalization state;
- provider, billing account, subaccount, resource, service, region, and charge category;
- billed, effective/amortized, list, contracted, and allocated cost where available;
- currency and any conversion rate, source, and effective date;
- commitment purchase, benefit, eligibility, coverage, utilization, and expiration;
- allocation rule version, source/target amounts, residual, and confidence;
- product, owner, environment, cost center, and business-unit mappings;
- correction, credit, refund, tax, marketplace, and shared-cost treatment.

FOCUS can normalize vendor billing schemas, but it does not choose business ownership, allocation policy, unit metrics, or acceptable value trade-offs.

## Operating Model and Decision Rights

| Decision | Accountable role | Required input |
|---|---|---|
| Scope and value target | Business/product owner | Strategy, demand, service objectives |
| Financial basis and reconciliation | Finance | Invoice, ledger policy, close calendar |
| Architecture and usage change | Engineering/workload owner | Risk, performance, reliability, test evidence |
| Rate or commitment purchase | Finance/procurement | Forecast, eligibility, utilization scenario, terms |
| Allocation policy | Finance plus business owners | Causality, materiality, controllability, dispute path |
| Guardrail or automated action | Platform/governance owner | Blast radius, approvals, rollback, exclusions |

Central teams enable data, standards, and guardrails. Workload teams remain accountable for usage they can control; finance owns accounting treatment; business owners decide whether cost produces acceptable value.

## Quality Attributes

Design for reconciliation, timeliness, traceability, repeatability, privacy, portability, and explainability. Keep raw deliveries and versioned transformations so a reported figure can be reproduced after mapping, price, correction, or allocation changes.
