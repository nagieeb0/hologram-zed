[
  (start_tag
    ">" @end)
  (self_closing_tag
    "/>" @end)
  (start_component
    ">" @end)
  (self_closing_component
    "/>" @end)
] @indent

[
  (element
    (start_tag) @start
    (end_tag)? @end)
  (component
    (start_component) @start
    (end_component)? @end)
  (if_block
    (if_open) @start
    (if_close)? @end)
  (for_block
    (for_open) @start
    (for_close)? @end)
] @indent
