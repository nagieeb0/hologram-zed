; Block keywords: {%if …} {%else} {/if} {%for …} {/for} {%raw} {/raw}
[
  "{%if"
  "{%for"
  (else_tag)
  (if_close)
  (for_close)
  (raw_open)
  (raw_close)
] @keyword

; Tag delimiters
[
  "<"
  "</"
  ">"
  "/>"
  "<!"
] @punctuation.bracket

; Expression delimiters
[
  "{"
  "}"
] @punctuation.bracket

"=" @punctuation.delimiter

(comment) @comment

(doctype_name) @tag.doctype

(doctype_value) @string

(tag_name) @tag

; Components are Elixir module aliases: <Layout.Default>, <UI.Button>
(component_name) @type

; Event bindings: $click, $change, $submit, …
(event_attribute_name) @keyword

(attribute_name) @attribute

[
  (attribute_value)
  (quoted_attribute_value)
] @string

; Contents of {%raw} … {/raw} are literal
(raw_content) @string

; \{ \} \# \$
(escape_sequence) @string.escape
