# [[ Basic Autocommands ]]
#  See `:help lua-guide-autocommands`
# https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
{
  programs.nixvim = {
    autoCmd = [
      # Inlay-Hints
      # {
      #   event = [ "LspAttach" ];
      #   desc = "Configure LSP and enable inlay hints";
      #   callback.__raw = ''
      #     function(args)
      #       local client = vim.lsp.get_client_by_id(args.data.client_id)
      #       if client and client.server_capabilities and client.server_capabilities.inlayHintProvider then
      #         vim.lsp.inlay_hint.enable(0, client.id, true) -- Enable inlay hints for the current buffer and client
      #       end
      #       -- Additional LSP configuration can be added here
      #     end
      #   '';
      # } # Highlight when yanking (copying) text
      #  Try it with `yap` in normal mode
      {
        event = ["TextYankPost"];
        desc = "Highlight when yanking (copying) text";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
      {
        event = ["FileType"];
        pattern = ["qf" "help" "man" "lspinfo"];
        command = "nnoremap <silent> <buffer> q :close<CR>";
      }
      # Markdown
      {
        event = ["FileType"];
        pattern = ["markdown"];
        command = "setlocal wrap";
      }
      {
        event = ["FileType"];
        pattern = ["markdown"];
        command = "setlocal spell";
      }
      # Save manual folds automatically
      {
        event = ["BufWrite"];
        pattern = ["*"];
        command = "mkview";
      }
      {
        event = ["BufRead"];
        pattern = ["*"];
        command = "silent! loadview";
      }

      # Set indent folds for python
      {
        event = ["FileType"];
        pattern = ["python"];
        command = "set foldmethod=indent";
      }

      # Display images for specific file types
      {
        event = ["BufRead"];
        pattern = ["*.png" "*.jpg" "*.jpeg"];
        command = ":call DisplayImage()";
      }
      # Restore Cursor Position
      {
        event = ["BufReadPost"];
        pattern = "*";
        callback = {
          __raw = ''
            function()
              if
                vim.fn.line "'\"" > 1
                and vim.fn.line "'\"" <= vim.fn.line "$"
                and vim.bo.filetype ~= "commit"
                and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
              then
                vim.cmd "normal! g`\""
              end
            end
          '';
        };
      }
    ];
  };
}
