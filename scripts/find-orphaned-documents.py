#!/usr/bin/env python3
"""Fail on Active documents with no authoritative inbound navigation link."""

from __future__ import annotations

import argparse
from pathlib import Path

try:
    from repository_quality import active_documents, find_orphans, print_findings, repository_root, runtime_failure
except ModuleNotFoundError as exc:
    print(f"repository:1: configuration error: missing dependency '{exc.name}'; install requirements-dev.txt")
    raise SystemExit(2)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, help="repository root (defaults to the script parent)")
    args = parser.parse_args()
    try:
        root = repository_root(args.root, __file__)
        errors, non_active_orphans, non_active_candidates = find_orphans(root)
        print_findings(errors)
        if non_active_orphans:
            print(
                "repository:1: warning: "
                f"{non_active_orphans} of {non_active_candidates} non-Active canonical-area documents have no authoritative inbound link; "
                "preserved non-Active content is non-gating"
            )
        print(f"repository:1: summary: checked {len(active_documents(root))} Active documents; violations={len(errors)}")
        return 1 if errors else 0
    except Exception as exc:  # pragma: no cover - defensive CLI boundary
        return runtime_failure(exc)


if __name__ == "__main__":
    raise SystemExit(main())
