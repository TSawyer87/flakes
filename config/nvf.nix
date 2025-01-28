{
  inputs,
  pkgs,
  ...
}: {
        imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        theme.enable = false;
        autocomplete.enable = true;
        autopairs.enable = true;
        visuals = {
          enable = true;
          indentBlankline.enable = true;
        };
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
          lspconfig.enable = true;
          lspkind.enable = true;
          #lightbulb.enable = true;
          #lsplines.enable = true;
        };
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

      basic = ''
      '';

      /*
      theme = ''

      '';
      */

    };

    extraPlugins = with pkgs.vimPlugins; {   

      fwatch = {
        package = fwatch-nvim;
      };

      neopywal = {
        package = pkgs.vimUtils.buildVimPlugin {
          pname = "neopywal"; version = "";
          src = builtins.fetchGit {
            url = "https://github.com/RedsXDD/neopywal.nvim.git";
            ref = "master";
            rev = "57fb800ccc1c2dd2f6623b82ef3612927a36fd4a";
          };
        };
        setup = ''
          -- Only apply neopywal theme if wallust template is found
          local neopywalPath = vim.env.HOME .. "/.cache/wallust/colors_neopywal.vim"
          local neopywalFile = io.open(neopywalPath, "r")
          if (neopywalFile ~= nil) then
              
              -- Close file handle 
              neopywalFile.close()

              -- Works :)
              local neopywal = require("neopywal")
              neopywal.setup({

                  plugins = {
                      neotree = true,
                      indent_blankline = {
                          enabled = true,
                          colored_indent_levels = false,

                          -- Can either be:
                          --   - A color exported by "get_colors()" (e.g.: `color8`)
                          --   - A hexadecimal color (e.g.: "#ff0000").
                          --   - A function with an optional "C" parameter that returns one of the two options above.
                          --     e.g: function(C) return C.color1 end
                          scope_color = "",
                      }
                  },
                  -- Uses a template file `~/.cache/wallust/colors_neopywal.vim` instead of the
                  -- regular pywal template at `~/.cache/wal/colors-wal.vim`.
                  use_wallust = true,

                  -- This option allows to specify where Neopywal should look for a ".vim" template file
                  -- (e.g.: os.getenv("HOME") .. "/.cache/wal/custom_neopywal_template.vim").
                  colorscheme_file = "",

                  -- This option allows to use a custom built-in theme palettes like "catppuccin-mocha" or "tokyonight".
                  -- To get the list of available themes take a look at `https://github.com/RedsXDD/neopywal.nvim#Alternative-Palettes`.
                  -- Take note that this option takes precedence over `use_wallust` and `colorscheme_file`.
                  use_palette = "",

                  -- Sets the background color of certain highlight groups to be transparent.
                  -- Use this when your terminal opacity is < 1.
                  transparent_background = true,

                  -- With this option you can overwrite all the base colors the colorscheme uses.
                  -- For more information take a look at `https://github.com/RedsXDD/neopywal.nvim#Customizing-Colors`
                  custom_colors = {},

                  -- With this option you can overwrite any highlight groups set by the colorscheme.
                  -- For more information take a look at `https://github.com/RedsXDD/neopywal.nvim#Customizing-Highlights`
                  custom_highlights = {},

                  -- Dims the background when another window is focused.
                  dim_inactive = true,

                  -- Apply colorscheme for Neovim's terminal (e.g. `g:terminal_color_0`).
                  terminal_colors = true,

                  -- Shows the '~' characters after the end of buffers.
                  show_end_of_buffer = false,

                  -- Shows the '|' split separator characters.
                  -- It's worth noting that this options works better in conjunction with `dim_inactive`.
                  show_split_lines = true,

                  no_italic = false, -- Force no italic.
                  no_bold = false, -- Force no bold.
                  no_underline = false, -- Force no underline.
                  no_undercurl = false, -- Force no undercurl.
                  no_strikethrough = false, -- Force no strikethrough.

                  -- Handles the styling of certain highlight groups (see `:h highlight-args`).
                  styles = {
                      comments = { "italic" },
                      conditionals = { "italic" },
                      loops = {},
                      functions = {},
                      keywords = {},
                      includes = { "italic" },
                      strings = {},
                      variables = { "italic" },
                      numbers = {},
                      booleans = {},
                      types = { "italic" },
                      operators = {},
                  },

                  -- Setting this to false disables all default file format highlights.
                  -- Useful if you want to enable specific file format options.
                  -- Defaults to false when treesitter is enabled,
                  -- unless manually enabled inside the `setup()` function.
                  default_fileformats = true,

                  -- Setting this to false disables all default plugin highlights.
                  -- Useful if you want to enable specific plugin options.
                  default_plugins = true,

                  -- For more fileformats options please scroll down (https://github.com/RedsXDD/neopywal.nvim#Fileformats)
                  fileformats = {
                      c_cpp = true,
                      c_sharp = true,
                  },

              })

              vim.cmd.colorscheme("neopywal")

              -- Use fwatch to watch for changes in wallust theme
              local fwatch = require('fwatch')
              fwatch.watch(vim.env.HOME .. "/.cache/wallust/colors_neopywal.vim", "colorscheme neopywal")

          else
              -- Do nothing right now
          end
        '';
      };

      web-devicons = {
        package = nvim-web-devicons;
        setup = '''';
      };

        tabline = {
          nvimBufferline.enable = true;
        };
      
      telescope = {
        package = telescope-nvim;
        setup = ''              
          require('telescope').setup{
              pickers = {
                  buffers = {
                      sort_lastused = true,
                      sort_mru = true,
                      ignore_current_buffer = true,
                  }
              }
          }
          local telescope_builtin = require('telescope.builtin') -- Import telescope functions
          vim.keymap.set('n', '<leader>o', telescope_builtin.find_files, {})
          vim.keymap.set('n', '<leader>f', telescope_builtin.live_grep, {})
          vim.keymap.set('n', '<leader>p', telescope_builtin.buffers, {})
        '';
      };
      lualine = {
        package = lualine-nvim;
        setup = ''
          require('lualine').setup {
            options = {
              icons_enabled = true,
              --theme = 'auto',
              theme = 'neopywal',
              component_separators = { left = '', right = ''},
              section_separators = { left = '', right = ''},
              disabled_filetypes = {
                statusline = {},
                winbar = {},
              },
              ignore_focus = {},
              always_divide_middle = true,
              globalstatus = false,
              refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
              }
            },
            sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch', 'diff', 'diagnostics'},
              lualine_c = {'filename'},
              lualine_x = {'encoding', 'fileformat', 'filetype'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
            },
            inactive_sections = {
              lualine_a = {},
              lualine_b = {},
              lualine_c = {'filename'},
              lualine_x = {'location'},
              lualine_y = {},
              lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
          }
        '';
      };
    };
  };
}



