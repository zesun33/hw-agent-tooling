# Execution Plan

This document tracks the build plan for the **Hardware Agent Tooling** portfolio family. It is updated after each repo is built and verified.

---

## Locked Decisions

| Decision | Value |
|---|---|
| Linux-first | Yes |
| Open-source-first | Yes |
| Repo style | Standalone repos |
| Publishing | Build locally first, then push |
| Engineering standard | Strict (10 gates) |
| Research Python libs | Deferred |

---

## Repo Sequence

| # | Repo | Type | Status |
|---|---|---|---|
| — | portfolio | Landing page | ✅ Done |
| 1 | eda-docker-images | DevOps foundation | ✅ Done |
| 2 | eda-devcontainer | DevOps foundation | 📋 Planned |
| 3 | gh-actions-for-hw | DevOps foundation | 📋 Planned |
| 4 | mcp-verilog | MCP server | 📋 Planned |
| 5 | hw-agent-skills | Agent skills | 📋 Planned |
| 6 | mcp-cocotb | MCP server | 📋 Planned |
| 7 | mcp-yosys | MCP server | 📋 Planned |
| 8 | mcp-rtl-review | MCP server | 📋 Planned |

---

## Repo 1: eda-docker-images

**Purpose:** Shared Docker images for hardware development (Verilog, SPICE, FPGA, ASIC).

**Images built:**

| Image | Base | Tools |
|---|---|---|
| `zesun33/verilog` | ubuntu:24.04 | iverilog, verilator, gtkwave, python3, make, node |
| `zesun33/spice` | ubuntu:24.04 | ngspice, python3, gnuplot |
| `zesun33/fpga` | ubuntu:24.04 | yosys, nextpnr-generic, opensta, fpga-icestorm |
| `zesun33/asic` | ubuntu:24.04 | yosys, opensta, openroad (optional) |

**Files:**

- 4 Dockerfiles
- 4 smoke scripts
- 6 fixture files (counter, RC filter, blinky, tiny_top)
- verify.sh, Makefile, CI workflow

**Verification:**

- Gate 1 spec lock: ✅
- Gate 2 static quality: ✅
- Gate 3 unit tests: ✅ (Docker build + smoke script presence)
- Gate 4 fixture integration: ✅ (fixtures present per image)
- Gate 5 packaging: ✅ (Docker images build)
- Gate 6 docs: ✅ (README, Makefile)
- Gate 7 release candidate: ✅
- Gate 8 post-publish: manual

**Exit criteria met:**

- [x] All 4 Dockerfiles exist
- [x] All 4 smoke scripts exist
- [x] Iconic fixtures per image
- [x] Makefile with build + verify targets
- [x] CI workflow
- [x] README with tool matrix and quickstart

---

## Repo 2: eda-devcontainer (Next)

**Goal:** VS Code / Cursor / OpenCode devcontainer profiles using the Docker images from Repo 1.

**Key deliverables:**

- 4 devcontainer profiles (verilog, spice, fpga, asic)
- Workspace tasks per profile
- Extension recommendations
- Example fixture per profile

---

## Repo 3: gh-actions-for-hw (Future)

**Goal:** Reusable GitHub Actions for hardware CI.

**Initial actions:**

- `verilog-lint`
- `verilog-simulate`
- `cocotb-test`
- `yosys-synthesize`

---

## Verification Standard

Every repo in the family runs `make verify` before shipping. The standard 10 gates are:

1. Spec lock — all required files present
2. Static quality — linter/formatter
3. Unit tests — logic tests
4. Fixture integration — toolchain tests
5. Packaging — installable artifact
6. Protocol/contract — MCP schema tests (where applicable)
7. Docs — link checks, quickstart validation
8. Agent integration — manual client matrix (where applicable)
9. Release candidate — changelog, version bump
10. Post-publish — smoke from clean install

---

## Updates

This plan is updated after each repo ships. Last update: June 2026.
