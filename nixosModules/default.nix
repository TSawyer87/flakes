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
    ./environmentVariables.nix
    ./nix.nix
    ./hardware.nix
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
    ./vm-guest-services.nix
    ./virtualization.nix
    ./local-hardware-clock.nix
    ./drivers
    ./utils.nix
    ./networking.nix
    # ./impermanence.nix
    # ./conditions.nix
    # ./grub.nix
    # ./greetdHypr.nix
    # ./flatpak.nix
  ];
}
