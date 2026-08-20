# hologram-zed

HOLO template language support for [Hologram](https://hologram.page) in [Zed](https://zed.dev).
Feature port of the official [hologram_vscode](https://github.com/bartblast/hologram_vscode)
extension.

Zed has no TextMate support, so the VS Code grammar could not be reused. This extension
ships [tree-sitter-holo](https://github.com/nagieeb0/tree-sitter-holo), a grammar whose
node names mirror the VS Code TextMate scopes one for one.

## Install

```sh
git clone https://github.com/nagieeb0/hologram-zed
cd hologram-zed
./scripts/patch-elixir-sigil.sh    # ~HOLO sigils in .ex files — see below
```

Then in Zed: command palette → **zed: extensions** → **Install Dev Extension** → pick the
`hologram-zed` folder. Zed fetches and compiles the grammar itself (the first build
downloads its wasi toolchain). Restart Zed and open `test/sample.holo`.

## Parity with the VS Code extension

| Feature | VS Code | Zed |
|---|---|---|
| `.holo` files | ✅ | ✅ |
| `~HOLO` sigils in `.ex` | ✅ | ✅ via `scripts/patch-elixir-sigil.sh` |
| Tags, attributes, `=`, quoted values | ✅ | ✅ |
| Components `<Layout.Default>` | ✅ | ✅ |
| Event bindings `$click`, `$change` | ✅ | ✅ |
| `{…}` expressions → Elixir | ✅ | ✅ |
| `{%if …}` `{%else}` `{/if}` | ✅ | ✅ keyword + Elixir condition |
| `{%for … <- …}` `{/for}` | ✅ | ✅ keyword + Elixir generator |
| `{%raw}` … `{/raw}` literal | ✅ | ✅ |
| `<style>` → CSS | ✅ | ✅ |
| `<script>` → JS, with `{…}` expressions | ✅ | ✅ |
| `\{ \} \# \$` escapes | ✅ | ✅ |
| Doctype, comments | ✅ | ✅ |
| Brackets, auto-close, comment toggle | ✅ | ✅ |
| Void elements `<br>` `<img …>` | — | ✅ |
| Bracket matching, indent, outline | — | ✅ |

## `~HOLO` sigils

A Zed extension cannot add injections to a language it does not own, so the sigil rule is
appended to the installed Elixir extension's `injections.scm`:

```scm
((sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content)
  (#eq? @_sigil_name "HOLO")
  (#set! injection.language "holo"))
```

`scripts/patch-elixir-sigil.sh` is idempotent — re-run it whenever the Elixir extension
updates, since updates overwrite that file.

## Development

```sh
./scripts/check.sh          # grammar corpus tests + query/grammar agreement
```

Changing the grammar means editing
[tree-sitter-holo](https://github.com/nagieeb0/tree-sitter-holo), pushing it, then
updating `commit` under `[grammars.holo]` in `extension.toml`.

If you change the grammar's `repository` URL, delete the cached checkout first —
`rm -rf grammars/` — otherwise Zed fails with *"grammar directory … already exists, but
is not a git clone of …"*.

## Requirements

The [Elixir extension](https://github.com/zed-extensions/elixir), for Elixir highlighting
inside `{…}` expressions and for the `~HOLO` sigil patch.

## License

Apache-2.0, matching the upstream VS Code extension this is ported from.
