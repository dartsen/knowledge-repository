# API Engineering and Troubleshooting

## 9. Best Practices

---

### 9.1 Start With the Business Process

Before choosing an API, understand:

* What process is being automated?
* What data is needed?
* Which system owns the data?
* Which system should be updated?
* Who is allowed to perform the action?
* What happens when the API fails?
* What needs to be logged?

---

### 9.2 Use the Right Integration Pattern

| Situation                           | Recommended Pattern                     |
| ----------------------------------- | --------------------------------------- |
| Simple read/write to SaaS           | REST API                                |
| Microsoft 365 data                  | Microsoft Graph                         |
| Internal enterprise service         | Internal API                            |
| Reusable Power Platform integration | Custom connector                        |
| Event-driven notification           | Webhook                                 |
| Long-running operation              | Async API or queue                      |
| High-volume data extraction         | Data pipeline, not repeated API polling |
| Legacy UI only                      | RPA as fallback                         |

---

### 9.3 Prefer APIs Over UI Automation

Use APIs when available.

APIs are usually:

* More stable
* More secure
* Easier to monitor
* Easier to test
* Easier to scale
* Less fragile than screen automation

Use UI automation only when:

* No API exists
* No database access exists
* No export mechanism exists
* Business value justifies the fragility

---

### 9.4 Use Least Privilege

Ask for the minimum permission needed.

Bad:

```text
Request full tenant-wide access when only one SharePoint site is needed.
```

Better:

```text
Request access only to the mailbox, site, file, table, or operation required.
```

---

### 9.5 Use Pagination Correctly

Do not assume the first API response contains all data.

Look for:

```json
"@odata.nextLink"
```

Then continue calling the next link until all pages are retrieved.

---

### 9.6 Handle Throttling

For Microsoft Graph:

```text
If status code = 429
Read Retry-After header
Wait
Retry
Repeat if needed
```

Do not retry immediately in a tight loop.

---

### 9.7 Validate Inputs and Outputs

Validate:

* Required fields
* Data types
* Null values
* Expected status codes
* Response body shape
* Business rules
* Duplicate records
* Empty arrays

---

### 9.8 Log Every Important Transaction

For production automations, log:

* Request ID
* Correlation ID
* API endpoint
* Method
* Status code
* Start time
* End time
* Business key
* Error message
* Retry count
* Environment
* Caller identity

---

### 9.9 Never Store Secrets in Code

Avoid storing secrets in:

* Git repositories
* Power Automate plain text actions
* Excel files
* SharePoint lists
* unsecured environment variables
* scripts on local machines

Use:

* Azure Key Vault
* managed identity
* certificates
* secure pipeline variables
* custom connector security configuration

---

### 9.10 Document API Contracts

A good API contract includes:

* Endpoint
* Method
* Authentication
* Required permissions
* Request headers
* Query parameters
* Request body
* Response body
* Status codes
* Error examples
* Rate limits
* Version
* Owner
* Support contact

---

## 10. Common Mistakes

---

### Mistake 1: Confusing Authentication and Authorization

Authentication:

```text
Who are you?
```

Authorization:

```text
What are you allowed to do?
```

A valid token does not guarantee access to the requested resource.

---

### Mistake 2: Using Too-Broad Permissions

Bad:

```text
Give app full read/write access to all SharePoint sites.
```

Better:

```text
Scope the app to the minimum required site, library, folder, or operation where possible.
```

---

### Mistake 3: Ignoring Pagination

Problem:

```text
Flow processes only first 100 records and misses the rest.
```

Better:

```text
Follow nextLink until complete.
```

---

### Mistake 4: Ignoring Rate Limits

Problem:

```text
Automation works in testing but fails under production volume.
```

Better:

```text
Handle 429, Retry-After, batching, and backoff.
```

---

### Mistake 5: Hardcoding URLs and IDs

Bad:

```text
Hardcode production SharePoint site ID directly in a flow.
```

Better:

```text
Use environment variables or configuration tables.
```

---

### Mistake 6: No Error Handling

Problem:

```text
API call fails and no one knows why.
```

Better:

```text
Capture status code, response body, correlation ID, and failed endpoint.
```

---

### Mistake 7: Treating Excel Like a Database

Problem:

```text
Multiple automations write to the same workbook at the same time.
```

Better:

```text
Use Excel for lightweight controlled workbooks.
Use Dataverse, SQL, or Databricks for transactional workloads.
```

---

### Mistake 8: Not Versioning API Changes

Problem:

```text
API response changes and downstream automations break.
```

Better:

```text
Version API contracts and test consumers before release.
```

---

### Mistake 9: Not Testing Negative Scenarios

Test:

* Missing token
* Expired token
* Wrong permission
* Bad request body
* Empty response
* Duplicate request
* API timeout
* Throttling
* Partial failure

---

### Mistake 10: Overusing APIs for Bulk Data Movement

APIs are excellent for operational transactions, but poor for huge repeated extracts when a data pipeline is more appropriate.

Use:

```text
API for operational action.
Pipeline for large-scale data movement.
```

---

## 11. Troubleshooting Guide

---

### 11.1 API Troubleshooting Checklist

```markdown
# API Troubleshooting Checklist

## Request

- [ ] Is the endpoint correct?
- [ ] Is the HTTP method correct?
- [ ] Are headers correct?
- [ ] Is the request body valid JSON?
- [ ] Are query parameters encoded correctly?
- [ ] Is the resource ID correct?

## Authentication

- [ ] Is the token present?
- [ ] Is the token expired?
- [ ] Is the token for the correct tenant?
- [ ] Is the token audience correct?
- [ ] Is the client secret or certificate valid?

## Authorization

- [ ] Does the app have required API permissions?
- [ ] Was admin consent granted?
- [ ] Does the user or app have resource access?
- [ ] Is the mailbox/site/file shared correctly?
- [ ] Is RBAC also required?

## Response

- [ ] What is the HTTP status code?
- [ ] What is the error message?
- [ ] Is there a correlation ID?
- [ ] Is there a Retry-After header?
- [ ] Is response pagination being handled?

## Data

- [ ] Are required fields present?
- [ ] Are values in the expected format?
- [ ] Are arrays empty?
- [ ] Are dates/time zones handled correctly?
- [ ] Are duplicate records possible?
```

---

### 11.2 Common Status Code Troubleshooting

| Code  | Meaning      | Likely Cause                                | Fix                                                 |
| ----- | ------------ | ------------------------------------------- | --------------------------------------------------- |
| `400` | Bad request  | Invalid JSON, missing parameter, bad filter | Validate request body and query syntax              |
| `401` | Unauthorized | Missing/expired token                       | Refresh token or fix authentication                 |
| `403` | Forbidden    | Permission or RBAC issue                    | Check API permissions and resource access           |
| `404` | Not found    | Wrong ID/path/resource                      | Validate site ID, drive ID, item ID, worksheet name |
| `409` | Conflict     | Duplicate or locked resource                | Handle conflict behavior                            |
| `429` | Throttled    | Too many requests                           | Honor `Retry-After`                                 |
| `500` | Server error | API/system issue                            | Retry safely and escalate                           |
| `503` | Unavailable  | Service overloaded/down                     | Retry with backoff                                  |

---

### 11.3 Microsoft Graph Troubleshooting

Common issues:

| Issue                         | Possible Cause                                       |
| ----------------------------- | ---------------------------------------------------- |
| `InvalidAuthenticationToken`  | Token expired, wrong audience, malformed token       |
| `Authorization_RequestDenied` | Missing permissions or admin consent                 |
| `AccessDenied`                | App/user lacks resource access                       |
| `ResourceNotFound`            | Wrong site, drive, item, mailbox, worksheet, or path |
| `TooManyRequests`             | Throttling                                           |
| Excel session `404`           | Workbook session expired                             |

Microsoft’s Excel API documentation notes that if a session ID expires, the API can return `404`; in that case, create a new session and continue.

---
