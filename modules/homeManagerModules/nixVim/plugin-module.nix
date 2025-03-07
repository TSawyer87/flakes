# lib/plugin-module.nix
{
  config,
  lib,
  ...
}:
with lib; {
  options = {
    plugins = mkOption {
      type = types.attrsOf types.attrs;
      default = {};
      description = "NixVim plugin configuration";
    };
  };

  config = {programs.nixvim.plugins = config.plugins;};
}
