#!/usr/bin/env bash
# Empty files and types (-type f, d, l). macOS: BSD find.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=lib-demo.sh
source "$ROOT/lib-demo.sh"

D="$(demo_root)"
trap 'cleanup_demo "$D"' EXIT

mkdir -p "$D/project/docs"
touch "$D/project/empty.txt"
echo "hello" > "$D/project/docs/readme.md"
ln -s "$D/project/docs/readme.md" "$D/project/link-to-readme"

echo "=== Demo directory: $D ==="
echo
echo "Empty files (-type f -empty):"
find "$D" -type f -empty
echo
echo "Directories only (-type d):"
find "$D" -type d
echo
echo "Symbolic links (-type l):"
find "$D" -type l
