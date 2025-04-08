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
    # ./nushell/nushell.nix
    ./emoji.nix
    ./bat.nix
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
