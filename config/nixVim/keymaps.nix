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
        options = {desc = "Exit terminal mode";};
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {desc = "Move focus to the left window";};
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {desc = "Move focus to the right window";};
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {desc = "Move focus to the lower window";};
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {desc = "Move focus to the upper window";};
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
        mode = ["n" "v"];
        key = "<C-a>";
        action = "<cmd>DialIncrement<cr>";
        options.desc = "Increment";
      }
      {
        mode = ["n" "v"];
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
        options.desc = "Allow cursor to stay in the same place after appending to current line ";
      }
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
        options = {desc = "Open parent directory";};
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
        mode = ["n" "i"];
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
        mode = ["n" "v"];
        key = "<leader>y";
        action = ''"+y'';
        options.desc = "Copy to system clipboard";
      }

      # Delete to void register
      {
        mode = ["n" "v"];
        key = "<leader>D";
        action = ''"_d'';
        options.desc = "Delete to void register";
      }
      {
        mode = ["n"];
        key = "<leader>zm";
        action = "<cmd>ZenMode<CR>";
        options.desc = "Activate ZenMode";
      }
      {
        mode = ["n"];
        key = "<leader>lg";
        action = "<cmd>LazyGit<CR>";
        options.desc = "Launch LazyGit";
      }
      {
        mode = ["n"];
        key = "<leader>do";
        action = "<cmd>DiffviewOpen<CR>";
        options.desc = "Open Diffview";
      }
      {
        mode = ["n"];
        key = "<leader>dc";
        action = "<cmd>DiffviewClose<CR>";
        options.desc = "Close Diffview";
      }

      {
        mode = ["n"];
        key = "<leader>j";
        action.__raw = ''function() require("treesj").toggle() end'';

        options.desc = "Treesj Toggle";
      }
      {
        mode = ["n"];
        key = "<leader>J";
        action.__raw = ''function() require("treesj").join() end'';

        options.desc = "Treesj Join";
      }
      {
        mode = ["n"];
        key = "<leader>S";
        action.__raw = ''function() require("treesj").split() end'';

        options.desc = "Treesj Split";
      }
      {
        mode = ["n" "v"];
        key = "<C-a>";
        action = "<cmd>CodeCompanionActions<CR>";
        options = {desc = "CodeCompanionActions";};
      }
      {
        mode = ["n" "v"];
        key = "<leader>a";
        action = "<cmd>CodeCompanionChat<CR>";
        options = {desc = "CodeCompanionChat";};
      }
      {
        mode = "v";
        key = "ga";
        action = "<cmd>CodeCompanionChat Add<CR>";
        options = {desc = "CodeCompanionChatAdd";};
      }
      {
        key = "s";
        action.__raw = ''function() require("flash").jump() end'';
        mode = ["n" "x" "o"];
        options.desc = "Flash";
      }
      {
        key = "S";
        action.__raw = ''function() require("flash").treesitter() end'';
        mode = ["n" "x" "o"];
        options.desc = "Flash Treesitter";
      }
      {
        key = "r";
        action.__raw = ''function() require("flash").remote() end'';
        mode = ["o"];
        options.desc = "Remote Flash";
      }
      {
        key = "R";
        action.__raw = ''function() require("flash").treesitter_search() end'';
        mode = ["o"];
        options.desc = "Treesitter Search";
      }
      {
        key = "gl";
        action.__raw = ''
          function()
            require("flash").jump {
              search = { mode = 'search', max_length = 0 },
              label = { after = { 0, 0 } },
              pattern = '^',
            }
          end
        '';
        mode = ["n" "x" "o"];
        options.desc = "Flash Line";
      }
      {
        mode = "n";
        key = "<leader>uC";
        action.__raw = ''
          function ()
           vim.cmd('ColorizerToggle')
           vim.notify(string.format("Colorizing %s", bool2str(vim.g.colorizing_enabled), "info"))
          end
        '';
        options = {
          desc = "Colorizing toggle";
          silent = true;
        };
      }
      # { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    ];
  };
}
