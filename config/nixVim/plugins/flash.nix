{
  programs.nixvim = {
    plugins.flash = {
      enable = true;
      keymaps = [
        {
          mode = [ "n" "x" "o" ];
          key = "s";
          action = ''
            function()
              require("flash").jump()
            end
          '';
          options = { desc = "Flash Jump"; };
        }
        {
          mode = "c";
          key = "<c-s>";
          action = "require('flash').toggle()";
          options = { desc = "Toggle Flash Search"; };
        }
      ];
    };
  };
}
