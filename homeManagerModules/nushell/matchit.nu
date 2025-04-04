const kb_config = {
  name: matchit_keybinding
  modifier: none
  keycode: 'char_%'
  mode: [vi_normal]
  event: {
    send: executehostcommand
    cmd: matchit_exec
  }
}
const delimiter_pairs = {
  "'": "$'"
  '"': '$"'
  "$'": "'"
  '$"': '"'
  (char lbrace): (char rbrace)
  (char lparen): (char rparen)
  (char lbracket): (char rbracket)
  (char rbrace): (char lbrace)
  (char rparen): (char lparen)
  (char rbracket): (char lbracket)
}
const pattern = '_(block|list|closure|record|string_interpolation)$'

use lib.nu substring_to_idx

def _find_matching_node [
  nodes: list<record> # ast nodes
  offset: int # offset of cursor position
] {
  mut matching_pair = {}
  mut stack = []
  for node in $nodes {
    if $node.shape =~ $pattern {
      let leading_space_count = $node.content
      | split chars
      | take while { $in in [' ' "\n"] }
      | length
      let d = if $node.shape == 'shape_string_interpolation' {
        $node.content
      } else { $node.content | str trim | str substring ..0 }
      let end = $node.span.start + $leading_space_count
      if $d not-in $delimiter_pairs { continue }
      let d_p = $delimiter_pairs | get $d
      if ($stack | is-not-empty) and ($stack | last | get d) == $d_p {
        let start = $stack | last | get pos
        $matching_pair = $matching_pair
        | merge {$start: $end $end: $start}
        $stack = $stack | drop
      } else {
        $stack = $stack
        | append {d: $d pos: $end}
      }
    }
  }
  ($matching_pair | get -i $'($offset)' | default (-1)) + 1
}

export def matchit_exec [] {
  let cursor_pos = commandline get-cursor
  let cmd_raw = commandline
  let offset = $cmd_raw
  | substring_to_idx -g ($cursor_pos - 1)
  | str length # grapheme to byte
  let nodes = ast -f $cmd_raw
  let node_at_cursor = $nodes
  | where span.start <= $offset and span.end > $offset
  if ($node_at_cursor | is-empty) {
    print "Do it on delimiters."
    return null
  }
  let node_at_cursor = $node_at_cursor | first

  let matched_offset = if $node_at_cursor.shape == 'shape_string' {
    let distance_to_start = $offset - $node_at_cursor.span.start | math abs
    let distance_to_end = $offset - $node_at_cursor.span.end | math abs
    if $distance_to_start < $distance_to_end {
      $node_at_cursor.span.end
    } else { $node_at_cursor.span.start + 1 }
  } else if $node_at_cursor.shape =~ $pattern {
    _find_matching_node $nodes $offset
  } else 0

  let matched_grapheme = $cmd_raw
  | substring_to_idx ($matched_offset - 1)
  | str length -g
  commandline set-cursor $matched_grapheme
}

export def --env "set matchit_keybinding" [] {
  $env.config.keybindings ++= [$kb_config]
}
