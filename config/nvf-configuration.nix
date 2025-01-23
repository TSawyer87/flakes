{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
    };
  };
}
