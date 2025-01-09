{
  programs.nixvim = {
    keymaps = [
      # Clear highlights on search when pressing <Esc> in normal mode
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      # Exit terminal mode 
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
      # Move Lines
      {
        mode = "n";
        key = "<A-Up>";
        action = "<cmd>m .-2<cr>==";
        options.desc = "Move line up";
      }

      {
        mode = "v";
        key = "<A-Up>";
        action = ":m '<-2<cr>gv=gv";
        options.desc = "Move line up";
      }

      {
        mode = "n";
        key = "<A-Down>";
        action = "<cmd>m .+1<cr>==";
        options.desc = "Move line down";
      }

      {
        mode = "v";
        key = "<A-Down>";
        action = ":m '>+1<cr>gv=gv";
        options.desc = "Move line Down";
      }

      # Better indenting
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }

      {
        mode = "v";
        key = ">";
        action = ">gv";
      }

      {
        mode = "i";
        key = "<C-b>";
        action = "<cmd> norm! ggVG<cr>";
        options.desc = "Select all lines in buffer";
      }
      {
        mode = [ "n" "v" ];
        key = "<C-a>";
        action = "<cmd>DialIncrement<cr>";
        options.desc = "Increment";
      }
      {
        mode = [ "n" "v" ];
        key = "<C-x>";
        action = "<cmd>DialDecrement<cr>";
        options.desc = "Decrement";
      }
      {
        key = "<leader>a";
        action.__raw = ''
          function()
            require("dial.map").inc_normal()
            end
        '';
        options.remap = true;
      }
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
        options.desc =
          "Allow cursor to stay in the same place after appending to current line ";
      }
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
        options = { desc = "Open parent directory"; };
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options.desc = "Allow search terms to stay in the middle";
      }

      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options.desc = "Allow search terms to stay in the middle";
      }

      # Clear search with ESC
      {
        mode = [ "n" "i" ];
        key = "<esc>";
        action = "<cmd>noh<cr><esc>";
        options = {
          silent = true;
          desc = "Escape and clear hlsearch";
        };
      }

      # Paste stuff without saving the deleted word into the buffer
      {
        mode = "x";
        key = "p";
        action = ''"_dP'';
        options.desc = "Deletes to void register and paste over";
      }

      # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
      {
        mode = [ "n" "v" ];
        key = "<leader>y";
        action = ''"+y'';
        options.desc = "Copy to system clipboard";
      }

      # Delete to void register
      {
        mode = [ "n" "v" ];
        key = "<leader>D";
        action = ''"_d'';
        options.desc = "Delete to void register";
      }
      {
        mode = [ "n" ];
        key = "<leader>zm";
        action = "<cmd>ZenMode<CR>";
        options.desc = "Activate ZenMode";
      }
      {
        mode = [ "n" ];
        key = "<leader>lg";
        action = "<cmd>LazyGit<CR>";
        options.desc = "Launch LazyGit";
      }
      {
        mode = [ "n" ];
        key = "<leader>do";
        action = "<cmd>DiffviewOpen<CR>";
        options.desc = "Open Diffview";
      }
      {
        mode = [ "n" ];
        key = "<leader>dc";
        action = "<cmd>DiffviewClose<CR>";
        options.desc = "Close Diffview";
      }
      {
        key = "s";
        action.__raw = ''
          function()
            require'flash'.jump({
            })
          end
        '';
        options.remap = true;
      }
      {
        key = "<c-s>";
        action.__raw = ''
          function()
            require'flash'.toggle({
            })
          end
        '';
        options.remap = true;
      }
    ];
  };
}
