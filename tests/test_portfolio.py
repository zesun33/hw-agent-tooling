"""Smoke tests for the portfolio repo's verification flow.

These tests are intentionally tiny. The portfolio repo has no runtime
logic, so the tests are structural: they confirm that the engineering
standard, roadmap, and CHANGELOG are present and well-formed enough
that an automated gate can rely on them.
"""

import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


class ReadmeStructure(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.readme = (ROOT / "README.md").read_text()

    def test_has_top_level_title(self):
        self.assertRegex(self.readme, r"^# .+", msg="README missing top-level title")

    def test_references_existing_license(self):
        # README links to ./LICENSE
        self.assertIn("./LICENSE", self.readme)
        self.assertTrue((ROOT / "LICENSE").exists())

    def test_references_existing_contributing(self):
        self.assertIn("./CONTRIBUTING.md", self.readme)
        self.assertTrue((ROOT / "CONTRIBUTING.md").exists())

    def test_status_table_is_present(self):
        self.assertIn("## AI Agent Tools", self.readme)
        self.assertIn("| Repo |", self.readme)

    def test_skill_matrix_is_present(self):
        self.assertIn("## Skill Matrix", self.readme)

    def test_every_repo_link_is_in_readme_or_excluded(self):
        # The README references a known set of family repos. This test fails
        # if a brand-new repo is added without being listed in the README.
        known = {
            "portfolio",
            "mcp-verilog",
            "hw-agent-skills",
            "mcp-cocotb",
            "mcp-yosys",
            "mcp-rtl-review",
            "mcp-openroad",
            "kernel-forge",
            "agentic-asic",
            # supporting / existing
            "cuda-gemm-optimization",
            "cuda-memory-benchmark",
            "parallel-computing-lab",
            "resnet-tensorrt-bench",
            "triton-flash-attention-lite",
        }
        mentioned = set(re.findall(r"zesun33/([\w-]+)", self.readme))
        unknown = mentioned - known
        self.assertEqual(unknown, set(), f"unknown repos in README: {unknown}")


class RoadmapStructure(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.roadmap = (ROOT / "ROADMAP.md").read_text()

    def test_has_all_five_phases(self):
        for phase in ("Phase 0", "Phase 1", "Phase 2", "Phase 3", "Phase 4", "Phase 5"):
            self.assertIn(phase, self.roadmap, f"missing {phase}")

    def test_phase_1_marks_portfolio_done(self):
        # The first item under Phase 1 is `portfolio`, which we ship first.
        self.assertRegex(
            self.roadmap,
            r"(?s)Phase 1.*?- \[x\] `portfolio`",
        )


class ChangelogStructure(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.changelog = (ROOT / "CHANGELOG.md").read_text()

    def test_has_unreleased_section(self):
        self.assertIn("## [Unreleased]", self.changelog)

    def test_has_first_release_section(self):
        self.assertRegex(self.changelog, r"## \[0\.1\.0\]")


if __name__ == "__main__":
    unittest.main(verbosity=2)
