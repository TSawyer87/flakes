{pkgs, ...}: {
  programs.nixvim = {
    # Dependencies
    # { 'Bilal2453/luvit-meta', lazy = true },
    #
    #
    # Allows extra capabilities providied by nvim-cmp
    # https://nix-community.github.io/nixvim/plugins/cmp-nvim-lsp.html
    plugins.cmp-nvim-lsp = {enable = true;};

    # Useful status updates for LSP.
    # https://nix-community.github.io/nixvim/plugins/fidget/index.html
    plugins.fidget = {enable = true;};

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugi#extraplugins
    extraPlugins = with pkgs.vimPlugins; [luvit-meta];

    # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
    autoGroups = {"kickstart-lsp-attach" = {clear = true;};};

    # https://nix-community.github.io/nixvim/plugins/lsp/index.html
    plugins.lsp = {
      enable = true;

      servers = {
        # clangd = {
        #  enable = true;
        #}
        # gopls = {
        #  enable = true;
        #}
        # pyright = {
        #  enable = true;
        #}
        # ...etc. See `https://nix-community.github.io/nixvim/plugins/lsp` for a list of pre-configured LSPs
        #
        # Some languages (like typscript) have entire language plugins that can be useful:
        #    `https://nix-community.github.io/nixvim/plugins/typescript-tools/index.html?highlight=typescript-tools#pluginstypescript-toolspackage`
        #
        # But for many setups the LSP (`tsserver`) will work just fine
        # tsserver = {
        #  enable = true;
        #}
        # nil_ls = {
        #   enable = true;
        #   autostart = true;
        # };

        bashls = {enable = true;};

        nixd = {enable = true;};

        marksman = {enable = true;};

        hyprls = {enable = true;};

        lua_ls = {
          enable = true;

          # cmd = {
          #};
          # filetypes = {
          #};
          settings = {
            completion = {callSnippet = "Replace";};
            #diagnostics = {
            #  disable = [
            #    "missing-fields"
            #  ];
            #};
          };
        };
      };

      keymaps = {
        # Diagnostic keymaps
        diagnostic = {
          "<leader>q" = {
            #mode = "n";
            action = "setloclist";
            desc = "Open diagnostic [Q]uickfix list";
          };
        };

        extra = [
          # Jump to the definition of the word under your cusor.
          #  This is where a variable was first declared, or where a function is defined, etc.
          #  To jump back, press <C-t>.
          {
            mode = "n";
            key = "gd";
            action.__raw = "require('telescope.builtin').lsp_definitions";
            options = {desc = "LSP: [G]oto [D]efinition";};
          }
          # Find references for the word under your cursor.
          {
            mode = "n";
            key = "gr";
            action.__raw = "require('telescope.builtin').lsp_references";
            options = {desc = "LSP: [G]oto [R]eferences";};
          }
          {
            mode = "n";
            key = "gI";
            action.__raw = "require('telescope.builtin').lsp_implementations";
            options = {desc = "LSP: [G]oto [I]mplementation";};
          }
          {
            mode = "n";
            key = "<leader>D";
            action.__raw = "require('telescope.builtin').lsp_type_definitions";
            options = {desc = "LSP: Type [D]efinition";};
          }
          {
            mode = "n";
            key = "<leader>ds";
            action.__raw = "require('telescope.builtin').lsp_document_symbols";
            options = {desc = "LSP: [D]ocument [S]ymbols";};
          }
          {
            mode = "n";
            key = "<leader>ws";
            action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
            options = {desc = "LSP: [W]orkspace [S]ymbols";};
          }
        ];

        lspBuf = {
          # Rename the variable under your cursor.
          #  Most Language Servers support renaming across files, etc.
          "<leader>rn" = {
            action = "rename";
            desc = "LSP: [R]e[n]ame";
          };
          # Execute a code action, usually your cursor needs to be on top of an error
          # or a suggestion from your LSP for this to activate.
          "<leader>ca" = {
            #mode = "n";
            action = "code_action";
            desc = "LSP: [C]ode [A]ction";
          };
          "gD" = {
            action = "declaration";
            desc = "LSP: [G]oto [D]eclaration";
          };
        };
      };

      # LSP servers and clients are able to communicate to each other what features they support.
      #  By default, Neovim doesn't support everything that is in the LSP specification.
      #  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      #  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      # NOTE: This is done automatically by Nixvim when enabling cmp-nvim-lsp below is an example if you did want to add new capabilities
      #capabilities = ''
      #  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      #'';

      # This function gets run when an LSP attaches to a particular buffer.
      #   That is to say, every time a new file is opened that is associated with
      #   an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      #   function will be executred to configure the current buffer
      # NOTE: This is an example of an attribute that takes raw lua
      onAttach = ''
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        -- The following two autocommands are used to highlight references of the
        -- word under the cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      '';
    };
  };
}
