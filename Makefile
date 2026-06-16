# Makefile — convenience targets for the portfolio repo.
# The real verification logic lives in scripts/verify.sh.
# This file is a thin wrapper for ergonomics.

SHELL := /usr/bin/env bash

.PHONY: help verify verify-quick lychee lint test clean

help:
	@echo "Targets:"
	@echo "  make verify         Run all 10 verification gates (incl. network)."
	@echo "  make verify-quick   Run all gates except network (lychee)."
	@echo "  make lint           Lint markdown only."
	@echo "  make test           Run unit tests only."
	@echo "  make lychee         Run link check only."

verify:
	bash scripts/verify.sh

verify-quick:
	bash scripts/verify.sh --quick

lint:
	npx --yes markdownlint-cli2 "**/*.md"

test:
	python3 -m unittest discover -s tests -p "test_*.py" -v

lychee:
	lychee --config .lychee/config.toml --no-progress README.md

clean:
	rm -rf .pytest_cache/ .mypy_cache/ .ruff_cache/ __pycache__/
	find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
