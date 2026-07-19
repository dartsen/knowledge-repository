---
title: "Reference Patterns Quick Reference"
domain: "Architecture"
level: "Beginner to Pro"
status: "Phase 2 Draft"
last_updated: "2026-06-20"
tags:
  - architecture
  - reference-patterns
  - quick-reference
related:
  - ../
---

# Reference Patterns Quick Reference

## Plain-English Explanation

Reference Patterns are reusable architecture designs for common problems, allowing teams to move faster while staying consistent and governed.

## Simple Analogy

Think of them as proven recipes. You still adjust for the meal, but you do not invent the entire cooking method each time.

## Why It Matters

- Faster Delivery
- Consistency
- Lower Risk
- Reusability
- Better Governance
- Easier Onboarding

## Common Flow

```text
Recurring Problem → Pattern Selection → Context Fit → Adaptation → Implementation → Review → Reuse / Improve
```

## Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Pattern | A reusable way to solve a recurring problem. | Avoids reinventing the wheel. | Standard automation lookup pattern. |
| Context | The situation where a pattern applies. | Prevents misuse. | Use when several automations need the same curated data. |
| Forces | The constraints and tradeoffs influencing the pattern. | Makes design reasoning clear. | Speed, security, data quality, ownership, cost. |
| Solution Structure | The recommended design approach. | Helps teams implement consistently. | Source → conformed model → curated table → read-only lookup. |
| Consequences | Benefits and tradeoffs of using the pattern. | Supports informed adoption. | More governance, but better reliability. |
| Reuse Criteria | Rules for when to apply or adapt the pattern. | Prevents one-size-fits-all thinking. | Only use for stable, repeated needs. |

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

> Reference Patterns helps us connect the business need to a practical, governed, and supportable approach so we avoid isolated decisions, hidden risk, and unnecessary technical debt.

## Beginner-to-Pro Focus

| Level | Focus |
|---|---|
| Beginner | Understand the basic purpose and vocabulary. |
| Advanced Beginner | Identify common flows, stakeholders, inputs, and outputs. |
| Intermediate Practitioner | Apply the concept to a real work scenario. |
| Advanced Practitioner | Design for scale, quality, reliability, and supportability. |
| Enterprise Professional | Connect the subject to governance, standards, and operating model. |
| Architect / Strategic Lead | Shape roadmap, strategy, reusable patterns, and cross-team decisions. |
