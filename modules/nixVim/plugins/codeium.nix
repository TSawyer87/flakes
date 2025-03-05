{
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      codeium-nvim = {
        enable = false;

        settings = {
          enable_chat = true;

          tools = {
            curl = lib.getExe pkgs.curl;
            gzip = lib.getExe pkgs.gzip;
            uname = lib.getExe' pkgs.coreutils "uname";
            uuidgen = lib.getExe' pkgs.util-linux "uuidgen";
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ac";
        action = "<cmd>Codeium Chat<CR>";
        options = {desc = "Codeium Chat";};
      }
      {
        mode = "i";
        key = "<C-;>";
        action.__raw = ''
          function()
            return vim.fn["codeium#Accept"]()
          end
        '';
        options.remap = true;
      }
    ];
  };
}
