{...}: {
  imports = [
    ./programs.nix
    ./packages.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
    ./dconf.nix
    ./yazi.nix
    ./git.nix
    ./tmux.nix
    ./jj.nix
    ./direnv.nix
    # ./fzf.nix
    ./nushell.nix
    ./emoji.nix
    ./nvf.nix
    ./helix
    ./fd.nix
    ./zed.nix
    ./nh.nix
    ./ssh.nix
    ./hypr
    ./shells
    ./terms
    ./rofi
  ];
}
