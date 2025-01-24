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
    extraPlugins = with pkgs.vimPlugins; {
      aerial = {
        package = aerial-nvim;
        setup = "require('aerial').setup {}";
      };

      harpoon = {
        package = harpoon;
        setup = "require('harpoon').setup {}";
        after = [ "aerial" ]; # place harpoon configuration after aerial
      };
    };
  };
}
