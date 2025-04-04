# list all installed packages
def nix-list-system []: nothing -> list<string> {
  ^nix-store -q --references /run/current-system/sw
  | lines
  | filter { not ($in | str ends-with 'man') }
  | each { $in | str replace -r '^[^-]*-' '' }
  | sort
}

# upgrade system packages
def nix-upgrade [
  flake_path: string # path that confains a flake.nix
  --interactive (-i) # select pacakges to upgrade interactively
]: nothing -> nothing {
  let working_path = $flake_path | path expand
  if not ($working_path | path exists) {
    echo "path not exists: $working_path"
    exit 1
  }
  let pwd = pwd
  cd $working_path
  if $interactive {
    let selections = nix flake metadata . --json
    | from json
    | get locks.nodes
    | columns
    | str join "\n"
    | fzf --multi --tmux center,20%
    | lines
    nix flake update ...$selections
  } else {
    nix flake update
  }
  cd $pwd
  nixos-rebuild switch --flake $working_path --show-trace
}
