fr:
    nh os switch --hostname magic /home/jr/flakes

fu:
    nh os switch  --hostname magic --update /home/jr/flakes

ft:
    nh os test --hostname magic /home/jr/flakes

ncg:
    nix-collect-garbage --delete-old ; sudo nix-collect-garbage -d ; sudo /run/current-system/bin/switch-to-configuration boot

upd:
    sudo nixos-rebuild switch --upgrade
