#!/usr/bin/env python3
"""Report exact and normalized Markdown duplicates; fail for Active duplicates."""

from __future__ import annotations

import argparse
from pathlib import Path

try:
    from repository_quality import find_duplicate_groups, print_findings, repository_root, runtime_failure
except ModuleNotFoundError as exc:
    print(f"repository:1: configuration error: missing dependency '{exc.name}'; install requirements-dev.txt")
    raise SystemExit(2)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, help="repository root (defaults to the script parent)")
    args = parser.parse_args()
    try:
        root = repository_root(args.root, __file__)
        errors, warnings, exact_groups, normalized_groups = find_duplicate_groups(root)
        print_findings(warnings)
        print_findings(errors)
        print(
            "repository:1: summary: "
            f"exact_groups={exact_groups}; normalized_equivalent_groups={normalized_groups}; violations={len(errors)}"
        )
        return 1 if errors else 0
    except Exception as exc:  # pragma: no cover - defensive CLI boundary
        return runtime_failure(exc)


if __name__ == "__main__":
    raise SystemExit(main())
