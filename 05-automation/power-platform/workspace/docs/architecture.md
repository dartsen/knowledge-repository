---
title: Power Platform Workspace Architecture
description: Local development, source-control, environment, configuration, and release architecture for solution-aware Power Platform delivery.
domain: Automation
subdomain: Power Platform
content_type: Architecture Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Quarterly
tags:
  - power-platform-architecture
  - alm
  - environment-strategy
related:
  - ../README.md
  - solution-design-template.md
---

# Power Platform Workspace Architecture

## Local Workspace and Release Flow

```mermaid
flowchart LR
    MAKER[Power Apps Maker Portal] --> DEV[Development Environment]
    DEV --> PAC[Power Platform CLI]
    PAC --> SOURCE[Local Solution Source]
    SOURCE --> GIT[Git Repository]
    GIT --> PR[Pull Request]
    PR --> BUILD[Managed Solution Build]
    BUILD --> TEST[Test]
    TEST --> UAT[UAT]
    UAT --> PROD[Production]
```

Development is the only maker environment in this model. A named PAC profile identifies each environment. Local source is reviewed in Git; an approved, immutable managed artifact progresses downstream. The workspace does not automate Production deployment.

## Environment Configuration

```mermaid
flowchart LR
    FLOW[Solution-Aware Flow] --> CR[Connection Reference]
    CR --> DEVCONN[Development Connection]
    CR --> TESTCONN[Test Connection]
    CR --> PRODCONN[Production Service Identity]

    FLOW --> EV[Environment Variable]
    EV --> DEVVALUE[Development Value]
    EV --> TESTVALUE[Test Value]
    EV --> PRODVALUE[Production Value]
```

A connection reference is transported with the solution and bound to an approved connection in each target. An environment variable definition is transported with the solution; its stage-specific value is supplied through controlled configuration. Credentials remain in the platform's approved identity or secret mechanism, not in Git.

## Responsibility Boundary

| Maker portal | VS Code workspace |
|---|---|
| Visual app and flow design | Source control and diff review |
| Dataverse table and form design | `.cdsproj` and supported source review |
| Connection-reference and environment-variable authoring | Deployment settings and inventories |
| AI Builder and Copilot Studio visual configuration | Custom code, documentation, tests, and Git history |
| Save, publish, and interactive testing | Static validation, package build, PR evidence |

## Solution Boundary

Every deployable workload should have an owner, publisher, solution unique name, component inventory, dependency model, connection inventory, environment-variable inventory, test plan, monitoring model, support model, and release/rollback procedure. Shared components should be split only when their dependency and lifecycle boundaries justify it.
