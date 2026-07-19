---
title: Worked Example - Governed Power Platform Employee Onboarding
description: Complete Power Platform example covering Dataverse, app, flow, external integration, agent boundary, ALM, security, and operations.
domain: Automation
subdomain: Power Platform
content_type: Example
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - power-platform
  - dataverse
  - worked-example
related:
  - ../../../05-automation/power-platform/README.md
  - ../../../14-learning-paths/automation/power-platform.md
---

# Worked Example: Governed Power Platform Employee Onboarding

## Problem and Scope

A fictitious organization needs managers to request onboarding, HR to validate data, IT/facilities to complete tasks, and the requester to see status. Real HR master data stays authoritative outside this sample. Names, IDs, endpoints, identities, owners, and targets are synthetic.

## Architecture

```text
Manager -> model-driven or canvas app -> Dataverse Onboarding Request
                                         |
                                         +-> Power Automate state orchestration
                                         |    -> approval
                                         |    -> approved HR/IT/facilities APIs
                                         |    -> task/result records
                                         +-> Power BI governed operational view

Optional Copilot Studio agent -> read-only approved status action
```

Dataverse tables include Onboarding Request, Onboarding Task, Integration Attempt, and Approval Decision. Each uses its platform GUID primary identifier. A unique `RequestNumber` or source-operation value is an alternate business key; it does not replace the GUID. The request state machine controls submitted, validating, awaiting approval, provisioning, complete, rejected, cancelled, and exception states.

## Implementation and Reliability

The app validates required fields but Dataverse/server boundaries enforce access and business rules. A flow receives the request GUID and stable operation ID, checks current state, creates tasks idempotently, invokes approved APIs through a reusable wrapper, classifies transient/terminal failures, and persists each outcome before progressing. Approval has expiry, reminder, escalation, and cancellation behavior. Reconciliation finds tasks without a terminal or known in-progress result.

The optional agent can retrieve status only through an action that authorizes the caller and returns a minimal response. It cannot create accounts, change approvals, or access HR detail. Consequential operations remain deterministic and human-controlled.

## Security and Governance

Managers see permitted requests; HR and fulfillment teams receive distinct roles; support has diagnostic access without unrestricted HR data. Production connections are service/workload-owned where supported. Data policy allows only reviewed connectors. Secrets are resolved through approved mechanisms and never stored in environment variables, flow definitions, logs, or examples. Audit, retention, owner, licensing, external API review, and AI evaluation are documented.

## ALM

Custom solutions contain tables, roles, apps, flows, connection references, environment-variable definitions, optional agent/action, and required custom components. Development uses unmanaged source; the same tested managed artifact moves through test/UAT to production. Environment-specific references are supplied at deployment. Synthetic role, duplicate, timeout, connector, approval, accessibility, and recovery tests gate release.

## Operations and Failure

Monitor requests by state/age, task outcome, approval age, connector/API failure/throttling, flow runs, Dataverse capacity, reconciliation variance, owner/connection health, solution version, agent evaluation, and business completion. On dependency outage, pause affected task creation, keep durable state, communicate degradation, and resume from exact task IDs after recovery. A timeout after an API call is reconciled before retry.

## Acceptance

Demonstrate two identical submissions produce one business request, an unauthorized manager cannot view another request, approval expires safely, API timeout does not duplicate provisioning, managed deployment rebinds configuration, reconciliation reaches zero unexplained tasks, the agent cannot exceed read-only scope, and support evidence contains no sensitive values.
