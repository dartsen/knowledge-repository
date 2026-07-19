---
title: AI Production Engineering Official References
description: Primary references for AI risk, production architecture, evaluation, observability, and security.
domain: Artificial Intelligence
subdomain: Production Engineering
content_type: Reference
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Quarterly
tags:
  - ai-references
  - nist-ai-rmf
  - ai-observability
related:
  - README.md
  - troubleshooting.md
---

# AI Production Engineering Official References

Checked 2026-07-18. Model lifecycle, provider behavior, product names, quotas, pricing, regions, evaluator availability, and semantic conventions can change; verify them for the selected deployment.

## Risk and Security

- [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework) - voluntary framework organized around Govern, Map, Measure, and Manage
- [NIST AI 600-1 Generative AI Profile](https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence) - generative-AI risks and actions
- [NIST AI RMF Playbook](https://airc.nist.gov/airmf-resources/playbook/) - suggested actions across the AI RMF functions
- [OWASP GenAI Security Project](https://genai.owasp.org/) - application-security risks and defensive resources for generative AI

## Architecture and Operations

- [Azure Well-Architected AI workload guidance](https://learn.microsoft.com/en-us/azure/well-architected/ai/) - nondeterministic workload architecture, operations, testing, and responsible AI
- [AI workload design principles](https://learn.microsoft.com/en-us/azure/well-architected/ai/design-principles) - reliability, security, cost, operations, and performance trade-offs
- [AI application design](https://learn.microsoft.com/en-us/azure/well-architected/ai/application-design) - application layers, prompts, models, and foundational design
- [Microsoft Foundry observability](https://learn.microsoft.com/en-us/azure/foundry/concepts/observability) - evaluation, monitoring, and tracing across the lifecycle

## Telemetry Standards

- [OpenTelemetry semantic conventions](https://opentelemetry.io/docs/specs/semconv/) - common telemetry naming and stability model
- [OpenTelemetry Generative AI conventions repository](https://github.com/open-telemetry/semantic-conventions-genai) - evolving GenAI traces, metrics, and events

Pin the convention version implemented and honor stability labels. Never enable prompt or response capture solely because an instrumentation library supports it; apply the workload's privacy, security, and retention policy.

## Qualification Notes

- Provider evaluators and safety controls require use-case calibration and do not replace accountable human review.
- A model or alias can change independently of application code; resolve and record the deployed version where the provider exposes it.
- End-to-end observability includes retrieval, tools, policy, and downstream effects, not only model latency and tokens.
- Product documentation and contract terms remain authoritative for data use, retention, regional support, quotas, and model retirement.
