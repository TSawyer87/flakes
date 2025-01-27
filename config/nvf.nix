{ inputs, pkgs, system, ... }: {
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      viAlias = true;
      vimAlias = false;
      lsp = { enable = true; };
      languages = {
      enableTreesitter = true;
      nix.enable = true;
      nix.lsp.enable = true;
      nix.lsp.server = "nil";
      nix.format.type = "alejandra",
      nix.treesitter.enable = true;
      markdown.enable = true;
    };
    theme.name = "tokyonight";
    autopairs.nvim-autopairs.enable = true;
    statusline.lualine.enable = true;
    autocomplete = {
    nvim-cmp.enable = true;
    };
    binds = {
    whichKey.enable = true;
    };
    lazy.plugins = {
    toggleterm-nvim = {
      package = "toggleterm-nvim";
      setupModule = "toggleterm";
      cmd = ["ToggleTerm"];
    };

    };
  };
  };
  };
  }
