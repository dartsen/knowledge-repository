---
title: "Solution Architecture Quick Reference"
domain: "Architecture"
level: "Beginner to Pro"
status: "Phase 2 Draft"
last_updated: "2026-06-20"
tags:
  - architecture
  - solution-architecture
  - quick-reference
related:
  - ../
---

# Solution Architecture Quick Reference

## Plain-English Explanation

Solution Architecture translates a specific business problem into a practical, buildable technical design that fits enterprise standards and can be delivered by teams.

## Simple Analogy

If enterprise architecture is city planning, solution architecture is the blueprint for a specific building that still follows city rules, utilities, safety codes, and neighborhood plans.

## Why It Matters

- Faster Delivery
- Clearer Requirements
- Risk Reduction
- Better Handoff To Delivery Teams
- Implementation Consistency
- Operational Readiness

## Common Flow

```text
Business Problem → Requirements → Context Diagram → Options → Recommendation → Build Plan → Testing → Deployment → Monitoring
```

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Problem Statement | A clear explanation of the business or technical issue. | Prevents building the wrong thing. | Automations fail because they depend on inconsistent manual input. |
| Requirements | Functional and non-functional needs. | Defines what success means. | Performance, access, monitoring, auditability, availability. |
| System Context | The systems, users, data, and integrations involved. | Shows boundaries and dependencies. | Databricks, Power BI, Power Automate, UiPath, SharePoint. |
| Design Options | Different ways to solve the problem. | Supports informed decision-making. | API integration versus curated table lookup. |
| Tradeoff Analysis | Comparison of benefits, risks, cost, and complexity. | Makes decisions transparent. | Fast manual workaround versus governed reusable service. |
| Operational Readiness | Support, monitoring, runbooks, and failure handling. | Prevents fragile production solutions. | Alerting, retries, support owner, exception queue. |

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

> Solution Architecture helps us connect the business need to a practical, governed, and supportable approach so we avoid isolated decisions, hidden risk, and unnecessary technical debt.

## Beginner-to-Pro Focus

| Level | Focus |
|---|---|
| Beginner | Understand the basic purpose and vocabulary. |
| Advanced Beginner | Identify common flows, stakeholders, inputs, and outputs. |
| Intermediate Practitioner | Apply the concept to a real work scenario. |
| Advanced Practitioner | Design for scale, quality, reliability, and supportability. |
| Enterprise Professional | Connect the subject to governance, standards, and operating model. |
| Architect / Strategic Lead | Shape roadmap, strategy, reusable patterns, and cross-team decisions. |
