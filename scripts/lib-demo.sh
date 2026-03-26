#!/usr/bin/env bash
# Shared helpers for the find examples (macOS / bash).

set -euo pipefail

demo_root() {
  local base
  base="$(mktemp -d "${TMPDIR:-/tmp}/find-demo.XXXXXX")"
  echo "$base"
}

cleanup_demo() {
  local dir="${1:-}"
  [[ -n "$dir" && -d "$dir" ]] && rm -rf "$dir"
}
