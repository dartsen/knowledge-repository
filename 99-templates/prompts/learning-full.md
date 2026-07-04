# Prompt Templates

## Full Subject Reference Guide Prompt

```text
Act as a senior technical educator, enterprise architect, data/AI practitioner, documentation strategist, and engineering mentor.

Create a complete, practical, well-structured Markdown reference guide for the following subject:

Subject

<INSERT SUBJECT HERE>


The audience is a beginner-to-pro technical professional who wants to build deep, practical mastery over time.

Assume the reader is intelligent and capable, but may be new to the subject. Explain concepts clearly without being condescending. Remove unnecessary jargon where it does not add value. When jargon is necessary, define it in plain English and show how it applies in real work.

Output Format

Create the output in clean, organized Markdown.

The guide should be practical enough to use as:

A learning reference
A team onboarding document
A technical architecture reference
A meeting preparation guide
A reusable knowledge repository article
A starting point for enterprise documentation
Required Sections

Include the following sections:

Executive Summary
Plain-English Explanation
Business Context
Core Concepts
Architecture View
Data / Process Flow
Common Use Cases
Best Practices
Common Mistakes
Troubleshooting Guide
Governance
Continuous Improvement
Development Lifecycle
Frameworks
Tools
Quick Reference
Meeting Talking Points
Example Scenario
Beginner-to-Pro Learning Path
Repository Placement
Reusable Templates
Final Mental Model
Style Requirements

Write in a practical, enterprise-ready style.

Use:

Plain English first
Clear examples
Tables where helpful
Step-by-step flows
Real-world business context
Beginner-friendly explanations
Intermediate and advanced guidance
Practical warnings and tradeoffs
Reusable templates
Operational considerations
Governance and support considerations

Avoid:

Unnecessary buzzwords
Overly academic explanations
Vague best practices
Vendor marketing language
Long theory without practical examples
Jargon that is not explained
Assuming the reader already knows the topic
Depth Requirements

For each major concept:

Define it simply.
Explain why it matters.
Show how it appears in real work.
Provide an example.
Include common mistakes or risks where relevant.
Diagramming Requirements

Include diagrams where they improve understanding.

Use Mermaid diagrams when possible.

Include diagrams for:

High-level architecture
Data or process flow
Development lifecycle
Governance or operating model
Example scenario flow

Use simple diagrams that a business or technical stakeholder could understand.

Example diagram style:

flowchart TD
    A[Business Request] --> B[Technical Intake]
    B --> C[Design]
    C --> D[Build]
    D --> E[Test]
    E --> F[Deploy]
    F --> G[Monitor]
    G --> H[Improve]
Practical Example Requirements

Include at least one realistic enterprise example scenario.

The example should show:

Business problem
Technical solution
Architecture
Step-by-step process
Risks
Governance considerations
Support or monitoring approach
Templates

Include reusable templates relevant to the subject.

Examples may include:

Design document template
Intake template
Troubleshooting checklist
Governance checklist
Production readiness checklist
Code review checklist
Meeting agenda
Architecture review checklist
Support runbook
Quick reference sheet
Quick Reference

Include a quick-reference section with commands, concepts, methods, terms, or decision rules depending on the subject.

Make this section easy to scan.

Learning Path

Include a beginner-to-pro learning path with levels such as:

Beginner
Advanced Beginner
Intermediate
Advanced
Pro / Enterprise Architect

For each level, include:

What to learn
What to practice
What the learner should be able to do
Common mistakes to avoid
Repository Placement

Recommend where this guide should live inside a technical knowledge repository.

Provide a folder structure like:

knowledge-repository/
└── <domain>/
    └── <subject>/
        ├── README.md
        ├── reference-guide.md
        ├── quick-reference.md
        ├── troubleshooting.md
        ├── governance.md
        ├── templates/
        └── examples/
Quality Bar

The final guide should feel like something a senior engineer, architect, or lead automation/data practitioner would give to a team member for onboarding and long-term growth.

Make it complete enough to stand alone, but structured enough that it can later be split into smaller repository files.

Optional Subject-Specific Requirements

Include the following subject-specific details:

<INSERT ANY SPECIFIC REQUIREMENTS HERE>

Examples:

For APIs: include Microsoft Graph examples for Outlook, SharePoint, and Excel.
For Power Automate: include cloud flows, desktop flows, connectors, solutions, ALM, environment variables, connection references, DLP, and monitoring.
For Databricks: include medallion architecture, Unity Catalog, dbt, jobs, SQL warehouses, governance, lineage, and data quality.
For Git: include branching, commits, pull requests, merge conflicts, rebasing, stashing, governance, and CI/CD.
For UiPath: include attended/unattended bots, Orchestrator, queues, assets, REFramework, AI agents, self-healing, and monitoring.
Final Instruction

Create the full Markdown guide now. Do not only provide an outline. Include detailed explanations, practical examples, diagrams, templates, and quick references.
```
