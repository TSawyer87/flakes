# tmux session switcher
export def sesh_connect [] {
  let kbd_message = {
    all: ^a
    tmux: ^t
    configs: ^c
    zoxide: ^x
    find: ^f
    kill: ^d
  }
  | transpose desc key
  | each { $'(ansi cyan)($in.key)(ansi reset) ($in.desc)' }
  | str join ' '
  let session = sesh list --icons
  | (
    fzf --ansi --border-label ' sesh ' --prompt '󱐋 '
    --tmux center,30%
    --header $'(ansi cyan)Keybindings(ansi reset): ($kbd_message)'
    --bind 'tab:down,btab:up'
    --bind 'ctrl-a:change-prompt(󱐋 )+reload(sesh list --icons)'
    --bind 'ctrl-t:change-prompt(󰧷 )+reload(sesh list -t --icons)'
    --bind 'ctrl-c:change-prompt( )+reload(sesh list -c --icons)'
    --bind 'ctrl-x:change-prompt( )+reload(sesh list -z --icons)'
    --bind 'ctrl-f:change-prompt(󰍉 )+reload(fd -H -d 2 -t d -E .Trash . ~)'
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(󱐋 )+reload(sesh list --icons)'
  )
  sesh connect $session
}
