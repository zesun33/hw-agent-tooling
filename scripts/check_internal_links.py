#!/usr/bin/env python3
"""Check internal file references in README.md.

Verifies that every `(./*.md)` link in `README.md` points to a real file.
External links (https://...) are not checked by this script — lychee does
that.
"""

import os
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
README = ROOT / "README.md"

text = README.read_text()
# Match links of the form (./something.md) — markdown relative links.
refs = sorted(set(re.findall(r"\(\./([A-Za-z0-9._-]+)\)", text)))

missing = []
for ref in refs:
    if not (ROOT / ref).exists():
        missing.append(ref)

if missing:
    print("Missing internal file references:", file=sys.stderr)
    for m in missing:
        print(f"  {m}", file=sys.stderr)
    sys.exit(1)

print(f"All {len(refs)} internal file references resolve:")
for r in refs:
    print(f"  OK  ./{r}")
