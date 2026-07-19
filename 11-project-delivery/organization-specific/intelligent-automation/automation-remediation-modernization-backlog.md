---
title: IA Automation Remediation and Modernization Task Backlog
description: Organization-specific remediation backlog derived from a static review of an intelligent-automation portfolio.
domain: Project Delivery
subdomain: Organization-Specific Intelligent Automation
content_type: Research Note
level: Advanced
status: Review Required
scope: Organization-Specific
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Event-driven
tags:
  - organization-specific
  - intelligent-automation
  - remediation-backlog
related:
  - power-platform-current-state-review.md
  - ../../../05-automation/power-platform/README.md
---

# IA Automation Remediation and Modernization Task Backlog

> **Scope notice - Organization-Specific / Review Required.** This public-safe planning record describes a particular portfolio and is not general platform guidance. It omits credentials, personal data, tenant identifiers, private endpoints, and confidential case details. Validate every task against authorized current environment evidence before execution.

**Source:** Power Platform Current-State Architecture Review and Modernization Blueprint  
**Prepared:** July 13, 2026  
**Scope:** Twelve reviewed Power Platform workloads and their Power BI/dataflow, Zendesk, Jira, UiPath, Databricks, and observability boundaries  
**Use:** Seed backlog for Azure DevOps, Jira, Planner, or another delivery-management tool

## Priority and ownership conventions

- **P0:** Immediate security or material operational exposure.
- **P1:** Required to establish reliable, governed production operations.
- **P2:** Modernization or optimization after foundational controls are in place.
- **Owner role** identifies the accountable function; assign a named owner before work starts.
- Tasks involving live environments require tenant validation because the architecture review was based only on local files.

## 0–30 days — Repeatable security and ownership

| Done | ID | Priority | Task | Affected workloads | Owner role | Dependencies | Acceptance criteria | Review mapping |
|---|---|---:|---|---|---|---|---|---|
| [ ] | IA-001 | P0 | Revoke and rotate the exposed Zendesk credentials; review authentication and access logs for misuse. | Auto Renewal, Media Auto Renewal, NOC, Mustang Failed Renewal Remediation, Zendesk Ticket Creation | Security + Zendesk administrator | Approved incident/rotation window | Old credentials are revoked; replacement access is least-privileged; affected flows are tested; incident evidence and decisions are retained without copying secret values. | R1 |
| [ ] | IA-002 | P0 | Remove credential-bearing values from solution/package exports, environment-variable defaults, source history, release artifacts, and shared storage. | Same as IA-001 | Platform engineering + Security | IA-001 | Automated scans of current artifacts return no credential material; sanitized artifacts replace exposed copies; retention/legal requirements are observed. | R1–R2 |
| [ ] | IA-003 | P0 | Add automated secret scanning and make a positive finding a release blocker. | All solutions and packages | DevOps/platform engineering | Repository or controlled artifact location | Scanner runs on pull requests/builds and packaged artifacts; test credential is detected; clean build passes; exception process has owner and expiry. | R1, R9 |
| [ ] | IA-004 | P0 | Enable Secure Inputs and Secure Outputs on credential retrieval and applicable Zendesk/Jira HTTP actions as an interim containment step. | Auto Renewal, Media Auto Renewal, NOC, Jira intake flows, Zendesk Ticket Creation | Flow owners | IA-001; deployment access | Run history no longer exposes authorization inputs/outputs; functional smoke tests pass; limitation is documented until shared integrations replace direct HTTP. | R2 |
| [ ] | IA-005 | P1 | Create the authoritative production ownership and support inventory. | All 12 workloads | CoE/platform operations | Tenant admin read access | Every production app/flow records business owner, technical owner, co-owner, connection identity, license context, support owner, criticality, recovery contact, environment, and lifecycle state. | R12, R17 |
| [ ] | IA-006 | P1 | Establish a daily exception review and minimum critical-flow alert rule. | All critical flows, starting with Zendesk/Jira/NOC | Platform operations | IA-005 | Critical failures reach a monitored channel with workload, flow, environment, correlation/business-safe reference, timestamp, and support owner; daily review has evidence and escalation rules. | R5, R7 |
| [ ] | IA-007 | P1 | Review assignments and privileges for the `IA_App_User` Dataverse role. | Rate Change Calculator | Dataverse security administrator + app owner | Tenant role-assignment evidence | Named assignments are documented; Global and process-management privileges are removed unless justified; calculator tests pass under the reduced role; rollback is documented. | R13 |
| [ ] | IA-008 | P1 | Correct US Data Science Intake Form success and failure behavior. | US Data Science Intake Form | App owner | Unmanaged editable source | Navigation occurs only from `Form.OnSuccess`; `OnFailure` shows an actionable message and preserves user input; success/failure test cases pass. | R15 |
| [ ] | IA-009 | P1 | Triage App Checker findings and fix the highest-risk accessibility and invalid-reference issues. | Rate Change Calculator, IA Intake Form, US Data Science Intake Form | App owners + accessibility reviewer | Editable app source; IA Intake Form re-export if required | Invalid-name/argument findings are resolved or dispositioned; required controls have accessible labels and valid tab/focus behavior; results are stored with the release. | R15 |
| [ ] | IA-010 | P1 | Create a current exception inventory and manual recovery runbook. | All 12 workloads | Platform operations + workload owners | IA-005 | Known failure modes, stranded-item locations, safe replay steps, duplicate-prevention checks, escalation paths, and recovery owners are documented and exercised for the five highest-risk workloads. | R5, R8 |

## 1–3 months — Defined governance and ALM

| Done | ID | Priority | Task | Affected workloads | Owner role | Dependencies | Acceptance criteria | Review mapping |
|---|---|---:|---|---|---|---|---|---|
| [ ] | IA-011 | P1 | Establish an unmanaged development source and unpacked repository structure for every workload. | All 12 workloads | Platform engineering + solution owners | Source-control project; owner assignment | Each workload has a traceable development source, solution/package boundary, version policy, component inventory, and protected main branch; compiled exports are not the source of truth. | R9 |
| [ ] | IA-012 | P1 | Implement automated validation, build, managed promotion, approvals, smoke testing, and rollback/forward instructions. | Eight solutions; migrate four legacy packages into solutions | DevOps/platform engineering | IA-011; target environments | One build artifact is promoted through dev/test/prod; Solution Checker and secret scan run automatically; connections/settings are supplied at deployment; approval and rollback evidence is retained. | R9–R10 |
| [ ] | IA-013 | P1 | Validate and document the development, test/UAT, and production environment topology. | Program-wide | Platform architecture + CoE | Tenant admin inventory | Environment purpose, group, region, Managed Environment status, makers, data boundary, deployment route, retention, and exception process are approved; default-environment restrictions are explicit. | R11 |
| [ ] | IA-014 | P1 | Validate DLP policies and classify every observed connector and external endpoint. | All workloads; Zendesk and Jira priority | Security + CoE | IA-013; connector inventory | SharePoint, Dataverse, Office 365, Power BI/dataflows, HTTP, Zendesk, Jira/custom connector, and future Azure services have approved business/nonbusiness/blocked classifications; policy simulation and exception ownership are recorded. | R3–R4, R11 |
| [ ] | IA-015 | P1 | Build a configuration and deployment-settings catalogue. | All solution-aware workloads | Platform engineering | IA-011–IA-013 | Connection references, SharePoint sites/lists, folders, endpoints, recipients, feature flags, and nonsecret constants have owner, type, environment values, validation rule, and deployment mapping; environment values are absent from solution source. | R10 |
| [ ] | IA-016 | P1 | Implement Azure Key Vault-backed secret environment variables and governed secret retrieval. | Zendesk and Jira integrations | Security + platform engineering | IA-001, IA-013–IA-015; Key Vault | Secrets are unique by environment/consumer, retrieved through an approved identity, rotated without editing flows, absent from exports/run history, and covered by access logging and break-glass procedure. | R2 |
| [ ] | IA-017 | P1 | Define and adopt the IA cloud-flow engineering standard and starter template. | All flows | Platform architecture + senior flow engineers | IA-011 | Standard includes validation, correlation ID, idempotency, thin orchestrator, typed child-flow request/response, try/catch/finally, transient/permanent errors, bounded retry, timeout, compensation, telemetry, terminate/response semantics, and user communication; exception approval is defined. | R5 |
| [ ] | IA-018 | P1 | Inventory production flow ownership and move suitable flows to service-principal ownership. | Critical automated/scheduled flows | Platform operations + identity team | IA-005, IA-013–IA-014; licensing review | Deployment and runtime identities are separated; application users have least privilege; unsupported/inappropriate cases retain documented nonpersonal ownership; break-glass co-ownership and credential rotation are tested. | R12 |
| [ ] | IA-019 | P1 | Decide and implement Dataverse RBAC, auditing, and retention requirements for queue tables. | BOP, Mustang Conditional, Mustang Failed Renewal | Dataverse architect + Security/Compliance | Data classification and retention decision | Business-unit/team access is documented; table/column auditing is enabled where required; retention and storage monitoring are configured; service and support roles pass least-privilege tests. | R13–R14 |
| [ ] | IA-020 | P1 | Establish the connector, license, request, and capacity baseline. | Program-wide | CoE + licensing/FinOps + platform operations | IA-005, IA-014 | Baseline records connector tier, entitlement context, flow type, owner license, daily requests, duration, API calls, throttling, Dataverse storage, dataflow capacity, and log retention; unlicensed or inefficient patterns have remediation owners. | R17 |
| [ ] | IA-021 | P1 | Create the reusable reliability acceptance-test suite. | Shared integrations and critical flows | QA automation + platform engineering | IA-017 | Automated or repeatable tests cover duplicate trigger, transient 429/5xx, permanent rejection, timeout, retry exhaustion, controlled requeue, external success/local persistence failure, telemetry outage, and successful recovery. | R5–R8, R19 |
| [ ] | IA-022 | P1 | Produce approved shared-integration designs for Zendesk and Jira. | Five Zendesk workloads; two Jira intake workloads | Integration architect + Security + API owners | IA-014–IA-017, IA-020 | Design selects certified/custom connector or governed alternative; defines authentication, Key Vault use, connection reference, DLP, request/response schema, timeout, throttling, idempotency, attachment handling, error taxonomy, telemetry, ownership, SLO, and migration plan. | R2–R4 |

## 3–6 months — Capable reusable platform

| Done | ID | Priority | Task | Affected workloads | Owner role | Dependencies | Acceptance criteria | Review mapping |
|---|---|---:|---|---|---|---|---|---|
| [ ] | IA-023 | P1 | Build and release the governed Zendesk integration surface and solution-aware child-flow contract. | Shared IA foundation | Integration engineering | IA-016–IA-017, IA-021–IA-022 | Contract supports idempotent create/update, correlation ID, external ID lookup, typed errors, bounded transient retry, explicit timeout, telemetry, secure history, and test stubs; owner/SLO/version policy are published. | R3, R5, R7 |
| [ ] | IA-024 | P1 | Migrate all direct Zendesk implementations and retire embedded-credential paths. | Auto Renewal, Media Auto Renewal, NOC, Mustang Failed Renewal, Zendesk Ticket Creation | Workload owners + integration engineering | IA-023 | All five workloads use the governed surface; duplicate branches/direct HTTP are removed; regression and idempotency tests pass; old connections/credentials are disabled; rollback evidence is retained. | R1–R3, R16 |
| [ ] | IA-025 | P1 | Build and release the governed Jira create/update/attachment operation. | Shared IA foundation | Integration engineering | IA-016–IA-017, IA-021–IA-022 | Contract provides deterministic external reference, attachment reconciliation, typed errors, bounded retry, timeout, secure authentication, telemetry, and test evidence. | R4–R5, R7 |
| [ ] | IA-026 | P1 | Migrate both intake solutions to the shared Jira operation. | US Data Intake Form Integration; US Data Science Intake Form | Workload owners + integration engineering | IA-025 | Both flows are solution-aware, use the shared contract, avoid duplicate issues on replay, reconcile partial attachments, and present actionable failure states. | R4, R9, R15 |
| [ ] | IA-027 | P1 | Standardize domain queue state and operational columns. | BOP, Mustang Conditional, Mustang Failed Renewal; future queues | Dataverse architect + workload owners | IA-017, IA-019, IA-021 | Queue standard includes correlation ID, idempotency key, state, attempt count, next retry, last error category, external ID, timestamps, support owner, and audit fields; state semantics and transition ownership are versioned. | R6 |
| [ ] | IA-028 | P1 | Add atomic duplicate prevention, bounded retry, dead-letter, and controlled requeue to queue-based workloads. | BOP, Mustang Conditional, Mustang Failed Renewal | Flow engineers + Dataverse architect | IA-027 | Stable business identifiers use alternate keys where valid; transient/permanent failures diverge; exhausted items remain recoverable; requeue is authorized/audited; acceptance tests pass. | R5–R6, R8 |
| [ ] | IA-029 | P1 | Build the model-driven exception workbench. | All queue-backed and migrated integration workloads | Power Apps/Dataverse team + operations | IA-027–IA-028 | Operators have failed/due/aging views, assignment, sanitized reason, audit history, SLA indicators, controlled requeue, and drill-through by correlation ID; least-privilege and usability tests pass. | R8 |
| [ ] | IA-030 | P1 | Implement the standard telemetry emitter and state-transition event schema. | All critical workloads | Observability team + platform engineering | IA-017, IA-027; internal platform interface | Events contain workload, environment, flow, correlation ID, business-safe reference, state, duration, attempt, error category, connector, and external result; telemetry failure does not corrupt durable processing; sensitive data is excluded. | R7 |
| [ ] | IA-031 | P1 | Deliver operational dashboards, actionable alerts, and support SLOs. | Program-wide | Observability team + operations | IA-005–IA-006, IA-030 | Dashboards show health, failure rate, age, retries, dead letters, external latency, throughput, and owner; alert thresholds have runbooks and escalation; correlation spans Power Platform and external boundaries. | R7–R8 |
| [ ] | IA-032 | P2 | Consolidate BOP general and GA notification flows using governed jurisdiction/template configuration. | BOP Nonrenewal Notice Process | BOP product owner + flow engineering | IA-017, legal/business rule approval | Shared operations replace confirmed duplication; jurisdiction exceptions remain explicit and testable; queue idempotency is enforced; output parity tests pass. | R6, R16 |
| [ ] | IA-033 | P1 | Replace fixed waits with persisted batch state and data-freshness continuation. | Mustang Conditional Renewal Notice Remediation | Flow engineering + Power BI/dataflow owners | IA-017, IA-021, dataflow freshness contract | Batch key prevents overlap; freshness watermark is persisted; scheduled/event-driven continuation replaces long waits; timeout and stale-data routes are recoverable and observable. | R5–R7, R19 |
| [ ] | IA-034 | P2 | Replace six MFRR status-specific Zendesk branches with one configuration-driven operation. | Mustang Failed Renewal Remediation | Flow engineering + business owner | IA-023–IA-024 | Status-to-template mapping is externalized and versioned; one shared call is used; unknown status is a permanent business error; existing status scenarios pass regression tests. | R3, R16 |
| [ ] | IA-035 | P1 | Refactor NOC child flows for typed errors and stateful document completion. | NOC Process | NOC product owner + flow engineering | IA-017, IA-021, IA-030 | Parent receives standard child-flow responses; repeated conversion waits are removed; document state can resume after timeout; partial output is reconciled; error and recovery tests pass. | R5–R7, R16 |
| [ ] | IA-036 | P2 | Consolidate NOC Final Notice and Payment Overdue notification patterns. | NOC Process | NOC product owner + flow engineering | IA-035 | Shared parameterized notification component replaces identical action shapes; template/config ownership is documented; message-content regression tests pass. | R16 |
| [ ] | IA-037 | P2 | Merge Auto Renewal and Media Auto Renewal ticket workflows behind a parameterized process. | Auto Renewal; Media Auto Renewal | Product owners + integration engineering | IA-023–IA-024 | One governed flow/component supports both variants; workload-specific fields remain configuration; recovery and idempotency behavior are consistent; retired flows are disabled and archived. | R3, R16 |
| [ ] | IA-038 | P1 | Split On Call Rotation from a true IA shared-foundation solution. | IA Core Connections / On Call Rotation | Solution architect + platform engineering | IA-011–IA-012, IA-023, IA-025, IA-030 | Business process and reusable assets have separate owned solutions; foundation contains approved connectors, references, environment variables, telemetry, templates, and version/dependency rules. | R9–R10, R16 |
| [ ] | IA-039 | P1 | Replace the Rate Change Calculator collection workaround with a delegable data-access pattern. | Rate Change Calculator | App owner + data architect | Data volume/security baseline; IA-009 | Results remain complete above the current canvas row limit; query is delegable and indexed; startup and response targets pass; Dataverse migration decision is documented if SharePoint cannot satisfy scale/governance. | R15 |
| [ ] | IA-040 | P2 | Create a reusable canvas component library and app quality gate. | All canvas apps | App platform lead + accessibility/QA | IA-009, IA-011–IA-012 | Library provides standard header, loading, success/error, accessibility, support, and telemetry components; checker/accessibility/test thresholds block noncompliant promotion. | R15–R16 |

## 6–12 months — Capable toward Efficient

| Done | ID | Priority | Task | Affected workloads | Owner role | Dependencies | Acceptance criteria | Review mapping |
|---|---|---:|---|---|---|---|---|---|
| [ ] | IA-041 | P1 | Define versioned cross-platform handoff contracts. | Power BI/dataflows, UiPath, Databricks, internal observability | Enterprise integration architecture + system owners | IA-030–IA-031; owner agreements | Each boundary defines correlation, schema/version, freshness, timeout, retry/rejection, idempotency/replay, security, ownership, SLO, and change process; contract tests exist. | R19 |
| [ ] | IA-042 | P2 | Establish measured Azure offload decision gates. | High-volume, bursty, isolated, or long-running workloads | Enterprise architecture + platform operations | IA-020, IA-031, IA-041 | Thresholds cover burst/throughput, throttling, network isolation, replay guarantee, authentication complexity, duration, and transformation volume; APIM/Functions/Service Bus/Databricks are selected only when evidence crosses an approved threshold. | R19 |
| [ ] | IA-043 | P2 | Optimize licensing, connector choice, capacity, storage, and telemetry retention from measured utilization. | Program-wide | CoE + licensing/FinOps + platform operations | IA-020, at least 60–90 days of telemetry | Rightsizing decisions have before/after usage and cost evidence; critical workloads retain performance/recovery headroom; savings do not weaken security or supportability. | R17 |
| [ ] | IA-044 | P1 | Run scheduled reliability exercises and recovery drills. | Critical workloads and shared integrations | Platform operations + QA + workload owners | IA-021, IA-023–IA-031 | Exercises cover API outage, expired secret, throttling, duplicate trigger, poison item, telemetry outage, queue replay, and successful recovery; actions are tracked to closure and SLOs are updated. | R5–R8, R19 |
| [ ] | IA-045 | P1 | Implement an AI readiness gate and AI component inventory before production AI use. | Copilot Studio, AI Builder, Azure OpenAI, or AI-assisted flows if introduced | Responsible AI lead + Security + CoE | Approved AI policy and risk classification | Gate requires owner/use case, trusted grounding, access/DLP, prompt/model version, injection and quality tests, moderation, human-review threshold, audit, monitoring, feedback, cost forecast, and rollback; no consequential AI action bypasses approval. | R18 |
| [ ] | IA-046 | P2 | Establish a recurring CoE governance and value-review cadence. | Program-wide | CoE lead + technical leadership | IA-005, IA-013–IA-020, IA-031 | Monthly/quarterly review covers ownership, abandonment, sharing, connector/DLP risk, security findings, reliability, capacity/license usage, release compliance, business value, exceptions, and roadmap progress; decisions and owners are recorded. | R9, R11–R12, R17–R18 |

## Recommended delivery sequence

1. Treat IA-001 through IA-004 as an immediate security workstream.
2. Run IA-005 through IA-010 in parallel where owners are available.
3. Complete the ALM, environment, identity, and flow-standard foundations before large refactoring.
4. Design shared integrations once, then migrate Zendesk and Jira consumers in controlled waves.
5. Standardize durable queue state before building the exception workbench and end-to-end telemetry.
6. Refactor solution-specific duplication after common contracts are stable.
7. Make Azure offload, licensing optimization, and AI adoption evidence-driven using production measurements.

## Backlog governance

- Assign a named accountable owner and target date to every P0/P1 task.
- Record live-tenant evidence separately from the static-review evidence.
- Link implementation stories and test evidence to the parent task ID.
- Do not close migration tasks until the old flow, connection, credential, or duplicate component is safely retired.
- Review dependencies and priorities monthly; revisit effort estimates after tenant inventory and production-volume baselines are available.
