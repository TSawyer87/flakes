{ config, pkgs, inputs, ... }:
let helpers = config.lib.nixvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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
    ./plugins/oil.nix
    #./plugins/alpha.nix
    #./plugins/ufo.nix
    ./plugins/flash.nix
    ./plugins/codeium.nix
    ./plugins/markdown.nix
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;

    colorschemes = {
      # https://nix-community.github.io/nixvim/colorschemes/tokyonight/index.html
      tokyonight = {
        enable = true;
        settings = {
          # Like many other themes, this one has different styles, and you could load
          # any other, such as 'storm', 'moon', or 'day'.
          style = "night";
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

      # Detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      sleuth = { enable = true; };

      lz-n = { enable = true; }; # lazy loading

      # Highlight todo, notes, etc in comments
      # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
      todo-comments = {
        settings = {
          enable = true;
          signs = true;
        };
      };
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
      obsidian = {
        enable = true;
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
