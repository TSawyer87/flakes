# def build-config [] { { footer_mode: "50" } }

# let config = build-config

const extra_colors = {
  menu_text_color: "#aaeaea"
  prompt_symbol_color: "#111726"
  explore_bg: "#1D1F21"
  explore_fg: "#C4C9C6"
}

$env.PATH = $env.PATH
| split row (char esep)
| append '/usr/local/bin'
| append ($env.HOME | path join ".elan" "bin")
| append ($env.HOME | path join ".cargo" "bin")
| prepend ($env.HOME | path join ".local" "bin")
| uniq
$env.FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix --exclude .git --exclude .cache --max-depth 9"
# $env.CARAPACE_LENIENT = 1
$env.CARAPACE_BRIDGES = 'zsh'
# $env.MANPAGER = "col -bx | bat -l man -p"
$env.MANPAGECACHE = ($nu.default-config-dir | path join 'mancache.txt')
$env.RUST_BACKTRACE = 1
$env.XDG_CONFIG_HOME = $env.HOME + "/.config"
$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)

use ~/flakes/homeManagerModules/nushell/fzf.nu [
  carapace_by_fzf
  complete_line_by_fzf
  update_manpage_cache
  atuin_menus_func
  prompt_decorator
]

$env.config.explore = {
  status_bar_background: {bg: $extra_colors.explore_bg fg: $extra_colors.explore_fg}
  command_bar_text: {fg: $extra_colors.explore_fg}
  highlight: {fg: "black" bg: "yellow"}
  status: {
    error: {fg: "white" bg: "red"}
    warn: {}
    info: {}
  }
  selected_cell: {bg: light_blue fg: "black"}
}

$env.config.menus ++= [
  # Configuration for default nushell menus
  # Note the lack of source parameter
  {
    name: my_history_menu
    only_buffer_difference: false
    marker: ''
    type: {layout: ide}
    style: {}
    source: (
      atuin_menus_func
      (
        prompt_decorator
        $extra_colors.prompt_symbol_color
        'light_blue'
        '▓▒░ Ctrl-d to del '
        "false"
      )
    )
  }
  {
    name: completion_menu
    only_buffer_difference: false
    marker: (prompt_decorator $extra_colors.prompt_symbol_color "yellow" "" "")
    type: {
      layout: columnar
      columns: 4
      col_width: 20 # Optional value. If missing all the screen width is used to calculate column width
      col_padding: 2
    }
    style: {
      text: $extra_colors.menu_text_color
      selected_text: {attr: r}
      description_text: yellow
      match_text: {attr: u}
      selected_match_text: {attr: ur}
    }
  }
  {
    name: history_menu
    only_buffer_difference: false
    marker: (prompt_decorator $extra_colors.prompt_symbol_color "light_blue" "" "")
    type: {
      layout: list
      page_size: 30
    }
    style: {
      text: $extra_colors.menu_text_color
      selected_text: light_blue_reverse
      description_text: yellow
    }
  }
]

$env.config.keybindings ++= [
  {
    name: history_menu
    modifier: control
    keycode: char_h
    mode: [emacs vi_insert vi_normal]
    event: {send: menu name: my_history_menu}
    # event: {send: menu name: ide_completion_menu}
  }
  {
    name: sesh
    modifier: control
    keycode: char_s
    mode: [emacs vi_insert vi_normal]
    event: {
      send: executehostcommand
      cmd: sesh_connect
    }
  }
  {
    name: vicmd_history_menu
    modifier: shift
    keycode: char_k
    mode: vi_normal
    event: {send: menu name: my_history_menu}
  }
  {
    name: cut_line_to_end
    modifier: control
    keycode: char_k
    mode: [emacs vi_insert]
    event: {edit: cuttoend}
  }
  {
    name: cut_line_from_start
    modifier: control
    keycode: char_u
    mode: [emacs vi_insert]
    event: {edit: cutfromstart}
  }
  {
    name: fuzzy_complete
    modifier: control
    keycode: char_t
    mode: [emacs vi_normal vi_insert]
    event: {
      send: executehostcommand
      cmd: complete_line_by_fzf
    }
  }
]
use ~/flakes/homeManagerModules/nushell/sesh.nu sesh_connect
use ~/flakes/homeManagerModules/nushell/auto-pair.nu *
use ~/flakes/homeManagerModules/nushell/scripts/extractor.nu extract
set auto_pair_keybindings
use ~/flakes/homeManagerModules/nushell/matchit.nu *
set matchit_keybinding
# $env.MANPAGER = "nvim +Man!"
# $env.config.edit_mode = "vi"

# alias gd = git diff
nitch
# fastfetch

source ~/flakes/homeManagerModules/nushell/zoxide.nu
source ~/flakes/homeManagerModules/nushell/atuin.nu
source ~/flakes/homeManagerModules/nushell/carapace.nu
# source ~/.cache/carapace/init.nu
source ~/flakes/homeManagerModules/nushell/nu_scripts/themes/nu-themes/ayu.nu
source ~/flakes/homeManagerModules/nushell/completions-jj.nu
