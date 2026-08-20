#!/usr/bin/env bash
# Teach the installed Zed Elixir extension to highlight ~HOLO sigils as HOLO.
# Zed extensions cannot add injections to a language they do not own, so this
# appends to the Elixir extension's own query file. Idempotent; re-run after
# the Elixir extension updates (updates overwrite the file).
set -euo pipefail

TARGET="${ZED_ELIXIR_INJECTIONS:-$HOME/.local/share/zed/extensions/installed/elixir/languages/elixir/injections.scm}"

[ -f "$TARGET" ] || { echo "not found: $TARGET (is the Zed Elixir extension installed?)" >&2; exit 1; }

if grep -q '"HOLO"' "$TARGET"; then
  echo "already patched: $TARGET"
  exit 0
fi

cat >> "$TARGET" <<'EOF'

; Hologram HOLO template sigil
((sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content)
  (#eq? @_sigil_name "HOLO")
  (#set! injection.language "holo"))
EOF
echo "patched: $TARGET  (restart Zed)"
