{ config, pkgs, inputs, ... }:
let
  helpers = config.lib.nixvim;
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };
}
