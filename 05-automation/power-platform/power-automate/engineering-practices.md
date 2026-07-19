# Power Automate Engineering Practices

## 8. Best Practices

---

### 8.1 Start With the Process, Not the Tool

Before building a flow, document:

* Process name
* Business owner
* Trigger
* Inputs
* Outputs
* Decision rules
* Exceptions
* Systems involved
* Expected volume
* SLA
* Support owner

Do not automate a bad process without understanding it.

---

### 8.2 Use Solutions for Enterprise Flows

For production-grade flows, build inside a Power Platform solution.

Benefits:

* Better ALM
* Easier deployment
* Connection references
* Environment variables
* Component grouping
* Cleaner ownership
* Better governance

---

### 8.3 Use Service Accounts Carefully

Production flows should usually avoid being owned only by an individual employee account.

Consider using:

* Service accounts
* Application users where appropriate
* Shared ownership
* Dedicated automation accounts
* Proper licensing
* Clear access reviews

Risk of personal ownership:

* Flow breaks when user leaves
* Password or MFA changes impact flow
* Permissions are unclear
* Support team lacks visibility

---

### 8.4 Use Environment Variables

Avoid hardcoding:

* URLs
* email addresses
* API endpoints
* list names
* site paths
* thresholds
* environment-specific values

Better:

```text
Environment variable: SupportMailbox
Dev value: automation-dev@company.com
Prod value: automation-support@company.com
```

---

### 8.5 Use Connection References

Connection references make deployments cleaner and reduce manual rework between environments.

Use them for:

* SharePoint
* Dataverse
* Outlook
* SQL
* Teams
* Custom connectors
* HTTP connections when applicable

---

### 8.6 Design for Failure

Every important flow should include error handling.

Recommended structure:

```text
Initialize
   ↓
Try Scope
   ↓
Catch Scope
   ↓
Finally / Logging Scope
```

Microsoft guidance recommends robust error handling using strategies such as retry policies and configuring “Run after” settings.

---

### 8.7 Log Important Runs

Do not rely only on Power Automate run history for critical business processes.

Create an operational log when needed.

Example log fields:

| Field          | Description                            |
| -------------- | -------------------------------------- |
| Flow name      | Name of automation                     |
| Run ID         | Unique run identifier                  |
| Start time     | When run started                       |
| End time       | When run completed                     |
| Status         | Success, failed, skipped               |
| Business key   | Policy number, request ID, customer ID |
| Error message  | Failure details                        |
| Retry count    | Number of retries                      |
| Environment    | Dev, test, prod                        |
| Trigger source | Email, SharePoint, API, schedule       |

---

### 8.8 Keep Flows Small and Modular

Avoid giant flows with hundreds of actions.

Better:

* Parent flow for orchestration
* Child flow for reusable logic
* Separate flow for logging
* Separate flow for notifications
* Separate flow for exception handling

---

### 8.9 Use Trigger Conditions

Trigger conditions prevent unnecessary runs.

Example:

```text
Only run when Status = "Ready for Processing"
```

Benefits:

* Reduces wasted flow runs
* Lowers request consumption
* Improves performance
* Avoids accidental loops

Microsoft’s pipeline extensibility guidance also notes that trigger conditions can help flows run only when specific conditions are met and reduce request consumption.

---

### 8.10 Understand Platform Limits

Power Platform request limits exist to maintain service levels, availability, and platform quality. Power Automate also has specific limits for automated, scheduled, and instant flows depending on license type.

Design flows with limits in mind:

* Avoid unnecessary loops
* Avoid excessive polling
* Use trigger conditions
* Batch where possible
* Filter early
* Avoid repeatedly calling APIs inside loops
* Use child flows thoughtfully
* Monitor throttling

Microsoft guidance warns that flows violating limits can be throttled and, if continuously throttled, can be turned off.

---

## 9. Common Mistakes

---

### Mistake 1: Building Before Understanding the Process

Problem:

```text
The automation reproduces a broken manual process.
```

Better:

```text
Map the process first.
Remove unnecessary steps.
Then automate the improved process.
```

---

### Mistake 2: Creating Production Flows Outside Solutions

Risk:

* Harder deployments
* Poor ownership
* Manual connection fixes
* No clean ALM
* Difficult environment promotion

Better:

```text
Build production flows inside solutions.
Use connection references and environment variables.
```

---

### Mistake 3: Hardcoding Values

Bad:

```text
Send email to john.smith@company.com
Use SharePoint site URL directly in every action
Use production API endpoint inside dev flow
```

Better:

```text
Use environment variables.
Use security groups or shared mailboxes.
Use configurable settings.
```

---

### Mistake 4: No Error Handling

Problem:

```text
Flow fails silently or sends confusing failure emails.
```

Better:

```text
Use Try / Catch / Finally scopes.
Log errors.
Notify support with useful details.
```

---

### Mistake 5: Ignoring Licensing and Limits

Problem:

```text
The flow works in testing but fails or throttles in production volume.
```

Better:

```text
Estimate volume.
Check request limits.
Use the correct license.
Monitor usage.
```

---

### Mistake 6: Using Personal Accounts for Production Connections

Problem:

```text
The flow depends on one person’s mailbox, password, MFA, or permissions.
```

Better:

```text
Use approved service accounts or managed ownership patterns.
```

---

### Mistake 7: Creating Infinite Loops

Example:

```text
Flow triggers when SharePoint item is modified.
Flow updates the same item.
Update triggers the flow again.
```

Better:

```text
Use trigger conditions.
Use status fields.
Use change tracking.
Avoid unnecessary writes.
```

---

### Mistake 8: Not Documenting Business Rules

Problem:

```text
Nobody remembers why the flow excludes certain records.
```

Better:

```text
Document rules in the flow notes, README, and solution design document.
```

---

### Mistake 9: Making One Giant Flow

Problem:

```text
The flow is too large to understand, test, or troubleshoot.
```

Better:

```text
Break reusable logic into child flows.
Separate orchestration from validation and logging.
```

---

### Mistake 10: No Operational Monitoring

Problem:

```text
The business only discovers failures after customers or users complain.
```

Better:

```text
Create failure alerts, run logs, dashboards, and support procedures.
```

---
