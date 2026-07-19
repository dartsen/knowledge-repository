---
title: "Medallion Architecture Quick Reference"
domain: "Architecture"
level: "Beginner to Pro"
status: "Phase 2 Draft"
last_updated: "2026-06-20"
tags:
  - architecture
  - medallion-architecture
  - quick-reference
related:
  - ../
---

# Medallion Architecture Quick Reference

## Plain-English Explanation

Medallion Architecture is a layered data design pattern that organizes data into progressively refined layers, commonly raw, conformed, and curated.

## Simple Analogy

Think of it as refining raw materials. Bronze captures what arrived, silver cleans and standardizes it, and gold packages it for specific business use.

## Why It Matters

- Data Trust
- Reusable Transformations
- Clear Ownership
- Better Lineage
- Automation-Ready Data
- Scalable Analytics

## Common Flow

```text
Source Systems → Raw / Bronze → Conformed / Silver → Curated / Gold → BI / Automation / AI → Monitoring
```

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Raw / Bronze Layer | Data captured close to the source format. | Preserves source history and auditability. | Raw policy table from source extract. |
| Conformed / Silver Layer | Cleaned, standardized, reusable business-aligned data. | Supports shared use across teams. | Standardized policy, customer, coverage models. |
| Curated / Gold Layer | Use-case-ready data optimized for consumption. | Makes reports and automations easier to build. | Automation-ready policy renewal table. |
| Data Quality Gates | Checks between layers. | Prevents bad data from flowing downstream unnoticed. | Unique keys, valid dates, accepted status values. |
| Lineage | Traceability from source to curated output. | Supports trust and impact analysis. | Source policy → conformed policy → curated renewal attributes. |
| Consumption Pattern | How downstream tools access the data. | Shapes design and performance. | Power BI import, SQL lookup, API, automation query. |

## Red Flags

- No clear owner.
- Current state is not understood.
- Target state is vague.
- Dependencies are undocumented.
- Governance is added too late.
- Security is treated as an afterthought.
- Monitoring and support are missing.
- Decisions are not documented.
- The solution solves a tool problem but not a business problem.

## Questions to Ask

1. What business outcome does this support?
2. Who owns the process, data, and system?
3. What is the current state?
4. What target state are we moving toward?
5. What risks and constraints exist?
6. What standards apply?
7. How will failure be handled?
8. How will success be measured?

## Meeting Soundbite

> Medallion Architecture helps us connect the business need to a practical, governed, and supportable approach so we avoid isolated decisions, hidden risk, and unnecessary technical debt.

## Beginner-to-Pro Focus

| Level | Focus |
|---|---|
| Beginner | Understand the basic purpose and vocabulary. |
| Advanced Beginner | Identify common flows, stakeholders, inputs, and outputs. |
| Intermediate Practitioner | Apply the concept to a real work scenario. |
| Advanced Practitioner | Design for scale, quality, reliability, and supportability. |
| Enterprise Professional | Connect the subject to governance, standards, and operating model. |
| Architect / Strategic Lead | Shape roadmap, strategy, reusable patterns, and cross-team decisions. |
