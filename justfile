# nix shell nixpkgs#just nixpkgs#nushell
set shell := ["nu", "-c"]
flake_path := "/home/jr/flakes"
hostname := "magic"
home_manager_output := "jr@magic"

utils_nu := absolute_path("utils.nu")

default:
    @just --list
# Rebuild
[group('nix')]
fr:
    nh os switch --hostname {{hostname}} {{flake_path}}

# Flake Update
[group('nix')]
fu:
    nh os switch  --hostname {{hostname}} --update {{flake_path}}

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
    nix flake update {{input}}
# Test
[group('nix')]
ft:
    nh os test --hostname {{hostname}} {{flake_path}}
# Collect Garbage
[group('nix')]
ncg:
    nix-collect-garbage --delete-old ; sudo nix-collect-garbage -d ; sudo /run/current-system/bin/switch-to-configuration boot

[group('nix')]
cleanup:
    nh clean all

# Clean
[group('nix')]
clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
# Upgrade
[group('nix')]
upd:
    sudo nixos-rebuild switch --upgrade --flake {{flake_path}}

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

# Usage: `./result/bin/run-*-vm`
# may need to set initialHashedPassword first
[group('nix')]
vm:
    sudo nixos-rebuild build-vm


system-info:
     "This is an {{arch()}} machine"

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

[group('git')]
push:
    git push -u origin main

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
