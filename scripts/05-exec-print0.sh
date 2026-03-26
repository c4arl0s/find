#!/usr/bin/env bash
# -exec and paths with spaces: -print0 and safe iteration (macOS).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=lib-demo.sh
source "$ROOT/lib-demo.sh"

D="$(demo_root)"
trap 'cleanup_demo "$D"' EXIT

mkdir -p "$D/with spaces"
touch "$D/with spaces/file one.txt" "$D/normal.txt"

echo "=== Directory: $D ==="
echo
echo "List with -exec ({} is replaced with the path; \\; runs one command per file):"
find "$D" -type f -exec basename {} \;
echo
echo "Paths with spaces: -print0 and read -d '' (robust alternative to xargs -0):"
while IFS= read -r -d '' f; do ls -la "$f"; done < <(find "$D" -type f -print0)
