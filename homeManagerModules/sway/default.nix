{...}: {
  imports = [
    ./sway.nix
    ./waybar.nix
    ./wlogout.nix
    ./wpaperd.nix
    ./envVars.nix
    ./swayr.nix
    ./swaync.nix
    ./swayidle.nix
    ./swaylock.nix
    # ./swayfx.nix
  ];
}
# {
#   imports = builtins.filter
#     (module: !lib.pathIsDirectory module && lib.hasSuffix ".nix" module)
#     (map (module: ./. + "/" + module)
#       (builtins.attrNames (builtins.readDir (toString ./.))));
# }

