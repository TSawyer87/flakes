{
  programs.nixvim = {
    # Neo-tree is a Neovim plugin to browse the file system
    # https://nix-community.github.io/nixvim/plugins/neo-tree/index.html?highlight=neo-tree#pluginsneo-treepackage
    plugins.flash = {
      enable = true;
    keymaps = [

      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = "function()
                 require("flash").jump(), end,";
        options = { desc = "Open parent directory"; };
      }
      {
        mode = "c";
        key = "<c-s>";
        action = "require("flash").toggle()";
        options = { desc = "Toggle Flash Search"; };
      }
    ];
    };
  };
}
