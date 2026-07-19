# Repository Management

This area contains the operational records for the knowledge system.

- `audits/`: baseline, duplicate, movement, and reorganization reports
- `maps/`: deterministic [domain](maps/active-content-by-domain.md), [content-type](maps/active-content-by-type.md), and [tag](maps/active-content-by-tag.md) indexes for Active content

Repository-management documents describe the system; durable technical guidance remains in its primary subject domain.

Run the non-writing checks and explicit index-update workflow documented in [scripts/README.md](../scripts/README.md). Generated indexes must be updated with `generate-indexes.py --write`; validation and pull-request commands never write them implicitly.
