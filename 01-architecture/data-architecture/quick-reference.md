---
title: "Data Architecture Quick Reference"
domain: "Architecture"
level: "Beginner to Pro"
status: "Phase 2 Draft"
last_updated: "2026-06-20"
tags:
  - architecture
  - data-architecture
  - quick-reference
related:
  - ../
---

# Data Architecture Quick Reference

## Plain-English Explanation

Data Architecture defines how data is sourced, stored, transformed, governed, secured, and consumed across an organization.

## Simple Analogy

Think of it as the plumbing and water-quality system for business information. It controls where data comes from, how it flows, how clean it is, and who can safely use it.

## Why It Matters

- Trusted Reporting
- Automation Reliability
- Ai Readiness
- Data Quality
- Regulatory Control
- Faster Analytics

## Common Flow

```text
Source Systems → Ingestion → Raw Layer → Conformed Layer → Curated Layer → BI / Automation / AI → Monitoring → Improvement
```

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Source System | The original system where data is created. | Clarifies authority. | Policy administration system, claims system, CRM. |
| Authoritative Source | The trusted source for a specific data element. | Prevents conflicting definitions. | Policy status from policy system, customer details from CRM. |
| Data Model | The structure of data entities, attributes, and relationships. | Makes data usable and consistent. | Policy, policy version, coverage, insured, claim. |
| Data Quality | Rules and checks that determine whether data is fit for use. | Protects reports, automations, and decisions. | No null policy IDs, valid status codes, unique keys. |
| Lineage | The path data follows from source to consumption. | Supports impact analysis and trust. | Raw source → conformed model → curated Power BI dataset. |
| Data Governance | Ownership, access, definitions, lifecycle, and controls. | Makes data trustworthy and accountable. | Data owners, glossary, sensitivity classification. |

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

> Data Architecture helps us connect the business need to a practical, governed, and supportable approach so we avoid isolated decisions, hidden risk, and unnecessary technical debt.

## Beginner-to-Pro Focus

| Level | Focus |
|---|---|
| Beginner | Understand the basic purpose and vocabulary. |
| Advanced Beginner | Identify common flows, stakeholders, inputs, and outputs. |
| Intermediate Practitioner | Apply the concept to a real work scenario. |
| Advanced Practitioner | Design for scale, quality, reliability, and supportability. |
| Enterprise Professional | Connect the subject to governance, standards, and operating model. |
| Architect / Strategic Lead | Shape roadmap, strategy, reusable patterns, and cross-team decisions. |
