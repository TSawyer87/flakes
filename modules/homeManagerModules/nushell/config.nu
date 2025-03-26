def build-config [] { { footer_mode: "50" } }

let config = build-config

use ./init.nu *

alias gd = git diff
