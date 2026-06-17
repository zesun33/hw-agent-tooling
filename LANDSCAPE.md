# Competitive Landscape — MCP Servers for Hardware / ML Systems

This document catalogs **every known MCP server, LLM-agent tool, and Python wrapper** in the hardware design, EDA, circuit simulation, device physics, neuromorphic, and architecture simulation domains. It serves as the *evidence file* behind the portfolio roadmap — every gap identified here is a candidate repo.

**Last updated:** June 2026
**Legend:** 🔴 = nothing exists · 🟡 = 1–2 tools, early/stale · 🟢 = 3+ active tools · ⭐ = active but no MCP

---

## Global Heatmap

| Domain | Tooling maturity | MCP servers | Python APIs | Gap for us |
|---|---|---|---|---|
| RTL / Verilog / SystemVerilog | 🟢 | 🟡 (3) | ✅ | `mcp-verilog` could differentiate on packaging + agent skills |
| FPGA (Vivado, Quartus) | 🟢 | 🟡 (4) | — | `mcp-fpga` (generic, open-source-first) |
| Synthesis (Yosys) | 🟢 | 🔴 (1 stale) | — | 🟢 **`mcp-yosys` — greenfield** |
| Physical Design (OpenROAD) | 🟢 | 🟡 (1 official) | ✅ | Compete or collaborate with official `OpenROAD-MCP` |
| Verification (cocotb) | 🟢 | 🔴 (none) | ✅ | 🟢 **`mcp-cocotb` — greenfield** |
| Formal Verification | 🟢 | 🟡 (2) | — | `chiasmus` (192 ⭐) is dominant; niche remains |
| SPICE Circuit Simulation | 🟢 | 🟢 (6+) | ✅ (PySpice 839 ⭐, spicelib 128 ⭐) | HSPICE / Spectre variants are untapped |
| TCAD (Sentaurus, Silvaco) | 🟢 (proprietary) | 🔴 (none) | 🔴 | 🟢 **TCAD MCP — greenfield but requires license** |
| Device Physics / Compact Models | 🔴 | 🔴 (none) | 🔴 | 🟢 **FeFET / BSIM / compact model MCP — greenfield** |
| Neuromorphic / SNN | 🟢 (15+ tools) | 🔴 (none*) | ✅ | 🟢 **snnTorch / Lava / Nengo MCP — greenfield** |
| Analog AI / In-Memory Computing | 🟡 | 🔴 (none) | ✅ (AIHWKit) | 🟢 **AIHWKit / CrossSim MCP — greenfield** |
| Architecture Simulation (GEM5) | 🟢 | 🔴 (none) | ✅ | 🟢 **mcp-gem5 — greenfield** |
| Emerging Devices (FeFET, MRAM, RRAM) | 🔴 | 🔴 (none) | 🔴 | 🟢 **FeFET / spintronics MCP — greenfield** |
| PCB Design (KiCad, Altium) | 🟢 | 🟢 (10+) | ✅ | Saturated — skip for now |
| Quantum Hardware | 🔴 | 🟡 (1) | — | Niche |

> *Brian2 has a single `brian2models-mcp` (0 stars, March 2026). No other neuromorphic tool has MCP integration.*

---

## RTL / Verilog / SystemVerilog

Existing MCP servers for HDL-level work:

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| pyslang-mcp | `ariklapid/pyslang-mcp` | 17 | Active (Jun 2026) | Tree-sitter + slang backed, compile + diagnostics |
| verilog-mcp-server | `airry12/verilog-mcp-server` | 0 | Very new (Jun 2026) | 28 tools: module search, FSM detection, clock domain |
| verilog-mcp-server | `kaiwenyu147369/verilog-mcp-server` | 1 | Early (May 2026) | AI-powered, testbench generation, UVM scaffolding |
| mcp-sandpipersaas | `shariethernet/mcp-sandpipersaas` | 3 | Stale (May 2025) | TL-Verilog compiler wrapper |

**Our play:** `mcp-verilog` wraps iverilog/Verilator (compile + simulate) rather than just static analysis. Differentiated by Docker packaging and built-in agent skills.

---

## FPGA

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| SynthPilot | `LNC0831/SynthPilot` | 47 | Active (Jun 2026) | AI-driven FPGA on Xilinx Vivado |
| vivado-mcp | `mapleleavessssssss-wq/vivado-mcp` | 60 | Active (Jun 2026) | Auto-diagnoses CRITICAL WARNINGs, fix suggestions |
| fpgaZeroMCP | `lcapossio/fpgaZeroMCP` | 4 | Early (Apr 2026) | Lint, simulate, synthesize, P&R; Verilog + VHDL |
| vivado-mcp-agent | `wangyuxin0707/vivado-mcp-agent` | 2 | Early (May 2026) | Windows-first, Vivado 2025.2 |
| quartus-91-mcp | `ethanrxla/quartus-91-mcp` | 0 | Minimal (Apr 2026) | Altera Quartus II 9.1 SP2 |

**Our play:** `mcp-fpga` could target open-source Yosys + nextpnr for generic FPGA synthesis, then add optional Vivado/Quartus adapters.

---

## Synthesis — Yosys

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| nl2tcl-mcp | `collinsoik/nl2tcl-mcp` | 0 | Stale (Dec 2025) | Wraps Yosys + iverilog; single commit, abandoned |

**Our play:** 🟢 **`mcp-yosys` — greenfield.** One stale competitor is unmaintained. Wrap `yosys` for synthesis, stat, hierarchy, and cell-level reports as structured JSON.

---

## Physical Design — OpenROAD

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| OpenROAD-MCP | `The-OpenROAD-Project/OpenROAD-MCP` | 11 | Active (Jun 2026) | Official MCP server from the OpenROAD Project; 29 open issues |

**Our play:** Official project exists. Either collaborate with upstream or build a complementary tool that integrates with the family (agentic-asic calls OpenROAD-MCP as a sub-flow).

---

## Verification — cocotb

No MCP server exists for cocotb (the standard Python-based verification framework for VHDL/Verilog). Zero competition.

**Our play:** 🟢 **`mcp-cocotb` — greenfield.** Run testbenches, collect results, surface failing assertions, return structured pass/fail data.

---

## Formal Verification

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| chiasmus | `yogthos/chiasmus` | **192** | Active (Jun 2026) | Z3 SMT solver + SWI-Prolog + tree-sitter; dominant player |
| frama-c-mcp-server | `lihaokun/frama-c-mcp-server` | 2 | Stable (Feb 2026) | Frama-C static analysis for C code |
| chiasmus.cr | `dsisnero/chiasmus.cr` | 0 | Early (May 2026) | Crystal port of chiasmus |

**Our play:** chiasmus dominates. Our niche could be a `mcp-formal` wrapping SymbiYosys/SVA specifically for RTL (not general-purpose like chiasmus).

---

## Circuit Simulation — SPICE

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| spicebridge | `clanker-lover/spicebridge` | 23 | Active (Apr 2026) | 28-tool MCP for ngspice; pip-installable |
| ltspice-mcp | `Cognitohazard/ltspice-mcp` | 15 | Active (Jun 2026) | LTspice + ngspice; 232 commits, pip-installable |
| ltspice-mcp | `daviditkin/ltspice-mcp` | 5 | Stale (Mar 2026) | Basic LTspice MCP |
| spicelib-mcp | `lucasgerads/spicelib-mcp` | 5 | Low (Apr 2026) | SPICE via spicelib |
| ltspice-converter | `ksugahar/ltspice-converter` | 3 | Active (Jun 2026) | Convert between LTspice .asc, SPICE .cir, schemdraw |
| qspice-mcp | `kh6570/HAbedini-qspice-mcp` | 0 | New (Jun 2026) | QSpice simulation MCP |
| SpiceService | `keithr/SpiceService` | 0 | Low (Feb 2026) | C# SPICE MCP |
| electronics-mcp | `manwithacat/electronics-mcp` | 0 | Stale (Mar 2026) | Circuit modelling + SPICE + schematic |

**Building blocks:**

| Library | GitHub Stars | Notes |
|---|---|---|
| PySpice (`PySpice-org/PySpice`) | **839** | Mature Python API to ngspice + Xyce; GPL-3.0 |
| spicelib (`nunobrum/spicelib`) | **128** | Python API for LTspice, QSPICE, NGSpice; MIT |

**Our play:** SPICE is active. Gaps: **no HSPICE MCP, no Spectre MCP, no Xyce MCP.** These are proprietary tools with no public MCP integration. An open-source-first MCP with optional proprietary adapters would be unique.

---

## TCAD — Sentaurus, Silvaco, Process Simulation

**Nothing exists.** Zero MCP servers, zero LLM-agent tools, zero Python wrappers (beyond trivial output-file parsers).

| "Tool" | What it is | Status |
|---|---|---|
| `CodeKboi/silvaco_parser` | Simple Python parser for Silvaco output | 1 ⭐ |
| `arjundatta-silvaco/Silvaco-Python-Data-Analysis` | Silvaco simulation + Python scripts | 0 ⭐ |
| `Beautifulboy111/Silvaco-Data-Handler` | Python scripts for Silvaco visualization | 0 ⭐ |

**Our play:** **Greenfield but hard.** Sentaurus and Silvaco are proprietary, closed-source, with no public Python APIs. Building an MCP server here requires wrapping the Tcl-based scripting interfaces — feasible if you have tool access (which you may from your Penn State lab).

---

## Device Physics / Compact Models

**Nearly nothing exists.** The entire category has zero MCP servers, zero LLM-agent tools, and zero compact-model Python wrappers.

| Search term | Result |
|---|---|
| FeFET compact model (Python) | No Python API — only MATLAB + Verilog-A models on GitHub |
| BSIM Python wrapper | None |
| FinFET compact model Python | None |
| Verilog-A Python device simulation | None |
| Compact model fitting Python | None |

**GitHub models found (no MCP):**

| Tool | Repo | Stars | Notes |
|---|---|---|---|
| Scalable-FeFET | `boltma/Scalable-FeFET` | 29 | MATLAB FeFET compact model + Verilog-A |
| heracles | `ncas-tum/heracles` | 15 | HfO₂ ferroelectric capacitor model (Verilog-A/SPICE); MIT |

**Our play:** 🟢 **Greenfield — and your direct research area.** A `fefet-mcp` (or `compact-model-mcp`) wrapping FeFET Verilog-A models + simple Python simulation would be **the first MCP server in this entire category.** Nobody else has your combination of FeFET research expertise and MCP development skills.

---

## Neuromorphic / Spiking Neural Networks

**15+ mature tools exist. Only Brian2 has an MCP server (0 stars).**

| Tool | Stars | Python API? | MCP server? | Our play? |
|---|---|---|---|---|
| **SpikingJelly** | 2,044 | ✅ PyTorch | ❌ | `mcp-spikingjelly` |
| **snnTorch** | 1,992 | ✅ PyTorch | ❌ | `mcp-snntorch` |
| **BindsNET** | 1,678 | ✅ PyTorch | ❌ | `mcp-bindsnet` |
| **Brian2** | 1,192 | ✅ | ✅ (0 ⭐, Mar 2026) | — |
| **Nengo** | 931 | ✅ + Loihi backend | ❌ | `mcp-nengo` |
| **Norse** | 807 | ✅ PyTorch | ❌ | `mcp-norse` |
| **Lava** (Intel) | 732 | ✅ + Loihi 2 HW | ❌ | `mcp-lava` |
| **NEST** | 649 | ✅ PyNEST | ❌ | `mcp-nest` |
| **NEURON** | 524 | ✅ + HOC | ❌ | `mcp-neuron` |
| **N2D2** | 160 | ✅ PyBind | ❌ | `mcp-n2d2` |
| **NeuroSim** | 232 | ❌ (C++/MATLAB) | ❌ | `mcp-neurosim` (harder — no Python) |

**Our play:** 🟢 **Massive greenfield.** Every SNN library is Python-native and well-maintained. Wrapping any of them as an MCP server lets AI agents design, train, and analyze spiking neural networks conversationally. This directly ties to your neuromorphic computing PhD research.

---

## Analog AI / In-Memory Computing

| Tool | Stars | Python API? | MCP server? | Notes |
|---|---|---|---|---|
| **IBM AIHWKit** | 483 | ✅ PyTorch, pip-installable | ❌ | IEEE award-winning, IBM-backed, MIT license |
| **CrossSim** (Sandia) | 208 | ✅ PyTorch, Keras | ❌ | Government-funded, v3.2.1 active (Jun 2026) |
| **MemTorch** | 186 | ✅ pip-installable | ❌ | Stale (2022), GPL |
| **PUMA** | 69 | ✅ (Python 2.7) | ❌ | Abandoned (2020) |
| **ISAAC** (MIT) | — | ❌ no public code | ❌ | Academic paper only |

**Our play:** 🟢 **Greenfield.** AIHWKit (483 ⭐) and CrossSim (208 ⭐) are the obvious targets. Both have active maintainers, rich Python APIs, and MIT/BSD licenses. An `mcp-aihwkit` would let AI agents simulate analog crossbar arrays, train with hardware-aware noise models, and benchmark energy efficiency — all without writing config files.

---

## Architecture Simulation — GEM5, SST

**Nothing exists.** GEM5 has a complex Python-based configuration system (SimObjects, m5) and is the standard architecture simulator used by every computer architecture research group. Yet zero MCP servers, zero LLM-agent tools, and zero Python CLI wrappers exist.

| Search term | Result |
|---|---|
| gem5 MCP | 0 results |
| gem5 LLM agent | 0 results |
| gem5 Python wrapper | 0 results |
| SST MCP | 0 results |
| gem5 Claude Code | 0 results |

**Our play:** 🟢 **Greenfield — huge audience.** `mcp-gem5` would let AI agents configure, run, and analyze architecture simulations: "run SPEC2017 benchmarks on this cache configuration and return IPC, miss rate, and energy."

---

## Emerging Devices — FeFET, Spintronics/MRAM, Memristor/RRAM

**Zero MCP servers across all three sub-categories.**

### Spintronics / MRAM

| Tool | Description | Python API? | MCP? |
|---|---|---|---|
| **Ubermag** (`ubermag/ubermag`) | Meta-package for OOMMF + Mumax3 ; 45 ⭐ | ✅ | ❌ |
| **oommfc** | Python OOMMF calculator; 55 ⭐ | ✅ | ❌ |
| **mumax3c** | Python interface to Mumax3 GPU simulator; part of Ubermag | ✅ | ❌ |
| **oommfpy** | OOMMF/Mumax3 data analysis; 15 ⭐ | ✅ | ❌ |
| **microLLG** | C/Python Landau-Lifshitz-Gilbert solver with STT; 24 ⭐ | ✅ | ❌ |

### Memristor / RRAM

| Tool | Description | Python API? | MCP? |
|---|---|---|---|
| **badcrossbar** (`joksas/badcrossbar`) | Nodal analysis solver for memristor crossbar arrays; 31 ⭐ -- pip-installable | ✅ | ❌ |
| **LUTorch** (`chinthana-w/LUTorch`) | PyTorch-based memristor crossbar simulation; not on PyPI | ✅ | ❌ |

**Our play:** 🟢 **Greenfield and directly tied to your research.** `ubermag-mcp` (spintronics), `badcrossbar-mcp` (memristor crossbars), and `fefet-mcp` (your area) would each be the first MCP server in their category. Your papers on FeFET and CIM architectures give you instant credibility here.

---

## PCB Design

**Highly saturated.** 10+ MCP servers exist for KiCad, Altium, EasyEDA.

| Tool | Stars | Notes |
|---|---|---|
| eda-agent (Altium) | 62 | 290+ tools, most mature |
| KiCad-MCP-Server | 1,290 | Most popular PCB MCP |
| kicad-mcp-pro | 5 | Active development |
| circuitron | 103 | KiCad MCP |
| easyeda-copilot | 61 | EasyEDA MCP |

**Our play:** Skip. This space is well-served by others.

---

## Quantum Hardware

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| quantum-hardware-mcp | `Lokesh-2025/quantum-hardware-mcp` | 1 | Active (Jun 2026) | IBM Quantum hardware data; very early |
| instrMCP | `caidish/instrMCP` | 27 | Active (Jun 2026) | Quantum device physics lab instrumentation |

**Our play:** Niche. Skip unless you have quantum computing research to tie in.

---

## Academic / Research MCP Projects

| Tool | Repo | Stars | Status | Notes |
|---|---|---|---|---|
| MCP4EDA | `NellyW8/MCP4EDA` | 90 | Stale (Jul 2025) | Published paper; wraps Yosys, iverilog, GTKWave, OpenLane, KLayout |
| SiliconForge-AI | `jayantsom/SiliconForge-AI` | 1 | Active | Multi-agent semiconductor fab platform (LangGraph + Ollama) |

---

## What's NOT on PyPI (packaging gap)

**None** of the hardware MCP servers found in this survey are published on PyPI. Even the mature ones (`spicebridge`, `ltspice-mcp`) are GitHub-only. This is a packaging gap — publishing any MCP server on PyPI would differentiate it from every existing hardware MCP.

---

## Summary — Our highest-ROI opportunities

Ranked by **greenfield × audience size × your unique advantage:**

| # | Repo | Category | Greenfield? | Audience | Your advantage |
|---|---|---|---|---|---|
| 1 | `mcp-cocotb` | Verification | ✅ No MCP exists | Every verification engineer using Python | Niche awareness |
| 2 | `mcp-yosys` | Synthesis | ✅ One stale competitor | Every RTL designer using open tools | EDA expertise |
| 3 | `mcp-gem5` | Architecture | ✅ Nothing exists | Every computer architecture researcher | Architecture background |
| 4 | `mcp-snntorch` | Neuromorphic | ✅ No MCP exists | Every SNN researcher (1,992 ⭐) | **Your PhD domain** |
| 5 | `mcp-aihwkit` | Analog AI | ✅ No MCP exists | Every CIM/analog AI researcher (483 ⭐) | **Your TrilinearCIM paper** |
| 6 | `fefet-mcp` | Device Physics | ✅ Nothing exists | FeFET/NVM device researchers | **You co-authored FeFET papers** |
| 7 | `mcp-neurosim` | Neuromorphic | ✅ No MCP exists | Neuromorphic architecture designers | Research adjacent |
| 8 | `ubermag-mcp` | Spintronics | ✅ No MCP exists | Spintronics/micromagnetics community | Device physics knowledge |
| 9 | `mcp-lava` | Neuromorphic HW | ✅ No MCP exists | Loihi 2 developers (732 ⭐) | SNN + HW background |

---

*This document is a living reference. Add new rows as the ecosystem evolves. File issues per repo proposal using the `new_repo_proposal.md` template.*
