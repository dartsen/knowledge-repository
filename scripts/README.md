# Repository Quality Scripts

These six command-line checks share `repository_quality.py`. They are read-only unless index generation is explicitly invoked with `--write`:

| Script | Purpose |
|---|---|
| `check-frontmatter.py` | Validate required fields, controlled values, related targets, review dates, and scoped-content rules for Active documents. |
| `check-links.py` | Resolve internal Markdown paths and heading anchors from the authoritative repository surface. |
| `find-duplicate-content.py` | Report repository-wide exact and normalized duplicates and reject groups containing multiple Active documents. |
| `find-orphaned-documents.py` | Reject Active documents with no authoritative inbound navigation link and report non-Active orphan counts. |
| `check-sensitive-content.py` | Detect high-confidence sensitive values while suppressing matched values in output. |
| `generate-indexes.py` | Verify three deterministic Active-content maps; `--write` is an explicit maintainer action. |

`check-frontmatter.py` reports the legacy-warning count without flooding pull-request logs. Add `--show-warnings` when reviewing preserved non-Active metadata.

Install the sole development dependency and run the same checks as pull requests:

```powershell
python -m pip install -r requirements-dev.txt
python -m unittest discover -s tests -v
python scripts/check-frontmatter.py
python scripts/check-links.py
python scripts/find-duplicate-content.py
python scripts/find-orphaned-documents.py
python scripts/check-sensitive-content.py
python scripts/generate-indexes.py --check
```

Use `check-frontmatter.py --show-warnings` to list preserved non-Active legacy metadata records and `check-links.py --all` for a wider advisory scan of Draft, review, and archive links. Those preserved lifecycle areas remain non-gating by default.

All commands emit `path:line` diagnostics and use exit code `0` for success, `1` for content violations, and `2` for runtime or configuration failure. The pull-request workflow finishes with a complete Git status check to prove that validation did not modify the checkout or create untracked output.
