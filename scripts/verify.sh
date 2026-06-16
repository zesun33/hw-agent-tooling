#!/usr/bin/env bash
# verify.sh — bulletproof verification flow for the portfolio repo.
#
# Mirrors the gates documented in the root README and is the single
# entry point used by CI. Each step is independent and exits non-zero
# on failure.
#
# Usage:
#   ./scripts/verify.sh              # full verification
#   ./scripts/verify.sh --quick      # skip network checks
#   ./scripts/verify.sh --gate N     # run only gate N

set -euo pipefail

# Resolve repo root regardless of where the script is invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${ROOT_DIR}"

QUICK=0
GATE=""
for arg in "$@"; do
  case "$arg" in
    --quick) QUICK=1 ;;
    --gate)
      shift
      GATE="${1:-}"
      ;;
    --gate=*) GATE="${arg#--gate=}" ;;
    -h|--help)
      cat <<'EOF'
verify.sh — bulletproof verification flow

  --quick        Skip network checks (lychee)
  --gate N       Run only the given gate (1..10). Gates:
                   1  spec lock
                   2  static quality
                   3  unit tests
                   4  fixture integration
                   5  packaging / install
                   6  protocol / contract
                   7  docs verification
                   8  agent integration matrix (manual)
                   9  release candidate
                  10  post-publish smoke
EOF
      exit 0
      ;;
  esac
done

color() { printf "\033[1;36m%s\033[0m\n" "$*"; }
ok()    { printf "  \033[1;32m✓\033[0m %s\n" "$*"; }
fail()  { printf "  \033[1;31m✗\033[0m %s\n" "$*"; exit 1; }

run_gate() {
  local n="$1"; shift
  local title="$1"; shift
  if [ -n "$GATE" ] && [ "$GATE" != "$n" ]; then
    return 0
  fi
  color "Gate ${n} — ${title}"
  "$@"
  ok "Gate ${n} passed"
}

# -- Gate 1: spec lock ---------------------------------------------------------
# For the portfolio repo this means: README, ROADMAP, and CHANGELOG exist
# and are non-empty, and the engineering standard is referenced.
gate1_spec() {
  for f in README.md ROADMAP.md CHANGELOG.md CONTRIBUTING.md LICENSE CODE_OF_CONDUCT.md .markdownlint.json .lychee/config.toml; do
    [ -s "$f" ] || fail "missing or empty: $f"
  done
  grep -q "## Engineering Standard" README.md || fail "Engineering Standard section not found in README.md"
}

# -- Gate 2: static quality ----------------------------------------------------
# markdownlint-cli2.
gate2_static() {
  npx --yes markdownlint-cli2 "**/*.md" >/dev/null
}

# -- Gate 3: unit tests --------------------------------------------------------
# python-based unit tests for any helper logic.
gate3_unit() {
  if compgen -G "tests/test_*.py" > /dev/null; then
    python3 -m unittest discover -s tests -p "test_*.py" -v
  else
    ok "no tests/test_*.py — skipping (portfolio repo has no logic)"
  fi
}

# -- Gate 4: fixture integration -----------------------------------------------
# portfolio repo has no fixture-based integration in v1.
gate4_fixture() {
  ok "no fixtures in portfolio repo — skipping"
}

# -- Gate 5: packaging / install ------------------------------------------------
# The portfolio has no installable artifact; the smoke test is that the
# files ship together and the standard tooling installs.
gate5_packaging() {
  # Re-run the same checks CI uses, in a clean way.
  : # nothing to install
}

# -- Gate 6: protocol / contract -----------------------------------------------
# No MCP contract in the portfolio repo. Skip.
gate6_protocol() {
  ok "no MCP contract in portfolio repo — skipping"
}

# -- Gate 7: docs verification --------------------------------------------------
# (a) internal file references in README point to real files
# (b) external link check (lychee) — skipped with --quick
gate7_docs() {
  python3 scripts/check_internal_links.py
  if [ "$QUICK" = "1" ]; then
    ok "lychee skipped (--quick)"
  else
    if command -v lychee >/dev/null 2>&1; then
      lychee --config .lychee/config.toml --no-progress README.md
    else
      ok "lychee not installed locally — CI will run it"
    fi
  fi
}

# -- Gate 8: agent integration matrix (manual) --------------------------------
# Documented, not automated.
gate8_agents() {
  if [ -d "agents" ]; then
    [ "$(ls -1 agents 2>/dev/null | wc -l)" -gt 0 ] || fail "agents/ is empty"
  else
    ok "no agents/ folder yet — manual gate, will be exercised in MCP repos"
  fi
}

# -- Gate 9: release candidate -------------------------------------------------
# Local check: changelog has an entry, version is consistent, README is current.
gate9_release_candidate() {
  grep -q "## \[Unreleased\]" CHANGELOG.md || fail "no [Unreleased] entry in CHANGELOG.md"
  grep -q "## \[0.1.0\]"        CHANGELOG.md || fail "no [0.1.0] entry in CHANGELOG.md"
}

# -- Gate 10: post-publish smoke -----------------------------------------------
# Manual gate: install from published artifact, rerun quickstart, verify badges.
gate10_post_publish() {
  ok "manual gate — see CONTRIBUTING.md and ROADMAP.md Phase 1"
}

run_gate 1 "spec lock"                  gate1_spec
run_gate 2 "static quality"             gate2_static
run_gate 3 "unit tests"                 gate3_unit
run_gate 4 "fixture integration"        gate4_fixture
run_gate 5 "packaging / install"        gate5_packaging
run_gate 6 "protocol / contract"        gate6_protocol
run_gate 7 "docs verification"          gate7_docs
run_gate 8 "agent integration matrix"   gate8_agents
run_gate 9 "release candidate"          gate9_release_candidate
run_gate 10 "post-publish smoke"        gate10_post_publish

color "All requested gates passed."
