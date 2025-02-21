{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
