def build-config [] { { footer_mode: "50" } }

let config = build-config

use ~/flakes/modules/homeManagerModules/nushell/init.nu *
# use ~/flakes/modules/homeManagerModules/nushell/env.nu *

alias gd = git diff

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source ~/.zoxide.nu
