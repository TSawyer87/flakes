{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };
}
