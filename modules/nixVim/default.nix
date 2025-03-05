{ pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  settings.editor = {
    bin = "nvim";
    terminal = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    extraPackages = with pkgs; [ gcc ];

    clipboard.providers.wl-copy.enable = true;

    opts = {
      number = true;
      relativenumber = true;
      cursorline = true;
      signcolumn = "yes";
      termguicolors = true;

      list = true;
      listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂";

      tabstop = 4;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smarttab = true;
      autoindent = true;
      wrap = true;

      foldcolumn = "0";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;

      infercase = true;
      ignorecase = true;
      smartcase = true;

      splitright = true;
      splitbelow = true;

      clipboard = "unnamedplus";
      undofile = true;
      swapfile = false;
      backup = false;
      writebackup = false;
      history = 50;

      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      { mode = "n"; key = "<leader>ff"; action = "<CMD>NvimTreeToggle<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>f/"; action = "<CMD>NvimTreeFindFile<CR>"; options = { silent = true; }; }

      { mode = "n"; key = "<leader>ll"; action = "<CMD>Limelight!! 0.7<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>lz"; action = "<CMD>ZenMode<CR>"; options = { silent = true; }; }

      { mode = "n"; key = "<leader>rm"; action = "<CMD>RenderMarkdown toggle<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>rn"; action = "<CMD>Neorg toggle-concealer<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>rc"; action = "<CMD>CccHighlighterToggle<CR>"; options = { silent = true; }; }

      { mode = "n"; key = "<leader>cp"; action = "<CMD>CccPick<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>cv"; action = "<CMD>CccConvert<CR>"; options = { silent = true; }; }

      { mode = "n"; key = "<leader>nj"; action = "<CMD>Neorg journal custom<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>ni"; action = "<CMD>Neorg index<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>nr"; action = "<CMD>Neorg return<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>nwh"; action = "<CMD>Neorg workspace home<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>nww"; action = "<CMD>Neorg workspace work<CR>"; options = { silent = true; }; }
    ];

    editorconfig.enable = true;
    plugins = {
      lualine.enable = true;
      which-key.enable = true;
      telescope = {
        enable = true;
        extensions = {
          file-browser.enable = true;
          undo.enable = true;
        };
        enabledExtensions = [ "hoogle" ];
        keymaps = {
          "<leader>tr" = "oldfiles";
          "<leader>t/" = "find_files";
          "<leader>tf" = "file_browser";
          "<leader>tw" = "buffers";
          "<leader>ts" = "session-lens";
          "<leader>th" = "hoogle";
          "<leader>tu" = "undo";
        };
      };
      nvim-tree.enable = true;
      auto-session = {
        enable = true;
        settings = {
          use_git_branch = true;
          suppressed_dirs = [
            "/"
            "~/"
          ];
        };
      };

      vim-surround.enable = true;
      web-devicons.enable = true;
      numbertoggle.enable = true;
      rainbow-delimiters.enable = true;
      ccc = {
        enable = true;
        settings = {
          highlighter.auto_enable = true;
          highlight_mode.__raw = "'virtual'";
          pickers = [
            "ccc.picker.hex"
            "ccc.picker.css_rgb"
            "ccc.picker.css_hsl"
            "ccc.picker.css_hwb"
            "ccc.picker.css_lab"
            "ccc.picker.css_lch"
            "ccc.picker.css_oklab"
            "ccc.picker.css_oklch"
            "ccc.picker.ansi_escape()"
          ];
        };
      };
      comment.enable = true;
      nvim-ufo = {
        enable = true;
        settings = {
          close_fold_kinds_for_ft = {
            default = ["imports" "comment"];
            json = ["array"];
          };
        };
      };
      zen-mode.enable = true;

      direnv.enable = true;
      treesitter = {
        enable = true;
        folding = true;
        settings = {
          highlight.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<TAB>";
              node_decremental = "<S-TAB>";
              node_incremental = "<TAB>";
            };
          };
          indent.enable = true;
        };
      };
      treesitter-textobjects.enable = true;

      otter.enable = true;
      lsp-lines.enable = true;
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          clangd.enable = true;
          cssls.enable = true;
          denols.enable = true;
          docker_compose_language_service.enable = true;
          dockerls.enable = true;
          gopls.enable = true;
          hls = {
            enable = true;
            installGhc = false;
          };
          html.enable = true;
          jsonls.enable = true;
          marksman.enable = true;
          nil_ls.enable = true;
          pylyzer.enable = true;
          sqls.enable = true;
          texlab.enable = true;
          yamlls.enable = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "treesiter"; }
            { name = "nvim_lsp"; }
            { name = "npm"; }
            { name = "neorg"; }
            { name = "crates"; }
            { name = "zsh"; }
            { name = "latex_symbols"; }
            { name = "conventionalcommits"; }
            { name = "path"; }
            { name = "emoji"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-w>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };

      nix.enable = true;
      nix-develop.enable = true;
      godot.enable = true;
      rustaceanvim.enable = true;
      render-markdown.enable = true;

      neorg = {
        enable = true;
        settings.load = {
          "core.defaults".__empty = null;
          "core.concealer".__empty = null;
          "core.completion".config = {
            engine = "nvim-cmp";
          };
          "core.dirman".config = {
            default_workspace = "home";
            workspaces = {
              work = "~/Documents/Work";
              home = "~/Documents/Home";
            };
          };
          "core.journal".config = {
            journal_folder = "Journal";
            template_name = "Template.norg";
          };
          "core.presenter".config = {
            zen_mode = "zen-mode";
          };
        };
        telescopeIntegration.enable = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      telescope_hoogle
      limelight-vim
    ];

    autoCmd = [
      {
        event = "VimEnter";
        callback.__raw = ''
          function()
            local in_repo =
              vim.system({'sh', '-c', 'git rev-parse --show-toplevel 2> /dev/null'}):wait().code == 0

            if in_repo then
              require("nvim-tree.api").tree.open()
            end
          end
        '';
      }
      {
        # https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#marvinth01
        event = "QuitPre";
        callback.__raw = ''
          function()
            local tree_wins = {}
            local floating_wins = {}
            local wins = vim.api.nvim_list_wins()
            for _, w in ipairs(wins) do
              local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
              if bufname:match("NvimTree_") ~= nil then
                table.insert(tree_wins, w)
              end
              if vim.api.nvim_win_get_config(w).relative ~= ''' then
                table.insert(floating_wins, w)
              end
            end
            if 1 == #wins - #floating_wins - #tree_wins then
              -- Should quit, so we close all invalid windows.
              for _, w in ipairs(tree_wins) do
                vim.api.nvim_win_close(w, true)
              end
            end
          end
        '';
      }
      {
        # https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#workaround-when-using-rmagattiauto-session
        event = "BufEnter";
        pattern = "NvimTree*";
        callback.__raw = ''
          function()
            local api = require('nvim-tree.api')
            local view = require('nvim-tree.view')

            if not view.is_visible() then
              api.tree.open()
            end
          end
        '';
      }
    ];

    highlightOverride = {
      Folded.bg = "none";
    };
  };
}

