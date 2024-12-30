{
  lib,
  pkgs,
  ...
}:
let
  sources = {
    pokemon-colorscripts = import ./pokemon-colorscripts.nix { inherit pkgs lib; };
  };

  overlays = builtins.mapAttrs (name: value: self: super: {
    ${name} = value;
  }) sources;

in
{

  nixpkgs.overlays = builtins.attrValues overlays;

  home.packages = builtins.attrValues sources;
}
