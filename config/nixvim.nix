{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
  };
}
