---
title: "Semantic Modeling Troubleshooting Guide"
domain: "Analytics and BI"
level: "Beginner to Pro"
status: "Phase 3 Analytics/BI Draft"
last_updated: "2026-06-20"
tags:
  - analytics-bi
  - semantic-modeling
  - troubleshooting
related:
  - ../
---

# Semantic Modeling Troubleshooting Guide

## Troubleshooting Mindset

Troubleshooting analytics and BI means tracing the issue from user experience back through visuals, measures, filters, semantic model, source data, refresh process, permissions, and governance.

```text
User Symptom
  → Report Visual
  → Filters / Slicers
  → Measure Logic
  → Semantic Model
  → Source Data
  → Refresh / Connection
  → Access / Security
  → Root Cause
  → Prevention
```

## Common Issues

| Issue | Likely Cause | Investigation Steps | Resolution | Prevention |
|---|---|---|---|---|
| Numbers do not match | Different metric definition, filter, source, or relationship | Compare DAX, filters, source query, and model relationships | Align calculation and publish definition | Use governed measures and glossary |
| Refresh failure | Credential, source, gateway, schema, or capacity issue | Check refresh history, credentials, gateway, source changes | Fix connection or schema and refresh | Monitor refresh and document owner |
| Slow report | Inefficient DAX, poor model, too many visuals, DirectQuery latency | Use Performance Analyzer and model review | Optimize measures, model, visuals, or storage mode | Use performance standards |
| User cannot access | App, workspace, license, RLS, or permission issue | Check roles, app audiences, build permissions, RLS | Grant correct access or update role | Use access process and periodic review |
| Visual broken | Field removed, renamed, or changed type | Review model and source changes | Update report and model | Use impact analysis before changes |
| Report not trusted | Unclear metric definition or inconsistent source | Review definitions and reconciliation | Publish definitions and validation notes | Govern semantic models and KPIs |
| Duplicate reports | No inventory or lifecycle control | Review usage, owners, and report purpose | Consolidate or retire | Use report rationalization cadence |

## Evidence to Collect

- Report link
- Workspace name
- Semantic model name
- Refresh history
- Error message
- Screenshot
- User role
- RLS role
- DAX measure
- Filter context
- Source query
- Usage metrics
- Recent deployments
- Data source change notes

## Escalation

| Issue Type | Escalate To |
|---|---|
| Metric definition conflict | Business owner / metric owner |
| Source data issue | Data owner / data engineering |
| Semantic model issue | BI model owner |
| Report visual issue | Report owner |
| Access issue | Workspace admin / security |
| Refresh issue | BI owner / platform owner |
| Capacity or performance issue | Power BI / Fabric admin |

## Post-Incident Review

- What failed?
- Who was impacted?
- Was the issue detected proactively?
- Was ownership clear?
- Was documentation sufficient?
- What test or monitor was missing?
- What should change before the next release?
