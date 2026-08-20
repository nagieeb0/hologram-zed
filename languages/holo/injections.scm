; {elixir}
(expression
  (expression_value) @injection.content
  (#set! injection.language "elixir"))

; {%if elixir} / {%for elixir}
(if_open
  (expression_value) @injection.content
  (#set! injection.language "elixir"))

(for_open
  (expression_value) @injection.content
  (#set! injection.language "elixir"))

; <style>…</style>
(style_element
  (raw_text) @injection.content
  (#set! injection.language "css"))

; <script>…</script> — combined, because `{...}` expressions split the JS
(script_element
  (raw_text) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.combined))

; style="…"
(attribute
  (attribute_name) @_attribute_name
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#eq? @_attribute_name "style")
  (#set! injection.language "css"))

; onEVENT="…"
(attribute
  (attribute_name) @_attribute_name
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#match? @_attribute_name "^on[a-z]+$")
  (#set! injection.language "javascript"))

((comment) @injection.content
  (#set! injection.language "comment"))
