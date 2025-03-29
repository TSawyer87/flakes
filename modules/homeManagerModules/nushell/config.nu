# def build-config [] { { footer_mode: "50" } }

# let config = build-config

# use ~/flakes/modules/homeManagerModules/nushell/init.nu *
# use ~/flakes/modules/homeManagerModules/nushell/env.nu *
# $env.config.buffer_editor = "hx"

# $env.MANPAGER = "nvim +Man!"
# $env.config.edit_mode = "vi"

# alias gd = git diff

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu
source ~/flakes/modules/homeManagerModules/nushell/atuin.nu
