# Changelog

All notable changes to this repo are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial landing-page README with portfolio identity, status tables, skill matrix, and verification matrix.
- `LANDSCAPE.md` — comprehensive competitive analysis of 100+ tools across 14 domains (RTL, FPGA, SPICE, TCAD, neuromorphic, analog AI, architecture simulation, device physics, emerging devices, PCB, quantum).
- Expanded `ROADMAP.md` with Phases 6–10 covering neuromorphic SNN MCPs, analog AI MCPs, device physics MCPs, architecture simulation MCPs, and SPICE/TCAD MCPs.
- Honest feasibility filter in LANDSCAPE.md: only 5 MCP repos survive the build list (snntorch, aihwkit, cocotb, yosys, fefet); 14 others dropped with documented reasons.
- Non-MCP opportunities section in LANDSCAPE.md: DevOps infrastructure for hardware ★★★ (`eda-devcontainer`, `gh-actions-for-hw`, `hw-agent-scaffold`, `eda-docker-images`), interactive/visualization tools, agent ecosystem tools, evaluation benchmarks, tutorial/knowledge repos.
- Expanded `ROADMAP.md` with Phases 11–15 covering DevOps/infrastructure, interactive/visualization, agent ecosystem, evaluation/benchmarks, and tutorial/knowledge repos.

### Changed

- Landing page one-step: `npx @zesun33/create-hw-agent`. `mcp-spice` and `hw-agent-scaffold` marked shipped. Verilog image Verilator 5.050; FPGA image openFPGALoader.
- Skill matrix and “how to use” copy match the eight shipped EDA MCP servers plus Sky130 scale signoff.
- `ROADMAP.md` Phase 4c: Sky130 PDN-before-place, CTS buffers, `regfile32x32` LVS match.
- Softened landing-page claims (Verified On Linux-first; Skill Matrix reflects shipped evidence; planned repos are not linked until they exist).
- Lychee no longer accepts HTTP 404.

### Deprecated

### Removed

### Fixed

- Excluded two flaky academic publication URLs from `lychee` so `make verify` is deterministic locally and in CI.
- Fixed `PLAN.md` markdownlint MD032/MD036 so Gate 2 passes.

### Security

## [0.1.0] — 2026-06-16

### Bootstrap

- `README.md`, `LICENSE`, `CONTRIBUTING.md`, `CHANGELOG.md`, `CODE_OF_CONDUCT.md`, `ROADMAP.md`.
- Issue templates: bug report, feature request, new repo proposal.
- GitHub Actions: link-check, markdown-lint.
- Dependabot configuration.
