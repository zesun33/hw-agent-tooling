# Contributing

This repository is the **landing page** for a family of open-source tools. It rarely receives code contributions — most of the action is in the per-tool repos. This document focuses on the contribution standards every repo in the family follows, and how to propose changes to the landing page itself.

## Engineering standard (applies to every repo in the family)

Before opening a PR against any repo in the family, your change must:

1. Pass the repo's `## Verification` gates (formatter, linter, type check, tests, packaging).
2. Update the repo's `CHANGELOG.md` under the `Unreleased` section.
3. Keep the public API or CLI surface backward-compatible, or call out the breaking change in the changelog and `README.md`.
4. Add or update fixture-based tests for any new behavior.
5. If you touched the public surface, add or update a transcript in the `agents/` evidence folder.

## Proposing changes to this landing page

The landing page itself is a single `README.md`. To propose a change:

1. Open a PR titled `[portfolio] <short description>`.
2. Keep changes small and reviewable. Do not reformat the whole file.
3. If you are adding a new repo to the family:
   - Open an issue first using the **New repo proposal** template.
   - The repo must already exist and have cleared its own gates before it is listed here.
4. Status changes go from `📋 Planned` → `🚧 Building` → `✅ Shipped`. Use the issue tracker to mark transitions.

## Filing bugs

Use the **Bug report** template. Include:

- Affected repo
- Platform (Linux, macOS, Windows) and version
- Steps to reproduce
- Expected vs actual
- Log / screenshot if available

## Requesting features

Use the **Feature request** template. Include:

- The user story ("As a ... I want ... so that ...")
- The repo(s) affected
- A short sketch of the proposed change

## Code of conduct

By participating, you agree to abide by the [Code of Conduct](./CODE_OF_CONDUCT.md).

## License

By contributing, you agree that your contributions are licensed under the [Apache-2.0 License](./LICENSE).
