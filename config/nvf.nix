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
        spellcheck = { enable = true; };
        lsp = {
          formatOnSave = true;
          lspkind.enable = true;
          trouble.enable = true;
          lsplines.enable = true;
        };

        debugger = {
          nvim-dap = {
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

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        leaderKey = " ";
        lineNumberMode = "relative";

        tabline = { nvimBufferline.enable = true; };

        snippets.luasnip.enable = true;

        filetree = { neo-tree = { enable = true; }; };

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

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        utility = {
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = true;
          };
          images = { image-nvim.enable = true; };
        };
        dashboard = { alpha.enable = true; };

        notify = { nvim-notify.enable = true; };

        notes = {
          obsidian.enable = false;
          todo-comments.enable = true;
          mind-nvim.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              nix = "110";
              markdown = "80";
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
            cmp.enable = false;
          };
        };

        session = { nvim-session-manager.enable = false; };

        gestures = { gesture-nvim.enable = false; };

        comments = { comment-nvim.enable = true; };

        presence = { neocord.enable = false; };
      };

    };
  };
}
