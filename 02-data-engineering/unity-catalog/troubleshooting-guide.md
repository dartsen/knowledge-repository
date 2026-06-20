---
title: "Unity Catalog Troubleshooting Guide"
domain: "Data Engineering"
level: "Beginner to Pro"
status: "Phase 3 Draft"
last_updated: "2026-06-20"
tags:
  - data-engineering
  - unity-catalog
  - troubleshooting
related:
  - ../
---

# Unity Catalog Troubleshooting Guide

## Troubleshooting Mindset

Troubleshooting data engineering issues requires following the data from source to consumption.

```text
Symptom
  → Consumer Impact
  → Affected Layer
  → Recent Change
  → Source / Transform / Access / Runtime Check
  → Root Cause
  → Resolution
  → Prevention
```

## Common Issues

| Issue | Likely Cause | Investigation Steps | Resolution | Prevention |
|---|---|---|---|---|
| Data missing | Source issue, filter error, late arrival | Check source, ingestion logs, filters, row counts | Fix source or transformation and rerun | Add freshness and volume checks |
| Duplicates | Incorrect grain or join logic | Check keys, joins, row counts | Fix grain or deduplication logic | Add uniqueness tests |
| Pipeline failure | Runtime, permission, code, or dependency issue | Review job logs and recent changes | Fix and rerun safely | Add retries and alerts |
| Report mismatch | Conflicting definitions | Compare model and report logic | Standardize metric definition | Use governed semantic layer or glossary |
| Access denied | Missing grant or wrong identity | Check permissions and groups | Grant correct least-privilege access | Document access model |
| Slow query | Poor model design or inefficient SQL | Review query plan and table design | Optimize model or materialization | Monitor performance and usage |
| Test failure | Data defect or rule mismatch | Review failed rows and business rule | Fix data or adjust rule with owner approval | Add issue tracking and source feedback |

## Evidence to Collect

- Job run ID
- Error message
- Recent commits
- Source row counts
- Target row counts
- Failed test output
- Query history
- Access logs
- Lineage diagram
- Business impact
- Screenshots or sample records

## Escalation

| Issue Type | Escalate To |
|---|---|
| Source data issue | Source system owner |
| Transformation bug | Data engineering / analytics engineering |
| Access issue | Platform / IAM / data governance |
| Business rule conflict | Business owner / data owner |
| Performance issue | Platform team / data engineering |
| Downstream report issue | BI owner |
| Automation impact | Automation owner |

## Post-Incident Review

- What failed?
- What was the business impact?
- How was it detected?
- Was monitoring sufficient?
- Was ownership clear?
- What test or alert would have caught it earlier?
- What documentation needs updating?
