(expression
  "{" @open
  "}" @close)

(start_tag
  "<" @open
  ">" @close
  (#set! rainbow.exclude))

(end_tag
  "</" @open
  ">" @close
  (#set! rainbow.exclude))

(self_closing_tag
  "<" @open
  "/>" @close
  (#set! rainbow.exclude))

(element
  (start_tag) @open
  (end_tag) @close
  (#set! newline.only)
  (#set! rainbow.exclude))

(start_component
  "<" @open
  ">" @close
  (#set! rainbow.exclude))

(end_component
  "</" @open
  ">" @close
  (#set! rainbow.exclude))

(self_closing_component
  "<" @open
  "/>" @close
  (#set! rainbow.exclude))

(component
  (start_component) @open
  (end_component) @close
  (#set! newline.only)
  (#set! rainbow.exclude))

(if_block
  (if_open) @open
  (if_close) @close
  (#set! newline.only))

(for_block
  (for_open) @open
  (for_close) @close
  (#set! newline.only))

(raw_block
  (raw_open) @open
  (raw_close) @close
  (#set! newline.only))
