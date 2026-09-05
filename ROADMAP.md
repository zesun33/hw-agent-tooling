# Roadmap

This is the cross-repo roadmap for the AI Agent Tooling for Hardware + ML Systems portfolio. Each phase has a clear exit condition. Status moves `📋 Planned` → `🚧 Building` → `✅ Shipped` and is mirrored in the root [`README.md`](./README.md) status table.

See [LANDSCAPE.md](./LANDSCAPE.md) for the full competitive analysis backing every entry in this roadmap.

## Phase 0 — Standards and assets

- [x] Strict engineering standard defined.
- [x] README template.
- [x] Issue and PR templates.
- [x] GitHub Actions: link-check, markdown-lint.
- [x] Dependabot configuration.
- [x] Cross-repo verification matrix.

## Phase 1 — Foundation (ship-first slice)

The minimum coherent public story: a landing page plus the two highest-signal tools.

- [x] `hw-agent-tooling` — landing page (this repo).
- [x] `mcp-verilog` — MCP server: lint, compile, simulate, toolchain-info.
  - [x] MVP scope locked.
  - [x] Contract tests for `tools/list`.
  - [x] Fixture: counter, syntax_error, failing_tb.
  - [x] Packaging: TypeScript build and dist/ produced.
  - [x] Docs: quickstart commands and client configs.
  - [x] Agent matrix: Claude Desktop, Cursor, Antigravity.
- [x] `hw-agent-skills` — portable skills pack.
  - [x] `rtl-reviewer` skill.
  - [x] `verilog-testbench-writer` skill.
  - [x] `synthesis-triage` skill.
  - [x] `kernel-roofline-explainer` skill.
  - [x] `asic-flow-operator` skill.
  - [x] Cursor `.mdc` export and schema validation.

Exit condition: a hardware engineer can install `mcp-verilog` and at least one `hw-agent-skills` skill, run it in all four target clients, and have a recorded transcript.

## Phase 2 — Hardware-agent suite

- [x] `mcp-cocotb` — run cocotb testbenches, summarize results.
- [x] `mcp-yosys` — synthesis wrapper, structured stats.
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

## Phase 6 — Neuromorphic / SNN MCPs

Greenfield: 15+ mature Python tools, zero MCP servers. Directly tied to your PhD research.

- [ ] `mcp-snntorch` — MCP for snnTorch (1,992 ⭐). SNN construction, training, and surrogate gradient tuning.
- [ ] `mcp-spikingjelly` — MCP for SpikingJelly (2,044 ⭐). ANN-to-SNN conversion, encoder selection, training.
- [ ] `mcp-lava` — MCP for Intel Lava (732 ⭐). SNN deployment to Loihi 2 hardware.
- [ ] `mcp-nengo` — MCP for Nengo (931 ⭐). Neural engineering framework + Loihi backend.
- [ ] `mcp-bindsnet` — MCP for BindsNET (1,678 ⭐). PyTorch-based SNN simulation.
- [ ] `mcp-norse` — MCP for Norse (807 ⭐). PyTorch-based spiking neural networks.
- [ ] `mcp-nest` — MCP for NEST (649 ⭐). Large-scale SNN simulations via PyNEST.
- [ ] `mcp-neuron` — MCP for NEURON (524 ⭐). Computational neuroscience model building.
- [ ] `mcp-n2d2` — MCP for N2D2 (160 ⭐). DNN simulation, quantization, export.
- [ ] `mcp-neurosim` — MCP for NeuroSim (232 ⭐). RRAM/PCM/SRAM in-memory computing benchmarking.

Exit condition: any neuromorphic researcher can ask an agent to "build a 2-layer SNN on Loihi 2" and get a trained, deployed model back.

## Phase 7 — Analog AI / In-Memory Computing MCPs

Greenfield: IBM AIHWKit (483 ⭐) and Sandia CrossSim (208 ⭐) have rich Python APIs. No MCP servers exist.

- [ ] `mcp-aihwkit` — MCP for IBM AI Hardware Kit. Analog crossbar training, PCM device models, hardware-aware noise.
- [ ] `mcp-crosssim` — MCP for Sandia CrossSim. Analog crossbar inference, PyTorch/Keras integration, GPU-accelerated.

Exit condition: an agent can design an analog crossbar array, train with device non-idealities, and benchmark energy vs digital baseline.

## Phase 8 — Device Physics / Compact Model MCPs

Greenfield: zero MCP servers, zero LLM-agent tools, zero compact-model Python wrappers. Your FeFET papers give you unique credibility here.

- [ ] `fefet-mcp` — MCP for FeFET compact models. Wrap Verilog-A models, generate I-V curves, simulate hysteresis.
- [ ] `ubermag-mcp` — MCP for spintronics (Ubermag/OOMMF/Mumax3). Micromagnetics simulation via natural language.
- [ ] `badcrossbar-mcp` — MCP for memristor crossbars (badcrossbar, 31 ⭐). Nodal analysis for passive crossbar arrays.
- [ ] `mcp-compact-model` — MCP for generic compact model fitting. BSIM, Verilog-A, SPICE model parameter sweeps.

Exit condition: a device physicist can ask an agent to "show me the I-V curve of an HfO₂ FeFET with 3 nm thickness at 300 K" and get a plotted result.

## Phase 9 — Architecture Simulation MCPs

Greenfield: GEM5 has a Python config system and is the standard architecture simulator. Zero MCP or LLM-agent integration exists.

- [ ] `mcp-gem5` — MCP for GEM5. Configure SimObjects, run benchmarks, return IPC/miss-rate/energy.
- [ ] `mcp-sst` — MCP for SST (Structural Simulation Toolkit). Structural-level architecture simulation.

Exit condition: an architecture researcher can ask "simulate SPEC2017 on a 4-wide OoO core with 32KB L1 and 256KB L2" and get a structured performance report.

## Phase 10 — SPICE / TCAD MCPs

SPICE has active MCPs (spicebridge, ltspice-mcp) but gaps for proprietary tools. TCAD is completely empty.

- [ ] `mcp-hspice` — MCP for HSPICE. Open-source-first (ngspice fallback), optional HSPICE adapter.
- [ ] `mcp-spectre` — MCP for Spectre. Same open-source-first pattern.
- [ ] `mcp-xyce` — MCP for Xyce (Sandia parallel SPICE). Wrap via PySpice (839 ⭐).
- [ ] `tcad-mcp` — MCP for TCAD (Sentaurus/Silvaco). Tcl script generation, simulation dispatch, result parsing.

Exit condition: a circuit designer can ask "run transient analysis on this netlist at 1 GHz" and get waveform data back — using ngspice by default, with HSPICE/Spectre as optional engines.

---

## Phase 11 — DevOps / Infrastructure for Hardware ★★★

Zero-setup, one command to a working hardware development environment. No reusable EDA infrastructure exists on Docker Hub or GitHub Actions today.

- [x] `eda-docker-images` — Docker images for Verilog (iverilog 12.0, verilator 5.020, verible, sv2v, svlint), SPICE (ngspice 42), FPGA (yosys 0.51, icestorm 1.1, nextpnr-ice40/ecp5, prjoxide, opensta 2.5, openroad 2.0, verible, sv2v, svlint), ASIC (yosys 0.51, opensta 2.5, openroad 2.0, verible, sv2v, svlint). Built and smoke-tested with rootless podman.
- [x] `eda-devcontainer` — VS Code Dev Containers with every open-source EDA tool pre-installed (Verilog suite, SPICE suite, FPGA suite). `git clone` → `code .` → everything works.
- [ ] `gh-actions-for-hw` — Reusable GitHub Actions: `verilog-lint`, `verilog-simulate`, `yosys-synthesize`, `openroad-pnr`, `cocotb-test`, `spice-simulate`. Like `actions/setup-python` for hardware.
- [ ] `hw-agent-scaffold` — `npx create-hw-agent` generates a complete AI-powered hardware project with MCP servers, skills, Makefile, and starter RTL.
- [ ] `eda-docker-images` — Pre-built Docker images on Docker Hub: `zesun33/verilog`, `zesun33/spice`, `zesun33/fpga`. Shared foundation for all other tools.

Exit condition: a hardware engineer can open a fresh laptop, run one command, and have a working Verilog development environment with AI agent integration.

## Phase 12 — Interactive / Visualization

Human-facing tools for exploring hardware concepts visually.

- [ ] `kernel-rosetta` — Side-by-side implementations: Python → NumPy → PyTorch → Triton → CUDA → cuBLAS for matmul, softmax, attention. One CLI, six backends, one benchmark with roofline overlay.
- [ ] `device-lab` — Interactive Jupyter device physics explorer. FeFET/FinFET/memristor parameter sweeps with real-time I-V curve plotting.
- [ ] `cim-roofline` — Specialized roofline for CIM architectures: analog precision cliffs, ADC energy walls, crossbar utilization.

Exit condition: a curious engineer can visually understand device physics or kernel performance without installing any EDA tools.

## Phase 13 — Agent Ecosystem (Not MCP)

Tools that wire your agent-facing products together into a coherent user experience.

- [ ] `opencode-hw-subagents` — Specialized OpenCode subagents: `rtl-reviewer`, `synthesis-expert`, `verification-engineer`, `kernel-optimizer`. Domain-specific prompts, tool configs, tested transcripts.
- [ ] `claude-code-hw-plugins` — Claude Code slash commands: `/review-rtl`, `/synthesize`, `/simulate`, `/benchmark-kernel`, `/estimate-energy`.

Exit condition: a hardware engineer can install one plugin and immediately get domain-specialized agent behavior.

## Phase 14 — Evaluation / Benchmarks

Standardized evaluation for hardware AI agents.

- [ ] `llm-eval-for-hw` — Benchmark evaluating LLMs on hardware design tasks: Verilog generation, kernel optimization, timing debugging, dataflow analysis. Like HumanEval but for hardware engineering.
- [ ] `cim-accuracy-bench` — Standard benchmark measuring how analog non-idealities degrade neural network accuracy at different precision levels.

Exit condition: any new hardware LLM can be fairly compared to existing ones on standard tasks.

## Phase 15 — Tutorial / Knowledge Repos

Self-contained educational repos that demonstrate your research in an accessible way.

- [ ] `build-a-cim-accelerator` — Step-by-step: design CIM array → model FeFET devices → map neural network → simulate energy/accuracy. Jupyter notebooks + pre-built Docker environment.
- [ ] `neuromorphic-from-scratch` — LIF neurons → STDP → SNN in NumPy → port to snnTorch → deploy to Loihi via Lava. Progressive difficulty, fully reproducible.

Exit condition: a graduate student can work through the tutorial and understand CIM or neuromorphic computing from first principles.

---

## Out of scope (this portfolio)

- A general-purpose HW agent framework.
- Cloud-hosted MCP servers.
- Commercial wrapper / SaaS.

## Tracking

- Public GitHub Project board: `zesun33/hw-agent-tooling` → Projects → **AI Agent Tooling Roadmap**.
- Each item maps to a tracked issue in the relevant repo.
