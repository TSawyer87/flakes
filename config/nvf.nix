{ inputs, pkgs, ... }: {
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        theme.enable = false;
        viAlias = false;
        vimAlias = true;
        spellcheck = {
          enable = true;
        }
        lsp = {
            formatOnSave = true;
            lspkind.enable = true;
            trouble.enable = true;
            lsplines.enable = true;
      };

        debugger = {
          nvim-dab = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableExtraDiagnostics = true;
          enableTreesitter = true;
          nix.enable = true;
          nix.lsp.enable = true;
          nix.lsp.server = "nil";
          nix.format.type = "alejandra";
          nix.treesitter.enable = true;
          markdown.enable = true;
          bash.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
        };

        leaderKey = " ";
        lineNumberMode = "relative";

        tabline = { nvimBufferline.enable = true; };

        theme = {
          name = "tokyonight";
          style = "storm";
          transparent = true;
        };
        autopairs.nvim-autopairs.enable = true;
        statusline = {
          lualine = {
            enable = true;
            theme = "tokyonight";
          };
        };
        autocomplete = {
          nvim-cmp.mappings.confirm = "<C-;>";
          nvim-cmp.enable = true;
        };
        binds = { whichKey.enable = true; };
        telescope.enable = true;

        utility = {
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = true;
        };
        };


      };
    };
  };
}
