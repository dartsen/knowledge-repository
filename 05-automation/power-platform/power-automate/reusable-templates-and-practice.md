# Power Automate Reusable Templates and Practice

## 21. Reusable Templates

---

### 21.1 Automation Intake Template

```markdown
# Automation Intake

## Process Name

`<process-name>`

## Requester

`<name / team>`

## Business Problem

Describe the problem being solved.

## Current Manual Process

Describe how the process works today.

## Desired Future State

Describe what should happen after automation.

## Trigger

What starts the process?

## Inputs

- Input 1
- Input 2
- Input 3

## Outputs

- Output 1
- Output 2
- Output 3

## Systems Involved

- System 1
- System 2
- System 3

## Business Rules

- Rule 1
- Rule 2
- Rule 3

## Exceptions

- Exception 1
- Exception 2
- Exception 3

## Volume

Expected daily / weekly / monthly volume.

## SLA

Expected completion time.

## Risk Level

- [ ] Low
- [ ] Medium
- [ ] High

## Data Sensitivity

- [ ] Public
- [ ] Internal
- [ ] Confidential
- [ ] Regulated / sensitive

## Business Owner

`<name>`

## Technical Owner

`<name>`

## Support Owner

`<name>`
```

---

### 21.2 Flow Design Document Template

```markdown
# Flow Design Document

## Flow Name

`<flow-name>`

## Purpose

Explain what this flow does.

## Business Context

Explain why the flow exists.

## Flow Type

- [ ] Automated cloud flow
- [ ] Instant cloud flow
- [ ] Scheduled cloud flow
- [ ] Desktop flow
- [ ] Business process flow
- [ ] Child flow

## Trigger

Describe the trigger.

## Trigger Conditions

List any trigger conditions.

## Systems and Connectors

| System | Connector | Connection Reference |
|---|---|---|
| SharePoint | SharePoint | `<connection-reference>` |
| Dataverse | Dataverse | `<connection-reference>` |

## Environment Variables

| Variable | Purpose |
|---|---|
| `<variable-name>` | `<purpose>` |

## Process Logic

Describe the major steps.

## Error Handling

Describe Try / Catch / Finally structure.

## Logging

Describe what is logged and where.

## Notifications

Describe success and failure notifications.

## Security

Describe account, permission, and data sensitivity considerations.

## Testing

Describe test scenarios.

## Deployment

Describe movement from dev to test to prod.

## Support Notes

Describe how to troubleshoot and support this flow.
```

---

### 21.3 Production Readiness Checklist

```markdown
# Power Automate Production Readiness Checklist

## Design

- [ ] Business owner identified
- [ ] Technical owner identified
- [ ] Support owner identified
- [ ] Process documented
- [ ] Business rules documented
- [ ] Exceptions documented

## Build

- [ ] Flow is inside a solution
- [ ] Connection references are used
- [ ] Environment variables are used
- [ ] No hardcoded production values
- [ ] Flow actions are clearly named
- [ ] Flow is modular where appropriate

## Security

- [ ] Approved connections used
- [ ] Service account or ownership model approved
- [ ] Permissions validated
- [ ] Sensitive data reviewed
- [ ] DLP policy reviewed

## Testing

- [ ] Happy path tested
- [ ] Exception path tested
- [ ] Permission failure tested
- [ ] Missing data tested
- [ ] Volume tested
- [ ] Retry behavior tested

## Monitoring

- [ ] Run logging configured
- [ ] Failure alerts configured
- [ ] Support mailbox or channel configured
- [ ] Dashboard created if needed

## Deployment

- [ ] Deployed through approved process
- [ ] Environment variables set
- [ ] Connection references mapped
- [ ] Flow turned on in production
- [ ] Smoke test completed

## Support

- [ ] Runbook created
- [ ] Support team briefed
- [ ] Rollback plan documented
- [ ] Known issues documented
```

---

### 21.4 Troubleshooting Runbook Template

```markdown
# Troubleshooting Runbook

## Flow Name

`<flow-name>`

## Business Purpose

Explain what the flow supports.

## Common Failure Scenarios

| Failure | Likely Cause | Resolution |
|---|---|---|
| Flow did not trigger | Trigger condition not met | Check trigger payload and conditions |
| Access denied | Connection lacks permission | Validate service account access |
| Null value error | Missing source data | Add validation or correct source record |
| Approval not sent | Recipient invalid | Check approval action inputs |
| Throttling | Too many requests | Reduce calls or review license limits |

## First Checks

- [ ] Is the flow turned on?
- [ ] Did the trigger event occur?
- [ ] Is the connection valid?
- [ ] Did a DLP policy block the connector?
- [ ] Did the failed action return a clear error?

## Escalation Path

| Issue Type | Escalate To |
|---|---|
| Business rule issue | Business owner |
| Permission issue | Platform admin |
| Connector issue | Power Platform admin |
| Data issue | Data owner |
| Production outage | Support lead |

## Recovery Steps

1. Identify failed run.
2. Capture error message.
3. Validate source data.
4. Correct issue.
5. Retry or resubmit if safe.
6. Log support note.
7. Notify business owner.
```

---

### 21.5 Error Handling Pattern Template

```markdown
# Error Handling Pattern

## Recommended Flow Structure

1. Initialize variables
2. Try scope
3. Catch scope
4. Finally scope

## Try Scope

Contains the main business logic.

## Catch Scope

Runs when Try fails, times out, or is skipped.

Actions:

- Capture error details
- Log failed run
- Notify support
- Update business record status
- Include run URL if available

## Finally Scope

Runs after success or failure.

Actions:

- Write completion status
- Release locks if used
- Send final notification if required

## Error Log Fields

| Field | Description |
|---|---|
| FlowName | Name of flow |
| RunId | Run identifier |
| Status | Failed / Succeeded |
| ErrorMessage | Error detail |
| BusinessKey | Related record ID |
| Timestamp | Failure time |
| Environment | Dev/Test/Prod |
```

---

### 21.6 Naming Standards Template

```markdown
# Power Automate Naming Standards

## Flow Names

Format:

`<Area> - <Process> - <Action>`

Examples:

- `IA - Renewal Notices - Intake Request`
- `Claims - FNOL - Send Approval`
- `Finance - Invoice - Validate Vendor`

## Child Flow Names

Format:

`Child - <Reusable Function>`

Examples:

- `Child - Write Run Log`
- `Child - Send Failure Alert`
- `Child - Validate Required Fields`

## Environment Variables

Format:

`<SolutionPrefix>_<Purpose>`

Examples:

- `IA_SupportMailbox`
- `IA_SharePointSiteUrl`
- `IA_ApiBaseUrl`

## Connection References

Format:

`cr_<connector>_<purpose>`

Examples:

- `cr_sharepoint_automation`
- `cr_dataverse_core`
- `cr_sql_policylookup`
```

---

## 22. Recommended Personal Practice Routine

### Daily

* Check failed runs for flows you own.
* Review new errors or retries.
* Validate that production flows are healthy.
* Document any changes made.

### Weekly

* Review flow success rates.
* Clean up unused test flows.
* Review stale approvals.
* Check high-volume flows for throttling risk.
* Update documentation when logic changes.

### Monthly

* Review ownership and service account access.
* Review DLP and connector usage.
* Review environment variable values.
* Review flow inventory.
* Identify flows that should be retired, refactored, or promoted.
* Report business value and hours saved.

---

## 23. Final Mental Model

Power Automate is not just a low-code workflow builder.

It is an automation platform that can support personal productivity, team workflows, enterprise integration, robotic process automation, and intelligent automation.

At the beginner level, Power Automate helps you automate simple tasks.

At the intermediate level, it helps you build reliable business workflows.

At the advanced level, it helps you integrate systems and manage exceptions.

At the enterprise level, it becomes part of an automation operating model involving governance, ALM, security, monitoring, support, and continuous improvement.

The core flow is:

```text
Process Need
   ↓
Automation Design
   ↓
Build Flow
   ↓
Test
   ↓
Deploy
   ↓
Monitor
   ↓
Improve
```

The goal is not just to make flows work.

The goal is to make automations that are useful, safe, supportable, scalable, and trusted.
