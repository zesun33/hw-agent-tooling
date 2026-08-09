# Publishing this repo

The portfolio repo is fully verified locally. To publish it to GitHub, follow
this runbook. Steps are idempotent — re-running is safe.

## One-time setup

```bash
# Authenticate the GitHub CLI (only needed once per machine).
gh auth login
```

## Create the repo and push

```bash
# From inside this directory:

# Create the public repo on GitHub. Adjust the description if you like.
gh repo create zesun33/hw-agent-tooling \
    --public \
    --source=. \
    --remote=origin \
    --description="AI Agent Tooling for Hardware + ML Systems — landing page" \
    --push

# Optional: pin topics so the repo is discoverable.
gh repo edit zesun33/hw-agent-tooling --add-topic mcp,hardware,verilog,ai-agents,portfolio
```

## Verify the CI is green

```bash
gh run watch
# or
gh run list --workflow=verify.yml --limit=1
```

If anything is red, copy the failing step and the local reproduction command
into a new issue tagged `ci`.

## Post-publish smoke (Gate 10)

After the first push, run these in a fresh shell:

```bash
# Clone somewhere clean and run the verify script.
tmp=$(mktemp -d)
git clone https://github.com/zesun33/hw-agent-tooling.git "$tmp/hw-agent-tooling"
cd "$tmp/hw-agent-tooling"
make verify
cd -
rm -rf "$tmp"
```

If that passes, you can mark Phase 1 / hw-agent-tooling ✅ in the ROADMAP.

## Wiring the website

Add a one-liner to `zesun33/zesun33.github.io` linking to this repo:

```markdown
- [AI Agent Tooling portfolio](https://github.com/zesun33/hw-agent-tooling)
```

## Recurring

- Bump the version in `CHANGELOG.md` on every release.
- Run `make verify` before every push.
- Keep `## Verified On` in the root README in sync with the actual CI matrix.
