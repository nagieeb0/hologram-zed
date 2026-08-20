#!/usr/bin/env bash
# Smallest thing that fails if the grammar, the queries, or config.toml drift apart.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GRAMMAR="${HOLO_GRAMMAR:-$HERE/../tree-sitter-holo}"
TS="${TS:-npx --yes tree-sitter-cli@0.25.10}"
LANG_DIR="$HERE/languages/holo"

cd "$GRAMMAR"
$TS test

out=$($TS parse "$HERE/test/sample.holo")
if grep -qE 'ERROR|MISSING' <<<"$out"; then
  echo "FAIL: parse errors in test/sample.holo"; grep -nE 'ERROR|MISSING' <<<"$out"; exit 1
fi
echo "ok   parse (no ERROR/MISSING nodes)"

for q in highlights injections brackets indents outline overrides; do
  if ! $TS query "$LANG_DIR/$q.scm" "$HERE/test/sample.holo" >/dev/null 2>&1; then
    echo "FAIL: $q.scm does not match the grammar"; exit 1
  fi
  echo "ok   $q.scm"
done

# Zed refuses to load a language whose [overrides.X] has no @X in overrides.scm.
captures=$(grep -oE '@[a-z_.]+' "$LANG_DIR/overrides.scm" | tr -d '@' | sort -u)
for scope in $(grep -oE '^\[overrides\.[a-z_]+\]' "$LANG_DIR/config.toml" | sed -E 's/^\[overrides\.(.*)\]$/\1/'); do
  if ! grep -qx "$scope" <<<"$captures"; then
    echo "FAIL: config.toml has [overrides.$scope] but overrides.scm has no @$scope"; exit 1
  fi
  echo "ok   overrides.$scope"
done
