def build-config [] { { footer_mode: "50" } }

let config = build-config

use ~/.config/nushell/init.nu *

alias gd = git diff
