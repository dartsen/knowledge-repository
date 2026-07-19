#!/usr/bin/env python3
"""Check deterministic Active-content indexes or write them explicitly."""

from __future__ import annotations

import argparse
from pathlib import Path

try:
    from repository_quality import check_indexes, print_findings, repository_root, runtime_failure, write_indexes
except ModuleNotFoundError as exc:
    print(f"repository:1: configuration error: missing dependency '{exc.name}'; install requirements-dev.txt")
    raise SystemExit(2)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, help="repository root (defaults to the script parent)")
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--check", action="store_true", help="check for missing or stale indexes (default; never writes)")
    mode.add_argument("--write", action="store_true", help="write only changed generated indexes")
    args = parser.parse_args()
    try:
        root = repository_root(args.root, __file__)
        if args.write:
            changed = write_indexes(root)
            for path in changed:
                print(f"{path}:1: updated: deterministic generated index")
            print(f"repository:1: summary: write mode completed; changed={len(changed)}")
            return 0
        findings = check_indexes(root)
        print_findings(findings)
        print(f"repository:1: summary: non-writing index check completed; violations={len(findings)}")
        return 1 if findings else 0
    except Exception as exc:  # pragma: no cover - defensive CLI boundary
        return runtime_failure(exc)


if __name__ == "__main__":
    raise SystemExit(main())
