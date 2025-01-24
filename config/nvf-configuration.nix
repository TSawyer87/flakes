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
    lazy.plugins = {
      "aerial.nvim" = {
        package = pkgs.vimPlugins.aerial-nvim;
        setupModule = "aerial";
        lazy = true;

        # load on command
        # cmd = ["AerialOpen"];

        # load on event
        # event = ["BufEnter"];

        keys = [{
          key = "<leader>a";
          action = ":AerialToggle<CR>";
        }];
      };
    };
  };
}
