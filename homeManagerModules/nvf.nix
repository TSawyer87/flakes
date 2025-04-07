{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf.enable = true;

  programs.nvf.settings.vim = {
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;

    options = {
      tabstop = 2;
      shiftwidth = 2;
      wrap = false;
    };

    keymaps = [
      # {
      #   key = "<leader>a";
      #   action = ":AerialToggle<CR>";
      # }
      {
        key = "jk";
        mode = ["i"];
        action = "<ESC>";
        desc = "Exit insert mode with jk";
      }
      {
        key = "<leader>nh";
        mode = ["n"];
        action = ":nohl<CR>";
        desc = "Clear search highlights";
      }
      {
        key = "<leader>F";
        mode = ["n"];
        action = "<cmd>Telescope find_files<cr>";
        desc = "Search files by name";
      }
      {
        key = "<leader>ff";
        mode = ["n"];
        action = "<cmd>Telescope live_grep<cr>";
        desc = "Search files by contents";
      }
    ];

    # theme = {
    #   enable = true;
    #   name = "dracula";
    #   style = "dark";
    #   transparent = true;
    # };

    telescope.enable = true;

    spellcheck = {
      enable = true;
    };

    lsp = {
      formatOnSave = true;
      lspkind.enable = false;
      lightbulb.enable = true;
      lspsaga.enable = false;
      trouble.enable = true;
      lspSignature.enable = true;
      otter-nvim.enable = false;
      # lsplines.enable = false;
      nvim-docs-view.enable = false;
    };

    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      nix.enable = true;
      clang.enable = true;
      zig.enable = true;
      rust = {
        enable = true;
        lsp.enable = true;
        lsp.package = pkgs.rust-analyzer;
        dap.enable = true;
        format.enable = true;
        format.package = pkgs.rustfmt;
        crates = {
          enable = true;
          #codeActions.enable = true;
        };
      };
      python.enable = true;
      markdown.enable = true;
      ts.enable = true;
      html.enable = true;
    };

    visuals = {
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;

      highlight-undo.enable = true;
      indent-blankline.enable = true;
    };

    statusline = {
      lualine = {
        enable = true;
        # theme = "dracula";
      };
    };

    autopairs.nvim-autopairs.enable = true;

    autocomplete.nvim-cmp.enable = true;
    snippets.luasnip.enable = true;

    tabline = {
      nvimBufferline.enable = true;
    };

    treesitter.context.enable = true;

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
    };

    projects.project-nvim.enable = true;
    dashboard.dashboard-nvim.enable = true;

    notify = {
      nvim-notify.enable = true;
      nvim-notify.setupOpts.background_colour = "#${config.lib.stylix.colors.base01}";
    };

    utility = {
      ccc.enable = false;
      vim-wakatime.enable = false;
      icon-picker.enable = true;
      surround.enable = true;
      diffview-nvim.enable = true;
      motion = {
        hop.enable = true;
        leap.enable = true;
        precognition.enable = false;
      };

      images = {
        image-nvim.enable = false;
      };
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      illuminate.enable = true;
      breadcrumbs = {
        enable = false;
        navbuddy.enable = false;
      };
      smartcolumn = {
        enable = false;
      };
      fastaction.enable = true;
    };

    session = {
      nvim-session-manager.enable = false;
    };

    comments = {
      comment-nvim.enable = true;
    };
  };
}
