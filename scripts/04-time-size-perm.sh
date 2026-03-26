#!/usr/bin/env bash
# mtime/mmin, size, and permissions (BSD find on macOS).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=lib-demo.sh
source "$ROOT/lib-demo.sh"

D="$(demo_root)"
trap 'cleanup_demo "$D"' EXIT

touch "$D/old.txt"
sleep 1
touch "$D/new.txt"
printf '1234567890' > "$D/tenbytes.bin"
chmod 644 "$D/old.txt"
chmod 600 "$D/new.txt"
chmod +x "$D/tenbytes.bin"

echo "=== Directory: $D ==="
echo
echo "Modified in the last 5 minutes (-mmin -5):"
find "$D" -type f -mmin -5
echo
echo "Larger than 5 bytes (-size +5c; c = bytes on macOS):"
find "$D" -type f -size +5c
echo
echo "Owner-executable (-perm -100):"
find "$D" -type f -perm -100
