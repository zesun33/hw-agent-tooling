# Md Zesun Ahmed Mia — AI Agent Tooling for Hardware + ML Systems

> PhD candidate in Electrical Engineering at Penn State. Ex-Intel graduate technical intern.
> I build MCP servers, agent skills, and CLIs that turn AI coding agents into capable hardware and ML-systems engineers.

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](./LICENSE)
[![Standard: Strict](https://img.shields.io/badge/engineering%20standard-strict-blueviolet)](#engineering-standard)
[![Platforms: Linux-first](https://img.shields.io/badge/platforms-linux--first-lightgrey)](#verified-on)
[![Made by zesun33](https://img.shields.io/badge/maintained%20by-zesun33-0a0a0a)](https://github.com/zesun33)
[![Landscape: 100+ tools](https://img.shields.io/badge/landscape-100%2B%20tools%20surveyed-informational)](./LANDSCAPE.md)

---

## Identity

- **Name:** Md Zesun Ahmed Mia
- **Role:** PhD Candidate, Electrical Engineering, Penn State
- **Focus:** Neuromorphic computing · Compute-in-Memory (CIM) · ML accelerators · Hardware-aware ML
- **Industry:** Ex-Intel graduate technical intern (thin film process + AI process models)
- **Selected work:** [TrilinearCIM (arXiv 2604.07628)](https://arxiv.org/abs/2604.07628) · [RMAAT (ICLR 2026)](https://openreview.net/forum?id=sTkJdbVxsI)
- **Website:** [zesun33.github.io](https://zesun33.github.io)

This repository is the **landing page** for a family of open-source hardware-agent tools. Shipped items clear the engineering gates below; planned items are sequenced in [ROADMAP.md](./ROADMAP.md) and are not installable yet.

---

## AI Agent Tools — the new family

These are agent-facing tools: MCP servers, agent skills, and CLIs that any modern coding agent (Claude Code, OpenCode, OpenAI Codex, Cursor) can call.

| Repo | Stack | What it does | Status |
|---|---|---|---|
| [`eda-docker-images`](https://github.com/zesun33/eda-docker-images) | Docker · Podman | Shared Verilog / SPICE / FPGA / ASIC images (Hub pending). | ✅ Shipped |
| [`eda-devcontainer`](https://github.com/zesun33/eda-devcontainer) | Dev Containers | VS Code / Cursor profiles on top of those images. | ✅ Shipped |
| `mcp-verilog` | TypeScript · MCP | Lint, compile, and simulate Verilog/SystemVerilog through iverilog/Verilator. | 📋 Planned |
| `hw-agent-skills` | Markdown · Skills | Portable skills (rtl-reviewer, synthesis-triage, kernel-roofline, asic-flow-operator). | 📋 Planned |
| `mcp-cocotb` | Python · MCP | Run cocotb testbenches, collect results, and surface failing assertions. | 📋 Planned |
| `mcp-yosys` | TypeScript · MCP | Synthesize RTL, return cell count, hierarchy, and warnings as structured JSON. | 📋 Planned |
| `mcp-rtl-review` | Python · MCP | Static RTL review (width mismatches, missing resets, blocking vs non-blocking). | 📋 Planned |
| `mcp-openroad` | TypeScript · MCP | Floorplan, place, and route through OpenROAD. Linux-first. | 📋 Planned |
| `kernel-forge` | Go CLI + Python | Agent-friendly kernel codegen, benchmark, and roofline for Triton/CUDA. | 📋 Planned |
| `agentic-asic` | TypeScript + Python | Orchestrates the family: RTL → review → simulate → synth → P&R. | 📋 Planned |
| `gh-actions-for-hw` | GitHub Actions | Reusable hardware CI: lint, simulate, cocotb, yosys synth. | 📋 Planned |

Legend: 🚧 Building · 📋 Planned · ✅ Shipped · ⛔ Blocked

> **See [LANDSCAPE.md](./LANDSCAPE.md)** for the full competitive analysis: 100+ tools surveyed across 14 domains — RTL, FPGA, synthesis, P&R, verification, SPICE, TCAD, device physics, neuromorphic/SNN, analog AI, architecture simulation, emerging devices (FeFET/MRAM/memristor), PCB, and quantum hardware.
>
> **Optional, deferred:** `astromorph` and `trilinearcim` (paper-linked research code) are intentionally not in this wave. They can be added later if there is a need for paper-aligned open-source software.

---

## Hardware + ML Systems

Code that demonstrates the underlying competence the agent tools sit on.

| Area | Evidence |
|---|---|
| ML accelerators / CIM | TrilinearCIM (DG-FeFET, 3-operand MAC, runtime-reprogram-free attention). |
| Efficient attention | RMAAT — astrocyte-inspired long-context transformer (ICLR 2026). |
| Hardware-aware ML | Mixed-precision, quantization, sparsity, kernel co-design experience. |
| ASIC / RTL | Verilog, SystemVerilog, synthesis, P&R, DFT, static timing (cadence + academic tools). |
| EDA | Cadence Virtuoso, HSPICE, TCAD Sentaurus, yosys, OpenROAD, Verilator, cocotb. |
| Programming | Python, CUDA, C/C++, Triton, PyTorch, TensorRT, ONNX, MATLAB, Verilog. |

---

## Existing Systems Work

Earlier self-study repos demonstrating systems-level fluency. Kept as supporting evidence, not the main act.

| Repo | Topic |
|---|---|
| [`cuda-gemm-optimization`](https://github.com/zesun33/cuda-gemm-optimization) | Naive → tiled → Tensor Core GEMM. |
| [`cuda-memory-benchmark`](https://github.com/zesun33/cuda-memory-benchmark) | Global/shared memory bandwidth, roofline, bank conflicts. |
| [`parallel-computing-lab`](https://github.com/zesun33/parallel-computing-lab) | OpenMP patterns and a parallel GEMM. |
| [`resnet-tensorrt-bench`](https://github.com/zesun33/resnet-tensorrt-bench) | FP32 / FP16 / INT8 inference through TensorRT. |
| [`triton-flash-attention-lite`](https://github.com/zesun33/triton-flash-attention-lite) | FlashAttention in Triton, block-level memory management. |

---

## Research

| Venue | Paper | Year |
|---|---|---|
| ICLR | [RMAAT: Astrocyte-Inspired Memory Compression and Replay for Efficient Long-Context Transformers](https://openreview.net/forum?id=sTkJdbVxsI) | 2026 |
| arXiv | [Trilinear Compute-in-Memory Architecture for Energy-Efficient Transformer Acceleration](https://arxiv.org/abs/2604.07628) | 2026 |
| IEEE TCDS | [Delving deeper into astromorphic transformers](https://ieeexplore.ieee.org/document/10976578/) | 2025 |
| ICONS | [Neuromorphic Cybersecurity with Semi-Supervised Lifelong Learning](https://doi.org/10.1109/ICONS69015.2025.00043) | 2025 |
| MWSCAS | Toward Variation-Tolerant Ferroelectric Neural Computing | 2025 |
| Matter (Cell) | [Self-sensitizable neuromorphic device based on adaptive hydrogen gradient](https://www.cell.com/matter/fulltext/S2590-2385(24)00108-5) | 2024 |

Google Scholar: [j-zfUj8AAAAJ](https://scholar.google.com/citations?user=j-zfUj8AAAAJ)

---

## Skill Matrix

| Skill | Strongest evidence today |
|---|---|
| DevOps / EDA containers | `eda-docker-images`, `eda-devcontainer` |
| Existing systems depth | `cuda-gemm-optimization`, `cuda-memory-benchmark`, `parallel-computing-lab` |
| ML systems awareness | `triton-flash-attention-lite`, research (CIM / RMAAT) |
| Research depth | ICLR 2026, IEEE TCDS, Matter (Cell Press) |
| MCP / agent tooling (planned) | `mcp-verilog`, `hw-agent-skills`, `agentic-asic` (see roadmap) |

---

## Verified On

CI for this landing page runs on `ubuntu-latest`. Container tools are verified on Linux hosts (Docker/Podman). macOS/Windows are expected via containers once Hub images ship — not claimed as CI-verified yet.

| Repo | Linux | macOS | Windows | Agents verified |
|---|---|---|---|---|
| `hw-agent-tooling` | ✅ (CI) | — | — | n/a |
| `eda-docker-images` | ✅ (local smokes) | —¹ | —¹ | n/a |
| `eda-devcontainer` | ✅ (local smokes) | —¹ | —¹ | n/a |
| `mcp-verilog` | 📋 | 📋 | 📋 | 📋 |
| `hw-agent-skills` | 📋 | 📋 | 📋 | 📋 |
| `mcp-cocotb` | 📋 | 📋 | 📋 | 📋 |
| `mcp-yosys` | 📋 | 📋 | 📋 | 📋 |
| `mcp-rtl-review` | 📋 | 📋 | 📋 | 📋 |
| `mcp-openroad` | 📋 | ⛔ | ⛔ | 📋 |
| `kernel-forge` | 📋 | 📋 | 📋 | 📋 |
| `agentic-asic` | 📋 | ⛔ | ⛔ | 📋 |
| `gh-actions-for-hw` | 📋 | 📋 | 📋 | n/a |

¹ Container images may run on macOS/Windows hosts; not part of current CI.

> "Agents verified" = installed and exercised in **Claude Code, OpenCode, OpenAI Codex, and Cursor** with one happy-path and one failure-path transcript recorded in the repo.

---

## How to use this portfolio

- **Recruiters / hiring managers:** Start with the [Skill Matrix](#skill-matrix); the end-to-end demo will live in `agentic-asic` once shipped.
- **Hardware engineers:** Use `eda-docker-images` / `eda-devcontainer` today; `mcp-verilog` is next for lint / simulate on your RTL.
- **Agent builders:** `hw-agent-skills` plus the MCP family are the intended install path once Phase 1 lands.
- **Researchers:** See the [Research](#research) section for the papers behind the design choices.

---

## Engineering Standard

Every repo in this family ships behind the same gates. No repo goes public without clearing all of them. See [CONTRIBUTING.md](./CONTRIBUTING.md) and the per-repo `## Verification` sections.

| Gate | What it catches |
|---|---|
| Spec lock | Scope creep, ambiguous contracts |
| Static quality | Formatter, linter, type errors |
| Unit tests | Logic regressions |
| Fixture integration | Real-world toolchain mismatches |
| Packaging / install | "Works on my machine" failures |
| Protocol / contract | MCP JSON-RPC drift, schema breakage |
| Docs verification | Stale quickstarts, broken links |
| Agent integration matrix | Client-specific breakage |
| Release candidate | Last-mile regressions |
| Post-publish smoke | Tag-vs-source drift |

---

## Contact

- Email: `zesun.ahmed@psu.edu`
- Website: [zesun33.github.io](https://zesun33.github.io)
- LinkedIn: [linkedin.com/in/zesun-ahmed](https://www.linkedin.com/in/zesun-ahmed)
- ORCID: [0009-0004-3509-8455](https://orcid.org/0009-0004-3509-8455)
- Scholar: [j-zfUj8AAAAJ](https://scholar.google.com/citations?user=j-zfUj8AAAAJ)

---

## License

[Apache-2.0](./LICENSE). © 2026 Md Zesun Ahmed Mia.
