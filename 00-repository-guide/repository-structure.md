---
title: Repository Structure
description: Taxonomy and placement principles for durable knowledge, reusable assets, and lifecycle areas.
domain: Repository Management
subdomain: Repository Architecture
content_type: Architecture Guide
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Annual
tags:
  - taxonomy
  - repository-structure
  - content-placement
related:
  - README.md
  - adding-new-content.md
  - navigation-guide.md
---

# Repository Structure

The repository separates durable subject knowledge from reusable assets and lifecycle areas.

```text
00-repository-guide/          How this knowledge system works
01-enterprise-architecture/  Enterprise, solution, and integration architecture
02-software-engineering/     Software design, APIs, testing, and code quality
03-data-engineering/         Data architecture, platforms, transformation, and quality
04-analytics-bi/             Analytics, semantic models, dashboards, and Power BI
05-automation/               Power Platform, UiPath, process design, and operations
06-artificial-intelligence/  AI concepts, patterns, evaluation, and operations
07-cloud-platforms/          Cloud services and workload architecture
08-devops/                   Delivery, platform engineering, reliability, and observability
09-security-governance/      Security, governance, risk, compliance, and FinOps
10-business-domain/          Durable business-domain knowledge
11-project-delivery/         Delivery methods and organization-specific implementation work
12-templates/                Blank reusable assets
13-reference/                Concise references, commands, and cheat sheets
14-learning-paths/           Sequences that link to canonical subject knowledge
15-examples/                 Complete worked examples
16-prompts/                  Prompts organized by purpose
90-inbox/                    Temporary unclassified intake
95-review-required/          Content awaiting placement, authority, or publication decisions
99-archive/                  Superseded, duplicate, obsolete, incomplete, or historical content
repository-management/      Audits, maps, reports, and repository configuration
scripts/                     Non-writing validation and explicit index generation
```

## Placement Principles

- A durable guide has one primary location based on its main subject.
- Templates, examples, prompts, learning paths, and concise references use their content-type areas.
- Cross-domain relevance is expressed through links and metadata, not duplicate files.
- Organization-specific implementation evidence belongs under Project Delivery, not general technical guidance.
- Maximum practical depth is four levels unless deeper nesting prevents a real ambiguity.
