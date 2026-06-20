---
title: "dbt Reference Guide"
domain: "Data Engineering"
level: "Beginner to Pro"
status: "Phase 3 Draft"
last_updated: "2026-06-20"
tags:
  - data-engineering
  - dbt
  - phase-3
related:
  - ../
---

# dbt Reference Guide

## 00. Executive Summary

dbt is a transformation framework that lets teams build modular SQL models, test data assumptions, document lineage, and manage analytics engineering workflows in version control.

This guide is designed to help you progress from beginner awareness to professional data engineering confidence. The goal is not only to understand dbt, but to apply it in real enterprise environments where data must be reliable, governed, documented, monitored, and useful for analytics, automation, AI, and business decision-making.

## 01. Plain-English Explanation

dbt is a transformation framework that lets teams build modular SQL models, test data assumptions, document lineage, and manage analytics engineering workflows in version control.

**Analogy:** Think of dbt as a disciplined assembly line for SQL transformations. Instead of scattered one-off queries, each transformation becomes a documented, testable, reusable model.

At a beginner level, focus on what dbt is and what problem it solves.

At a professional level, focus on how dbt connects to architecture, data quality, governance, testing, operational reliability, and business value.

## 02. Business Context

Data engineering exists to make data usable, trusted, timely, secure, and scalable. Without it, reports become unreliable, automations fail, AI outputs become questionable, and teams spend too much time reconciling conflicting data.

### Business Outcomes Supported

- Trusted Transformations
- Lineage Visibility
- Testing Discipline
- Faster Analytics Development
- Version-Controlled Logic
- Reusable Data Models

### Business Questions This Subject Helps Answer

1. What data do we need?
2. Where does the data come from?
3. Who owns the data?
4. What transformations happen to it?
5. Is the data reliable enough for the use case?
6. Who consumes the data?
7. What happens if the data is late, missing, duplicated, or wrong?
8. How is access controlled?
9. How is lineage documented?
10. How will quality and performance be monitored?

## 03. Core Concepts

| Concept | Simple Explanation | Why It Matters | Example |
|---|---|---|---|
| Model | A SQL select statement that dbt builds into a table, view, or incremental model. | Models are the core transformation unit. | intermediate_policy_base.sql. |
| Source | A declared upstream table or dataset. | Clarifies raw dependencies. | raw_magic_policy declared as a source. |
| Ref | A dbt function for referencing another model. | Builds lineage and dependency order. | select * from {{ ref('intermediate_policy_base') }}. |
| Test | A rule that validates assumptions about data. | Protects downstream trust. | not_null, unique, accepted_values, relationships. |
| Documentation | Descriptions and metadata generated for models and columns. | Improves discoverability and onboarding. | dbt docs site showing lineage and column definitions. |
| Materialization | How dbt persists a model. | Controls performance and storage behavior. | view, table, incremental, ephemeral. |
| Seed | Static reference data loaded from CSV. | Useful for controlled lookup mappings. | industry-to-line-of-business mapping seed. |

## 04. Architecture View

dbt fits into the larger enterprise data architecture as part of the path from source systems to trusted consumption.

```text
Business Need
  → Source Systems
  → Ingestion
  → Storage
  → Transformation
  → Validation
  → Governance
  → Consumption
  → Monitoring
  → Continuous Improvement
```

### Common Systems Involved

- Source business systems
- APIs and files
- Data lake or lakehouse storage
- Databricks or other data platform
- dbt or transformation framework
- Data catalog and governance tools
- BI tools such as Power BI
- Automation platforms
- AI or ML platforms
- Monitoring and alerting tools
- Git and CI/CD platforms

### Inputs

- Source data
- Business rules
- Data contracts
- Transformation logic
- Quality rules
- Access requirements
- Consumption requirements
- Refresh schedule
- Operational requirements

### Outputs

- Trusted data models
- Tables and views
- Documentation
- Tests
- Lineage
- Quality results
- Monitoring alerts
- Runbooks
- Consumption-ready datasets

## 05. Data / Process Flow

A typical dbt flow can be represented as:

```text
Sources → Staging Models → Intermediate Models → Marts / Curated Models → Tests → Docs → Deployment
```

A professional enterprise flow usually adds governance and monitoring:

```text
Intake
  → Source assessment
  → Data classification
  → Ingestion design
  → Transformation design
  → Data quality checks
  → Access control
  → Deployment
  → Monitoring
  → Incident handling
  → Continuous improvement
```

## 06. Common Use Cases

| Use Case | Description | Business Value | Technical Components | Risks or Limitations |
|---|---|---|---|---|
| Reporting enablement | Prepare data for dashboards and analytics. | Improves decision-making. | Tables, semantic models, BI connections. | Conflicting definitions can reduce trust. |
| Automation lookup | Provide structured data to automations. | Reduces manual effort and errors. | Curated tables, SQL endpoints, service principals. | Bad data can trigger wrong actions. |
| Data quality monitoring | Validate data before use. | Reduces rework and risk. | Tests, dashboards, alerts. | Rules must match business tolerance. |
| Lineage and impact analysis | Understand dependencies. | Prevents broken downstream assets. | Catalog, dbt docs, Unity Catalog lineage. | Incomplete metadata can hide risk. |
| Migration support | Move from legacy sources to governed platforms. | Simplifies and modernizes data estate. | Pipelines, transformations, reconciliation. | Migration can expose source data issues. |
| AI readiness | Prepare governed, documented data for AI use cases. | Improves accuracy and responsible use. | Data products, access policies, lineage, quality checks. | Weak governance increases AI risk. |

## 07. Best Practices

### Design

- Start with the business question and consumption pattern.
- Define the grain of each model clearly.
- Separate raw capture, reusable transformations, and use-case-specific outputs.
- Document source systems and ownership.
- Design quality checks based on use case risk.
- Avoid duplicating business logic across many places.

### Development

- Use version control.
- Use modular models.
- Keep naming conventions consistent.
- Use comments for business logic, not obvious syntax.
- Build small and validate frequently.
- Use reusable macros, templates, and tests when appropriate.

### Testing

- Test keys, nulls, relationships, accepted values, freshness, and row counts.
- Validate business rules with data owners.
- Test incremental logic and late-arriving data.
- Add reconciliation checks when migrating sources.
- Test failure paths, not just happy paths.

### Documentation

- Document models, columns, owners, sources, and refresh expectations.
- Include lineage.
- Add examples for common queries.
- Maintain quick-reference pages.
- Keep documentation close to code when possible.

### Security

- Apply least privilege.
- Use groups or service principals rather than personal accounts.
- Classify sensitive data.
- Avoid storing secrets in code.
- Review downstream consumption before granting access.

### Governance

- Define authoritative sources.
- Assign data owners and stewards.
- Track lineage and data quality.
- Use approval gates for production changes.
- Capture architecture and modeling decisions.

### Maintenance

- Monitor pipelines.
- Review failed tests.
- Track technical debt.
- Remove unused models.
- Update documentation after schema or logic changes.
- Review cost and performance.

### Scalability

- Use appropriate table design and partitioning where relevant.
- Avoid unnecessary joins in high-volume paths.
- Materialize models based on consumption need.
- Separate reusable conformed logic from curated use-case logic.
- Design for additional consumers without breaking existing ones.

## 08. Common Mistakes and Anti-Patterns

| Mistake | Why It Happens | Why It Is Risky | How to Avoid It |
|---|---|---|---|
| Building before defining the business question | Technical work starts too quickly. | Data may not answer the right need. | Start with use case and consumer. |
| Unclear grain | Teams do not define one row per what. | Causes duplicates and wrong aggregations. | Document grain in every model. |
| No data quality tests | Tests are treated as optional. | Bad data reaches reports or automations. | Add minimum tests for keys, nulls, relationships, and accepted values. |
| Duplicated transformation logic | Teams copy SQL from one place to another. | Logic drifts and becomes hard to maintain. | Centralize reusable logic. |
| Poor naming | No naming standards. | Models become hard to find and understand. | Use consistent conventions by layer and purpose. |
| Direct consumption from unstable sources | Teams want speed. | Downstream tools break when sources change. | Use governed intermediate or curated layers. |
| No lineage | Documentation is not maintained. | Change impact is hard to assess. | Use tools and conventions that generate lineage. |
| Access granted too broadly | Convenience wins over governance. | Sensitive data risk increases. | Use least privilege and access reviews. |
| No monitoring | Pipelines are assumed to work. | Failures are discovered by business users. | Add alerts, dashboards, and runbooks. |
| Treating all data quality issues the same | No risk-based thinking. | Teams either overblock or undercontrol. | Define severity and use-case tolerance. |

## 09. Exception Handling and Troubleshooting

| Common Issue | Likely Cause | How to Investigate | How to Resolve | Prevention |
|---|---|---|---|---|
| Pipeline failed | Source unavailable, code error, cluster issue, permission issue | Check job logs, recent commits, source availability, access changes | Fix root cause and rerun safely | Add retries, alerts, and dependency checks |
| Data is late | Upstream delay or schedule mismatch | Compare source refresh time and pipeline schedule | Adjust schedule or dependency | Define SLAs and freshness checks |
| Row counts changed unexpectedly | Source change, filter change, duplication, missed records | Compare historical counts and recent logic changes | Correct logic or confirm business change | Add anomaly checks |
| Duplicate records | Grain or key issue | Check primary keys and joins | Deduplicate or fix join logic | Define grain and uniqueness tests |
| Null required fields | Source data issue or transformation bug | Trace field lineage | Add default, remediation, or reject rule | Add not-null tests and source feedback loop |
| BI report mismatch | Metric definition or model difference | Compare query logic and semantic model | Align definition and model | Maintain glossary and certified datasets |
| Automation failure | Bad lookup data or unavailable endpoint | Check curated table, access, and automation logs | Fix data and retry business process | Add validation and exception handling |

### Troubleshooting Questions

1. What changed recently?
2. Which layer is affected?
3. Is the issue in source, ingestion, transformation, validation, access, or consumption?
4. Is the issue systematic or isolated?
5. Which downstream consumers are impacted?
6. Is this a data defect, code defect, access issue, or business rule issue?
7. What temporary workaround exists?
8. What permanent fix is needed?
9. What test or monitor would have caught this earlier?

## 10. Governance and Controls

### Ownership

- Business owner
- Data owner
- Technical owner
- Support owner
- Security or access owner
- Downstream consumer owner

### Access Control

- Use least privilege.
- Grant through groups where possible.
- Use service principals for non-human access.
- Review access periodically.
- Protect sensitive data.
- Separate dev, test, and production access.

### Change Management

- Assess upstream and downstream impact.
- Run tests before merging.
- Require review for production models.
- Document breaking changes.
- Communicate with consumers.
- Maintain rollback or remediation plan.

### Auditability

- Version-controlled code.
- Test results.
- Job run history.
- Access logs.
- Lineage.
- Documentation.
- Decision records.
- Release notes.

### Operational Monitoring

- Job success and failure
- Runtime duration
- Data freshness
- Row counts
- Test failures
- Cost trends
- Downstream consumption
- Incident frequency

## 11. Continuous Improvement

### How to Measure Maturity

| Level | Characteristics |
|---|---|
| Ad hoc | Manual queries, weak docs, unclear ownership. |
| Documented | Basic sources, models, and responsibilities recorded. |
| Standardized | Naming, testing, documentation, and release standards exist. |
| Managed | Monitoring, governance, lineage, and support model are in place. |
| Optimized | Feedback, automation, reusable patterns, and metrics drive improvement. |

### What to Monitor

- Test failures
- Freshness delays
- Pipeline failures
- Runtime trends
- Cost trends
- Data defects
- Support tickets
- Downstream incidents
- Duplicate logic
- Unused models

### Improvement Practices

- Add tests after every incident.
- Convert repeated fixes into reusable patterns.
- Review model usage.
- Remove stale assets.
- Improve documentation based on onboarding questions.
- Review access and ownership.
- Track technical debt as backlog items.

## 12. Development Lifecycle

1. **Intake** — Understand business need, consumer, and priority.
2. **Requirements** — Define source data, grain, fields, quality rules, refresh needs, and access.
3. **Design** — Select layer, model structure, transformation approach, tests, and governance.
4. **Build** — Create models, pipelines, documentation, and access controls.
5. **Test** — Validate data quality, business logic, performance, and downstream usage.
6. **Review** — Code review, architecture review, data owner review, and security review where needed.
7. **Deploy** — Release through controlled process.
8. **Monitor** — Track jobs, quality, freshness, cost, and incidents.
9. **Improve** — Use feedback to reduce defects and improve reuse.

## 13. Common Frameworks, Models, or Patterns

| Framework / Pattern | What It Is | When to Use It | Benefit | Watchout |
|---|---|---|---|---|
| Analytics Engineering | A common data engineering method, operating model, or design pattern. | Use when it fits the business, data, and platform context. | Improves consistency and quality. | Avoid applying it mechanically without context. |
| Modular SQL Modeling | A common data engineering method, operating model, or design pattern. | Use when it fits the business, data, and platform context. | Improves consistency and quality. | Avoid applying it mechanically without context. |
| Staging / Intermediate / Mart Pattern | A common data engineering method, operating model, or design pattern. | Use when it fits the business, data, and platform context. | Improves consistency and quality. | Avoid applying it mechanically without context. |
| Data Testing | A common data engineering method, operating model, or design pattern. | Use when it fits the business, data, and platform context. | Improves consistency and quality. | Avoid applying it mechanically without context. |
| Documentation as Code | A common data engineering method, operating model, or design pattern. | Use when it fits the business, data, and platform context. | Improves consistency and quality. | Avoid applying it mechanically without context. |
| Lineage-Driven Development | A common data engineering method, operating model, or design pattern. | Use when it fits the business, data, and platform context. | Improves consistency and quality. | Avoid applying it mechanically without context. |

## 14. Tools and Technologies

| Tool / Technology | What It Does | Where It Fits | Beginner Note | Enterprise Consideration |
|---|---|---|---|---|
| dbt Core | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| dbt Cloud | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| dbt Docs | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| dbt Explorer | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| dbt Tests | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| Git | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| Databricks Adapter | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| VS Code | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |
| CI/CD Pipelines | Supports work related to dbt. | Used for development, governance, monitoring, documentation, or consumption. | Learn the problem it solves before memorizing features. | Define ownership, access, naming, lifecycle, and operational support. |

## 15. Quick Reference Sheet

### Key Definitions

- **Source:** Original place data comes from.
- **Model:** Structured representation or transformation of data.
- **Grain:** What one row represents.
- **Lineage:** Path from source to consumption.
- **Test:** Rule used to validate data.
- **Catalog:** Place to organize and discover governed data.
- **Pipeline:** Automated flow that moves or transforms data.
- **SLA:** Expected delivery or quality commitment.

### Common Workflow

```text
Business question
  → Source identification
  → Grain definition
  → Modeling
  → Testing
  → Documentation
  → Governance
  → Consumption
  → Monitoring
```

### Red Flags

- No defined grain
- No data owner
- No tests
- No lineage
- No documentation
- No monitoring
- Duplicated logic
- Direct consumption from unstable sources
- Broad access to sensitive data
- Manual fixes with no root-cause follow-up

## 16. Interview / Meeting Talking Points

### Simple Explanation

dbt is a transformation framework that lets teams build modular SQL models, test data assumptions, document lineage, and manage analytics engineering workflows in version control.

### Business-Value Explanation

It helps improve trusted transformations, lineage visibility, testing discipline, faster analytics development by making data more reliable, reusable, governed, and easier to consume.

### Technical Explanation

dbt supports the path from source systems through ingestion, transformation, validation, governance, and consumption.

### Risk / Governance Explanation

The main risks are poor ownership, weak data quality, unclear lineage, broad access, missed dependencies, and unsupported production pipelines.

### Example Answer

> dbt helps us move from scattered, unreliable data work to a more governed and reusable data foundation. It supports reporting, automation, and AI by making data easier to trust, trace, secure, and operate.

## 17. Example Scenario

### Business Problem

A data team needs to rebuild automation policy attribute logic as tested, documented, reusable models rather than relying on copied SQL and undocumented Power Query logic.

### Technical Approach

- Define the consumer and use case.
- Identify authoritative data sources.
- Define grain, fields, and quality expectations.
- Build reusable transformations.
- Add tests and documentation.
- Govern access.
- Deploy with monitoring.
- Review failures and improve.

### Architecture

```text
Source
  → Ingestion
  → Transformation
  → Validation
  → Governance
  → Consumption
  → Monitoring
```

### Governance Considerations

- Data ownership
- Access control
- Sensitive data
- Version control
- Auditability
- Quality checks
- Downstream consumers
- Support model

### Testing Approach

- Key uniqueness
- Not-null checks
- Relationship checks
- Accepted values
- Freshness
- Reconciliation
- Performance
- Access validation
- Downstream acceptance

### Expected Outcome

- More trusted data
- Reduced manual reconciliation
- Better automation reliability
- Clearer ownership
- Stronger lineage
- Faster troubleshooting
- Reusable patterns for future work

## 18. Beginner-to-Pro Learning Path

| Level | What I Should Understand | What I Should Explain | What I Should Build or Apply | Common Mistakes | Practice Exercise | Ready to Move On When |
|---|---|---|---|---|---|---|
| Beginner | Basic purpose and vocabulary of dbt. | What it is and why it matters. | A one-page summary. | Memorizing terms without context. | Explain it to a non-technical person. | You can explain it simply. |
| Advanced Beginner | Common flows, tools, and stakeholders. | How it fits into a data process. | A simple diagram or checklist. | Jumping into tools too soon. | Map a source-to-report flow. | You can identify inputs and outputs. |
| Intermediate Practitioner | Real-world design, testing, and documentation. | How to apply it in a project. | A working example or model. | Skipping tests or ownership. | Build a small validated data flow. | You can deliver a useful artifact. |
| Advanced Practitioner | Scale, reliability, security, and exceptions. | Tradeoffs and failure modes. | A reusable pattern or runbook. | Overengineering or ignoring operations. | Design failure handling and monitoring. | You can support production behavior. |
| Enterprise Professional | Governance, lineage, SLAs, and cross-team standards. | Enterprise value and operating model. | A governed data product or roadmap. | Ignoring organizational constraints. | Create a domain standard. | You can influence multiple teams. |
| Architect / Strategic Lead | Strategy, platform patterns, and investment decisions. | How this supports transformation. | A reference architecture or strategy brief. | Becoming too theoretical. | Lead a design review. | You can guide standards and mentor others. |

## 19. Repository Placement

Suggested path:

```text
02-data-engineering/dbt/reference-guide.md
```

Related topics:

- `01-architecture/data-architecture/`
- `01-architecture/medallion-architecture/`
- `02-data-engineering/data-quality/`
- `02-data-engineering/data-lineage/`
- `02-data-engineering/orchestration/`
- `03-analytics-bi/power-bi/`
- `05-automation/intelligent-automation/`
- `08-governance-risk-controls/data-governance/`

## 20. Reusable Templates

See the local files in this folder:

- `quick-reference.md`
- `architecture-overview.md`
- `business-context.md`
- `best-practices.md`
- `troubleshooting-guide.md`
- `governance-checklist.md`
- `common-frameworks.md`
- `learning-path.md`

Also see the package-level files in:

```text
99-templates/
```
