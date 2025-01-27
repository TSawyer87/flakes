{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./stylix.nix
    ./systemPackages.nix
    ./systemPrograms.nix
    ./systemServices.nix
    ./config.nix
    ./hardware.nix
    ./users.nix
    ./variables.nix
  ];
}
