---
title: Microsoft Fabric
description: Canonical production guidance for architecting, delivering, governing, and operating Microsoft Fabric analytics workloads.
domain: Data Engineering
subdomain: Microsoft Fabric
content_type: Overview
level: Beginner to Pro
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - microsoft-fabric
  - onelake
  - analytics-platform
related:
  - ../README.md
  - ../../14-learning-paths/data-engineering/microsoft-fabric.md
  - ../../15-examples/data-engineering/fabric-sales-lakehouse.md
---

# Microsoft Fabric

Microsoft Fabric is a SaaS analytics platform that combines data integration, engineering, science, real-time analytics, warehousing, databases, and Power BI experiences over shared platform services and OneLake. A production design still needs explicit data products, ownership, workspace and capacity boundaries, quality contracts, security, lifecycle, and operations; a unified product surface does not make those decisions automatically.

## Start Here

1. [Architecture](architecture.md) — choose workloads, data-product boundaries, workspaces, OneLake patterns, and capacity isolation.
2. [Implementation](implementation.md) — deliver ingestion, lakehouse/warehouse transformations, quality, semantic consumption, tests, and CI/CD.
3. [Operations](operations.md) — operate pipelines, items, data freshness, capacity, throttling, incidents, and recovery.
4. [Security and governance](security-governance.md) — control tenant, capacity, workspace, item, data, sharing, network, and lifecycle boundaries.
5. [Troubleshooting](troubleshooting.md) — diagnose access, path, schema, refresh, deployment, and capacity failures.
6. [Official references](official-references.md) — current Microsoft primary documentation.
7. [Central learning path](../../14-learning-paths/data-engineering/microsoft-fabric.md).
8. [Worked example](../../15-examples/data-engineering/fabric-sales-lakehouse.md).

## Production Contract

For each data product record its owner and consumers, authoritative sources, grain and keys, freshness and quality objectives, workspace/item locations, classification, access model, lineage, capacity/SKU dependency, deployment path, recovery/reprocessing behavior, cost attribution, support tier, and retirement policy.

## Current-Scope Rule

Fabric changes frequently. Verify item support, regional availability, preview status, licensing, Git/deployment behavior, and limits in current Microsoft documentation before committing an architecture. Preview capabilities require an explicit risk, exit, and support decision.

## Organization-Specific Adoption Notes

> **Scope: Organization-Specific.** Tenant IDs, capacity names, workspace inventory, domain assignments, data classifications, source endpoints, identity groups, support contacts, chargeback rules, and production objectives belong in a clearly labeled controlled overlay, not in this public general guide.
