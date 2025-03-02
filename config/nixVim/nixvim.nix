{ config, pkgs, inputs, lib, ... }:
let helpers = config.lib.nixvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    (import ./plugins/ufo.nix { inherit helpers; })
    ./plugins/gitsigns.nix
    ./plugins/which-key.nix
    ./plugins/telescope.nix
    ./plugins/conform.nix
    ./plugins/lsp.nix
    ./plugins/nvim-cmp.nix
    ./plugins/mini.nix
    ./plugins/treesitter.nix
    ./plugins/autopairs.nix
    ./plugins/lint.nix
    ./plugins/debug.nix
    ./plugins/indent-blankline.nix
    ./plugins/bufferline.nix
    ./plugins/lualine.nix
    ./plugins/undotree.nix
    ./plugins/codecompanion.nix
    ./plugins/navic.nix
    ./plugins/harpoon.nix
    ./plugins/oil.nix
    ./plugins/flash.nix
    ./plugins/neoscroll.nix
    ./plugins/dial.nix
    ./plugins/toggleterm.nix
    ./plugins/alpha.nix
    ./plugins/codeium.nix
    ./plugins/markdown.nix
    ./plugins/zen-mode.nix
    ./plugins/dressing.nix
    ./plugins/colorizer.nix
    # ./plugins/rustaceanvim.nix
    ./plugins/notify.nix
    ./plugins/noice.nix
    ./plugins/yazi.nix
    ./options.nix
    # ./plugin-module.nix
    ./keymaps.nix
    ./autocmds.nix
    ./performance.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;

    colorschemes = {
      # https://nix-community.github.io/nixvim/colorschemes/tokyonight/index.html
      onedark = {
        enable = true;
        settings = {
          # Like many other themes, this one has different styles, and you could load
          # any other, such as 'storm', 'moon', or 'day'.
          # style = "night";
        };
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#globals
    globals = {
      # Set <space> as the leader key
      # See `:help mapleader`
      mapleader = " ";
      maplocalleader = " ";

      # Set to true if you have a Nerd Font installed and selected in the terminal
      have_nerd_font = true;
    };

    plugins = {
      # Adds icons for plugins to utilize in ui
      web-devicons.enable = true;
      rainbow-delimiters = { enable = true; };

      direnv.enable = true;
      nix.enable = true;
      nix-develop.enable = true;

      # Detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      sleuth = { enable = true; };

      lz-n = { enable = true; }; # lazy loading

      diffview = { enable = true; };

      persistence = { enable = true; };
      # Highlight todo, notes, etc in comments
      # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
      todo-comments = {
        settings = {
          enable = true;
          signs = true;
        };
      };
      lazygit = { enable = true; };
      treesj = { enable = true; };
      nvim-bqf = { enable = true; };
      grug-far = {
        enable = true;
        lazyLoad = { settings = { cmd = "GrugFar"; }; };
      };
      marks = { enable = true; };
      glow = {
        enable = true;
        lazyLoad.settings.ft = "markdown";
      };
      render-markdown = {
        enable = true;
        lazyLoad.settings.ft = "markdown";
      };
      crates = { enable = true; };

      obsidian = {
        enable = true;
        lazyLoad.settings.ft = "markdown";
        settings = {
          completion = {
            min_chars = 2;
            nvim_cmp = true;
          };
          new_notes_location = "current_dir";
          workspaces = [
            {
              name = "notes";
              path = "~/notes";
            }
            {
              name = "2nd_brain";
              path = "~/notes/2nd_brain";
            }
          ];
        };
      };
      rustaceanvim = {
        enable = true;
        settings = {

          dap = { autoloadConfigurations = true; };

          server = {
            cmd = [ (lib.getExe pkgs.rust-analyzer) ];
            default_settings = {
              rust-analyzer = {
                cargo = {
                  buildScripts.enable = true;
                  features = "all";
                };

                diagnostics = {
                  enable = true;
                  styleLints.enable = true;
                };

                checkOnSave = true;
                check = {
                  command = "clippy";
                  extraArgs = [
                    "--"
                    "--no-deps"
                    "-Dclippy::correctness"
                    "-Dclippy::complexity"
                    "-Wclippy::perf"
                    "-Wclippy::pedantic"
                  ];
                  features = "all";
                };

                files = {
                  excludeDirs =
                    [ ".cargo" ".direnv" ".git" "node_modules" "target" ];
                };

                inlayHints = {
                  bindingModeHints.enable = true;
                  closureStyle = "rust_analyzer";
                  closureReturnTypeHints.enable = "always";
                  discriminantHints.enable = "always";
                  expressionAdjustmentHints.enable = "always";
                  implicitDrops.enable = true;
                  lifetimeElisionHints.enable = "always";
                  rangeExclusiveHints.enable = true;
                };

                procMacro = { enable = true; };

                rustc.source = "discover";
              };
            };
          };
        };
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraplugins
    extraPlugins = with pkgs.vimPlugins;
      [
        # Useful for getting pretty icons, but requires a Nerd Font.
        nvim-web-devicons # TODO: Figure out how to configure using this with telescope
      ];

    # TODO: Figure out where to move this
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapre
    extraConfigLuaPre = ''
      if vim.g.have_nerd_font then
        require('nvim-web-devicons').setup {}
      end
    '';

    # The line beneath this is called `modeline`. See `:help modeline`
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapost
    extraConfigLuaPost = ''
      -- vim: ts=2 sts=2 sw=2 et
    '';
  };
}
