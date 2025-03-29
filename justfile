# Rebuild
fr:
    nh os switch --hostname magic /home/jr/flakes

# Update
fu:
    nh os switch  --hostname magic --update /home/jr/flakes

# Test
ft:
    nh os test --hostname magic /home/jr/flakes
# Collect Garbage
ncg:
    nix-collect-garbage --delete-old ; sudo nix-collect-garbage -d ; sudo /run/current-system/bin/switch-to-configuration boot

# Clean
clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 3d
# Upgrade
upd:
    sudo nixos-rebuild switch --upgrade

# Nix Repl flake:nixpkgs
repl:
    nix repl -f flake:nixpkgs


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
