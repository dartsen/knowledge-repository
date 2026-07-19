# API Use Cases and Microsoft Graph

## 7. Common Use Cases

---

### 7.1 Reading Email

Examples:

* Read Outlook mailbox messages
* Find emails with attachments
* Process shared mailbox requests
* Monitor incoming customer submissions
* Trigger downstream automation

Microsoft Graph supports accessing data in users’ primary mailboxes and shared mailboxes, including mail, calendar, and contacts data stored in Exchange Online or supported hybrid deployments. It does not support in-place archive mailboxes.

---

### 7.2 Creating Files

Examples:

* Create a SharePoint document
* Upload a generated PDF
* Save an email attachment
* Store automation output
* Archive reports

Microsoft Graph represents files and folders in OneDrive and SharePoint document libraries as `driveItem` resources, and drive items can be addressed by ID or by path.

---

### 7.3 Editing Excel Workbooks

Examples:

* Update status trackers
* Insert rows into a workbook
* Read workbook tables
* Update a named range
* Write automation results to a worksheet

The Microsoft Graph Excel APIs can use workbook sessions. Microsoft recommends using the `workbook-session-id` header to improve performance, although the header is not required for an Excel API call to work.

---

### 7.4 Calling Databricks

Examples:

* Execute SQL statement
* Fetch curated automation data
* Retrieve policy attributes
* Pull monitoring metrics
* Query a Delta table through a SQL warehouse

---

### 7.5 Generating Documents

Examples:

* Send data to a PDF generation API
* Create renewal notices
* Create customer letters
* Generate invoices
* Generate exception reports

---

### 7.6 AI Tool Calling

Examples:

* AI agent calls a policy lookup API
* AI assistant retrieves knowledge base records
* Copilot calls an enterprise API through a connector
* Claude or ChatGPT calls an API using a JSON schema

APIs are the bridge between AI reasoning and real enterprise systems.

---

## 8. Microsoft Graph API Examples

---

# 8.1 Authentication Pattern for Microsoft Graph

Most Microsoft Graph calls require a Bearer token.

General header:

```http
Authorization: Bearer {access_token}
```

For background automations, the common enterprise pattern is **client credentials flow**, where an app authenticates as itself instead of acting on behalf of a signed-in user. In the Microsoft identity platform client credentials flow, permissions are granted directly to the application by an administrator, and no user is involved at runtime. Microsoft also recommends using supported Microsoft Authentication Libraries, or MSAL, when possible.

### Token Request Example: Client Credentials

```http
POST https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded
```

Body:

```text
client_id={client-id}
&scope=https://graph.microsoft.com/.default
&client_secret={client-secret}
&grant_type=client_credentials
```

Example response:

```json
{
  "token_type": "Bearer",
  "expires_in": 3599,
  "access_token": "eyJ0eXAiOiJKV1QiLCJ..."
}
```

### Important Security Note

Do not hardcode secrets in Power Automate, source code, Git repos, Excel files, or configuration files. Prefer:

* Azure Key Vault
* Managed identity where supported
* Certificate-based authentication
* Secured custom connector
* Environment variables with appropriate protection
* Enterprise secret management tools

---

# 8.2 Graph API Example: Read Outlook Emails

## Use Case

Read recent Outlook messages from a user mailbox or shared mailbox.

---

## Endpoint: Signed-In User Mailbox

```http
GET https://graph.microsoft.com/v1.0/me/messages?$top=10&$select=id,subject,from,receivedDateTime,hasAttachments
Authorization: Bearer {access_token}
Accept: application/json
```

---

## Endpoint: Specific User Mailbox

```http
GET https://graph.microsoft.com/v1.0/users/{user-id-or-upn}/messages?$top=10&$select=id,subject,from,receivedDateTime,hasAttachments
Authorization: Bearer {access_token}
Accept: application/json
```

Example:

```http
GET https://graph.microsoft.com/v1.0/users/automation.sharedmailbox@company.com/messages?$top=10&$select=id,subject,from,receivedDateTime,hasAttachments
```

---

## Endpoint: Inbox Folder

```http
GET https://graph.microsoft.com/v1.0/users/{user-id-or-upn}/mailFolders/Inbox/messages?$top=25&$select=id,subject,from,receivedDateTime,bodyPreview,hasAttachments
Authorization: Bearer {access_token}
Accept: application/json
```

---

## Filter by Subject

```http
GET https://graph.microsoft.com/v1.0/users/{user-id-or-upn}/messages?$filter=contains(subject,'Renewal')&$select=id,subject,from,receivedDateTime
Authorization: Bearer {access_token}
Accept: application/json
```

---

## Sort by Received Date

```http
GET https://graph.microsoft.com/v1.0/users/{user-id-or-upn}/messages?$top=25&$orderby=receivedDateTime desc&$select=id,subject,from,receivedDateTime
Authorization: Bearer {access_token}
Accept: application/json
```

---

## Example Response

```json
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users('automation.sharedmailbox%40company.com')/messages(id,subject,from,receivedDateTime,hasAttachments)",
  "value": [
    {
      "id": "AAMkAGVm...",
      "subject": "Renewal Notice Request - POL123456",
      "receivedDateTime": "2026-07-04T13:45:00Z",
      "hasAttachments": true,
      "from": {
        "emailAddress": {
          "name": "Broker Team",
          "address": "broker@example.com"
        }
      }
    }
  ]
}
```

---

## Power Automate Usage Pattern

```text
HTTP - Get Access Token
   ↓
HTTP - Get Outlook Messages from Graph
   ↓
Parse JSON
   ↓
Apply to each message
   ↓
Filter by subject/body/sender
   ↓
Create business request
   ↓
Log result
```

---

## Permissions to Discuss With Admins

Possible permissions depend on delegated versus application access and the exact mailbox scenario.

Typical examples:

| Scenario                                             | Possible Permission                           |
| ---------------------------------------------------- | --------------------------------------------- |
| Read signed-in user mail                             | `Mail.Read` delegated                         |
| Read mail across mailboxes using app-only automation | `Mail.Read` application or higher as approved |
| Read and modify messages                             | `Mail.ReadWrite`                              |
| Send email                                           | `Mail.Send`                                   |

Use least privilege. Microsoft Graph’s permission guidance specifically warns that granting more privileges than necessary increases exposure to unauthorized or unintended access.

---

# 8.3 Graph API Example: Create a File in SharePoint

## Use Case

Create or upload a file into a SharePoint document library.

Microsoft Graph supports uploading or replacing the contents of a drive item in a single API call for files up to 250 MB; larger files should use an upload session.

---

## Step 1: Identify the Site

Common pattern:

```http
GET https://graph.microsoft.com/v1.0/sites/{hostname}:/sites/{site-path}
Authorization: Bearer {access_token}
```

Example:

```http
GET https://graph.microsoft.com/v1.0/sites/contoso.sharepoint.com:/sites/Automation
Authorization: Bearer {access_token}
```

Response includes:

```json
{
  "id": "contoso.sharepoint.com,abc123,def456",
  "name": "Automation",
  "webUrl": "https://contoso.sharepoint.com/sites/Automation"
}
```

---

## Step 2: Upload a Small File by Path

```http
PUT https://graph.microsoft.com/v1.0/sites/{site-id}/drive/root:/Shared Documents/Renewal Notices/RenewalNotice_POL123456.txt:/content
Authorization: Bearer {access_token}
Content-Type: text/plain

Renewal notice content goes here.
```

---

## Step 3: Upload a PDF File by Path

```http
PUT https://graph.microsoft.com/v1.0/sites/{site-id}/drive/root:/Shared Documents/Renewal Notices/RenewalNotice_POL123456.pdf:/content
Authorization: Bearer {access_token}
Content-Type: application/pdf

{binary_pdf_content}
```

---

## Step 4: Create a Folder

```http
POST https://graph.microsoft.com/v1.0/sites/{site-id}/drive/root:/Shared Documents:/children
Authorization: Bearer {access_token}
Content-Type: application/json
```

Body:

```json
{
  "name": "Renewal Notices",
  "folder": {},
  "@microsoft.graph.conflictBehavior": "rename"
}
```

---

## Example Response

```json
{
  "id": "01ABCDEF...",
  "name": "RenewalNotice_POL123456.pdf",
  "webUrl": "https://contoso.sharepoint.com/sites/Automation/Shared%20Documents/Renewal%20Notices/RenewalNotice_POL123456.pdf",
  "size": 24567,
  "file": {
    "mimeType": "application/pdf"
  }
}
```

---

## Power Automate Usage Pattern

```text
HTTP - Get Access Token
   ↓
HTTP - Upload File to SharePoint via Graph
   ↓
Parse Graph Response
   ↓
Store webUrl in run log
   ↓
Send email with link or attachment
```

---

## Permissions to Discuss With Admins

Possible permissions:

| Scenario                            | Possible Permission                                                     |
| ----------------------------------- | ----------------------------------------------------------------------- |
| Read files current user can access  | `Files.Read` delegated                                                  |
| Write files current user can access | `Files.ReadWrite` delegated                                             |
| App-only write across SharePoint    | `Files.ReadWrite.All` or `Sites.ReadWrite.All`, depending on governance |
| Restrict app to selected sites      | `Sites.Selected` plus explicit site grant pattern                       |

The exact permission model should be confirmed with the Microsoft Graph permissions reference and your tenant governance standards.

---

# 8.4 Graph API Example: Edit and Scope Microsoft Excel Workbooks

## Use Case

Use Microsoft Graph to update an Excel workbook stored in SharePoint or OneDrive.

Examples:

* Update a tracking worksheet
* Write automation run status
* Update named ranges
* Insert data into a table
* Read scoped workbook data
* Modify only a specific worksheet/range

---

## Excel Scope Mental Model

```text
Tenant
   ↓
Site
   ↓
Drive / Document Library
   ↓
DriveItem / Workbook File
   ↓
Workbook Session
   ↓
Worksheet
   ↓
Range / Table / Named Item
   ↓
Cell Values / Formats / Formulas
```

The goal is to scope your API call as narrowly as possible:

```text
Do not update the whole workbook.
Update the specific workbook file, worksheet, range, table, or named item.
```

---

## Step 1: Create a Workbook Session

```http
POST https://graph.microsoft.com/v1.0/sites/{site-id}/drive/items/{item-id}/workbook/createSession
Authorization: Bearer {access_token}
Content-Type: application/json
```

Body:

```json
{
  "persistChanges": true
}
```

Response:

```json
{
  "id": "{session-id}",
  "persistChanges": true
}
```

Use the session ID in later requests:

```http
workbook-session-id: {session-id}
```

Microsoft documents that the session ID returned from `createSession` should be passed on subsequent Excel API requests using the `workbook-session-id` header.

---

## Step 2: List Worksheets

```http
GET https://graph.microsoft.com/v1.0/sites/{site-id}/drive/items/{item-id}/workbook/worksheets
Authorization: Bearer {access_token}
workbook-session-id: {session-id}
Accept: application/json
```

Example response:

```json
{
  "value": [
    {
      "id": "{worksheet-id}",
      "name": "RunLog",
      "position": 0,
      "visibility": "Visible"
    },
    {
      "id": "{worksheet-id-2}",
      "name": "Config",
      "position": 1,
      "visibility": "Visible"
    }
  ]
}
```

---

## Step 3: Read a Specific Range

```http
GET https://graph.microsoft.com/v1.0/sites/{site-id}/drive/items/{item-id}/workbook/worksheets/RunLog/range(address='A1:E10')
Authorization: Bearer {access_token}
workbook-session-id: {session-id}
Accept: application/json
```

---

## Step 4: Update a Specific Range

```http
PATCH https://graph.microsoft.com/v1.0/sites/{site-id}/drive/items/{item-id}/workbook/worksheets/RunLog/range(address='A2:E2')
Authorization: Bearer {access_token}
Content-Type: application/json
workbook-session-id: {session-id}
```

Body:

```json
{
  "values": [
    [
      "RUN-000123",
      "POL123456",
      "Success",
      "2026-07-04T13:45:00Z",
      "Renewal notice emailed"
    ]
  ]
}
```

Microsoft’s range update API supports updating values, number formats, and formulas; `null` can be used to ignore a cell for a particular input.

---

## Step 5: Update a Named Range

Named ranges are useful for stable automation because they avoid relying on hardcoded cell coordinates.

Example:

```http
PATCH https://graph.microsoft.com/v1.0/sites/{site-id}/drive/items/{item-id}/workbook/names/LastRunStatus/range
Authorization: Bearer {access_token}
Content-Type: application/json
workbook-session-id: {session-id}
```

Body:

```json
{
  "values": [
    [
      "Success"
    ]
  ]
}
```

---

## Step 6: Update a Table Row

If the workbook has a table named `AutomationRunLog`, use a table-based pattern rather than raw cell coordinates.

```http
POST https://graph.microsoft.com/v1.0/sites/{site-id}/drive/items/{item-id}/workbook/tables/AutomationRunLog/rows/add
Authorization: Bearer {access_token}
Content-Type: application/json
workbook-session-id: {session-id}
```

Body:

```json
{
  "values": [
    [
      "RUN-000123",
      "POL123456",
      "Success",
      "2026-07-04T13:45:00Z",
      "Renewal notice emailed"
    ]
  ]
}
```

---

## Recommended Excel API Scoping Rules

| Need                              | Preferred Scope                                       |
| --------------------------------- | ----------------------------------------------------- |
| Update one value                  | Named range or exact cell                             |
| Update one row                    | Table row                                             |
| Update tracker                    | Excel table                                           |
| Update formulas                   | Specific range                                        |
| Read config values                | Named ranges or config table                          |
| Large structured dataset          | Prefer Dataverse, SQL, or Databricks instead of Excel |
| Mission-critical system of record | Avoid Excel as the primary system of record           |

---

## Power Automate Usage Pattern

```text
HTTP - Get Access Token
   ↓
HTTP - Create Workbook Session
   ↓
HTTP - Read Worksheet / Range / Table
   ↓
HTTP - Update Range or Add Table Row
   ↓
HTTP - Close Session if applicable
   ↓
Log result
```

---

## Important Excel API Guidance

Use Excel APIs for controlled workbook automation, not as a replacement for a real database.

Good uses:

```text
Update small trackers.
Read controlled config sheets.
Write audit rows.
Modify a known range.
```

Risky uses:

```text
Large transactional workloads.
Concurrent writes from many automations.
Unbounded ranges.
Critical system-of-record updates.
Complex workbooks with volatile formulas.
```

---
