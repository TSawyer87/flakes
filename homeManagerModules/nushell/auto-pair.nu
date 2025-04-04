const auto_pair_key_maps = {
  `'`: {left: `'` right: `'`}
  `"`: {left: `"` right: `"`}
  '`': {left: '`' right: '`'}
  (char lbrace): {left: (char lbrace) right: (char rbrace)}
  (char lparen): {left: (char lparen) right: (char rparen)}
  (char lbracket): {left: (char lbracket) right: (char rbracket)}
  (char rbrace): {left: (char lbrace) right: (char rbrace)}
  (char rparen): {left: (char lparen) right: (char rparen)}
  (char rbracket): {left: (char lbracket) right: (char rbracket)}
}
const kb_template = {
  name: ''
  modifier: none
  keycode: ''
  mode: [emacs vi_insert]
  event: {
    send: executehostcommand
    cmd: ''
  }
}
const auto_pair_backspace_binding = {
  name: auto_pair_backspace
  modifier: none
  keycode: backspace
  mode: [emacs vi_insert]
  event: {
    send: executehostcommand
    cmd: auto_pair_backspace
  }
}
const keys_to_bind = [
  `'`
  `"`
  '`'
  (char lparen)
  (char rparen)
  (char lbracket)
  (char rbracket)
  (char lbrace)
  (char rbrace)
]
use lib.nu substring_to_idx

def is_pair_matched [
  char_list: list<string>
  char: string
] {
  let kp = $auto_pair_key_maps | get -i $char
  if $kp.left == $kp.right {
    # for '"`
    let occurrence = $char_list
    | where {|it| $it == $char }
    | length
    ($occurrence mod 2) == 0
  } else {
    # for ([{
    mut count = 0
    for it in $char_list {
      if $it == $kp.left {
        $count += 1
      } else if $it == $kp.right {
        $count -= 1
        if $count < 0 {
          return false
        }
      }
    }
    $count == 0
  }
}

def analyse_commandline [] {
  let cmd_raw = commandline
  let cursor_pos = commandline get-cursor
  let all_chars = $cmd_raw | split chars
  let char_next = $all_chars | get -i $cursor_pos | default ''

  let char_current = (
    $all_chars
    | get -i (
      [($cursor_pos - 1) 0]
      | math max
    ) | default ' '
  )
  {
    cmd_raw: $cmd_raw
    cursor_pos: $cursor_pos
    char_next: $char_next
    char_current: $char_current
    all_chars: $all_chars
  }
}

def backspace_delete_by_replace [
  cmd_raw: string
  pos: int
  left_offset: int
  right_offset: int
] {
  let new_cmd = (
    $cmd_raw
    | substring_to_idx ($pos - $left_offset - 1)
  ) + (
    $cmd_raw
    | str substring ($pos + $right_offset)..
  )
  commandline edit --replace $new_cmd
  commandline set-cursor ($pos - $left_offset)
}

export def auto_pair_backspace [] {
  let cmd_info = analyse_commandline
  let need_check = $auto_pair_key_maps
  | transpose
  | any {|r|
    (
      $cmd_info.char_current == $r.column1.left and $cmd_info.char_next == $r.column1.right
    )
  }
  if $need_check and (
    is_pair_matched
    $cmd_info.all_chars $cmd_info.char_current
  ) {
    (
      backspace_delete_by_replace
      $cmd_info.cmd_raw
      $cmd_info.cursor_pos 1 1
    )
  } else {
    (
      backspace_delete_by_replace
      $cmd_info.cmd_raw
      $cmd_info.cursor_pos 1 0
    )
  }
}

export def auto_pair_complete [
  char: string # which key is pressed
] {
  let key_pairs = $auto_pair_key_maps | get -i $char
  if ($key_pairs | is-empty) {
    # unknown key
    commandline edit --insert $char
    return
  }
  let left_char = $key_pairs.left
  let right_char = $key_pairs.right
  let which_side = match [
    ($left_char == $char)
    ($right_char == $char)
  ] {
    [true true] => 'both'
    [true false] => 'left'
    [false true] => 'right'
    _ => 'none'
  }
  let cmd_info = analyse_commandline
  let is_matched = is_pair_matched $cmd_info.all_chars $char
  let operation = (
    match $which_side {
      'right' if $is_matched and ($char == $cmd_info.char_next) => 'move'
      'both' if $char == $cmd_info.char_next => 'move'
      'both' if $is_matched and ($cmd_info.char_next in "'`\" ") => 'pair'
      'left' if $is_matched and ($cmd_info.char_next in ' ') => 'pair'
      _ => 'default'
    }
  )
  match $operation {
    'move' => { commandline set-cursor ($cmd_info.cursor_pos + 1) }
    'pair' => {
      commandline edit --insert $"($left_char)($right_char)"
      commandline set-cursor ($cmd_info.cursor_pos + 1)
    }
    _ => { commandline edit --insert $char }
  }
}

export def --env "set auto_pair_keybindings" [] {
  let new_kbs = $keys_to_bind
  | each {|k|
    $kb_template
    | update name $"auto_pair_key_($k)"
    | update keycode $"char_($k)"
    | update event.cmd $"auto_pair_complete r#'($k)'#"
  }
  $env.config.keybindings ++= [
    ...$new_kbs
    # $auto_pair_backspace_binding
  ]
}
