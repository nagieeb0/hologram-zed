#!/usr/bin/env bash
# Smallest thing that fails if the grammar or the queries break.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GRAMMAR="${HOLO_GRAMMAR:-$HERE/../tree-sitter-holo}"
TS="${TS:-npx --yes tree-sitter-cli@0.25.10}"

cd "$GRAMMAR"
$TS test

out=$($TS parse "$HERE/test/sample.holo")
if grep -qE 'ERROR|MISSING' <<<"$out"; then
  echo "FAIL: parse errors in test/sample.holo"; grep -nE 'ERROR|MISSING' <<<"$out"; exit 1
fi
echo "ok   parse (no ERROR/MISSING nodes)"

for q in highlights injections brackets indents outline overrides; do
  if ! $TS query "$HERE/languages/holo/$q.scm" "$HERE/test/sample.holo" >/dev/null 2>&1; then
    echo "FAIL: $q.scm does not match the grammar"; exit 1
  fi
  echo "ok   $q.scm"
done
