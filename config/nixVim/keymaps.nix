{
  programs.nixvim = {
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
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
        options = { desc = "Open parent directory"; };
      }
      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = ''
          <CMD>require("flash").jump()
        '';
        options = { desc = "Flash Jump"; };
      }
      {
        mode = "c";
        key = "<c-s>";
        action = "<CMD>require('flash').toggle()";
        options = { desc = "Toggle Flash Search"; };
      }
      {
        key = "f";
        action.__raw = ''
          function()
            require'hop'.hint_char1({
              direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
              current_line_only = true
            })
          end
        '';
        options.remap = true;
      }

    ];
  };
}
