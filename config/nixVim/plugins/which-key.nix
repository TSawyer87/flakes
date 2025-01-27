{
  programs.nixvim = {
    # Useful plugin to show you pending keybinds.
    # https://nix-community.github.io/nixvim/plugins/which-key/index.html
    plugins.which-key = {
      enable = true;

      # Document existing key chains
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>c";
            group = "[C]ode";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "[D]ocument";
          }
          {
            __unkeyed-1 = "<leader>r";
            group = "[R]ename";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "[W]orkspace";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "Git [H]unk";
            mode = ["n" "v"];
          }
          {
            __unkeyed = "<leader>h";
            group = "Harpoon";
            icon = "󱡀 ";
          }
          {
            __unkeyed = "<leader>ha";
            desc = "Add";
          }
          {
            __unkeyed = "<leader>he";
            desc = "QuickMenu";
          }
          {
            __unkeyed = "<leader>hj";
            desc = "1";
          }
          {
            __unkeyed = "<leader>hk";
            desc = "2";
          }
          {
            __unkeyed = "<leader>hl";
            desc = "3";
          }
          {
            __unkeyed = "<leader>hm";
            desc = "4";
          }
        ];
      };
    };
  };
}
