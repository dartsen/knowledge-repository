---
title: Power Automate Child Flow Contract Template
description: Template for a narrow, versioned, supportable child-flow request and response contract.
domain: Automation
subdomain: Power Platform
content_type: Template
level: Intermediate
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-24
review_cycle: Annual
tags:
  - child-flow
  - contract
  - template
related:
  - ../governance.md
  - solution-design-template.md
---

# Power Automate Child Flow Contract Template

## Contract

- Flow name and version:
- Narrow responsibility:
- Owner and support contact:
- Calling flows:
- Inputs, types, required/optional rules, and validation:
- Outputs and types:
- Required connection references:
- Required environment variables:
- Timeout:
- Retry behavior:
- Idempotency key and duplicate behavior:
- Supported outcome codes:
- Security and data classification:
- Telemetry and correlation:
- Versioning and backward compatibility:

## Standard Response

```json
{
  "success": true,
  "status": "Succeeded",
  "code": "OPERATION_COMPLETED",
  "message": "The operation completed successfully.",
  "correlationId": "00000000-0000-0000-0000-000000000000",
  "businessKey": "EXAMPLE-001",
  "retryable": false,
  "data": {}
}
```

Document every non-success code, its retryability, and the caller's required handling. Do not use an HTTP or flow-run success state as the only business-success signal.
