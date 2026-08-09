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
| 2 | eda-devcontainer | DevOps foundation | ✅ Done |
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

| Image | Base | Tools | Status |
|---|---|---|---|
| `zesun33/verilog` | ubuntu:24.04 | iverilog 12.0, verilator 5.020, verible 0.0-4080, sv2v 0.0.13, svlint 0.9.5, cocotb 2.0, python3, make, node | ✅ PASS |
| `zesun33/spice` | ubuntu:24.04 | ngspice 42, cocotb 2.0, python3 | ✅ PASS |
| `zesun33/fpga` | ubuntu:24.04 | yosys **0.51**, icestorm 1.1, nextpnr-ice40 0.10, nextpnr-ecp5 0.7, prjoxide, opensta 2.5, openroad 2.0, verible 0.0-3622, sv2v 0.0.13, svlint 0.9.5, cocotb 2.0 | ✅ PASS |
| `zesun33/asic` | ubuntu:24.04 | yosys **0.51**, opensta 2.5, openroad 2.0, verible 0.0-3622, sv2v 0.0.13, svlint 0.9.5, cocotb 2.0 | ✅ PASS |

**Local dev toolchain (user-space, conda + source builds):**

| Tool | Version | Source |
|---|---|---|
| iverilog | 11.0 | conda-forge |
| verilator | 5.048 | conda-forge |
| yosys | 0.51 | conda-forge |
| ngspice | 38 | conda-forge |
| gtkwave | 3.3.121 | conda-forge (needs DISPLAY) |
| openroad + sta | 2.0-12381 | litex-hub |
| icestorm | 1.1 | source build |
| nextpnr-ice40 | 0.10 | source build |
| nextpnr-ecp5 | 0.7 | conda litex-hub |
| cocotb | 2.0.1 | pip |
| verible | 0.0-4080 | conda-forge |
| sv2v | 0.0.13 | GitHub release |
| svlint | 0.9.5 | GitHub release |

**Container build notes:**

- Rootless podman with `overlay.ignore_chown_errors=true`
- All Dockerfiles set `APT::Sandbox::User "root"` for no-subuid environments
- `DEBIAN_FRONTEND=noninteractive` set globally
- fontconfig postinst failures in rootless are handled with `dpkg --force-all --configure -a`
- `python3-pip` may not fully install via apt; fallback is `python3 -m ensurepip`
- icestorm and nextpnr built from source in the fpga image
- `nextpnr-ice40` needs `CMAKE_INSTALL_RPATH` set to find boost shared libs
- gtkwave intentionally omitted from containers (needs DISPLAY/X11)
- opensta (standalone) not available via apt; bundled with openroad in litex-hub conda channel
- opensta + nextpnr-ecp5 installed via conda litex-hub (separate Python envs: Python 3.10 for openroad, Python 3.7 for nextpnr-ecp5)
- prjoxide for Lattice Nexus built from source (Rust); chipdb data installed to `/usr/local/share/prjoxide/chipdb`
- conda install done after source builds to avoid Python ABI conflicts with system Python
- yosys upgraded from apt 0.33 to conda 0.51 in fpga/asic containers
- openroad needed `fmt=8.1.1` pinned explicitly (conda dep missing from litex-hub package) + `libgl1`/`libegl1` for GL runtime
- verible installed via conda-forge in fpga/asic, via static binary download in verilog
- sv2v/svlint installed via pre-built binary from GitHub releases; need `unzip`

**Files:**

- 4 Dockerfiles
- 4 smoke scripts
- 6 fixture files (counter, RC filter, blinky, tiny_top)
- verify.sh, Makefile, CI workflow
- Conda activation script for EDA tools (`etc/conda/activate.d/eda-tools.sh`)

**Verification:**

- Gate 1 spec lock: ✅
- Gate 2 static quality: ✅ (markdownlint, lychee)
- Gate 3 unit tests: ✅ (Docker build + smoke script presence)
- Gate 4 fixture integration: ✅ (all 4 images smoke-tested with fixtures)
- Gate 5 packaging: ✅ (Docker images build with podman, all pass smoke)
- Gate 6 docs: ✅ (README, Makefile, PLAN.md updated)
- Gate 7 release candidate: ✅
- Gate 8 post-publish: manual

**Exit criteria met:**

- [x] All 4 Dockerfiles exist
- [x] All 4 smoke scripts exist
- [x] All 4 images build and pass smoke tests with podman
- [x] Iconic fixtures per image (counter, RC filter, blinky, tiny_top)
- [x] Makefile with build + verify targets
- [x] CI workflow
- [x] README with tool matrix and quickstart
- [x] Local dev toolchain with conda + source builds
- [x] Conda activation script for persistent PATH/LD_LIBRARY_PATH

---

## Repo 2: eda-devcontainer

**Goal:** VS Code / Cursor / OpenCode devcontainer profiles using the Docker images from Repo 1.

**Key deliverables:**

| Profile | Base Image | Tools | Extensions |
|---|---|---|---|
| `verilog` | `zesun33/verilog` | iverilog 12.0, verilator 5.020, cocotb 2.0 | Verilog HDL, SV, iverilog runner |
| `spice` | `zesun33/spice` | ngspice 42, cocotb 2.0 | SPICE language support |
| `fpga` | `zesun33/fpga` | yosys, icestorm, nextpnr-ice40/ecp5, prjoxide, opensta, cocotb | Verilog HDL, Yosys format |
| `asic` | `zesun33/asic` | yosys, opensta, cocotb | Verilog HDL, Yosys format |

Status: Done.

- 4 devcontainer profiles with `devcontainer.json` + Dockerfile per profile
- VS Code extension recommendations per profile
- Fixtures copied from eda-docker-images
- Makefile with build/verify targets
- CI workflow
- All 4 profiles build and smoke-test with podman

Notes:

- Each profile Dockerfile inherits from the corresponding base image and adds sudo + openssh-client
- Rootless podman fix: `dpkg --force-all --configure -a` for openssh-client postinst
- Devcontainer smoke scripts mount fixtures directory and verify all tools

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
