const fzf_carapace_extra_args = [--exit-0 --read0 --ansi --no-tmux --height=30%]
const fzf_window_first_column_max_length = 25
const fd_default_args = [--hidden --exclude .git --exclude .cache --max-depth 9]
const fd_executable_args = [--exclude .git --exclude .cache --hidden --max-depth 5 --type x --color always '']
const carapace_preview_description = true
const manpage_preview_cmd = 'man {} | col -bx | bat -l man -p --color=always --line-range :200'
const dir_preview_cmd = "eza --tree -L 3 --color=always {} | head -200"
const file_preview_cmd = "bat -n --color=always --line-range :200 {}"
const process_preview_cmd = 'ps | where pid == ({1} | into int) | transpose Property Value | table -i false'
const remote_preview_cmd = "dig {} | jc --dig | from json | get -i answer.0 | table -i false"
const default_preview_cmd = "if ({} | path type) == 'dir'" + $" {($dir_preview_cmd)} else {($file_preview_cmd)}"
const help_preview_cmd = "$env.config.use_ansi_coloring = true; try {help {1}} catch {'custom command or alias'}"
const external_tldr_cmd = "try {tldr -c {1}} catch {'No doc yet'}"
const hybrid_help_cmd = $"if {2} == 'EXTERNAL' {($external_tldr_cmd)} else {($help_preview_cmd)}"
const fzf_prompt_default_setting = {
  fg: '#000000'
  bg: '#c0caf5'
  symbol: ''
}
const fzf_prompt_info = {
  Carapace: {bg: '#1d8f8f' symbol: '󰳗'}
  Variable: {symbol: '󱄑'}
  Directory: {symbol: ''}
  File: {symbol: '󰈔'}
  Remote: {symbol: '󰛳'}
  Process: {symbol: ''}
  Command: {symbol: ''}
  Manpage: {bg: '#f7768e' symbol: '󰙃'}
  Internals: {bg: '#0dcf6f' symbol: ''}
  Externals: {bg: '#7aa2f7' symbol: ''}
}
use lib.nu [
  substring_from_idx
  substring_to_idx
]

def get_variable_by_name [
  name: string # $foo.bar style
] {
  let segs = $name
  | split row '.'
  mut content = {
    '$env': $env
    '$nu': $nu
  }
  for var in (scope variables) {
    $content = $content
    | default $var.value $var.name
  }
  try {
    for seg in $segs {
      if ($content | describe | str starts-with 'list') {
        $content = $content
        | get ($seg | into int)
      } else {
        $content = $content
        | get $seg
      }
    }
  } catch { {} }
  $content
}

def _quote_if_not_empty [] {
  if ($in | str trim | is-empty) { '' } else { $"`($in)`" }
}

export def prompt_decorator [
  fg_color: string
  bg_color: string
  symbol: string
  type: string
] {
  let fg = {fg: $bg_color}
  let bg = {fg: $fg_color bg: $bg_color}
  $"(ansi --escape $bg)▓▒░ ($type) ($symbol)(ansi reset)(ansi --escape $fg)(ansi reset) "
}

def _build_fzf_prompt [
  key: string
] {
  let prompt_config = $fzf_prompt_info
  | get -i $key
  | default {}
  | default $fzf_prompt_default_setting.fg fg
  | default $fzf_prompt_default_setting.bg bg
  | default $fzf_prompt_default_setting.symbol symbol
  (
    prompt_decorator
    $prompt_config.fg
    $prompt_config.bg
    $prompt_config.symbol
    $key
  )
}

def _build_fzf_args [
  query: string
  prompt_key?: string
  preview_cmd?: string
] {
  mut args = [-q $query]
  if ($preview_cmd | is-not-empty) {
    $args = $args
    | append [--preview $preview_cmd]
  }

  if ($prompt_key | is-not-empty) {
    $args = $args
    | append [--prompt (_build_fzf_prompt $prompt_key)]
  }
  $args
}

def _padding_to_length [input_string: string length?: int] {
  let length = $length | default $fzf_window_first_column_max_length
  $input_string | fill -a l -w $length
}

def _two_column_item [
  item1: string
  item2: string
  style1?: string = (ansi yellow_reverse)
  style2?: string = (ansi purple_reverse)
] {
  $"($style1)(_padding_to_length $item1)\t\t($style2)($item2)(ansi reset)"
}

def _list_internal_commands [] {
  scope commands
  | get name
  | uniq
}

def _list_external_commands [] {
  $env.PATH
  | par-each {
    if ($in | path exists) {
      ls -s $in | get name
    } else []
  }
  | flatten
  | uniq
}

# Load full list of available manpage names from carapace zsh bridge (more thorough than apropos)
# and save to $env.MANPAGECACHE for further completion
export def update_manpage_cache [
  --force (-f) # force update if the file already exists
  --silent (-s) # print no message if set
]: nothing -> string {
  let cache_fp = $env | get -i 'MANPAGECACHE'
  if ($cache_fp | is-empty) {
    if not $silent {
      print '$env.MANPAGECACHE should be set before using this command.'
    }
    return null
  }
  if not ($cache_fp | path dirname | path exists) {
    mkdir ($cache_fp | path dirname)
  }
  if not ($cache_fp | path exists) or $force {
    carapace --macro bridge.Zsh man ''
    | from json | get values.value
    | uniq | str join "\n"
    | save -f $cache_fp
  } else {
    if not $silent {
      print 'File already exists, force rewrite by passing --force (-f) flag.'
    }
  }
  $cache_fp
}

# Do a fzf search of misc contents accroding to current command
def _complete_by_fzf [
  cmd: string # command whose arguments need to complete at present
  query: string # preceding string to search for
]: nothing -> string {
  match $cmd {
    # Search for internal commands
    _ if ($cmd in ['**' 'view']) => {
      _list_internal_commands
      | str join "\n"
      | fzf ...(
        _build_fzf_args ($query | str trim -c '*') 'Internals'
        $help_preview_cmd
      )
    } # Search for external commands
    '*^' => {
      _list_external_commands
      | str join "\n"
      | fzf ...(_build_fzf_args '' 'Externals' $external_tldr_cmd)
    }
    'man' => {
      let cache_fp = update_manpage_cache --silent
      if ($cache_fp | is-empty) {
        ''
      } else {
        open $cache_fp
        | fzf ...(_build_fzf_args $query 'Manpage' $manpage_preview_cmd)
      }
    }
    '' => {
      let dirname = ($query + (char nul)) | path dirname
      # search for executable in path
      if ($dirname | path exists) {
        fd ...$fd_executable_args $dirname
        | (
          fzf ...(_build_fzf_args ($query | path basename) 'File' $file_preview_cmd)
          --ansi --no-tmux --preview-window down,50%
        )
        | ansi strip
      } else {
        # combine internals and externals
        _list_internal_commands
        | par-each { _two_column_item $in 'NUSHELL_INTERNAL' '' (ansi green_italic) }
        | append (
          _list_external_commands
          | par-each { _two_column_item $in 'EXTERNAL' '' (ansi blue_italic) }
        )
        | str join "\n"
        | (
          fzf --ansi --header (_two_column_item 'Command' 'Type')
          ...(_build_fzf_args $query 'Command' $hybrid_help_cmd)
        )
        | split row "\t"
        | get -i 0
        | default $query
        | str trim
      }
    }
    _ if ($cmd in ['z' '__zoxide_z' 'cd' 'zoxide']) => {
      fd --type=d --strip-cwd-prefix ...$fd_default_args
      | fzf ...(_build_fzf_args $query 'Directory' $dir_preview_cmd)
      | _quote_if_not_empty
    }
    "kill" => {
      ps
      | par-each { $"($in.pid)\t($in.name)" }
      | str join "\n"
      | fzf ...(_build_fzf_args $query 'Process' $process_preview_cmd)
      | split row "\t" | get -i 0
    }
    "ssh" => {
      let ssh_known_host_fp = $env.HOME | path join '.ssh' 'known_hosts'
      let parsed = $query | parse --regex '^(?<username>(.*@){0,1})(?<host_query>.*)'
      ($parsed | get 0.username | default '') + (
        if ($ssh_known_host_fp | path exists) {
          cat $ssh_known_host_fp
          | lines
          | each {
            $in
            | split column ' '
            | get -i 0.column1
            | str replace -r '.*\[(.+)\].*' '$1'
          }
          | uniq
          | str join "\n"
          | fzf ...(
            _build_fzf_args
            $parsed.0.host_query
            'Remote'
            $remote_preview_cmd
          )
        } else ''
      )
    }
    _ if ($cmd in ['use' 'source']) => {
      $env.NU_LIB_DIRS
      | append $nu.default-config-dir
      | par-each { try { glob ($in | path join '**' '*.nu') } catch { [] } }
      | flatten
      | uniq
      | str join "\n"
      | fzf ...(_build_fzf_args $query 'File' ($file_preview_cmd + " -l zsh"))
    }
    _ => {
      # keep ~/foo/ all in parent, make stem empty
      let path_info = ($query + (char nul)) | path parse
      let base_dir = if ($path_info.parent | is-empty) {
        '.'
      } else $path_info.parent
      if (not ($base_dir | path exists)) {
        return null
      }
      nu -c ([fd ...$fd_default_args . $base_dir] | str join " ")
      | fzf --multi ...(
        _build_fzf_args
        (
          $path_info.stem
          | str trim -r -c (char nul)
          | str trim -r -c "*"
        )
        'File'
        $default_preview_cmd
      )
      | split row "\n"
      | each { $in | _quote_if_not_empty }
      | str join ' '
    }
  }
}

def _final_spans_for_carapace [spans: list<string>] {
  $spans
  | drop 1
  | append (
    $spans
    | last
    | str replace -r '\w*$' ''
  )
}

# post process for multi selected items
# select the first column if is a table
# ansi strip
def _fzf_post_process [] {
  let lines = $in
  if ($lines | is-empty) { return null }
  let lines = $lines
  | split row "\n"
  | each {
    $in
    | split row "\t"
    | get -i 0
    | ansi strip
    | str trim
  }
  # multiple items only triggered for files
  (
    if ($lines | length) > 1 {
      $lines
      | each {
        $in | _quote_if_not_empty
      }
    } else { $lines }
  )
  | str join ' '
}

def _carapace_by_fzf [command: string spans: list<string>] {
  let query = $spans | last
  let carapace_completion = carapace $command nushell ...(_final_spans_for_carapace $spans)
  | from json
  match ($carapace_completion | length) {
    0 => null
    1 => $carapace_completion.0.value
    _ if $carapace_preview_description => (
      $carapace_completion
      | par-each {
        let value_style = ansi --escape ($in | get -i style | default {fg: yellow})
        $"($value_style)($in.value)(ansi reset)"
      }
      | str join (char nul)
      | (
        fzf ...(_build_fzf_args $query 'Carapace')
        ...($fzf_carapace_extra_args)
        --preview (
          $"const raw = ($carapace_completion | to json); " +
          `$"(ansi purple_reverse)Description:(ansi reset) " + ` +
          `($raw | where value == ({} | ansi strip) | get -i 0.description | default '')`
        )
        --preview-window top,10%
        ...(_carapace_git_diff_preview $spans)
      )
      | _fzf_post_process
      | default $query
    )
    _ => (
      $carapace_completion
      | par-each {
        let value_style = ansi --escape ($in | get -i style | default {fg: yellow})
        (
          _two_column_item
          $in.value # drop items with no value field
          ($in | get -i description | default '')
          $value_style
          (ansi purple_italic)
        )
      }
      | str join (char nul)
      | (
        fzf ...(_build_fzf_args $query 'Carapace')
        --header (_two_column_item 'Value' 'Description')
        ...($fzf_carapace_extra_args)
        ...(_carapace_git_diff_preview $spans)
      )
      | _fzf_post_process
      | default $query
    )
  }
}

def _env_by_fzf [
  query: string
  use_carapace?: bool = false
] {
  if not ('$' in $query) {
    return null
  }
  let parsed = $query | parse --regex '(?<prefix>.*)(?<true_query>\$[^$]*)'
  let prefix = $parsed.0.prefix
  let true_query = $parsed.0.true_query
  if $use_carapace {
    let res = _carapace_by_fzf 'get-env' [get-env ($true_query | str substring 1..)]
    if ($res | is-empty) { $query } else { $prefix + '$env.' + $res }
  } else {
    let segs = $true_query | split row '.'
    let seg_prefix = $segs | drop 1 | append '' | str join '.'
    let content = get_variable_by_name $seg_prefix
    let res = (
      match ($content | describe | str substring 0..4) {
        'list<' => {
          0..(($content | length) - 1)
          | each { $in | into string }
        }
        'recor' => {
          $content
          | columns
        }
        'table' => {
          $content
          | get ($content | columns | first)
        }
        _ => {
          []
        }
      }
      | str join "\n"
      | (
        fzf ...(
          _build_fzf_args ($segs | last)
          'Variable'
          (
            $"const raw = ($content | to json); " +
            `(match ($raw | describe | str substring ..4) {
'list<' => {$raw | get -i ({} | into int)},
_ => {$raw | table -i false -t basic | find {}
| each {let segs = $in | split row '|'
{$'name': ($segs | get 1)
$'value': ($segs | get (($segs | length) - 2))}}
| table -i false}})
| str replace --regex '((│(\s*\w+\s*))*│)\n├' $"(ansi green)$1(ansi reset)\n├"
| str replace --regex --all '([╭├][┬┼─]+[┤╮])' $'(ansi green)$1(ansi reset)'`
          )
        )
        --tmux center,90%,50%
        --preview-window right,70%
      )
    )
    if ($res | is-empty) { $query } else { $prefix + $seg_prefix + $res }
  }
}

def _carapace_git_diff_preview [
  spans: list<string>
] {
  match $spans.0 {
    'git' if ($spans | get -i 1 | default '') in [
      'add'
      'show'
      'diff'
      'stage'
    ] => [
      --preview
      r#'let fp = {1}; if ($fp | path exists) {git diff $fp | delta} else {git log --color}'#
      --height=100%
      --multi
      '--preview-window=right,65%'
      '--tmux=center,80%,80%'
    ]
    _ => []
  }
}

# if the current command is an alias, get it's expansion
def _expand_alias_if_exist [cmd: string] {
  scope aliases
  | where name == $cmd
  | get -i 0.expansion
  | default $cmd
}

# Completion done by external carapace command
# specially treated when something like `vim **` is present
export def carapace_by_fzf [
  spans: list<string> # list of commandline arguments to trigger `carapace <command> nushell ...($spans)`
] {
  let query = $spans | last
  let res = try {
    match $spans.0 {
      _ if "$" in $query => {
        _env_by_fzf $query
      }
      _ if ($query | str substring (-2)..) in ['**' '*^'] => {
        _complete_by_fzf $spans.0 $query
      }
      _ if $spans.0 == 'which' or ($spans | length) == 1 => {
        _complete_by_fzf '' $query
      }
      '__zoxide_z' => {
        _complete_by_fzf 'cd' $query
      }
      'man' => {
        _complete_by_fzf 'man' $query
      }
      '__zoxide_zi' => {
        $'(zoxide query --interactive ...($spans | skip 1) | str trim -r -c "\n")'
      }
      _ => {
        _carapace_by_fzf $spans.0 $spans
      }
    }
  } catch { null }
  match $res {
    null => null # continue with built-in completer, may cause another trigger of this completer
    '' => [$query] # nothing changes
    _ => [({description: 'From customized external completer'} | default $res 'value')]
  }
}

# find the innermost command that contains the given position
export def find_command [
  position: int # the position to find
]: string -> record {
  let cmd = $in
  let nodes = ast -f $cmd | reverse
  mut query_node = null
  mut command_node = null
  for node in $nodes {
    if ($node.span.start > $position) { continue }
    if $node.span.end > $position {
      # node of the cursor, a position-taking 'a' token
      $query_node = $node
    } else if $node.shape == 'shape_variable' {
      let content_to_cursor = ($cmd | str substring $node.span.start..<$query_node.span.end)
      if ' ' not-in $content_to_cursor {
        # e.g. $env.foo.a
        $query_node = $query_node
        | default {}
        | update content $content_to_cursor
        | update span {start: $node.span.start end: $query_node.span.end}
      }
      break
    }
    if $node.shape =~ '_(internalcall|external|variable)$' {
      $command_node = $node
      break
    }
  }
  {command: $command_node query: $query_node}
}

# Manually triggered completion inline replacement of the commandline string
# override default behaviors for some commands like kill ssh zoxide which is defined in _complete_by_fzf
export def complete_line_by_fzf [] {
  let cmd_raw = commandline
  let cursor_pos = commandline get-cursor
  let suffix = $cmd_raw | str substring -g $cursor_pos..
  let cmd_before_pos = $cmd_raw | str substring -g ..($cursor_pos - 1)
  let cursor_pos = $cmd_before_pos | str length # in byte not in grapheme
  let nodes = ($cmd_before_pos + 'a' + $suffix) | find_command $cursor_pos
  let command_start_offset = $nodes.command.span?.start | default 0
  let query_start_offset = $nodes.query.span?.start | default 0
  let parsed = {
    prefix: ($cmd_raw | substring_to_idx ($command_start_offset - 1))
    # trim position-taking 'a' if in content
    query: (
      $nodes.query.content? | default ''
      | substring_to_idx ($cursor_pos - $query_start_offset - 1)
    )
    cmd: (
      $cmd_raw
      | substring_from_idx $command_start_offset
      | substring_to_idx ($query_start_offset - 1 - $command_start_offset)
    )
    # trim position-taking 'a' if in content
    cmd_head: (
      $nodes.command.content? | default ''
      | substring_to_idx ($cursor_pos - $command_start_offset - 1)
    )
  }
  let query = $parsed.query
  let fzf_res = try {
    if ('$' in $query) {
      _env_by_fzf $query
    } else {
      _complete_by_fzf $parsed.cmd_head $query
    }
  } catch { $query }
  let completed_before_pos = $parsed.prefix + $parsed.cmd + $fzf_res
  | str replace --all (char nul) "\n"
  commandline edit --replace ($completed_before_pos + $suffix)
  commandline set-cursor ($completed_before_pos | str length -g)
}

const atuin_refresh_cmd = r#'
  atuin history list --reverse false --cwd --cmd-only --print0
  | split row (char nul) | uniq
  | par-each {$in | nu-highlight}
  | str join (char nul)'#

const atuin_delete_cmd = r##'let cmd = r#'{}'#
| str trim -c `'`
| str trim -c `\`
| str replace -a "'\\''" `'`;
atuin search --search-mode full-text --delete $cmd'##

export def atuin_menus_func [
  prompt: string
]: nothing -> closure {
  {|buffer, position|
    {
      # only history of current directory
      value: (
        nu -c $atuin_refresh_cmd
        | (
          fzf --read0 --ansi -q $buffer
          --bind $"ctrl-d:execute\(($atuin_delete_cmd)\)+reload\(($atuin_refresh_cmd)\)"
          --no-tmux --height 40%
          --prompt $prompt
        )
        | ansi strip
      )
    }
  }
}
