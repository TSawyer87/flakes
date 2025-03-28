def build-config [] { { footer_mode: "50" } }

let config = build-config

use ~/flakes/modules/homeManagerModules/nushell/init.nu *

alias gd = git diff

source ~/.zoxide.nu
