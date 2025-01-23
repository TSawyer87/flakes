{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "dark";
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
