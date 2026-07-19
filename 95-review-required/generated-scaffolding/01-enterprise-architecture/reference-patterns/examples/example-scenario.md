---
title: "Reference Patterns Example Scenario"
domain: "Architecture"
level: "Beginner to Pro"
status: "Phase 2 Draft"
last_updated: "2026-06-20"
tags:
  - architecture
  - reference-patterns
  - example
related:
  - ../
---

# Reference Patterns Example Scenario

## Scenario

A data and automation team wants a catalog of approved patterns for automation lookups, exception handling, monitoring, and BI consumption.

## Current State

- Multiple teams or systems are involved.
- Ownership may be unclear.
- Documentation may be incomplete.
- Manual workarounds may exist.
- Data, process, or integration dependencies may not be fully understood.

## Target State

- Clear business outcome
- Documented current-state and target-state views
- Defined ownership
- Governed access and controls
- Tested and supportable implementation
- Monitoring and feedback loop
- Reusable pattern where appropriate

## Example Diagram

```text
Business Problem
  → Current-State Assessment
  → Target-State Design
  → Governance Review
  → Build / Implement
  → Test
  → Deploy
  → Monitor
  → Improve
```

## Decision Record Prompt

Use this prompt to create an ADR for the scenario:

```text
Create an architecture decision record for the following scenario:

Scenario:
A data and automation team wants a catalog of approved patterns for automation lookups, exception handling, monitoring, and BI consumption.

Include:
- Context
- Options considered
- Decision
- Rationale
- Tradeoffs
- Risks
- Mitigations
- Governance considerations
- Follow-up actions
```

## Lessons to Capture

- What did we learn about ownership?
- What dependencies were discovered?
- What risk was underestimated?
- What pattern can be reused?
- What documentation should be updated?
