# Roadmap

This is the cross-repo roadmap for the AI Agent Tooling for Hardware + ML Systems portfolio. Each phase has a clear exit condition. Status moves `📋 Planned` → `🚧 Building` → `✅ Shipped` and is mirrored in the root [`README.md`](./README.md) status table.

## Phase 0 — Standards and assets

- [x] Strict engineering standard defined.
- [x] README template.
- [x] Issue and PR templates.
- [x] GitHub Actions: link-check, markdown-lint.
- [x] Dependabot configuration.
- [x] Cross-repo verification matrix.

## Phase 1 — Foundation (ship-first slice)

The minimum coherent public story: a landing page plus the two highest-signal tools.

- [x] `portfolio` — landing page (this repo).
- [ ] `mcp-verilog` — MCP server: lint, compile, simulate, toolchain-info.
  - [ ] MVP scope locked.
  - [ ] Contract tests for `tools/list`.
  - [ ] Fixture: counter, adder, FSM, broken RTL.
  - [ ] Packaging: npm tarball installs and starts.
  - [ ] Docs: quickstart commands work.
  - [ ] Agent matrix: Claude Code, OpenCode, Codex, Cursor.
- [ ] `hw-agent-skills` — portable skills pack.
  - [ ] `rtl-reviewer` skill.
  - [ ] `verilog-testbench-writer` skill.
  - [ ] `synthesis-triage` skill.
  - [ ] `kernel-roofline-explainer` skill.
  - [ ] `asic-flow-operator` skill.
  - [ ] Per-skill transcript in `agents/`.

Exit condition: a hardware engineer can install `mcp-verilog` and at least one `hw-agent-skills` skill, run it in all four target clients, and have a recorded transcript.

## Phase 2 — Hardware-agent suite

- [ ] `mcp-cocotb` — run cocotb testbenches, summarize results.
- [ ] `mcp-yosys` — synthesis wrapper, structured stats.
- [ ] `mcp-rtl-review` — AST-backed static review.
- [ ] End-to-end demo: RTL → review → compile → simulate → synth.

Exit condition: a user can run the family end-to-end on a single tiny design.

## Phase 3 — Flagship CLI

- [ ] `kernel-forge` — Go CLI + Python backend.
  - [ ] MVP ops: `matmul`, `softmax` or `attention` microbench.
  - [ ] JSON output schema.
  - [ ] Deterministic benchmark mode.
  - [ ] `--help` snapshot test.
  - [ ] Cross-platform build (Linux, macOS, Windows).

Exit condition: stable JSON schema and one reproducible operator path.

## Phase 4 — Full physical-design flow

- [ ] `mcp-openroad` — Linux-first P&R wrapper.
- [ ] `agentic-asic` — orchestrator that drives the family end-to-end.
- [ ] One deterministic demo flow with golden transcripts.

Exit condition: a single agent run goes from an RTL file to a structured report that includes review, simulation, synthesis, and (optionally) P&R results.

## Phase 5 — Optional research track

- [ ] `astromorph` — RMAAT-style memory compression (deferred until needed).
- [ ] `trilinearcim` — DG-FeFET CIM simulator (deferred until needed).

## Out of scope (this portfolio)

- A general-purpose HW agent framework.
- Cloud-hosted MCP servers.
- Commercial wrapper / SaaS.

## Tracking

- Public GitHub Project board: `zesun33/portfolio` → Projects → **AI Agent Tooling Roadmap**.
- Each item maps to a tracked issue in the relevant repo.
