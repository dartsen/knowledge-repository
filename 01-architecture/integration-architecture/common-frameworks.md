---
title: "Integration Architecture Common Frameworks"
domain: "Architecture"
level: "Beginner to Pro"
status: "Phase 2 Draft"
last_updated: "2026-06-20"
tags:
  - architecture
  - integration-architecture
  - frameworks
related:
  - ../
---

# Integration Architecture Common Frameworks, Models, and Patterns

## Purpose

Use this file to capture frameworks, models, and reusable patterns that support Integration Architecture.

## Frameworks and Patterns

| Framework / Pattern | What It Is | When to Use It | Benefit | Watchout |
|---|---|---|---|---|
| API-Led Connectivity | A commonly used method, model, or reusable approach related to Integration Architecture. | Use when the problem matches the framework's intended context. | Improves consistency and decision quality. | Can overcomplicate simple needs. |
| Event-Driven Architecture | A commonly used method, model, or reusable approach related to Integration Architecture. | Use when the problem matches the framework's intended context. | Improves consistency and decision quality. | Needs strong monitoring and event contracts. |
| Publish-Subscribe | A commonly used method, model, or reusable approach related to Integration Architecture. | Use when the problem matches the framework's intended context. | Improves consistency and decision quality. | Consumers must handle eventual consistency. |
| Request-Response | A commonly used method, model, or reusable approach related to Integration Architecture. | Use when the problem matches the framework's intended context. | Improves consistency and decision quality. | Creates runtime dependency between systems. |
| Batch Processing | A commonly used method, model, or reusable approach related to Integration Architecture. | Use when the problem matches the framework's intended context. | Improves consistency and decision quality. | May not support real-time needs. |
| Message Queue Pattern | A commonly used method, model, or reusable approach related to Integration Architecture. | Use when the problem matches the framework's intended context. | Improves consistency and decision quality. | Requires dead-letter and replay strategy. |
| Data Contracts | A commonly used method, model, or reusable approach related to Integration Architecture. | Use when the problem matches the framework's intended context. | Improves consistency and decision quality. | Requires producer and consumer agreement. |

## How to Choose a Framework

Ask:

1. What problem are we solving?
2. Is this a strategy, design, governance, delivery, or support problem?
3. Is the framework too heavy for the context?
4. Does the team understand how to use it?
5. Will it improve decision-making?
6. Will it improve delivery?
7. Will it improve governance or supportability?

## Practical Rule

Use frameworks as guides. Do not let the framework become the work.

## Beginner-to-Pro Framework Growth

| Level | Capability |
|---|---|
| Beginner | Recognize the framework names. |
| Advanced Beginner | Understand when they are useful. |
| Intermediate Practitioner | Apply one framework to a small scenario. |
| Advanced Practitioner | Adapt frameworks to real constraints. |
| Enterprise Professional | Standardize patterns across teams. |
| Architect / Strategic Lead | Select and govern frameworks at portfolio level. |
