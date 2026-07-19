# Reusable Flow Design Template

```markdown
# Flow Design: <Flow Name>

## Purpose

<What business outcome does this flow provide?>

## Trigger

- Trigger type:
- Source:
- Trigger conditions:
- Expected frequency:
- Expected volume:
- Concurrency setting:

## Grain

<What does one transaction represent?>

## Business Key

<Policy ID, request ID, file ID, or composite key>

## Idempotency Key

<Explain how duplicate work is prevented.>

## Inputs

| Input | Type | Required | Sensitive | Description |
|---|---|---:|---:|---|
| <name> | <type> | Yes/No | Yes/No | <description> |

## Outputs

| Output | Type | Description |
|---|---|---|
| status | String | Final outcome |
| code | String | Stable result code |
| correlationId | String | Trace identifier |

## Configuration

| Variable | Purpose | Environment-Specific |
|---|---|---:|
| <name> | <purpose> | Yes/No |

## Connections

| Connection Reference | Connector | Owner |
|---|---|---|
| <name> | <connector> | <team> |

## TRACE Design

### Trigger Selectively

<Describe trigger filters.>

### Resolve Context

<Describe configuration and correlation ID.>

### Assert Validity

<Describe validation and duplicate control.>

### Carry Out Logic

<Describe Try/Catch/Finally and child flows.>

### Emit Outcome

<Describe telemetry, notifications, and response.>

## Error Model

| Code | Category | Retryable | Owner |
|---|---|---:|---|
| <code> | <category> | Yes/No | <team> |

## Monitoring

<Describe telemetry, dashboard, and alerting.>

## Security

<Describe identities, sensitive data, and secure settings.>

## Testing

<List required test cases.>

## Recovery

<Describe replay and compensation.>

## Deployment

<Describe solution, variables, references, and pipeline.>
```

---

# Reusable Child Flow Contract Template

```markdown
# Child Flow Contract: <Name>

## Responsibility

<One clear responsibility.>

## Owner

<Team or role>

## Inputs

| Name | Type | Required | Sensitive | Validation |
|---|---|---:|---:|---|
| correlationId | String | Yes | No | Valid GUID |
| businessKey | String | Yes | No | Not empty |
| <input> | <type> | Yes/No | Yes/No | <rule> |

## Outputs

| Name | Type | Description |
|---|---|---|
| success | Boolean | Technical/business completion |
| status | String | Standard outcome |
| code | String | Stable outcome code |
| message | String | Safe summary |
| retryable | Boolean | Whether parent may retry |
| data | Object | Result payload |

## Supported Outcomes

| Code | Status | Retryable | Meaning |
|---|---|---:|---|
| <code> | <status> | Yes/No | <meaning> |

## Dependencies

- Connector:
- Connection reference:
- Environment variables:
- API:
- Table or system:

## Idempotency

<Explain whether and how repeated calls are safe.>

## Retry Policy

<Explain retryable failures and maximum behavior.>

## Timeout

<Expected completion time and timeout handling.>

## Security

<Explain sensitive inputs, logging, and access.>

## Versioning

<Explain backward compatibility and contract changes.>
```

---

# Repository Placement

```text
automation/
└── power-automate/
    ├── README.md
    ├── architecture/
    │   ├── trace-pattern.md
    │   ├── parent-worker-pattern.md
    │   ├── queue-processing-pattern.md
    │   └── api-wrapper-pattern.md
    ├── patterns/
    │   ├── error-handling.md
    │   ├── idempotency.md
    │   ├── retry-and-backoff.md
    │   ├── pagination.md
    │   ├── concurrency.md
    │   ├── approvals.md
    │   ├── telemetry.md
    │   ├── security.md
    │   └── feature-flags.md
    ├── standards/
    │   ├── naming-standard.md
    │   ├── solution-alm-standard.md
    │   ├── connection-reference-standard.md
    │   ├── environment-variable-standard.md
    │   └── production-readiness-standard.md
    ├── templates/
    │   ├── flow-design-template.md
    │   ├── child-flow-contract-template.md
    │   ├── test-case-template.md
    │   ├── runbook-template.md
    │   └── production-checklist.md
    ├── examples/
    │   ├── parent-flow/
    │   ├── worker-flow/
    │   ├── logging-child-flow/
    │   └── api-wrapper-child-flow/
    └── quick-reference/
        ├── expressions.md
        ├── error-codes.md
        └── repeatable-solution-patterns.md
```

Recommended filename:

```text
automation/power-automate/quick-reference/power-automate-repeatable-solution-patterns.md
```

---

# Final Mental Model

Think of Power Automate as an orchestration platform operating a controlled transaction:

```text
Event
    ↓
Selective Trigger
    ↓
Configuration and Correlation
    ↓
Validation
    ↓
Idempotency
    ↓
Structured Business Logic
    ↓
Retry or Exception Handling
    ↓
Telemetry and Notification
    ↓
Explicit Final Outcome
```

Use TRACE:

```text
T — Trigger Selectively
R — Resolve Context
A — Assert Validity
C — Carry Out Logic
E — Emit Outcome
```

The final rule is:

> A reusable flow should have a clear contract, a narrow responsibility, predictable outcomes, safe retry behavior, visible telemetry, and no hidden environment dependencies.
