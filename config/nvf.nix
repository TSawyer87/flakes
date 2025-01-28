{ inputs, pkgs, ... }: {
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        viAlias = false;
        vimAlias = true;
        lsp = { enable = true; };
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
          nix.lsp.enable = true;
          nix.lsp.server = "nil";
          nix.format.type = "alejandra";
          nix.treesitter.enable = true;
          markdown.enable = true;
          bash.enable = true;
        };

        leaderKey = " ";
        lineNumberMode = "relative";

        tabline = { nvimBufferline.enable = true; };

        theme.name = "tokyonight";
        autopairs.nvim-autopairs.enable = true;
        statusline.lualine.enable = true;
        autocomplete = {
          nvim-cmp.mappings.confirm = "<C-;>";
          nvim-cmp.enable = true;
        };
        binds = { whichKey.enable = true; };
        lazy.plugins = {
          toggleterm-nvim = {
            package = "toggleterm-nvim";
            setupModule = "toggleterm";
            cmd = [ "ToggleTerm" ];
          };
        };
      };
    };
  };
}
