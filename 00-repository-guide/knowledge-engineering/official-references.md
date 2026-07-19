---
title: Knowledge Engineering Official References
description: Primary standards and authoritative guidance for metadata, vocabularies, provenance, validation, and documentation structure.
domain: Repository Management
subdomain: Knowledge Engineering
content_type: Quick Reference
level: All Levels
status: Active
scope: General
owner: Repository Maintainer
last_reviewed: 2026-07-18
review_cycle: Semiannual
tags:
  - knowledge-references
  - metadata-standards
  - semantic-web
related:
  - README.md
  - troubleshooting.md
---

# Knowledge Engineering Official References

Checked 2026-07-18. Select only the standards needed by the use case and record the implemented version/profile.

## Metadata and Vocabularies

- [DCMI Metadata Terms](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/) - maintained descriptive metadata vocabulary
- [W3C SKOS Reference](https://www.w3.org/TR/skos-reference/) - concepts, preferred/alternative labels, and broader/narrower relationships
- [Schema.org documentation](https://schema.org/docs/documents.html) - widely used structured-data vocabulary and data model

## Provenance and Validation

- [W3C PROV-O](https://www.w3.org/TR/prov-o/) - interoperable provenance model for entities, activities, agents, and relationships
- [W3C PROV overview](https://www.w3.org/TR/prov-overview/) - guide to the PROV family of specifications
- [W3C SHACL](https://www.w3.org/TR/shacl/) - Recommendation for validating RDF graphs against shapes

## Content and Repository Practice

- [Diátaxis](https://diataxis.fr/) - primary documentation-system guidance distinguishing tutorials, how-to guides, reference, and explanation
- [GitHub documentation for non-code files](https://docs.github.com/en/repositories/working-with-files/using-files/working-with-non-code-files) - Markdown, relative links, and repository-native rendering

## Repository Standards

- [Metadata standards](../metadata-standards.md)
- [Content lifecycle](../content-lifecycle.md)
- [Naming standards](../naming-standards.md)
- [Adding new content](../adding-new-content.md)

## Qualification Notes

- Dublin Core, SKOS, PROV-O, SHACL, and Schema.org solve different problems; adopting one does not require adopting them all.
- Machine-readable semantics complement clear human-facing content and ownership.
- Diátaxis is a documentation method, not a metadata, provenance, or access-control standard.
- A vector index or knowledge graph is derived infrastructure and does not replace a governed canonical source.
