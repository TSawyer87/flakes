# nix shell nixpkgs#just nixpkgs#nushell
set shell := ["nu", "-c"]

utils_nu := absolute_path("utils.nu")

default:
    @just --list
# Rebuild
[group('nix')]
fr:
    nh os switch --hostname magic /home/jr/flakes

# Flake Update
[group('nix')]
fu:
    nh os switch  --hostname magic --update /home/jr/flakes

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
    nix flake update {{input}}
# Test
[group('nix')]
ft:
    nh os test --hostname magic /home/jr/flakes
# Collect Garbage
[group('nix')]
ncg:
    nix-collect-garbage --delete-old ; sudo nix-collect-garbage -d ; sudo /run/current-system/bin/switch-to-configuration boot

# Clean
[group('nix')]
clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
# Upgrade
[group('nix')]
upd:
    sudo nixos-rebuild switch --upgrade

# Nix Repl flake:nixpkgs
[group('nix')]
repl:
    nix repl -f flake:nixpkgs

# format the nix files in this repo
[group('nix')]
fmt:
    nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
    ls -al /nix/var/nix/gcroots/auto/

# Verify all store entries
[group('nix')]
verify-store:
    nix store verify --all

    
[group('nix')]
repair-store *paths:
    nix store repair {{paths}}

system-info:
    @echo "This is an {{arch()}} machine".

# Sort-Reverse nushell
sort:
    ls | sort-by size | reverse

# Find > 5kb files
five:
    ls | where size > 5kb

running:
    ps | where status == Running

help:
    help commands | explore


# =================================================
#
# Other useful commands
#
# =================================================

[group('common')]
path:
   $env.PATH | split row ":"

[group('common')]
trace-access app *args:
  strace -f -t -e trace=file {{app}} {{args}} | complete | $in.stderr | lines | find -v -r "(/nix/store|/newroot|/proc)" | parse --regex '"(/.+)"' | sort | uniq

[linux]
[group('common')]
penvof pid:
  sudo cat $"/proc/($pid)/environ" | tr '\0' '\n'

# Remove all reflog entries and prune unreachable objects
[group('git')]
ggc:
  git reflog expire --expire-unreachable=now --all
  git gc --prune=now

# Amend the last commit without changing the commit message
[group('git')]
game:
  git commit --amend -a --no-edit

# Delete all failed pods
[group('k8s')]
del-failed:
  kubectl delete pod --all-namespaces --field-selector="status.phase==Failed"

[linux]
[group('services')]
list-inactive:
  systemctl list-units -all --state=inactive

[linux]
[group('services')]
list-failed:
  systemctl list-units -all --state=failed

[linux]
[group('services')]
list-systemd:
  systemctl list-units systemd-*
