{ pkgs, inputs, ... }: {
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
    ./options.nix
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
      have_nerd_font = false;
    };

    # [[ Setting options ]]
    # See `:help vim.opt`
    # NOTE: You can change these options as you wish!
    #  For more options, you can see `:help option-list`
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#opts

    # [[ Basic Keymaps ]]
    #  See `:help vim.keymap.set()`
    # https://nix-community.github.io/nixvim/keymaps/index.html
    keymaps = [
      # Clear highlights on search when pressing <Esc> in normal mode
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
      # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
      # is not what someone will guess without a bit more experience.
      #
      # NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      # or just use <C-\><C-n> to exit terminal mode
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = { desc = "Exit terminal mode"; };
      }
      # TIP: Disable arrow keys in normal mode
      /* {
           mode = "n";
           key = "<left>";
           action = "<cmd>echo 'Use h to move!!'<CR>";
         }
         {
           mode = "n";
           key = "<right>";
           action = "<cmd>echo 'Use l to move!!'<CR>";
         }
         {
           mode = "n";
           key = "<up>";
           action = "<cmd>echo 'Use k to move!!'<CR>";
         }
         {
           mode = "n";
           key = "<down>";
           action = "<cmd>echo 'Use j to move!!'<CR>";
         }
      */
      # Keybinds to make split navigation easier.
      #  Use CTRL+<hjkl> to switch between windows
      #
      #  See `:help wincmd` for a list of all window commands
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = { desc = "Move focus to the left window"; };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = { desc = "Move focus to the right window"; };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = { desc = "Move focus to the lower window"; };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = { desc = "Move focus to the upper window"; };
      }
    ];

    # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
    autoGroups = { kickstart-highlight-yank = { clear = true; }; };

    # [[ Basic Autocommands ]]
    #  See `:help lua-guide-autocommands`
    # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
    autoCmd = [
      # Highlight when yanking (copying) text
      #  Try it with `yap` in normal mode
      #  See `:help vim.highlight.on_yank()`
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
    ];

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
      glow = {
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
