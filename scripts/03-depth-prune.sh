#!/usr/bin/env bash
# Depth and pruning (-maxdepth, -prune). Both work on macOS.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=lib-demo.sh
source "$ROOT/lib-demo.sh"

D="$(demo_root)"
trap 'cleanup_demo "$D"' EXIT

mkdir -p "$D/src" "$D/node_modules/pkg" "$D/src/lib"
touch "$D/root.js" "$D/src/app.js" "$D/node_modules/pkg/index.js" "$D/src/lib/util.js"

echo "=== Directory: $D ==="
echo
echo "Only this depth (no deep recursion):"
find "$D" -maxdepth 1 -type f
echo
echo "Recursive but do not descend into node_modules:"
find "$D" \( -path "$D/node_modules" -o -path "$D/node_modules/*" \) -prune -o -type f -print
