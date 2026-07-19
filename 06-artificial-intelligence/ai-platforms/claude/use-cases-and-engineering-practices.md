# Claude Use Cases and Engineering Practices

## 7. Common Use Cases

### 7.1 Business Use Cases

| Use Case | Description | Risk Level |
|---|---|---|
| Meeting preparation | Summarize context, prepare questions, create agenda | Low to medium |
| Document summarization | Summarize PDFs, contracts, requirements, transcripts | Medium |
| Email drafting | Draft professional responses | Low to medium |
| Research synthesis | Combine information from multiple sources | Medium |
| Data extraction | Extract structured fields from unstructured documents | Medium to high |
| Policy lookup assistant | Answer questions from approved internal docs | Medium |
| Support ticket triage | Classify, prioritize, and route tickets | Medium |
| Compliance review support | Identify missing documents or control gaps | High |
| Workflow automation design | Generate process flows and exception paths | Medium |
| Report generation | Create first drafts from approved data | Medium |

### 7.2 Technical Use Cases

| Use Case | Description | Claude Surface |
|---|---|---|
| Code review | Review code changes for bugs and maintainability | Claude Code |
| Repo onboarding | Explain folder structure, lineage, dependencies | Claude Code |
| API integration | Draft and test API calls | API / Claude Code |
| dbt model review | Analyze SQL grain, joins, tests, lineage | Claude Code |
| Data documentation | Generate catalog descriptions and lineage docs | API / Claude Code |
| Incident analysis | Summarize logs, changes, and likely causes | Claude Code + MCP |
| Test generation | Create unit/integration tests | Claude Code |
| PR automation | Respond to issue comments and create PRs | Claude Code + GitHub integration |
| Internal copilot | Build a governed assistant for teams | Messages API |
| Agent workflow | Execute multi-step business or engineering tasks | Managed Agents / Agent SDK / Claude Code |

---

## 8. Best Practices

### 8.1 Start with the Business Problem

Bad starting point:

```text
We need to use Claude.
```

Better starting point:

```text
We need to reduce the manual effort required to review renewal policy documents and create consistent downstream automation inputs.
```

### 8.2 Design the Human Role First

Before designing the AI, decide what the human owns.

| Decision | Human or Claude? |
|---|---|
| Final legal advice | Human |
| Production deployment approval | Human |
| Drafting first version | Claude |
| Summarizing source documents | Claude |
| Tool execution for read-only lookup | Claude can request |
| Tool execution for write actions | Human-approved |
| Exception handling | Shared, but human accountable |

### 8.3 Use Clear Prompt Structure

Recommended prompt sections:

```text
<role>
</role>

<task>
</task>

<context>
</context>

<input>
</input>

<constraints>
</constraints>

<output_format>
</output_format>

<quality_bar>
</quality_bar>
```

### 8.4 Prefer Grounded Answers

For enterprise work, Claude should answer from:

| Source Type | Example |
|---|---|
| Provided files | Requirements document, SDD, runbook |
| Approved knowledge base | Internal policy docs |
| Database query | Databricks SQL result |
| API result | Policy lookup API |
| Tool output | Jira issue, GitHub PR diff |
| Human-provided context | Meeting notes or business rules |

### 8.5 Use Structured Outputs for Systems

If a downstream system needs JSON, do not rely only on “please output JSON.” Use schema-based outputs where possible.

Example JSON schema goal:

```json
{
  "policy_number": "string",
  "renewal_status": "string",
  "missing_fields": ["string"],
  "recommended_action": "string",
  "confidence": "high | medium | low"
}
```

### 8.6 Treat Tools Like Production APIs

Every tool should have:

| Requirement | Why |
|---|---|
| Owner | Someone must support it |
| Description | Claude needs to know when to use it |
| Input schema | Prevent malformed calls |
| Authentication | Protect systems |
| Authorization | Limit user/tool access |
| Logging | Auditability |
| Rate limits | Prevent overload |
| Error handling | Recover safely |
| Test cases | Validate behavior |

### 8.7 Keep Sensitive Data Out Unless Approved

Before sending data to Claude, verify:

| Question | Why |
|---|---|
| Is this data confidential? | Protect company information |
| Is it regulated? | HIPAA, financial, legal, privacy obligations |
| Is it necessary? | Minimize exposure |
| Is ZDR or retention coverage required? | Retention varies by feature |
| Does this feature store files or context? | Some features require storage |
| Is there a BAA or enterprise agreement? | Required for PHI workflows |

---

## 9. Common Mistakes

| Mistake | Why It Happens | Better Practice |
|---|---|---|
| Treating Claude like a database | Users expect exact facts without giving data | Connect approved sources or require citations |
| Overloading prompts | Too many mixed instructions | Separate role, task, context, rules, output |
| No evaluation set | Prototype seems good on one example | Build representative test cases |
| No owner for prompts | Prompts drift and break | Version prompts in source control |
| Too many tools | Claude may choose poorly or waste tokens | Use tool registry and tool selection rules |
| Unclear permissions | Tool can do too much | Least privilege |
| No human approval | AI actions become uncontrolled | Require approval for consequential actions |
| Ignoring cost | Long prompts and tools become expensive | Track tokens and cache reusable context |
| No rollback plan | AI-assisted changes can break systems | Use branches, PRs, tests, rollback |
| Weak logging | Cannot troubleshoot failures | Log requests, tool calls, outputs, decisions |
| Using Cowork or computer use on sensitive tasks too early | Agent has broad local/app access | Start in sandbox, classify risk, validate audit needs |

---
