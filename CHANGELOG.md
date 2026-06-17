# Changelog

All notable changes to this repo are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial landing-page README with portfolio identity, status tables, skill matrix, and verification matrix.
- `LANDSCAPE.md` — comprehensive competitive analysis of 100+ tools across 14 domains (RTL, FPGA, SPICE, TCAD, neuromorphic, analog AI, architecture simulation, device physics, emerging devices, PCB, quantum).
- Expanded `ROADMAP.md` with Phases 6–10 covering neuromorphic SNN MCPs, analog AI MCPs, device physics MCPs, architecture simulation MCPs, and SPICE/TCAD MCPs.

### Changed

### Deprecated

### Removed

### Fixed

- Excluded two flaky academic publication URLs from `lychee` so `make verify` is deterministic locally and in CI.

### Security

## [0.1.0] — 2026-06-16

### Bootstrap

- `README.md`, `LICENSE`, `CONTRIBUTING.md`, `CHANGELOG.md`, `CODE_OF_CONDUCT.md`, `ROADMAP.md`.
- Issue templates: bug report, feature request, new repo proposal.
- GitHub Actions: link-check, markdown-lint.
- Dependabot configuration.
