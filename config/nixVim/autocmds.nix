# [[ Basic Autocommands ]]
#  See `:help lua-guide-autocommands`
# https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
{
  programs.nixvim = {

    autoCmd = [
      # Highlight when yanking (copying) text
      #  Try it with `yap` in normal mode
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking (copying) text";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
      # Restore Cursor Position
      {
        event = [ "BufReadPost" ];
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
