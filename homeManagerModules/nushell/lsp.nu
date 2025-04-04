# Minimal config file for LSP
# $env.PATH = $env.PATH
# | split row (char esep)
# | append '/usr/local/bin'
# | append ($env.HOME | path join ".cargo" "bin")
# | uniq
export-env {
    load-env {
        BROWSER: "firefox"
        CARGO_TARGET_DIR: "~/.cargo/target"
        # CARGO_HOME : "~/.cargo"
        # EDITOR: "nvim"
        # VISUAL: "nvim"
        PAGER: "less"
        # SHELL: "~/.cargo/bin/nu"
        HOSTNAME:  (hostname | split row '.' | first | str trim)
        SHOW_USER: true
        LS_COLORS: ([
             "di=01;34;2;102;217;239"
             "or=00;40;31"
             "mi=00;40;31"
             "ln=00;36"
             "ex=00;32"
        ] | str join (char env_sep))
    }
}

$env.CARAPACE_LENIENT = 1
$env.CARAPACE_BRIDGES = 'zsh'
$env.config.completions.external.completer = {|spans: list<string>|
  carapace $spans.0 nushell ...$spans
  | from json
  | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}
const NU_LIB_DIRS = ["/home/jr/flakes/modules/homeManagerModules/nushell/nu_scripts/"]
