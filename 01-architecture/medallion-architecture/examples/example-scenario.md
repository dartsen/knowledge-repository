---
title: "Medallion Architecture Example Scenario"
domain: "Architecture"
level: "Beginner to Pro"
status: "Phase 2 Draft"
last_updated: "2026-06-20"
tags:
  - architecture
  - medallion-architecture
  - example
related:
  - ../
---

# Medallion Architecture Example Scenario

## Scenario

An intelligent automation team needs policy-level and coverage-level attributes that are validated, documented, and optimized for SQL lookup by automations.

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
An intelligent automation team needs policy-level and coverage-level attributes that are validated, documented, and optimized for SQL lookup by automations.

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
