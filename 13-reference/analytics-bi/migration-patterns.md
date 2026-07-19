---
title: "Migration Patterns Quick Reference"
domain: "Analytics and BI"
level: "Beginner to Pro"
status: "Phase 3 Analytics/BI Draft"
last_updated: "2026-06-20"
tags:
  - analytics-bi
  - migration-patterns
  - quick-reference
related:
  - ../
---

# Migration Patterns Quick Reference

## Plain-English Explanation

Migration Patterns are repeatable approaches for moving reports, semantic models, data sources, dashboards, and business logic from one analytics environment or source to another.

## Simple Analogy

Think of migration like moving a business to a new office. You do not just move furniture; you decide what to keep, what to redesign, what to retire, and how to avoid disrupting daily operations.

## Common Flow

```text
Inventory → Rationalize → Map Sources → Rebuild / Refactor → Reconcile → Parallel Run → Cutover → Decommission → Improve
```

## Why It Matters

- Reduced Migration Risk
- Modernized Reporting
- Improved Governance
- Technical Debt Reduction
- Source Standardization
- Business Continuity

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Inventory | A list of reports, models, data sources, owners, and usage. | Shows migration scope. | All reports connected to Dataverse. |
| Rationalization | Deciding what to keep, merge, redesign, or retire. | Reduces report sprawl. | Retire unused reports. |
| Source Mapping | Mapping old data fields to new source fields. | Preserves meaning across migration. | Dataverse policy status to Databricks policy_status. |
| Reconciliation | Comparing old and new outputs. | Builds trust in migration. | Premium total matches within tolerance. |
| Parallel Run | Running old and new versions together temporarily. | Reduces go-live risk. | Compare dashboards for two weeks. |
| Cutover | Switching users to the new solution. | Marks business transition. | Publish new Power BI app and retire old one. |
| Decommissioning | Safely retiring old assets. | Reduces cost and confusion. | Archive old datasets and remove refresh schedules. |

## Red Flags

- No business owner.
- No metric definition.
- No source validation.
- No semantic model owner.
- No security testing.
- No usage monitoring.
- Reports duplicate existing content.
- Users disagree on the numbers.
- Report refresh fails silently.
- Content is published without lifecycle control.

## Questions to Ask

1. What decision does this support?
2. Who is the audience?
3. What are the agreed metric definitions?
4. What is the trusted source?
5. Is a shared semantic model available?
6. What access controls apply?
7. How will this be deployed?
8. How will usage be monitored?
9. Who owns maintenance?
10. What should be retired or consolidated?

## Beginner-to-Pro Focus

| Level | Focus |
|---|---|
| Beginner | Understand the basic idea and vocabulary. |
| Advanced Beginner | Follow common BI workflows and identify audience/data/source. |
| Intermediate Practitioner | Build or apply the concept in a real report/model. |
| Advanced Practitioner | Design for performance, trust, security, and supportability. |
| Enterprise Professional | Govern, monitor, document, and standardize across teams. |
| Architect / Strategic Lead | Define BI strategy, reference patterns, and operating model. |
