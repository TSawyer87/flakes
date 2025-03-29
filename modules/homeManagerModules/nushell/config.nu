# def build-config [] { { footer_mode: "50" } }

# let config = build-config

# use ~/flakes/modules/homeManagerModules/nushell/init.nu *
# use ~/flakes/modules/homeManagerModules/nushell/env.nu *
# $env.config.buffer_editor = "hx"
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
$env.MANPAGER = "col -bx | bat -l man -p"
$env.MANPAGECACHE = ($nu.default-config-dir | path join 'mancache.txt')
$env.RUST_BACKTRACE = 1
$env.XDG_CONFIG_HOME = $env.HOME + "/.config"
$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)

use ~/flakes/modules/homeManagerModules/nushell/fzf.nu [
  carapace_by_fzf
  complete_line_by_fzf
  update_manpage_cache
  atuin_menus_func
]
# use ~/flakes/modules/homeManagerModules/nushell/sesh.nu sesh_connect
use ~/flakes/modules/homeManagerModules/nushell/auto-pair.nu *
set auto_pair_keybindings
use ~/flakes/modules/homeManagerModules/nushell/matchit.nu *
set matchit_keybinding
# $env.MANPAGER = "nvim +Man!"
# $env.config.edit_mode = "vi"
# use ~/flakes/modules/homeManagerModules/nushell/lsp.nu *

# alias gd = git diff
pfetch

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source ~/flakes/modules/homeManagerModules/nushell/zoxide.nu
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu
source ~/flakes/modules/homeManagerModules/nushell/atuin.nu
source ~/flakes/modules/homeManagerModules/nushell/nu_scripts/themes/nu-themes/tokyo-moon.nu
