# API Reusable Templates

## 22. Reusable Templates

---

### 22.1 API Design Document Template

````markdown
# API Design Document

## API Name

`<api-name>`

## Business Purpose

Describe why this API exists.

## Consumer Systems

- Consumer 1
- Consumer 2
- Consumer 3

## Provider System

`<system-name>`

## Endpoint

`<method> <endpoint>`

## Authentication

- [ ] API key
- [ ] OAuth delegated
- [ ] OAuth client credentials
- [ ] Managed identity
- [ ] Certificate
- [ ] Other

## Authorization

Required permissions:

- Permission 1
- Permission 2

## Request Headers

| Header | Required | Description |
|---|---|---|
| Authorization | Yes | Bearer token |
| Content-Type | Yes | application/json |

## Query Parameters

| Parameter | Required | Description |
|---|---|---|
| param1 | Yes | Description |

## Request Body

```json
{
  "example": "value"
}
````

## Response Body

```json
{
  "example": "value"
}
```

## Status Codes

| Code | Meaning      |
| ---- | ------------ |
| 200  | Success      |
| 400  | Bad request  |
| 401  | Unauthorized |
| 403  | Forbidden    |
| 429  | Throttled    |
| 500  | Server error |

## Error Handling

Describe retry and failure behavior.

## Logging

Describe what should be logged.

## Security Notes

Describe sensitive data and access controls.

## Owner

Business owner:
Technical owner:
Support owner:

## Version History

| Version | Date       | Change          |
| ------- | ---------- | --------------- |
| v1.0    | YYYY-MM-DD | Initial version |

````

---

### 22.2 API Contract Template

```markdown
# API Contract

## Operation

`<operation-name>`

## Method and URL

```http
POST https://api.company.com/resource
````

## Headers

```http
Authorization: Bearer {token}
Content-Type: application/json
```

## Request

```json
{
  "id": "123",
  "name": "Example"
}
```

## Successful Response

```json
{
  "success": true,
  "id": "123"
}
```

## Error Response

```json
{
  "error": {
    "code": "InvalidRequest",
    "message": "The required field 'id' is missing."
  }
}
```

## Notes

* Note 1
* Note 2

````

---

### 22.3 API Testing Checklist

```markdown
# API Testing Checklist

## Happy Path

- [ ] Valid request returns expected success status
- [ ] Required fields are returned
- [ ] Response body matches schema
- [ ] Business outcome is correct

## Authentication

- [ ] Missing token fails correctly
- [ ] Expired token fails correctly
- [ ] Wrong tenant token fails correctly
- [ ] Invalid client secret fails correctly

## Authorization

- [ ] Missing permission fails correctly
- [ ] Unauthorized resource access fails correctly
- [ ] Least-privilege permission works

## Data Validation

- [ ] Missing required field fails correctly
- [ ] Invalid data type fails correctly
- [ ] Empty array handled correctly
- [ ] Null values handled correctly
- [ ] Duplicate request handled correctly

## Reliability

- [ ] Timeout handled
- [ ] Retry logic tested
- [ ] Throttling tested
- [ ] Pagination tested

## Logging

- [ ] Success logged
- [ ] Failure logged
- [ ] Correlation ID captured
- [ ] Sensitive data not over-logged
````

---

### 22.4 API Security Review Template

```markdown
# API Security Review

## API Name

`<api-name>`

## Data Classification

- [ ] Public
- [ ] Internal
- [ ] Confidential
- [ ] Regulated / sensitive

## Authentication Method

Describe authentication.

## Authorization Model

Describe permissions and scope.

## Least Privilege Review

- [ ] Permissions are minimal
- [ ] Admin consent reviewed
- [ ] Resource access scoped
- [ ] Access expiration considered

## Secret Management

- [ ] No secrets in code
- [ ] No secrets in Git
- [ ] Secret rotation defined
- [ ] Key Vault or approved secret store used

## Logging Review

- [ ] API calls logged
- [ ] Errors logged
- [ ] Sensitive payloads not over-logged
- [ ] Correlation IDs captured

## Risk Notes

Describe risks.

## Approval

Security reviewer:
Technical owner:
Business owner:
Approval date:
```

---

### 22.5 Microsoft Graph Request Template

```http
### Microsoft Graph Request

METHOD https://graph.microsoft.com/v1.0/{resource-path}
Authorization: Bearer {access_token}
Accept: application/json
Content-Type: application/json

{
  "example": "body if needed"
}
```

---

### 22.6 Power Automate API Flow Template

```text
Trigger
   ↓
Initialize variables
   ↓
Get configuration
   ↓
Get access token
   ↓
Call API
   ↓
Check status code
   ↓
Parse JSON
   ↓
Apply business rules
   ↓
Handle pagination if needed
   ↓
Log success
   ↓
Catch errors
   ↓
Log failure
   ↓
Notify support
```

---

## 23. Final Mental Model

APIs are not just technical endpoints.

They are controlled agreements between systems.

At the beginner level, APIs help you read and send data.

At the intermediate level, APIs help you build reliable integrations.

At the advanced level, APIs help you design secure automation and data flows.

At the enterprise level, APIs become part of governance, architecture, AI enablement, and digital operating models.

The core mental model is:

```text
Need
   ↓
Endpoint
   ↓
Auth
   ↓
Request
   ↓
Response
   ↓
Validation
   ↓
Error Handling
   ↓
Logging
   ↓
Governance
   ↓
Improvement
```

The goal is not just to “make the API call work.”

The goal is to make the integration secure, reliable, observable, reusable, and supportable.
