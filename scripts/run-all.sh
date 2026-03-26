#!/usr/bin/env bash
# Run all examples in order.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
for s in \
  "$ROOT/01-empty-and-types.sh" \
  "$ROOT/02-name-and-quotes.sh" \
  "$ROOT/03-depth-prune.sh" \
  "$ROOT/04-time-size-perm.sh" \
  "$ROOT/05-exec-print0.sh"
do
  echo "########################################"
  echo "# $(basename "$s")"
  echo "########################################"
  bash "$s"
  echo
done
