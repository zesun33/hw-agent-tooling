#!/usr/bin/env bash
# run_demo.sh — Phase 2 End-to-End Autonomous Hardware Agent Demo Flow.
#
# Connects the hardware agent tooling portfolio in a closed loop:
# 1. mcp-rtl-review: static semantic audit & triage of buggy design (score 0/100)
# 2. mcp-rtl-review: audit of healed design (score 100/100)
# 3. mcp-verilog: simulation verification with testbench assertions
# 4. mcp-yosys: latch triage (0 latches) and gate-level synthesis (13 cells)
#
# Usage:
#   bash run_demo.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
cd "${SCRIPT_DIR}"

MCP_RTL_REVIEW="${PARENT_DIR}/mcp-rtl-review/dist/index.js"
MCP_VERILOG="${PARENT_DIR}/mcp-verilog/dist/index.js"
MCP_YOSYS="${PARENT_DIR}/mcp-yosys/dist/index.js"

echo "=========================================================================="
echo "⚡ Phase 2 End-to-End Autonomous Hardware Agent Demo"
echo "=========================================================================="
echo "Working directory: ${SCRIPT_DIR}"

# 1. Preflight checks
for server in "${MCP_RTL_REVIEW}" "${MCP_VERILOG}" "${MCP_YOSYS}"; do
  if [ ! -f "${server}" ]; then
    echo "[-] Missing built MCP server: ${server}"
    echo "    Please run 'npm run build' in its repository."
    exit 1
  fi
done

mkdir -p transcripts

cleanup() {
  rm -f "${SCRIPT_DIR}/build_sim.vvp"
}
trap cleanup EXIT

# Step 1: Audit Buggy Design
echo ""
echo "--- Step 1: Semantic Audit & Triage of Flawed RTL (mcp-rtl-review) ---"
REQ1=$(cat << JSON
{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"rtl_review","arguments":{"cwd":"${SCRIPT_DIR}","verilog_sources":["src/buggy_fifo_ctrl.v"],"top_module":"buggy_fifo_ctrl"}}}
JSON
)
RESP1=$(echo "${REQ1}" | node "${MCP_RTL_REVIEW}")
echo "${RESP1}" | jq -r '.result.content[0].text' > transcripts/01_rtl_review_buggy.json

SCORE1=$(jq -r '.score' transcripts/01_rtl_review_buggy.json)
ERR1=$(jq -r '.errors' transcripts/01_rtl_review_buggy.json)
WARN1=$(jq -r '.warnings' transcripts/01_rtl_review_buggy.json)
echo "▶ Score: ${SCORE1}/100 (Errors: ${ERR1}, Warnings: ${WARN1})"
echo "▶ Violations detected: $(jq -r '.violations | map(.ruleId) | unique | join(", ")' transcripts/01_rtl_review_buggy.json)"

# Step 2: Audit Healed Design
echo ""
echo "--- Step 2: Verification of Healed RTL (mcp-rtl-review) ---"
REQ2=$(cat << JSON
{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"rtl_review","arguments":{"cwd":"${SCRIPT_DIR}","verilog_sources":["src/clean_fifo_ctrl.v"],"top_module":"clean_fifo_ctrl"}}}
JSON
)
RESP2=$(echo "${REQ2}" | node "${MCP_RTL_REVIEW}")
echo "${RESP2}" | jq -r '.result.content[0].text' > transcripts/02_rtl_review_clean.json

SCORE2=$(jq -r '.score' transcripts/02_rtl_review_clean.json)
PASSED2=$(jq -r '.passed' transcripts/02_rtl_review_clean.json)
echo "▶ Score: ${SCORE2}/100 (Passed: ${PASSED2})"
echo "▶ Violations: $(jq -r '.totalViolations' transcripts/02_rtl_review_clean.json)"

if [ "${PASSED2}" != "true" ] || [ "${SCORE2}" -ne 100 ]; then
  echo "[-] Step 2 failed: Clean module did not receive 100/100 score"
  exit 1
fi

# Step 3: Simulation Verification
echo ""
echo "--- Step 3: Functional Simulation with Assertion Testbench (mcp-verilog) ---"
REQ3=$(cat << JSON
{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"verilog_simulate","arguments":{"cwd":"${SCRIPT_DIR}","files":["src/clean_fifo_ctrl.v","src/tb_fifo_ctrl.v"],"top_module":"tb_fifo_ctrl"}}}
JSON
)
RESP3=$(echo "${REQ3}" | node "${MCP_VERILOG}")
echo "${RESP3}" | jq -r '.result.content[0].text' > transcripts/03_verilog_simulate.json

SIM_SUCCESS=$(jq -r '.success' transcripts/03_verilog_simulate.json)
SIM_STDOUT=$(jq -r '.stdout' transcripts/03_verilog_simulate.json | head -n 1)
echo "▶ Simulation Success: ${SIM_SUCCESS}"
echo "▶ Output: ${SIM_STDOUT}"

if [ "${SIM_SUCCESS}" != "true" ]; then
  echo "[-] Step 3 failed: Simulation failed"
  exit 1
fi

# Step 4: Latch Triage & Gate-Level Synthesis
echo ""
echo "--- Step 4: Latch Triage & Synthesis (mcp-yosys) ---"
REQ4A=$(cat << JSON
{"jsonrpc":"2.0","id":4,"method":"tools/call","params":{"name":"yosys_check_latch","arguments":{"cwd":"${SCRIPT_DIR}","verilog_sources":["src/clean_fifo_ctrl.v"],"top_module":"clean_fifo_ctrl"}}}
JSON
)
RESP4A=$(echo "${REQ4A}" | node "${MCP_YOSYS}")
echo "${RESP4A}" | jq -r '.result.content[0].text' > transcripts/04_yosys_check_latch.json

HAS_LATCHES=$(jq -r '.hasLatches' transcripts/04_yosys_check_latch.json)
echo "▶ Inferred Latches: ${HAS_LATCHES}"

if [ "${HAS_LATCHES}" != "false" ]; then
  echo "[-] Step 4A failed: Inferred latches found"
  exit 1
fi

REQ4B=$(cat << JSON
{"jsonrpc":"2.0","id":5,"method":"tools/call","params":{"name":"yosys_synthesize","arguments":{"cwd":"${SCRIPT_DIR}","verilog_sources":["src/clean_fifo_ctrl.v"],"top_module":"clean_fifo_ctrl","target":"generic"}}}
JSON
)
RESP4B=$(echo "${REQ4B}" | node "${MCP_YOSYS}")
echo "${RESP4B}" | jq -r '.result.content[0].text' > transcripts/05_yosys_synthesize.json

CELL_COUNT=$(jq -r '.cellCount // (.design.num_cells)' transcripts/05_yosys_synthesize.json)
echo "▶ Synthesis Gate Count: ${CELL_COUNT} cells"
echo "▶ Cell Types: $(jq -r '.cellsByType // (.design.num_cells_by_type)' transcripts/05_yosys_synthesize.json | jq -c .)"

echo ""
echo "=========================================================================="
echo "✅ Demo Flow Succeeded! All 4 stages verified end-to-end."
echo "Transcripts recorded in: ${SCRIPT_DIR}/transcripts"
echo "=========================================================================="
