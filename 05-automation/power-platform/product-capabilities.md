---
title: Power Platform Product Capabilities and Boundaries
description: Selection guide for Power Apps, Power Automate, Dataverse, Power Pages, Copilot Studio, AI Builder, Power BI, and extensibility.
domain: Automation
subdomain: Power Platform
content_type: Concept Guide
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - power-apps
  - power-automate
  - copilot-studio
related:
  - README.md
  - architecture.md
---

# Power Platform Product Capabilities and Boundaries

| Capability | Use it for | Do not assume |
|---|---|---|
| Power Apps canvas apps | Task-focused custom interfaces and mobile/responsive experiences | A large app remains maintainable without component, data, delegation, and performance design |
| Power Apps model-driven apps | Process/data-centric apps over Dataverse metadata, forms, views, and security | Default forms and roles match the business operating model |
| Power Automate cloud flows | Event, approval, schedule, API, and business-process automation | Retries, ownership, idempotency, scale, monitoring, or rollback are automatic |
| Power Automate desktop flows | UI automation where supported APIs are unavailable | Desktop state, selectors, machines, credentials, and attended/unattended licensing are simple |
| Dataverse | Governed business tables, relationships, logic, security, auditing, APIs, and solution metadata | It is only storage or that every data source should be copied into it |
| Power Pages | External-facing sites connected to Dataverse | External identity, table permissions, web roles, exposure, content, and lifecycle are safe by default |
| Microsoft Copilot Studio | Governed agents, topics/instructions, knowledge, tools/actions, channels, and analytics | Generated responses and tool calls are correct or authorized merely because the agent can produce them |
| AI Builder | Packaged AI capabilities in apps and flows where feature/licensing fit | Model quality, bias, capacity, human review, and data use need no validation |
| Connectors/custom connectors | Typed access to Microsoft and external APIs | Connector certification replaces authorization, data-policy, or vendor-risk review |
| Power Fx | Declarative formulas and reusable low-code logic | Complex business logic belongs only in client formulas |
| PCF, plug-ins, custom APIs | Professional-code UI, server logic, and integration extensions | Code removes the need for solution packaging, tests, telemetry, support, and limits review |
| Power BI | Analytics and semantic consumption across platform data | BI lifecycle and governance belong solely to Automation; use the [Power BI domain guide](../../04-analytics-bi/power-bi/README.md) |

## Connectors and Custom Connectors

Treat a connector as an integration boundary. Review supported triggers/actions, authentication, delegated versus application identity, connector tier and licensing, data-policy classification, region, limits, timeout/retry behavior, pagination, concurrency, vendor lifecycle, monitoring, and support. A custom connector also needs an owned API contract, secure authentication, least-privilege operations, versioning, tests, telemetry, and a retirement path; publishing an OpenAPI description does not make the underlying API safe or reliable.

## Power BI Integration

Keep Power BI as a governed analytics lifecycle even when it consumes Dataverse or appears inside a Power Platform solution. Choose the supported Dataverse/Power Query connection and Import or DirectQuery mode from freshness, volume, performance, network, and security requirements. Define semantic grain and measures, validate report and data access by persona, version and deploy reports/models through their supported ALM path, and monitor refresh and query behavior. Embedding a report in a model-driven app does not remove Power BI permissions, licensing, semantic governance, or support ownership.

## Licensing, Capacity, and Limits

Create a licensing and capacity model before release: makers and users, apps, attended/unattended or process automation, premium and custom connectors, Power Pages users, Copilot Studio and AI Builder consumption, Managed Environments, Dataverse database/file/log storage, Power Platform requests, and any separate Power BI entitlement. Model steady and peak demand, retry/pagination amplification, growth, nonproduction use, and contingency capacity. Microsoft changes offers and transition limits; verify the current licensing guide and product documentation, then monitor actual consumption rather than treating a design-time estimate as permanent.

## Selection Tests

Choose from process latency, volume, concurrency, transaction/consistency, data classification, user population, external access, offline/mobile, accessibility, recoverability, extensibility, ALM, support skill, licensing/capacity, and expected change. Move heavy compute, long-running bulk work, complex integration, or specialized security boundaries to an API/data/platform service when the low-code component cannot meet the contract transparently.

## AI Boundary

Agents and AI Builder introduce probabilistic behavior and new data/tool paths. Define approved knowledge, grounding, evaluation set, unsafe-output and prompt-injection controls, tool identity and authorization, human approval for consequential actions, monitoring, cost/capacity, and fallback. An agent must never broaden the caller's data or operation permissions.
