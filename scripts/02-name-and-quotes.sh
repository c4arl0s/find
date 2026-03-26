#!/usr/bin/env bash
# Names: quote patterns with * so the shell does not expand them.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=lib-demo.sh
source "$ROOT/lib-demo.sh"

D="$(demo_root)"
trap 'cleanup_demo "$D"' EXIT

mkdir -p "$D/a"
touch "$D/report_Q1.ppt" "$D/notes.txt" "$D/a/backup_Q1.ppt"

echo "=== Directory: $D ==="
echo
echo "Files whose name contains Q1 (correct: quoted pattern):"
find "$D" -type f -name '*Q1*'
echo
echo "Directories (recommended: -type before -name):"
find "$D" -type d -name 'a'
echo
echo "Without quotes, the shell may expand * before find (can fail or surprise):"
# Deliberately unquoted on the next line to illustrate the risk:
set +e
# shellcheck disable=SC2061,SC2035
find "$D" -type f -name *Q1* 2>&1 || true
set -e
