{ ... }: {
  imports = [
    ./programs.nix
    ./packages.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
    ./dconf.nix
    # ./yazi.nix
    ./git.nix
    # ./tmux.nix
    # ./jj.nix
    ./direnv.nix
    # ./helix.nix
    # ./fzf.nix
    ./nushell.nix
    ./emoji.nix
  ];
}
