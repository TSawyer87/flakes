{ inputs, pkgs, system, ... }: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      vim.viAlias = true;
      vim.vimAlias = false;
      vim.lsp = { enable = true; };
      vim.languages.nix.enable = true;
    };
      config.vim.lazy.plugins = {
      "aerial.nvim" = {
      package = pkgs.vimPlugins.aerial-nvim;
      setupModule = "aerial";

      # Explicitly mark plugin as lazy. You don't need this if you define one of
      # the trigger "events" below
      lazy = true;

      # load on keymap
      keys = [
        {
          key = "<leader>a";
          action = ":AerialToggle<CR>";
        }
      ];
    };
  };
  }
