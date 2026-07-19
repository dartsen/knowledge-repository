# Contributing

## Before Adding a File

1. Follow the [new-content decision tree](00-repository-guide/adding-new-content.md).
2. Search for an existing canonical document.
3. Update an existing guide when the new material serves the same audience and purpose.
4. Use `90-inbox/` when placement or authority is not yet clear.

## Content Requirements

- Use lowercase kebab-case filenames except for recognized navigation files such as `README.md`.
- Give every durable guide valid YAML front matter.
- State whether content is general, organization-specific, or project-specific.
- Link to related files using relative Markdown paths.
- Cite primary sources for current product behavior, limits, security guidance, and architecture recommendations.
- Never commit credentials, tokens, confidential case details, or production personal data.

## Pull Request Checklist

- [ ] The primary location is unambiguous.
- [ ] Existing canonical content was updated instead of duplicated where appropriate.
- [ ] Metadata uses controlled values.
- [ ] Links and anchors resolve.
- [ ] New Active guidance has an owner and review date.
- [ ] Organization-specific content is clearly labeled.
- [ ] Generated indexes are current.
- [ ] Repository checks pass locally.

## Local Validation

Run the commands documented in [scripts/README.md](scripts/README.md) and follow the [repository maintenance guide](repository-management/maintenance-guide.md). Validation scripts are non-writing by default; index generation writes only with an explicit `--write` option. Review structural changes from committed Git objects and use normal Git revert commits for recovery.
