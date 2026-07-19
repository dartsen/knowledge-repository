---
title: Microsoft Fabric Architecture
description: Architecture method for Fabric data products, OneLake, workspaces, workload engines, semantic consumption, and capacity.
domain: Data Engineering
subdomain: Microsoft Fabric
content_type: Architecture Guide
level: Advanced
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - fabric-architecture
  - onelake
  - lakehouse
related:
  - README.md
  - implementation.md
---

# Microsoft Fabric Architecture

## Architecture from Data Products

Begin with business decisions and consumers. Define each product's domain, authoritative inputs, grain, identifiers, history, latency/freshness, quality, classification, consumers, owner, and service objectives. Map products to Fabric items only after the contract is stable.

## Logical Layers

```text
Operational, file, SaaS, event, and external lake sources
  -> ingestion: Data Factory pipelines/dataflows, events, shortcuts, APIs
  -> OneLake landing/bronze: immutable or replayable source-aligned data
  -> validated/silver: typed, deduplicated, conformed, quality-observed data
  -> product/gold: warehouse/lakehouse tables, eventhouse outputs, semantic models
  -> Power BI, SQL, notebooks, applications, exports, and governed sharing
```

OneLake is the tenant-wide logical data lake, but access and lifecycle are organized through workspaces and items. Shortcuts can reduce copies; they also preserve a runtime dependency on the source's access, availability, consistency, egress, and lifecycle. Record which system owns the data and what happens when a shortcut target is unavailable.

## Workload Choice

| Need | Candidate | Architecture question |
|---|---|---|
| Spark and open-file engineering | Lakehouse/Data Engineering | Who owns table maintenance, schema, partitioning, and session cost? |
| Relational warehouse development and serving | Warehouse | Does the workload fit SQL, concurrency, and deployment requirements? |
| Managed ingestion/orchestration | Data Factory | Are connectors, networking, retries, and item lifecycle supported? |
| Streaming/event analytics | Real-Time Intelligence | What are event time, retention, ordering, replay, and late-data rules? |
| Governed business metrics | Power BI semantic model | Is grain, security, refresh/direct access, endorsement, and ownership explicit? |
| Data science/ML | Data Science | How are features, experiments, models, environments, and inference governed? |

## Workspace and Capacity Boundaries

Use workspaces as security, ownership, deployment, and lifecycle boundaries—not merely folders. Separate development, test, and production. Further separate domains or high-risk/high-scale products when independent access, release, support, or cost control is needed. Map workspaces to capacities deliberately: shared capacity improves utilization but couples workloads through consumption and throttling.

## Recovery and Portability

Define source replay, checkpoints, immutable landing retention, table recovery/time travel where applicable, semantic-model rebuild, deployment rehydration, workspace/capacity loss procedures, and export/portability. Test the specific Fabric items used; do not infer end-to-end disaster recovery from storage durability alone.
