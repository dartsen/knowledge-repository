---
title: Power Platform Troubleshooting Guide
description: Diagnostic paths for Power Apps, Power Automate, Dataverse, Power Pages, Copilot Studio, connections, policy, and deployment.
domain: Automation
subdomain: Power Platform
content_type: Troubleshooting Guide
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - power-platform-troubleshooting
  - dataverse
  - power-automate
related:
  - README.md
  - operations.md
---

# Power Platform Troubleshooting Guide

## Evidence

Capture environment, solution/component and version, app/flow/site/agent/item, user or application identity, UTC time, operation/run/correlation/request ID, record key in approved masked form, connection reference/connector (not credential), recent solution/configuration/policy change, license/capacity/limit signal, and exact error without sensitive payloads.

| Symptom | Investigate | Response |
|---|---|---|
| App cannot read/update data | Dataverse role/team/row/column access, app sharing, connection, delegation/formula error | Test as affected persona; correct boundary permission or query |
| App slow/incomplete results | Delegation warnings, query shape, network, data volume, connector calls, formula loops | Move filtering server-side; reduce calls and measure representative data |
| Flow did not trigger | Trigger conditions, connection, owner, data policy, turned-off/suspended state, source event | Fix trigger/connection/policy; recover missed operations from authoritative query |
| Flow fails or duplicates | Run history, inputs, retry, timeout-after-side-effect, idempotency, concurrency, throttling | Stop unsafe reruns; reconcile by business-operation key |
| Dataverse limit/throttle | Request rate, plug-in/custom API time, bulk pattern, parallelism, query/select columns | Batch/paginate, reduce concurrency, optimize and respect retry guidance |
| Power Pages data exposed/denied | Site visibility, identity, web role, table permission, form/list/API configuration, cache | Restrict exposure immediately; test anonymous and each web role |
| Agent wrong or unsafe | Knowledge version, grounding, instructions, data policy, tool auth, evaluation, model/service | Disable unsafe tool/channel; route to fallback/human and add regression case |
| Import/pipeline fails | Dependencies, solution layers, version, managed/unmanaged state, connection refs, environment variables, target policy | Preserve artifact/log; fix source/config and redeploy same tested artifact |
| Works in development only | Hard-coded value, connection owner, target data/security, missing configuration/dependency, license | Compare governed environment/solution inventory; do not patch production manually |
| Policy suddenly blocks asset | Tenant/environment data-policy change, connector/action/MCP classification, enforcement delay | Confirm intended policy, assess all affected assets, use approved exception/remediation |

## Diagnosis Order

Start with business impact and platform health, then license/capacity/limits, identity and policy, solution/configuration, component logic, data, and external dependency. Use a nonproduction reproduction with synthetic data when possible. Do not fix a production managed component through unmanaged customization; repair source and redeploy.

## Closeout

Verify the user journey and business state, missed/duplicate work, authorization for each persona, monitoring, owner/support, solution version, no unmanaged drift, and no secrets in evidence. Update test, runbook, inventory, and root-cause action.
