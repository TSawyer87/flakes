{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./keyd.nix
    ./stylix.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./security.nix
    ./environmentVariables.nix
    ./nix.nix
    ./hardware.nix
    ./users.nix
    ./zram.nix
    ./i18n.nix
    ./fonts.nix
    ./guix.nix
    ./cachix.nix
    ./xdg.nix
    ./greetd.nix
    ./thunar.nix
    ./lsp.nix
    ./printer.nix
    # ./grub.nix
    # ./greetdHypr.nix
  ];
}
