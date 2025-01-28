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

        luaConfigRC = {
          globalsScript = ''
            --vim.g.mapleader = " " -- Set leader to space
          '';
          optionsScript = ''
            vim.opt.wrap = false
            vim.opt.clipboard = "unnamedplus" -- External clipboard support
            vim.opt.number = true
            vim.opt.laststatus = 0 -- Never show status line
            --vim.opt.relativenumber = true
            vim.opt.mouse = ""

            -- Tab config
            vim.opt.tabstop = 4 -- A TAB character looks like 2 spaces
            vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
            vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
            vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting
          '';

          basic = "";

          /* theme = ''

             '';
          */

          extraPlugins = with pkgs.vimPlugins; {

            fwatch = { package = fwatch-nvim; };
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
    };
  };
}
