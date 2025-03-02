{ ... }: {
  imports = [
    ./programs.nix
    ./packages.nix
    ./services.nix
    ./homeFiles.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
    ./dconf.nix
    ./yazi.nix
    ./git.nix
    ./jj.nix
    ./helix.nix
  ];
}
