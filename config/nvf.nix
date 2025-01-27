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
      nix.enable = true;
    };
    autocomplete = {
    nvim-cmp.enable = true;
    };
    lazy.plugins = {
    toggleterm-nvim = {
      package = "toggleterm-nvim";
      setupModule = "toggleterm";
      cmd = ["ToggleTerm"];
    };
    binds = {
    whichKey.enable = true;
    };

    };
  };
  };
  };
  }
