# Source this in your ~/.config/nushell/config.nu
$env.ATUIN_SESSION = (atuin uuid)
hide-env -i ATUIN_HISTORY_ID
# Magic token to make sure we don't record commands run by keybindings
let ATUIN_KEYBINDING_TOKEN = $"# (random uuid)"
let _atuin_pre_execution = {||
  if ($nu | get -i history-enabled) == false {
    return
  }
  let cmd = commandline
  if ($cmd | is-empty) {
    return
  }
  if not ($cmd | str starts-with $ATUIN_KEYBINDING_TOKEN) {
    $env.ATUIN_HISTORY_ID = (atuin history start -- $cmd)
  }
}
let _atuin_pre_prompt = {||
  let last_exit = $env.LAST_EXIT_CODE
  if 'ATUIN_HISTORY_ID' not-in $env {
    return
  }
  with-env {ATUIN_LOG: error} {
    do { atuin history end $'--exit=($last_exit)' -- $env.ATUIN_HISTORY_ID } | complete
  }
  hide-env ATUIN_HISTORY_ID
}

$env.config.hooks.pre_execution ++= [$_atuin_pre_execution]
$env.config.hooks.pre_prompt ++= [$_atuin_pre_prompt]

source ~/.local/share/atuin/init.nu
